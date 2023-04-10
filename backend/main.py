import psycopg2
from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity

app = Flask(__name__)

# Configurar a chave secreta do JWT
app.config['JWT_SECRET_KEY'] = 'minha_chave_secreta'
jwt = JWTManager(app)

# Conectar ao banco de dados PostgreSQL
conn = psycopg2.connect(
    host='localhost',
    port=5432,
    database='meu_banco_de_dados',
    user='meu_usuario',
    password='minha_senha'
)

# Definir a consulta SQL para buscar o usuário pelo email
sql_usuario_por_email = "SELECT * FROM usuarios WHERE email = %s"

@app.route('/login', methods=['POST'])
def login():
    email = request.form.get('email')
    senha = request.form.get('senha')

    # Buscar o usuário pelo email no banco de dados
    cur = conn.cursor()
    cur.execute(sql_usuario_por_email, (email,))
    usuario = cur.fetchone()

    # Verificar se o usuário existe e a senha está correta
    if usuario and usuario[3] == senha:
        # Gerar o token de acesso para o usuário
        token = create_access_token(identity=usuario[0])
        return jsonify({'access_token': token}), 200
    else:
        return jsonify({'message': 'Credenciais inválidas.'}), 401

@app.route('/cadastro-prestador', methods=['POST'])
def cadastro_prestador():
    # Obter os dados do formulário
    nome = request.form.get('nome')
    email = request.form.get('email')
    senha = request.form.get('senha')
    cpf = request.form.get('cpf')
    especialidades = request.form.getlist('especialidades')

    # Verificar se o CPF já está cadastrado
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    cur.execute("SELECT id FROM usuarios WHERE cpf = %s", (cpf,))
    resultado = cur.fetchone()

    if resultado:
        return jsonify({'message': 'Já existe um usuário cadastrado com este CPF.'}), 400

    # Gerar o hash da senha
    senha_hash = generate_password_hash(senha)

    # Executar a consulta SQL para inserir o novo usuário
    cur.execute(
        "INSERT INTO usuarios (nome, email, senha, cpf, tipo_usuario, descricao) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id",
        (nome, email, senha_hash, cpf, 'prestador', None)
    )
    usuario_id = cur.fetchone()[0]

    # Inserir as especialidades do prestador
    for especialidade in especialidades:
        cur.execute("INSERT INTO especialidades (nome, usuario_id) VALUES (%s, %s)", (especialidade, usuario_id))

    conn.commit()

    # Retornar uma mensagem de sucesso
    return jsonify({'message': 'Usuário prestador de serviços criado com sucesso.'}), 201


@app.route('/cadastro-consumidor', methods=['POST'])
def cadastro_consumidor():
    # Obter os dados do formulário
    nome = request.form.get('nome')
    email = request.form.get('email')
    senha = request.form.get('senha')
    cpf = request.form.get('cpf')

    # Verificar se já existe um usuário com o mesmo CPF
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    cur.execute("SELECT * FROM usuarios WHERE cpf = %s", (cpf,))
    usuario_existente = cur.fetchone()
    if usuario_existente:
        return jsonify({'message': 'Já existe um usuário com esse CPF.'}), 400

    # Executar a consulta SQL para inserir o novo usuário
    cur.execute("INSERT INTO usuarios (nome, email, senha, cpf, tipo_usuario) VALUES (%s, %s, %s, %s, %s)",
                (nome, email, senha, cpf, 'consumidor'))
    conn.commit()

    # Retornar uma mensagem de sucesso
    return jsonify({'message': 'Usuário criado com sucesso.'}), 201


@app.route('/cadastro-caso', methods=['POST'])
@jwt_required() # somente usuários autenticados podem criar casos
def cadastro_caso():
    # Obter os dados do formulário
    titulo = request.form.get('titulo')
    status = request.form.get('status')
    usuario_responsavel = request.form.get('usuario_responsavel')
    data_abertura = datetime.strptime(request.form.get('data_abertura'), '%Y-%m-%d %H:%M:%S')
    data_fechamento = datetime.strptime(request.form.get('data_fechamento'), '%Y-%m-%d %H:%M:%S') if request.form.get('data_fechamento') else None

    # Buscar o ID do usuário autenticado a partir do token
    usuario_id = get_jwt_identity()

    # Executar a consulta SQL para inserir o novo caso
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO casos (titulo, status, usuario_responsavel, data_abertura, data_fechamento, usuario_id) VALUES (%s, %s, %s, %s, %s, %s)",
        (titulo, status, usuario_responsavel, data_abertura, data_fechamento, usuario_id)
    )
    conn.commit()

    # Retornar uma mensagem de sucesso
    return jsonify({'message': 'Caso criado com sucesso.'}), 201

if __name__ == '__main__':
    app.run(port=8393)

@app.route('/finalizar-caso/<int:caso_id>', methods=['PUT'])
@jwt_required()
def finalizar_caso(caso_id):
    # buscar o caso correspondente ao id
    cur = conn.cursor()
    cur.execute("SELECT * FROM casos WHERE id = %s", (caso_id,))
    caso = cur.fetchone()

    # verificar se o usuário logado é o responsável pelo caso
    usuario_id = get_jwt_identity()
    if usuario_id != caso['usuario_id']:
        return jsonify({'message': 'Você não tem permissão para finalizar esse caso.'}), 403

    # atualizar o status do caso para "finalizado"
    cur.execute("UPDATE casos SET status = 'finalizado' WHERE id = %s", (caso_id,))
    conn.commit()

    # calcular a média das notas recebidas pelo paciente
    cur.execute("SELECT AVG(nota) FROM avaliacoes WHERE caso_id = %s AND avaliado = 'paciente'", (caso_id,))
    media_notas = cur.fetchone()[0]

    # atualizar a nota do usuário correspondente
    cur.execute("UPDATE usuarios SET nota = %s WHERE id = %s", (media_notas, caso['usuario_id']))
    conn.commit()

    return jsonify({'message': 'Caso finalizado com sucesso.'}), 200


@app.route('/busca-usuario-por-especialidade', methods=['POST'])
def busca_usuario_por_especialidade():
    especialidade = request.form.get('especialidade')

    # executar a consulta SQL para buscar usuários com a especialidade especificada
    cur = conn.cursor()
    cur.execute("SELECT id, nome, especialidade, nota FROM usuarios WHERE especialidade = %s", (especialidade,))
    usuarios = cur.fetchall()

    # retornar os valores importantes para o filtro
    usuarios_filtros = [{'id': u[0], 'nome': u[1], 'especialidade': u[2], 'nota': u[3]} for u in usuarios]

    return jsonify({'usuarios': usuarios_filtros}), 200

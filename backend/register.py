import psycopg2
from flask import Flask, request, jsonify

app = Flask(__name__)

# Conectar ao banco de dados PostgreSQL
conn = psycopg2.connect(
    host='localhost',
    port=5432,
    database='meu_banco_de_dados',
    user='meu_usuario',
    password='minha_senha'
)

# Definir a consulta SQL para inserir um novo usuário
sql = "INSERT INTO usuarios (nome, email, senha) VALUES (%s, %s, %s)"

@app.route('/cadastro', methods=['POST'])
def cadastro():
    nome = request.form.get('nome')
    email = request.form.get('email')
    senha = request.form.get('senha')
    confirmacao_senha = request.form.get('confirmacao_senha')

    # Verificar se as senhas coincidem
    if senha != confirmacao_senha:
        return jsonify({'message': 'As senhas não coincidem.'}), 400

    # Executar a consulta SQL para inserir o novo usuário
    cur = conn.cursor()
    cur.execute(sql, (nome, email, senha))
    conn.commit()

    # Retornar uma mensagem de sucesso
    return jsonify({'message': 'Usuário criado com sucesso.'}), 201

if __name__ == '__main__':
    app.run(debug=True)

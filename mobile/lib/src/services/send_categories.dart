import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Criminal',
      'description':
          'Refere-se a questões relacionadas a crimes e infrações penais.',
      'icon': 'security',
    },
    {
      'name': 'Civil',
      'description':
          'Refere-se a litígios entre indivíduos, empresas ou entidades legais no âmbito civil.',
      'icon': 'gavel',
    },
    {
      'name': 'Constitucional',
      'description':
          'Refere-se à interpretação e aplicação da Constituição em assuntos legais.',
      'icon': 'account_balance',
    },
    {
      'name': 'Trabalhista',
      'description':
          'Refere-se a questões relacionadas aos direitos e relações de trabalho entre empregadores e funcionários.',
      'icon': 'work',
    },
    {
      'name': 'Negócios',
      'description':
          'Refere-se a assuntos legais relacionados a empreendimentos comerciais, contratos e transações empresariais.',
      'icon': 'business',
    },
    {
      'name': 'Ambiental',
      'description':
          'Refere-se a questões legais relacionadas à proteção e conservação do meio ambiente.',
      'icon': 'eco',
    },
    {
      'name': 'Propriedade Intelectual',
      'description':
          'Refere-se a direitos autorais, patentes, marcas registradas e proteção de propriedade intelectual.',
      'icon': 'create',
    },
    {
      'name': 'Família',
      'description':
          'Refere-se a questões legais relacionadas a relações familiares, como divórcio, guarda de crianças e adoção.',
      'icon': 'family_restroom',
    },
    {
      'name': 'Internacional',
      'description':
          'Refere-se a questões legais que envolvem relações entre países e transações internacionais.',
      'icon': 'public',
    },
    {
      'name': 'Tributário',
      'description':
          'Refere-se a questões legais relacionadas a impostos, obrigações fiscais e planejamento tributário.',
      'icon': 'attach_money',
    },
    {
      'name': 'Imobiliário',
      'description':
          'Refere-se a questões legais relacionadas a propriedades, compra, venda, locação e direitos imobiliários.',
      'icon': 'home',
    },
    {
      'name': 'Tecnologia da Informação',
      'description':
          'Refere-se a questões legais relacionadas a tecnologia, proteção de dados, segurança cibernética e propriedade intelectual no campo da tecnologia da informação.',
      'icon': 'computer',
    },
    {
      'name': 'Outros',
      'description':
          'Refere-se a assuntos legais que não se enquadram nas categorias anteriores.',
      'icon': 'category',
    },
  ];

  try {
    for (var category in categories) {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(category['name'])
          .set(category);
      print('Categoria "${category['name']}" enviada com sucesso!');
    }
    print('Todas as categorias foram enviadas ao Firestore.');
  } catch (e) {
    print('Erro ao enviar as categorias: $e');
  }
}

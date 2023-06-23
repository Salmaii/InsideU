import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/model/sign_up_user.dart';
import '../../domain/repository/sign_up_interface.dart';

class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class SignUpRepository implements ISignUp {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<SignUpUser> signUp(SignUpUser signUpUser) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpUser.email,
        password: signUpUser.password!,
      );

      final user = userCredential.user;
      await user!.updateDisplayName(signUpUser.name);
      await _usersCollection.doc(user.uid).set({
        'name': signUpUser.name,
        'email': signUpUser.email,
        'descricao': '',
      });

      final token = await user.getIdToken();
      final domain =
          SignUpUser(signUpUser.name, signUpUser.email, null, token: token);
      return domain;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        print('An error occurred: $e');
      }
      throw Exception("Algo de errado aconteceu");
    } catch (e) {
      print('An error occurred: $e');
      throw Exception("Algo de errado aconteceu");
    }
  }
}

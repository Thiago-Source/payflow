import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow_nlw/shared/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();
  Future<void> googleSignIn(
    BuildContext context,
  ) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
    ]);
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl!,
      );
      authController.setUser(context, user);
      //print(response);
    } catch (error) {
      //print('DEU ERRO');
    }
  }

  Future<void> googleSignOut(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    final response = instance.getStringList('boletos');
    if (response != null) response.remove('boletos');
    instance.clear();
    await instance.remove('user');

    GoogleSignIn _googleSignOut = GoogleSignIn(scopes: ['email']);
    await _googleSignOut.signOut();
  }
}

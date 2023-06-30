import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sky/Auth/signup.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sky/Auth/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sky/Auth/updateProfile.dart';
import 'package:sky/Homepage.dart';

import 'authentication.dart';

class LoginUiPage extends StatelessWidget {
  LoginUiPage({Key? key}) : super(key: key);

  final emailInputController = TextEditingController();

  final passwordInputController = TextEditingController();

  var authHandler = new AuthenticationHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF202020),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/logoupfind.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Bienvenue sur Upfind',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xFFFFBD73),
                      )),
                  controller: emailInputController,
                ),
                const SizedBox(
                  height: 14,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.edit,
                        color: Color(0xFFFFBD73),
                      )),
                  controller: passwordInputController,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    elevation: 0,
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(color: Color(0xFFFFBD73)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: MaterialButton(
                    color: const Color(0xFFFFBD73),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      'Se connecter ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {

                      authHandler.signInWithEmail(emailInputController.text, passwordInputController.text).then((User user) {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new UpdateProfile()));
                      }).catchError((e) => print(e));
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'se conneter avec ',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  height: 30,
                ),
                SignInButtonBuilder(
                  text: 'Connecte toi avec ton tel',
                  icon: Icons.phone,
                  onPressed: () {},
                  backgroundColor: Color(0xFFFFBD73),
                ),
                Row(
                  children: [],
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: "pas de compte ? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    ),
                    TextSpan(
                      text: 'Creer un compte Upfind',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => const SingUpPage(),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration:
                                  const Duration(milliseconds: 1000),
                            ),
                          );
                        },
                      style: const TextStyle(
                          color: Color(0xFFFFBD73),
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

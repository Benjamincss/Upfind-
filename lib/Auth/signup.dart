
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky/party.dart';

import 'updateProfile.dart';
import 'authentication.dart';
import 'login.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  bool isActive = false;

  final userNameInputController = TextEditingController();

  final emailInputController = TextEditingController();

  final passwordInputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xFF202020),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
              ),
              Image.asset(
                'assets/logoupfind.png',
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Sign up',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(0xFF202020)),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.person_outline_sharp,
                      size: 22,
                      color: Color(0xFFFFBD73),
                    )),
                controller: userNameInputController,
              ),
              const SizedBox(
                height: 14,
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
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Color(0xFFFFBD73),
                    )),
                controller: passwordInputController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isActive,
                    onChanged: (value) => setState(() {
                      isActive = value!;
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'I agree with the terms and conditions\nand privacy policy',
                      style: TextStyle(color: Colors.grey[400] , fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: MaterialButton(
                  color: const Color(0xFFFFBD73),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    AuthenticationHelper()
                        .signUpWithEmail(email: emailInputController.text, password: passwordInputController.text)
                        .then((result) {
                      if (result == null) {
                        _saveProfileUpdate();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginUiPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result,
                            style: TextStyle(fontSize: 16),
                          ),
                        ));
                      }
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _saveProfileUpdate() async {

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;

    FirebaseFirestore.instance.collection("user_properties").add({"Email": emailInputController.text, "Username": userNameInputController.text, "User_UID_Reference": user?.uid}).then((value) => print("user added "+user!.uid));

  }

}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky/main.dart';




enum PhoneVerificationState { SHOW_PHONE_FORM_STATE, SHOW_OTP_FORM_STATE }

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final GlobalKey<ScaffoldState> _scaffoldKeyForSnackBar = GlobalKey();
  PhoneVerificationState currentState =
      PhoneVerificationState.SHOW_PHONE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  late String verificationIDFromFirebase;
  bool spinnerLoading = false;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _verifyPhoneButton() async {
    print('Phone Number: ${phoneController.text}');
    setState(() {
      spinnerLoading = true;
    });
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (phoneAuthCredential) async {
          setState(() {
            spinnerLoading = false;
          });
          //TODO: Auto Complete Function
          //signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            spinnerLoading = true;
          });


        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            spinnerLoading = false;
            currentState = PhoneVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationIDFromFirebase = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  _verifyOTPButton() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIDFromFirebase,
        smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      spinnerLoading = true;
    });
    try {
      final authCredential =
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      setState(() {
        spinnerLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>     MyApp()));
      }
    } on FirebaseAuthException {
      setState(() {
        spinnerLoading = false;
      });


    }
  }

  getPhoneFormWidget(context) {
    return Column(
      children: [

        const Text(
          "Enter authentication phone number\nUse country code (eg: +94712345678)",
          style: const TextStyle(fontSize: 16.0, color: Color(0xFFFFBD73)),
        ),
        const SizedBox(
          height: 40.0,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          maxLength: 12,
          //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: phoneController,
          textAlign: TextAlign.start,

          decoration: const InputDecoration(

              hintText:  ("Numero de telephone"),
              prefixIcon: Icon(Icons.phone_android_rounded),prefixIconColor: Color(0xFFFFBD73)),

        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: () => _verifyPhoneButton(),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFBD73), // background
              onPrimary: Colors.white, // foreground
            ),
            child: const Text("Verify Phone Number")),
      ],
    );
  }

  getOTPFormWidget(context) {

    return Column(
      children: [
        const Text(
          "Enter code Number",
          style: const TextStyle(fontSize: 16.0,color: Color(0xFFFFBD73)),
        ),
        const SizedBox(
          height: 40.0,
        ),
        TextField(
          controller: otpController,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
              hintText: "OTP Number",
              prefixIcon: Icon(Icons.confirmation_number_rounded)),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: () => _verifyOTPButton(),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFBD73), // background
            onPrimary: Colors.white, // foreground
          ),
          child: const Text("Verify OTP Number"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF202020),

          key: _scaffoldKeyForSnackBar,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/logoupfind.png',
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        "Flutter Firebase Phone Auth",
                        style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold , color: Color(0xFFFFBD73)),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Image.asset(
                            'assets/hand_with_phone_127px.png',
                            scale: 2,
                          ),
                          Image.asset(
                            'assets/verified_127px.png',
                            scale: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  spinnerLoading

                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : currentState == PhoneVerificationState.SHOW_PHONE_FORM_STATE
                      ? getPhoneFormWidget(context)
                      : getOTPFormWidget(context),
                ],
              ),
            ),
          ),
        ));
  }
}
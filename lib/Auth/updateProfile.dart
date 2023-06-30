import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky/Homepage.dart';


import '../Discover.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFFFBD73),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => homepage()));
          },
        ),
      ),
      backgroundColor: Color(0xFF202020),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PersonalizedTextField(
                        hintText: "nom", controller: nameController),
                    PersonalizedTextField(
                        hintText: "age", controller: ageController),
                    PersonalizedTextField(
                        hintText: "Bio", controller: bioController),
                    PersonalizedTextField(
                        hintText: "Situation",
                        controller: romanticStatusController),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder:(context)=>homepage()
                              ));
                          _saveProfileUpdate();
                        },

                        child: Center(
                          child: Text(
                            "Creer mon compte",
                            style: TextStyle(
                              fontFamily: 'PaybAck',
                              fontSize: 23,
                              color: Color(0xFF202020),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            // painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Color(0xFF202020),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFFBD73), width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: AssetImage('images/profile.png'),
                  // ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Color(0xFFFFBD73),
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final bioController = TextEditingController();
  final romanticStatusController = TextEditingController();

  void _saveProfileUpdate() async {
    final User? user = auth.currentUser;

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("user_properties").where("User_UID_Reference", isEqualTo: user?.uid).get();
    DocumentSnapshot documentSnapshot = snapshot.docs[0];
    var doc = FirebaseFirestore.instance.collection("user_properties").doc(documentSnapshot.id);

    final String name = nameController.text;
    final String bio = bioController.text;
    final String romanticStatus = romanticStatusController.text;

    doc.update({"Username": name});
    doc.update({"Bio": bio});
    doc.update({"Romantic_Status": romanticStatus});
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget PersonalizedTextField({@required hintText, @required controller}) {
  return TextField(
    decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          letterSpacing: 2,
          color: Color(0xFFFFBD73),
          fontFamily: 'PaybAck',
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),focusColor: Colors.white,hoverColor: Colors.white),
    controller: controller,
    // keyboardType: TextInputType.text,
  );
}
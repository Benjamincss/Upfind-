import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ChipsDemo extends StatefulWidget {
  const ChipsDemo({Key? key}) : super(key: key);

  @override
  Validator() {}

  @override
  _ChipsDemoState createState() => _ChipsDemoState();
}

class _ChipsDemoState extends State<ChipsDemo> {

  var _currentItemSelected = '';

  @override


  List<DropdownMenuItem<String>> get Partytype{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Public party"),value: "pp"),
      DropdownMenuItem(child: Text("Private Party"),value: "mp"),
      DropdownMenuItem(child: Text("On request"),value: "on"),
    ];
    return menuItems;
  }


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Party at home"),value: "Myparty"),
      DropdownMenuItem(child: Text("Birthday"),value: "Birthday"),
      DropdownMenuItem(child: Text("Outdoor Party"),value: "Outddor"),
      DropdownMenuItem(child: Text("Sesional Party"),value: "sesional"),
    ];
    return menuItems;
  }




  String selectedValue = "Myparty";
  String selectedValues = "pp";





  var thumbType = [
    "Piscine",
    "Alcool",
    "After",
    "Before",
    "18-25 ans",
    "30-40 ans",
    "Deguise",
    "Payant",
    "gratuit",
    "Sexe"
  ];
  List<bool> selectedList = [];
  List<String> selectedLanguage = [];
  late String marque;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'PaybAck'),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Organise ta soiree"),
              backgroundColor: Colors.black87,
            ),
            body: SingleChildScrollView(
              child: Wrap(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Text("Parametrer votre soiree"),
                            TextFormField(
                              controller: nameOfPartyTextFieldController,
                              validator: (String? value) {
                                if (value == null || value.trim().length == 0) {
                                  return "Le nom de la soirée n'est pas saisi ";
                                }
                                return null;
                              },
                              onChanged: (e) => marque = e,
                              decoration: InputDecoration(
                                  hintText: "nom de la soirée",
                                  labelText: "Party name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                filled: true,),
                            ),






                            TextFormField(
                              controller: themeOfPartyTextFieldController,
                              validator: (String? value) {
                                if (value == null || value.trim().length == 0) {
                                  return "Le nom de la soirée n'est pas saisi ";
                                }
                                return null;
                              },
                              onChanged: (e) => marque = e,
                              decoration: InputDecoration(
                                  hintText: "theme de la soirée",
                                  labelText: "Party theme",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                filled: true,),
                            ),

                            DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,

                                ),

                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: dropdownItems)


                            ,DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,

                                ),

                                value: selectedValues,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValues = newValue!;
                                  });
                                },
                                items: Partytype)



                            ,TextFormField(
                              controller: dateOfPartyTextFieldController,
                              onTap: () {
                                _selectDate(context);
                              },
                              validator: (String? value) {
                                if (value == null || value.trim().length == 0) {
                                  return "Le nom de la soirée n'est pas saisi ";
                                }
                                return null;
                              },
                              onChanged: (e) => marque = e,
                              decoration: InputDecoration(
                                  hintText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                  labelText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            Text(
                              "Selectionne des tags  ",
                              textAlign: TextAlign.center,
                            ),
                            Wrap(
                              children: [
                                for (int i = 0; i < thumbType.length; i++)
                                  _listItem(i)
                              ],
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.arrow_forward),
                              label: Text("cree ta soiree"),
                              onPressed: () {
                                // if (!_formkey.currentState!.validate()) return;
                                _createParty();
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.deepPurple),
                                alignment: Alignment.bottomCenter,
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.redAccent),
                              ),
                            ),
                          Lottie.network(
                          'https://assets4.lottiefiles.com/private_files/lf30_sccnvauk.json',width: 140,
                            height: 140,)

                          ],
                        ),
                      ))
                ],
              ),
            )));
  }

  Widget _listItem(int i) {
    selectedList.add(false);
    return Container(
      margin: EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
      child: FilterChip(
        backgroundColor: Colors.black45,
        label: Text(
          thumbType[i],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        selected: selectedList[i],
        onSelected: (bool value) {
          setState(() {
            if (value) {
              selectedLanguage.add(thumbType[i]);
            } else {
              selectedLanguage.remove(thumbType[i]);
            }
            selectedList[i] = value;
            //get selected language
            debugPrint("selected Language :  $selectedLanguage");
          });
        },
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }


  final FirebaseAuth auth = FirebaseAuth.instance;

  final nameOfPartyTextFieldController = TextEditingController();
  final themeOfPartyTextFieldController = TextEditingController();
  final dateOfPartyTextFieldController = TextEditingController();

  void _createParty() async {
    final User? user = auth.currentUser;

    var partyData = {
      'CreatorId': user?.uid,
      'NameOfParty': nameOfPartyTextFieldController.text,
      'ThemeOfParty': themeOfPartyTextFieldController.text,
      'DateOfParty': dateOfPartyTextFieldController.text,
      'partyTags': selectedLanguage
    };

    var partyDbObject = FirebaseFirestore.instance.collection('party');
    partyDbObject
        .add(partyData) // <-- Your data
        .then((_) => print('Added'))
        .catchError((error) => print('Add failed: $error'));

    updateUserPartiesHosting();
  }

  void updateUserPartiesHosting() async {
    final User? user = auth.currentUser;

    QuerySnapshot partySnapshot = await FirebaseFirestore.instance.collection("party").where("CreatorId", isEqualTo: user?.uid).get();
    DocumentSnapshot partyDocumentSnapshot = partySnapshot.docs[0];


    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("user_properties").where("User_UID_Reference", isEqualTo: user?.uid).get();
    DocumentSnapshot documentSnapshot = snapshot.docs[0];
    var userDoc = FirebaseFirestore.instance.collection("user_properties").doc(documentSnapshot.id);
    userDoc.update({'Parties_Hosting_Ids':FieldValue.arrayUnion([partyDocumentSnapshot.id])});
  }

  }


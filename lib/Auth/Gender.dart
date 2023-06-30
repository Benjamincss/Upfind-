import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:lottie/lottie.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Picker',
      theme: ThemeData(fontFamily: 'PaybAck'),
      home: MyHomePage(title: 'Complete Profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = 'Gender Picker'}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFFFFBD73),
      ),
      body:



      SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 15 , height: 15,)


            ,Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_we4yddwi.json')
            ,Container(
              child: Text(
                'Select You genre',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color:Color(0xFFFFBD73)),
              ),
            ),
            getWidget(false, true),


            Container(
              child: Text(
                'You are interested by  ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color:Color(0xFFFFBD73) ),
              ),
            ),
            getWidget(false, true),



            Container(
              height: 60,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:(context)=>MyApp()
                      ));

                },

                child: Center(
                  child: Text(
                    "Continue",
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
      ),
    );
  }

  Widget getWidget(bool showOtherGender, bool alignVertical) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        maleImage:      AssetImage("assets/images/female.png"),
        femaleImage:    AssetImage("assets/discover.png")  ,




        showOtherGender: showOtherGender,

        verticalAlignedText: alignVertical,

        // to show what's selected on app opens, but by default it's Male

        selectedGender: Gender.Male,

        selectedGenderTextStyle: TextStyle(
            color: Color(0xFFFFBD73), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(
            color: Color(0xFFFFBD73), fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          print(gender);
        },

        //Alignment between icons
        equallyAligned: true,

        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(1),
        size: 67, //default : 40

      ),

    );
  }
}

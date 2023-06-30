import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky/Discover.dart';
import 'package:sky/Homepage.dart';
import 'package:sky/party.dart';
import 'package:sky/settings.dart';
import 'package:sky/Auth/signup.dart';
import 'package:sky/Auth/updateProfile.dart';
import'Auth/login.dart';
import 'package:sky/Auth/phone.dart';
import 'package:sky/logsub.dart';




  Future main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upfind',
      home: LoginUiPage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}








class _MyHomePageState extends State<MyHomePage> {
  List <Widget> pages = <Widget> [
    Discover(),
    ChipsDemo(),
    OnboardingScreen(),

  ];

  int _selectedpages = 0;
  final _pageOption  = [
    Text(''),
    ChipsDemo(),
    OnboardingScreen(),


  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        extendBodyBehindAppBar: true,
        appBar: AppBar(

            elevation: 0,
            backgroundColor: Colors.transparent,
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _pageOption[_selectedpages],

                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                        'Upfind',
                        style: TextStyle(
                          fontFamily: 'PaybAck',
                          fontSize: 35,
                        )
                    ),
                  ],
                )



                , IconButton (
                    icon: Icon(Icons.account_box_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>  OnboardingScreen(),
                          ));
                    })
                ,
                IconButton (
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>settings()
                          ));
                    })





                , Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black.withOpacity(0.1)
                  ),
                  child: Icon(Icons.group_add , color: Colors.white,),
                )
              ],
            )
        )



        , bottomNavigationBar: BottomNavigationBar(
        currentIndex:_selectedpages,


        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/discover.png', height: 50 , width: 50,),
            label: 'discover',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/plusde.png', height: 50 , width: 50, ),


            label: 'create',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/group.png', height: 50 , width: 50,)  ,
            label: 'message',

          )
        ],
        onTap: (index){
          setState(() {
            _selectedpages = index ;

          });

        }

    ),


        body: Center ( child: pages.elementAt(_selectedpages) ,)

    );

  }
}




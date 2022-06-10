import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glucose_control/const.dart';
import 'package:glucose_control/model/enterform_doctor.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 40),
          title: const Text(LoginTexts.target)),
      body: const Center(
        child: Image(
          image: AssetImage('assets/images/doctor.jpg'),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        //You can add more widget bellow
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //Now we need multiple widgets into a parent = "Container" widget
    Widget titleSection = Container(
      padding: const EdgeInsets.all(30.0), //Top, Right, Bottom, Left
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: const Text("E Heart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32)),
                ),
                //Need to add space below this Text ?
                Text(
                  "Explore top organic fruit & grab them",
                  style: TextStyle(color: Colors.grey[850], fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    //build function returns a "Widget"
    return MaterialApp(
        title: "",
        home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
              title: const Text(LoginTexts.target)),
          body: ListView(
            children: <Widget>[
              Image.asset('assets/images/insulin.jpg', fit: BoxFit.cover),
              //You can add more widget bellow
              titleSection
            ],
          ),
          floatingActionButton: Theme(
            data: Theme.of(context).copyWith(
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    extendedSizeConstraints:
                        BoxConstraints.tightFor(height: 60, width: 200))),
            child: FloatingActionButton.extended(
              shape: const RoundedRectangleBorder(),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScr()));
              },
              backgroundColor: Colors.green,
              label: const Text('Next'),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        )); //Widget with "Material design"
  }
}

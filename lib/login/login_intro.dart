import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glucose_control/login/login.dart';
import 'package:glucose_control/path.dart';
import '../form_infor/form_doctor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String? myEmail = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 57, 169),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.menu),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Profile"),
                      onTap: () {
                        print("OKOKOOK**********");
                      },
                    ),
                  ]),
        ],
        leading: const Icon(Icons.arrow_back),
        centerTitle: true,
        title: Container(
          width: 45,
          height: 45,
          child: const Icon(Icons.person),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.white24),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: const <Widget>[
                      Card(
                          child: ListTile(
                              title: Text("Ballot"),
                              subtitle: Text("Cast your vote."),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://miro.medium.com/fit/c/64/64/1*WSdkXxKtD8m54-1xp75cqQ.jpeg")),
                              trailing: Icon(Icons.star)))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 500, left: 32),
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 188, 191, 193),
                  ),
                  child: InkWell(
                      child: Image.asset(PathImage.plus_Image),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormScreen()));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      myEmail = ds.data()!['email'].toString();
      print('***********************${myEmail}*************');
    }).catchError((e) {
      print(e);
    });
  }
}

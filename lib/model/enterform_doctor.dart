import 'package:flutter/material.dart';
import 'package:glucose_control/const.dart';
import 'package:glucose_control/form_infor/form_doctor.dart';

class LoginScr extends StatefulWidget {
  @override
  _LoginScrState createState() => _LoginScrState();
}

var emailController = TextEditingController();
var passwordController = TextEditingController();
var EmailErr;
var PassErr;
bool checkEmail = false;
bool checkPass = false;
bool isChecked = false;
bool showPass = false;

class _LoginScrState extends State<LoginScr> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                //title
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: const Text(
                    LoginTexts.title,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
                Container(
                  width: size.width * 3 / 4,
                  height: (checkEmail && checkPass
                      ? size.height * 3 / 6 + 40
                      : size.height * 3 / 6 + 10),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(7.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ]),
                  child: Column(
                    children: [
                      //label Email
                      Container(
                          alignment: Alignment.centerLeft,
                          margin:
                              const EdgeInsets.only(left: 12.0, top: 10, bottom: 5.0),
                          child: const Text(
                            LoginTexts.labelEmail,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),

                      //textfield email
                      Container(
                        width: size.width * 2 / 3,
                        // height: 60,
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              hintText: LoginTexts.hintTextEmail,
                              errorText: checkEmail ? EmailErr : null),
                        ),
                      ),

                      //label password
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                          child: const Text(
                            LoginTexts.labelPass,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),

                      // textfield password
                      Stack(alignment: Alignment.centerRight, children: [
                        Container(
                          width: size.width * 2 / 3,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: TextField(
                            obscureText: !showPass,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              hintText: LoginTexts.hintTextPass,
                              errorText: checkPass ? PassErr : null,
                            ),
                          ),
                        ),

                        // show/hide password
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: checkPass ? 30 : 15, right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPass = !showPass;
                              });
                            },
                            child: Icon(showPass
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_rounded),
                          ),
                        )
                      ]),

                      //remember/forgot password
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Theme(
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                    data: ThemeData(
                                      primarySwatch: Colors.green,
                                      unselectedWidgetColor: Colors.green[200],
                                    ),
                                  ),
                                ),
                                const Text(
                                  LoginTexts.rememberPass,
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                LoginTexts.forgotPass,
                                style: TextStyle(
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //button login
                      SizedBox(
                        width: size.width * 2 / 3,
                        height: 50,
                        child: Container(
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                checkLogin();
                                if (!checkEmail && !checkPass) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormScreen()),
                                  );
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              LoginTexts.title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String value) {
  String pattern = r'^[a-z0-9_]*@[a-z]*(\.[a-z]{3})$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validatePass(String value) {
  String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

void checkLogin() {
  if (emailController.text.isEmpty) {
    checkEmail = true;
    EmailErr = LoginTexts.emptydata;
  } else if (!validateEmail(emailController.text)) {
    checkEmail = true;
    EmailErr = LoginTexts.EmailErr;
  } else {
    checkEmail = false;
  }
  if (passwordController.text.isEmpty) {
    checkPass = true;
    PassErr = LoginTexts.emptydata;
  } else if (!validatePass(passwordController.text)) {
    checkPass = true;
    PassErr = LoginTexts.PassErr;
  } else {
    checkPass = false;
  }
}

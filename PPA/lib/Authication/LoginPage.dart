import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppa/Authication/CreateAccount.dart';
import 'package:ppa/Authication/Method.dart';
import 'package:ppa/Authication/ResetPassword.dart';
import 'package:ppa/Component/Loading.dart';
import 'package:ppa/Screen/DashBoard.dart';
import 'package:ppa/Screen/FAQpage.dart';
import 'package:ppa/Services/UserServices.dart';

import '../db/Account model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List Pdfdata = [];
  var _userService = UserServices();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isloading = false;
  bool passVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isloading
            ? Center(child: spinkit)
            : AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: Text(
                        "Wellcome",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Sign In to Continue!",
                        style: TextStyle(
                          color: Colors.teal[200],
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        cursorColor: Colors.teal,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: [AutofillHints.email],
                        controller: _email,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.teal,
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextField(
                        cursorColor: Colors.teal,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: [AutofillHints.password],
                        onEditingComplete: () =>
                            TextInput.finishAutofillContext(),
                        controller: _password,
                        obscureText: passVisibility,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passVisibility = !passVisibility;
                                });
                              },
                              icon: Icon(
                                passVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.teal,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.teal,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_email.text.isNotEmpty &&
                              _password.text.isNotEmpty) {
                            setState(() {
                              isloading = true;
                            });
                            var _ModelUser = ModelUser();
                            _ModelUser.email = _email.text.trim();
                            _ModelUser.pass = _password.text;
                            await getData();
                            print(Pdfdata);
                            setState(() {
                              isloading = false;
                            });
                            if (Pdfdata.isNotEmpty) {
                              _email.clear();
                              _password.clear();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard()));
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Invalid Username & Password'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            // Loginuser(_email.text.trim(), _password.text).then((user){
                            //   if(user!=null){
                            //     setState(() {
                            //       isloading=false;
                            //     });
                            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                            //   }else{
                            //     setState(() {
                            //       const snackBar = SnackBar(
                            //         content: Text('Invalid Password'),
                            //       );
                            //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            //       isloading=false;
                            //     });
                            //   }
                            // } );

                          } else {
                            const snackBar = SnackBar(
                              content: Text('Invalid Email & Password'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?   "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.teal),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()));
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
                            },
                            child: Text(
                              "FAQs",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/bg.png"),
                          fit: BoxFit.fitHeight,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
  getData() async {

    var users=await _userService.Sigin(_email.text.trim(),_password.text);
    users.forEach((user){
      setState(() {
        Pdfdata.add(user);
      });
    });
  }
}

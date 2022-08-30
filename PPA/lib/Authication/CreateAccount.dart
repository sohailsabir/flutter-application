


import 'package:flutter/material.dart';
import 'package:ppa/Authication/LoginPage.dart';
import 'package:ppa/Authication/Method.dart';
import 'package:ppa/Services/UserServices.dart';
import 'package:ppa/db/Account%20model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


import '../Component/Loading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List Pdfdata = [];
  TextEditingController _email= TextEditingController();
  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();
  bool check=false;
  bool isloading=false;
  var _userService=UserServices();
  final _form = GlobalKey<FormState>();
  bool emailValidation(String e){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    return emailValid;
  }

  bool passVisibility=true;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isloading?Center(child: spinkit,):Form(
          key: _form,
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
                      color: Colors.teal
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Sign Up to Continue!",
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
                child: TextFormField(
                  cursorColor: Colors.teal,
                  controller: _email,
                  validator: (value){
                    if(!emailValidation(value!)||value.isEmpty){
                      return "Please enter valid email adddress";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.email,color: Colors.teal,),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
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
                child: TextFormField(
                  cursorColor: Colors.teal,
                  controller: _username,
                  validator: (value){
                    if(value!.isEmpty||value.length<4){
                      return "Please enter atleast 4 character";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.question_answer,color: Colors.teal,),
                      hintText: "Text for reset password.eg:school",
                      hintStyle: TextStyle(color: Colors.grey),
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
                child: TextFormField(
                  cursorColor: Colors.teal,
                  controller: _password,
                  validator: (value){
                    if(value!.isEmpty||value.length<7){
                      return "Please enter at least 7 character";
                    }
                    return null;
                  },
                  obscureText: passVisibility,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          passVisibility=!passVisibility;
                        });
                      }, icon: Icon(passVisibility?Icons.visibility:Icons.visibility_off,color: Colors.teal,),),
                      prefixIcon: Icon(Icons.lock,color: Colors.teal,),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
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
                  onPressed: () async{
                    if(!_form.currentState!.validate()){
                      return;
                    }
                    else if(_form.currentState!.validate()){
                      await getData();
                      if(Pdfdata.isEmpty){
                        setState(() {
                          isloading=true;
                        });
                        var _ModelUser=ModelUser();
                        _ModelUser.email=_email.text.trim();
                        _ModelUser.pass=_password.text;
                        _ModelUser.question=_username.text;

                        var result=await _userService.SaveUserAccount(_ModelUser);
                        Pdfdata=[];
                        print(result);
                        if(result!=null){
                          setState(() {
                            isloading=false;
                            Pdfdata=[];
                            check=true;
                          });
                          _email.clear();
                          _username.clear();
                          _password.clear();

                          const snackBar = SnackBar(
                            content: Text('Account Create Successfully'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        }
                        else{
                          const snackBar = SnackBar(
                            content: Text('Sothing went wrong'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);

                        }

                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(child: Text('Error',style: TextStyle(color: Colors.teal),)),
                                content: Text("Account already created. Please reinstall the app then create account."),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 12,

                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }


                      // setState(() {
                      //   isloading=true;
                      // });

                      // createAccount(_username.text, _email.text.trim(), _password.text).then((user){
                      //   if(user!=null){
                      //     setState(() {
                      //       isloading=false;
                      //       const snackBar = SnackBar(
                      //         content: Text('Create Account Successfully'),
                      //       );
                      //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //     });
                      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      //
                      //   }
                      //   else{
                      //     const snackBar = SnackBar(
                      //       content: Text('Something went wrong'),
                      //     );
                      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //
                      //     setState(() {
                      //       isloading=false;
                      //     });
                      //   }
                      // });
                      print('Good');


                    }

                    else{
                      print("Please enter feild");
                    };

                  },
                  child: Text(
                    "Sign Up",
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
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?   "),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: Text("Sign In",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color:Colors.teal
                    ),),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bg.png"),
                        fit: BoxFit.fitHeight,
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  getData() async {
    var users=await _userService.ReadAllUser();
    users.forEach((user){
      setState(() {
        Pdfdata.add(user);
      });
    });
  }
}


import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ppa/Screen/ResetPasswordScreen.dart';

import '../Services/UserServices.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  List Pdfdata = [];
  var _userService = UserServices();
  TextEditingController _email= TextEditingController();
  final _form = GlobalKey<FormState>();
  bool emailValidation(String e){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    return emailValid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Enter Reset Password Text eg:school name",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.teal
                ),),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  cursorColor: Colors.teal,
                  controller: _email,
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
                      hintText: "Reset Password text",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton.icon(
                  onPressed: () async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    if(!_form.currentState!.validate()){
                      return;
                    }
                    if(_form.currentState!.validate()){

                      await getData();
                      if(Pdfdata.isNotEmpty){
                        print(Pdfdata);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen(PDFData: Pdfdata,)));

                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text('Invalid Question Text'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }

                    }


                  },
                  icon: Icon(Icons.mail_outline),
                  label: Text("Reset Password",style: TextStyle(fontSize: 20.0),),

                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
  Future verifyEmail()async{
    try{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=>Center(child: CircularProgressIndicator(),));
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      final snackBar = SnackBar(
        content: Text("Password Reset Email Send"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);

    }on FirebaseAuthException catch(e){

      Navigator.pop(context);
      print(e);
      final snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }
  getData() async {

    var users=await _userService.Match(_email.text);
    users.forEach((user){
      setState(() {
        Pdfdata.add(user);
      });
    });
  }
}

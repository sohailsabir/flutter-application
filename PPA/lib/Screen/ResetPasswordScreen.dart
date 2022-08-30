import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppa/Authication/LoginPage.dart';
import 'package:ppa/Services/UserServices.dart';
import 'package:ppa/db/passwordmodel.dart';

import '../db/Account model.dart';
class ResetPasswordScreen extends StatefulWidget {
   ResetPasswordScreen({required this.PDFData});
   final List PDFData;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _email= TextEditingController();
  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();
  List Pdfdata = [];
  var _userService = UserServices();
  final _form = GlobalKey<FormState>();
  bool emailValidation(String e){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
    return emailValid;
  }
  @override
  void initState(){
    print(widget.PDFData);



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Update Password")),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 5,),
                Center(child: Text("Old Password",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),)),
                Container(
                  padding: EdgeInsets.all(10),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email: ${widget.PDFData[0]['username']}",style: TextStyle(fontSize: 18),),
                    Text('Password: ${widget.PDFData[0]['pass']}',style: TextStyle(fontSize: 18),),
                    Text('Reset Password Text: ${widget.PDFData[0]['question']}',style: TextStyle(fontSize: 18),),
                  ],
                )),


                SizedBox(
                  height: 50.0,
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
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.teal, width: 2.0),
                        ),
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
                        var modaluser=ModelUser();
                        modaluser.id=widget.PDFData[0]['id'];
                        modaluser.email=_email.text.trim();
                        modaluser.pass=_password.text;
                        modaluser.question=_username.text;
                        var result=await _userService.UpdateUserAccount(modaluser);
                        if(result!=null)
                          {
                            _email.clear();
                            _password.clear();
                            _username.clear();
                            const snackBar = SnackBar(
                              content: Text('Password Update Successfully'),
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
                        const snackBar = SnackBar(
                          content: Text('Please fill all field'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);;
                      };

                    },
                    child: Text(
                      "Update Password",
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

              ],
            ),
          ),
        ),
      ),
    );
  }
  // getData() async {
  //
  //   var users=await _userService.AccountData(widget.PDFData[0]['id']);
  //   users.forEach((user){
  //     setState(() {
  //       Pdfdata.add(user);
  //     });
  //   });
  // }
}

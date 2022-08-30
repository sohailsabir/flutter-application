import 'package:flutter/material.dart';

class LoginFAQs extends StatefulWidget {
  const LoginFAQs({Key? key}) : super(key: key);

  @override
  _LoginFAQsState createState() => _LoginFAQsState();
}

class _LoginFAQsState extends State<LoginFAQs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FAQs"),centerTitle: true,backgroundColor: Colors.teal),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey
          ),
        ),
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How can I log in to the app?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
            SizedBox(height: 15,),
            Text('1. Firstly you create the account e.g: Enter any email, Reset password text and password.',style: TextStyle(color: Colors.grey),),
            SizedBox(height: 10,),
            Text('2. Reset Password text are the text that are used when you forget your password or change your password.',style: TextStyle(color: Colors.grey),),
            SizedBox(height: 10,),
            Text('3. Then you can login with email and password',style: TextStyle(color: Colors.grey),),
            SizedBox(height: 10,),
            Text('4. To reset the password click reset password button and enter Reset Password Text',style: TextStyle(color: Colors.grey),),


          ],
        ),
      ),

    );
  }
}





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ppa/Authication/LoginPage.dart';
import 'package:ppa/Screen/DashBoard.dart';

class CheckUser extends StatelessWidget {

FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser!=null){
      return DashBoard();

    }
    else{
      return LoginPage();
    }
  }
}

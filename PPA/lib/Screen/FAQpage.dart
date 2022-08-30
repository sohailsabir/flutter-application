import 'package:flutter/material.dart';
import 'package:ppa/Screen/Feature.dart';
import 'package:ppa/Screen/LoginFAQs.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: Text('FAQs'),centerTitle: true,backgroundColor: Colors.teal),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 25,horizontal: 20)
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginFAQs()));
            }, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person,color: Colors.grey.shade700,size: 40,),
                      SizedBox(width: 20,),
                      Text('LOGIN',style: TextStyle(color: Colors.grey.shade700,fontSize: 20,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,color: Colors.grey.shade700),
            ],
          ),),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 25,horizontal: 20)
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeaturePage()));
            }, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.mobile_friendly,color: Colors.grey.shade700,size: 40,),
                      SizedBox(width: 20,),
                      Text('FEATURES',style: TextStyle(color: Colors.grey.shade700,fontSize: 20,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,color: Colors.grey.shade700),
            ],
          ),),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body: SafeArea(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Center(child: Text('Welcome user', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),)),
           Center(child: Text(FirebaseAuth.instance.currentUser!.uid))
         ],
       ),
     ),
   );
  }

}
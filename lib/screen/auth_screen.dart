import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_application/widget/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  void _submitAuthScreen(String email,String password , String username , bool isLogin) async {

    if(isLogin)
        {
         UserCredential userCredential =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
             password: password);
        }else
          {
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
                password: password);
            CollectionReference collectionReference = await FirebaseFirestore.instance.collection('user');
            collectionReference.doc(userCredential.user!.uid).set({
              'username' : username,
              'email' : email,
              'password' : password
            });

          }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthScreen)
      ,
    );
  }
}


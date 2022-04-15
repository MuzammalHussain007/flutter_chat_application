import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_application/screen/chat_screen.dart';
import 'package:flutter_chat_application/widget/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/AuthScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {


  void _submitAuthScreen(String email,String password , String username , bool isLogin,File? userImage) async {

    if(isLogin)
        {
         UserCredential userCredential =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
             password: password).whenComplete((){
               print('done');
               Navigator.pushNamed(context, ChatScreen.routeName);
         }).catchError((error){
           print(error);
         });
        }else
          {

            print('AuthForm');
            print(userImage);

            final imageRef =  FirebaseStorage.instance
                .ref()
                .child("userImage")
                .child(FirebaseAuth.instance.currentUser!.uid + ".jpg");
            final metadata = SettableMetadata(
              contentType: 'image/jpeg',
            );
            await imageRef.putFile(userImage!,metadata).whenComplete(() {
             print('imageUploaded');
            });

            final imageURL =  await imageRef.getDownloadURL().whenComplete(() {
              print('image URL Get');
            });

            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
                password: password);
            CollectionReference collectionReference =
            await FirebaseFirestore.instance.collection('users');
            collectionReference
                .doc(userCredential.user?.uid)
                .set({'username': username,
              'email': email,
              'password': password,
              'imageURL' : imageURL
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


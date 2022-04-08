import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
            {
             return const Center(
               child: CircularProgressIndicator(),
             );
            }
          return ListView.builder(
              itemCount: snapshot.requireData.size,
              itemBuilder: (ctx,i)=>Container(

                padding: EdgeInsets.all(20.0),
                child: Text('this works'),
              ));
        },),
    ) ;
  }
}

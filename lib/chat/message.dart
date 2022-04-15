import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_application/chat/message_bubble.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser!.uid),
        builder: (ctx,futureSnapeShot){
      if(futureSnapeShot.connectionState==ConnectionState.waiting)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      return StreamBuilder( stream:FirebaseFirestore.instance.collection('chats').orderBy('createdAt',descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        return ListView.builder(
            reverse: true,
            itemCount: snapshot.requireData.size,
            itemBuilder: (ctx, i) {
              DocumentSnapshot course = snapshot.data.docs[i];
              print(course['message']);
              return Container(
                padding: EdgeInsets.all(20.0),
                child: MessageBubble(
                    course['message'],
                    course['userid']==FirebaseAuth.instance.currentUser!.uid,
                    course['userid']
                  , ValueKey(course['userid']),
                ),

              );
            });
          },);
    }
    );
  }
}

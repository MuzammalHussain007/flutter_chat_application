import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String message;
  bool isMe;
  final Key key ;
  String userid;
  MessageBubble(this.message,this.isMe,this.userid,this.key);
  @override
  Widget build(BuildContext context) {
    print(userid);
    return   Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                  bottomLeft: !isMe ? const Radius.circular(0): const Radius.circular(12.0), bottomRight: !isMe ? Radius.circular(0): const Radius.circular(12.0)
              ),
            ),
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
            margin: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  builder: (context, snapshot) {

                    if(snapshot.connectionState==ConnectionState.waiting)
                    {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return
                      Text(snapshot.data?['username']  ,style: const TextStyle(

                          fontWeight: FontWeight.bold,

                      ),textAlign: isMe ? TextAlign.end :TextAlign.start,);
                  },
                  future: FirebaseFirestore.instance.collection('users').doc(userid).get(),
                ),
                Text(message,
                  style: TextStyle(color:isMe ? Colors.black : Theme.of(context).textTheme.labelLarge?.color),textAlign:  isMe ? TextAlign.end :TextAlign.start,

                ),
              ],
            )
        )
      ],
    );

  }
}

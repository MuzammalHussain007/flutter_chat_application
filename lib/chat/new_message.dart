import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageEntered = '';
  var _controller = TextEditingController();

  void _newMessage() async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance
        .collection('chats')
        .add({'message': _messageEntered,
      'createdAt': Timestamp.now(),
       'userid' : FirebaseAuth.instance.currentUser!.uid
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter New Message'),
            onChanged: (value) {
              setState(() {
                _messageEntered = value;
              });
            },
          )),
          IconButton(
            onPressed: _messageEntered.isEmpty
                ? null
                : () {
                    _newMessage();
                  },
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}

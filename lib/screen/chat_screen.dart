import 'package:flutter/material.dart';
 import 'package:flutter_chat_application/chat/message.dart';
import 'package:flutter_chat_application/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chatScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Chat Screen'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(child: Message()),
            NewMessage()
          ],
        ),
      )
    ) ;
  }
}

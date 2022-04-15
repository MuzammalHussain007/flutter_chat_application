import 'package:flutter/material.dart';
import 'package:flutter_chat_application/screen/auth_screen.dart';
import 'package:flutter_chat_application/screen/chat_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)))),
      title: 'Application',
      home: const AuthScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        ChatScreen.routeName: (ctx)=> ChatScreen(),
      },
    );
  }
}

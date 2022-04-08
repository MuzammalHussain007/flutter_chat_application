import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);
  final void Function(String email, String password , String username,bool isLogin) submitFn ;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true ;
  String _email = "";
  String _password = "";
  String _username = "";

  void _trySubmitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_email);
      print(_password);
      print(_username);

      widget.submitFn(
        _email,_password ,_username , _isLogin
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                  TextFormField(
                    key: const ValueKey('userName'),
                    onSaved: (value) {
                      _username = value.toString();
                    },
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Enter user Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'User Name'),
                  ),
                  TextFormField(
                    key: const ValueKey('email'),

                    onSaved: (value) {
                      _email = value.toString();
                    },
                    validator: (value) {
                      if (value.toString().isEmpty ||
                          !value.toString().contains('@')) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (value) {
                      _password = value.toString();
                    },
                    validator: (value) {
                      if (value.toString().isEmpty ||
                          value.toString().length < 7) {
                        return ' Password must be 7 character long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _trySubmitForm();
                    },
                    child:  Text(_isLogin ? 'Login' : 'SignUp'),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin ? 'Create an Account' : 'Already have an Account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

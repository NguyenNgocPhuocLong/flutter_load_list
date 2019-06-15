import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Form SignUp',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: InputBox(),
      );
  }
}

class InputBox extends StatefulWidget{
  @override
  InputBoxState createState() => InputBoxState();
}

class InputBoxState extends State<InputBox>{
  bool loggedIn = false;
  String _email, _userName, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: mainKey,
      appBar: AppBar(title: Text('Form SignUp')),
      body: Padding(
          padding: EdgeInsets.all(10.0),
        child: loggedIn == false?
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
                validator: (str)=> !str.contains('@')?'Valid Email':null,
                onSaved: (str) => _email = str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "UserName"
                ),
                validator: (str)=> str.length < 6?'Valid UserName':null,
                onSaved: (str) => _userName = str,
              ),TextFormField(
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password"
                ),
                validator: (str)=> !str.contains('@')?'Valid Password':null,
                onSaved: (str) => _password = str,
              ),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text('Sign In'),
                onPressed: onPresseForm,

              )
            ],
          ),
        ): Center(
          child: Column(
            children: <Widget>[
              Text("Welcome $_userName"),
              RaisedButton(
                color: Colors.deepOrange,
                child: Text("Log out"),
                onPressed: (){
                  setState(() {
                    loggedIn =false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPresseForm(){
    var form = formKey.currentState;

    if(form.validate()){
      form.save();
      setState(() {
        loggedIn =true;
      });

      var snackBar = SnackBar(
        content:
        Text('Username: $_userName, Email: $_email, Password: $_password'),
        duration: Duration(milliseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackBar);
    }

  }
}
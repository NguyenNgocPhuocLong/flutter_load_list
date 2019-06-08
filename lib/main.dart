import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: StarWarsData()
  ));
}

class StarWarsData extends StatefulWidget{
  @override
  StarWarsState createState()=> StarWarsState();
}

class StarWarsState extends State<StarWarsData>{
  final String url = "https://swapi.co/api/starships";
  List  data;
  String next="";

  Future<String> getSwData(String link) async{
    var linkApi = "";
    if(link != ""){
      linkApi = link;
    }else{
      linkApi = url;
    }
    var res = await http.get(Uri.parse(linkApi),headers: {"Accept":"application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      if(data == null){
        data = resBody['results'];
      }else{
        data.addAll(resBody['results']);
      }

      next = resBody['next'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Startships"),
        backgroundColor: Colors.deepPurpleAccent
      ),
      body: ListView.builder(
        itemCount: data == null ?0:data.length,
        itemBuilder: (BuildContext context,int index){
          if(index > data.length -2 ){

            this.getSwData(next);
          }
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text("Name: "),
                          Text(data[index]['name'],style: TextStyle(fontSize: 18.0,color: Colors.black87)),

                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text("Model: "),
                          Text(data[index]['model'],style: TextStyle(fontSize: 18.0,color: Colors.black87)),

                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text("Cargo_Capacity: "),
                          Text(data[index]['cargo_capacity'],style: TextStyle(fontSize: 18.0,color: Colors.black87)),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    this.getSwData("");
  }
}
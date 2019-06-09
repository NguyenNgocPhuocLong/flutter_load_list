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
      title: 'Photo Streamer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PhotoList()
    );
  }
}

class PhotoList extends StatefulWidget{
  @override
  PhotoListState createState() => PhotoListState();
}

class PhotoListState extends State<PhotoList>{
  StreamController<Photo> streamController;
  List<Photo> list =[];

  @override
  void initState(){
    super.initState();
    streamController = StreamController.broadcast();

    streamController.stream.listen((p)=> setState(()=> list.add((p))));

    load(streamController);
  }

  load(StreamController<Photo> sc) async{
    String url ="https://jsonplaceholder.typicode.com/photos";
    var client = new http.Client();

    var req = new http.Request('get', Uri.parse(url));

    var streamRes = await client.send(req);

    streamRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((e)=> e)
      .map((map)=> Photo.fromJsonMap(map))
    .pipe(sc);
  }

  @override
  void dispose(){
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Streams'),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context,int index) => _makeElement(index),
        ),
      ),
    );
  }

  Widget _makeElement(int index){
    if(index >= list.length){
      return null;
    }

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Image.network(list[index].url),
            Text(index.toString() + ":" +list[index].title)
          ],
        ),
      ),
    );
  }
}


class Photo{
  final String title;
  final String url;
  Photo.fromJsonMap(Map map) : title = map['title'],url = map['url'];
}
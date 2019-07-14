import 'dart:math';

import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      title: "Random Squares",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<MyApp> {
  final Random _random = Random();
  Color color = Colors.amber;

  void onTap() {
    setState(() {
      color = Color.fromARGB(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ColorState(
      color: color,
      onTap: onTap,
      child: BoxTree(),
    );
  }
}

class ColorState extends InheritedWidget {
  ColorState({Key key, this.color, this.onTap, Widget child})
      : super(key: key, child: child);

  final Color color;
  final Function onTap;

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    // TODO: implement ==
    print(oldWidget);
    return color != oldWidget.color;
  }

  static ColorState of(BuildContext context) {
    print(context);
    return context.inheritFromWidgetOfExactType(ColorState);
  }
}

class BoxTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[Box(), Box()],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final colorState = ColorState.of(context);
    return GestureDetector(
      onTap: colorState.onTap,
      onVerticalDragUpdate: (d) => print('drag vertial'),
      onHorizontalDragUpdate: (d) => print('drag horizon'),
      child: Container(
        width: 50.0,
        height: 50.0,
        margin: EdgeInsets.only(left: 100.0),
        color: colorState.color,
      ),
    );
  }
}

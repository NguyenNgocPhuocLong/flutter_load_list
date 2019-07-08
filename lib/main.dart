import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  double input;
  double output;
  bool fOrC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch (err) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText: "Input a value in ${!fOrC ? "Fahrenheit" : "Celsius"}",
      ),
      textAlign: TextAlign.center,
    );

    AppBar appBar = AppBar(
      title: Text("Temperature Calculator"),
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          //use switch
          //Text("Choose Fahrenheit or Celsius"),
          //Switch(
          //  value: fOrC,
          //  onChanged: (e) {
          //    setState(() {
          //      fOrC = !fOrC;
          //    });
          //  },
          //)

          //Checkbox(
          //  value: fOrC,
          //  onChanged: (e) {
          //    setState(() {
          //      fOrC = !fOrC;
          //    });
          //  },
//),

          Text("F"),
          Radio<bool>(
            groupValue: fOrC,
            value: false,
            onChanged: (v) {
              setState(() {
                fOrC = v;
              });
            },
          ),
          Text("C"),
          Radio<bool>(
            groupValue: fOrC,
            value: true,
            onChanged: (v) {
              setState(() {
                fOrC = v;
              });
            },
          ),
        ],
      ),
    );

    Container calcBtn = Container(
      child: RaisedButton(
        child: Text("Calculate"),
        onPressed: () {
          setState(() {
            !fOrC
                ? output = (input - 32) * (5 / 9)
                : output = (input * 9 / 5) + 32;
          });
          AlertDialog dialog = AlertDialog(
              content: !fOrC
                  ? Text(
                  "${input.toStringAsFixed(2)} F: ${output.toStringAsFixed(
                      2)} C ")
                  : Text(
                  "${output.toStringAsFixed(2)} F: ${input.toStringAsFixed(
                      2)} C"));
          showDialog(context: context, child: dialog);
        },
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[inputField, tempSwitch, calcBtn],
        ),
      ),
    );
  }
}

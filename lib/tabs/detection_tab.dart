import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cv_demo/tabs/camera_tab.dart';

const Color bgBlack = Color(0xDD1a1a1a);
const Color mainBlack = Color(0xFF262626);
const Color mainGrey = Color(0xDD505050);

class DetectionTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetectionTabState();
}

class _DetectionTabState extends State<DetectionTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detection Task",
        ),
        backgroundColor: bgBlack,
      ),
      backgroundColor: Color.fromARGB(255, 214, 208, 208),
      body: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 25),
          height: 150,
          width: double.infinity,
          child: Text(
            'This is a fruit detection demo:\n- press the button\n- take a pic\n- wait for result.',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        RaisedButton(
          child: Text('press'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return TakePictureScreen();
                }));
          },
        )
      ]),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const Color bgBlack = Color(0xDD1a1a1a);
const Color mainBlack = Color(0xFF262626);
const Color mainGrey = Color(0xDD505050);

class DetectionTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetectionTabState();
}

class _DetectionTabState extends State<DetectionTab> {
  var TEST_URL = Uri.parse("https://cv-demo-app.herokuapp.com/test");
  var FRUIT_DETECTION_URL = Uri.parse("https://cv-demo-app.herokuapp.com/fruit_detection");
  var IMAGE_URL = Uri.parse("https://cv-demo-app.herokuapp.com/image_test");

  PickedFile file;
  final _picker = ImagePicker();

  TextEditingController queryController = TextEditingController();

  String _result_string = "";
  Uint8List _selectedBytes;

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
            'This is a fruit detection demo:\n- press the button\n- choose a pic\n- wait for result.',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        RaisedButton(
          child: Text('Choose a pic'),
          onPressed: _choose,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            decoration: InputDecoration(

            ),
            controller: queryController,
            onSubmitted: (msg){
              this.getTestResponse();
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 25),
          height: 150,
          width: double.infinity,
          child: Text(
            _result_string,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Get Image'),
              onPressed: getImageResponse,
            ),
            getImageWidget(),
          ],
        ),
      ]),
    );
  }


  Future<void> getTestResponse() async {
    var client = http.Client();
    try {
      client.post(
          TEST_URL,
          body: {"query": queryController.text},
      ).. then((response){
        print(response.body);
        this.setState((){
          _result_string = response.body.toString();
        });
      });
    } finally {
      client.close();
      queryController.clear();
    }
  }

  void _choose() async {
    file = await _picker.getImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    String fileName = file.path.split("/").last;
    print(fileName);
    final base64Image = base64Encode(bytes);
    var client = http.Client();
    try {
      client.post(
        FRUIT_DETECTION_URL,
        body: {"image":  base64Image},
      ).. then((response){
        print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        this.setState((){
          _result_string = data['response'].toString();
        });
      });
    } finally {
      client.close();
    }
  }

  Widget getImageWidget() {
    if (_selectedBytes != null) {
      return Image.memory(
        _selectedBytes,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "images/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  void getImageResponse() async {
    var client = http.Client();
    try {
      client.post(
        IMAGE_URL,
        body: {"query": 'text'},
      ).. then((response){
        print(response.body);
        Map<String, dynamic> response_data = jsonDecode(response.body);
        Uint8List image = base64Decode(response_data['response'].substring(2, response_data['response'].length -1));
        this.setState((){
          _selectedBytes = image;
        });

      });
    } finally {
      client.close();
    }
  }


}

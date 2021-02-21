import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color bgBlack = Color(0xDD1a1a1a);
const Color mainBlack = Color(0xFF262626);
const Color mainGrey = Color(0xDD505050);


class SegmentationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Segmentation Task",
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text('kappa')),
    );
  }
}

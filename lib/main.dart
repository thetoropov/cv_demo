import 'package:flutter/material.dart';

import 'package:cv_demo/tabs/detection_tab.dart';
import 'package:cv_demo/tabs/segmentation_tab.dart';
import 'package:cv_demo/tabs/style_transfer_tab.dart';
import 'package:cv_demo/widgets/category_card.dart';

const Color bgBlack = Color(0xDD1a1a1a);
const Color mainBlack = Color(0xFF262626);
const Color mainGrey = Color(0xDD505050);

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Demo App',
      theme: ThemeData(
          fontFamily: "Ciaro",
          scaffoldBackgroundColor: bgBlack,
          textTheme:
          Theme.of(context).textTheme.apply(displayColor: Colors.white)),
      home: HomeTab(),
    );
  }
}


class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgBlack,
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: mainBlack,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Welcome to CV demo!\nChoose a task:",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: .85,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: <Widget>[
                          CategoryCard(
                            title: 'Detection',
                            img: 'images/detection_icon.png',
                            press: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetectionTab();
                              }));
                            },
                          ),
                          CategoryCard(
                            title: 'Segmentation',
                            img: 'images/segmentation_icon.png',
                            press: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SegmentationTab();
                              }));
                            },
                          ),
                          CategoryCard(
                            title: 'Style Transfer',
                            img: 'images/style_transfer_icon.png',
                            press: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StyleTransferTab();
                              }));
                            },
                          ),
                          CategoryCard(
                            title: 'Coming soon',
                            img: 'images/coming_soon_icon.png',
                            press: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

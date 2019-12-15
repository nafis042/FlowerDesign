import 'package:flutter/material.dart';
import 'explore_widget.dart';
import 'navigation_bar.dart';
import 'placeholder_widgetr.dart';

class FlowerPage extends StatefulWidget {
  static String tag = 'login_page';

  @override
  FlowerPageState createState() => new FlowerPageState();
}


class FlowerPageState extends State<FlowerPage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();


  final List<Widget> _children = [
    ExploreWidget(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 70.0,
        items: <Widget>[
          Image.asset(
            'images/explore.png',
            height: 30,
            width: 30,
          ),
          Image.asset(
            'images/makeit.png',
            height: 30,
            width: 30,
          ),
          Icon(Icons.menu, color: Colors.amber, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}

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
      bottomNavigationBar: Material(
        shadowColor: Colors.black,
        elevation: 10,
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 70.0,
          items: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Image.asset(
                  'images/explore.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(height: 8,),
                Text('Explore'),
                SizedBox(height: 8,)
              ],
            ),
            Container(
//            color: Colors.green,
              height: 90,
              constraints: BoxConstraints(
                minHeight: 90
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
//              Image.asset(
//                'images/makeit.png',
//                height: 52,
//                width: 52,
//              ),
                  Container(
                    height: 30,
                    width: 30,
                    color: Colors.red,
                  ),
                  SizedBox(height: 20,),
                  Text('Make it'),
                  SizedBox(height: 8,)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.menu, color: Colors.grey, size: 30),
                SizedBox(height: 8,),
                Text('Orders'),
                SizedBox(height: 8,)
              ],
            ),
//          Image.asset(
//            'images/explore.png',
//            height: 10,
//            width: 10,
//          ),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
      ),
    );
  }
}

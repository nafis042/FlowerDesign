import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'flower_details_page.dart';
import 'flower_list_model.dart';


final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];


class ExploreWidget extends StatefulWidget {


  @override
  ExploreWidgetState createState() => new ExploreWidgetState();
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class ExploreWidgetState extends State<ExploreWidget> {


  AsyncSnapshot snapshotData;
  List<FlowerListModel> _list;
  int _current = 0;

  _getList() async {
    var client = new http.Client();
    try {
      var response =
      await client.get('http://18.221.244.108:8000/flower/api/flowers/');

      if (response.statusCode == 200) {
        print("flower list success");
        var jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse
            .map<FlowerListModel>((obj) => FlowerListModel.fromJson(obj))
            .toList());
        setState(() {
          _list = jsonResponse
              .map<FlowerListModel>((obj) => FlowerListModel.fromJson(obj))
              .toList();
        });
        print(_list.first.name_en);
      }
    } finally {
      client.close();
    }
  }



  final List child = map<Widget>(
    imgList,
        (index, i) {
      return Container(
//        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          child: Stack(children: <Widget>[
            Image.network(
              i,
              fit: BoxFit.fitWidth,
              width: 1000.0,
            ),
          ]),
        ),
      );
    },
  ).toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 180,
          pinned: true,
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: Icon(
              Icons.search,
              color: Colors.blueAccent,
              size: 30,
            ),
          ),
          flexibleSpace: Stack(fit: StackFit.expand, children: [
            CarouselSlider(
              items: child,
//                autoPlay: true,
              viewportFraction: 1.0,
//                aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            Positioned(
              bottom: 8.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  imgList,
                      (index, url) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          _current == index ? Colors.white : Colors.grey),
                    );
                  },
                ),
              ),
            )
          ]),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.white,
              ),
              width: 40,
              child: Icon(
                Icons.more_horiz,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ],
        ),
//
//          SliverPersistentHeader(
//              pinned: true,
//              delegate: _SliverAppBarDelegate()),

        SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 150,
                color: Colors.white,
                child: ListView(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      crossAxisAlignment: CrossAxisAlignment.center,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 150,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/bouquet.png'))),
                    ),
                    Container(
                      height: 150,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/vases.png'))),
                    ),
                    Container(
                      height: 150,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/boxes.png'))),
                    ),
                    Container(
                      height: 150,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/baskets.png'))),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Container(
                height: 330,
//                     color: Colors.red,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Shop By Occasions',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Center(
                            child: Text('View All'),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(top: 16),
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/birthday.png'),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(top: 16),
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/wedding.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(top: 8),
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/thank.png'),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(top: 8),
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/grad.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Container(
                height:
                _list == null ? 0 : (_list.length / 2).floor() * 270 + 90.0,
//                     color: Colors.red,
                padding: EdgeInsets.all(16.0),
                child: _list == null ? Container() : Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Popular Orders',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    for (int i = 0; i <= (_list.length / 2).floor(); i += 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print("tapped $i");
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                        Duration(milliseconds: 300),
                                        pageBuilder: (_, __, ___) =>
                                            FlowerDetails(
                                              flowerListModel: _list[i],
                                            )));
                              },
                              child: Container(
                                height: 270,
                                width:
                                (MediaQuery.of(context).size.width - 40) / 2,
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      height: 60,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.blue,
                                              Colors.lightBlue
                                            ]),
                                            border: Border.all(
                                                color:
                                                Colors.grey.withOpacity(0.5)),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(32),
                                                topLeft: Radius.circular(32))),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              _list[i].name_en,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      height: 50,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color:
                                                Colors.grey.withOpacity(0.5)),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(32),
                                                bottomRight:
                                                Radius.circular(32))),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "${_list[i].price} USD",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 40,
                                      child: Container(
                                        height: 200,
                                        //                                    margin: EdgeInsets.only(top: 16),
                                        padding: EdgeInsets.all(8),
                                        width:
                                        (MediaQuery.of(context).size.width -
                                            40) /
                                            2,
                                        decoration: BoxDecoration(
                                          //                              gradient: LinearGradient(
                                          //                                  colors: [
                                          //                                    Colors.blue,
                                          //                                    Colors.lightBlue
                                          //                                  ]
                                          //                              ),
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Colors.grey.withOpacity(0.5)),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${_list[i].image}'),
                                                  fit: BoxFit.fill)),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, top: 8.0),
                                                child: Image.asset(
                                                  'images/sm_flower.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            i < _list.length - 1
                                ? GestureDetector(
                              onTap: () {
                                print("tapped ${i + 1}");
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                        Duration(milliseconds: 300),
                                        pageBuilder: (_, __, ___) =>
                                            FlowerDetails(
                                              flowerListModel: _list[i + 1],
                                            )));
                              },
                              child: Container(
                                height: 270,
                                width: (MediaQuery.of(context).size.width -
                                    40) /
                                    2,
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      height: 60,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.blue,
                                                  Colors.lightBlue
                                                ]),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                Radius.circular(32),
                                                topLeft:
                                                Radius.circular(32))),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              _list[i + 1].name_en,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      height: 50,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(32),
                                                bottomRight:
                                                Radius.circular(32))),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "${_list[i + 1].price} USD",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 40,
                                      child: Container(
                                        height: 200,
                                        //                                    margin: EdgeInsets.only(top: 16),
                                        padding: EdgeInsets.all(8),
                                        width: (MediaQuery.of(context)
                                            .size
                                            .width -
                                            40) /
                                            2,
                                        decoration: BoxDecoration(
                                          //                              gradient: LinearGradient(
                                          //                                  colors: [
                                          //                                    Colors.blue,
                                          //                                    Colors.lightBlue
                                          //                                  ]
                                          //                              ),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${_list[i + 1].image}'),
                                                  fit: BoxFit.fill)),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 8.0),
                                                child: Image.asset(
                                                  'images/sm_flower.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Container(
                height: 630,
//                     color: Colors.red,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '99 Warda Specials',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 270,
                            width: (MediaQuery.of(context).size.width - 40) / 2,
                            child: Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  height: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.lightBlue
                                        ]),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'Mixed Tulip Flowers',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32),
                                            bottomRight: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '25,000 IQD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 40,
                                  child: Container(
                                    height: 200,
//                                    margin: EdgeInsets.only(top: 16),
                                    padding: EdgeInsets.all(8),
                                    width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        2,
                                    decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Colors.blue,
//                                    Colors.lightBlue
//                                  ]
//                              ),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image:
                                              AssetImage('images/flower.png'),
                                              fit: BoxFit.fill)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 8.0),
                                            child: Image.asset(
                                              'images/sm_flower.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 270,
                            width: (MediaQuery.of(context).size.width - 40) / 2,
                            child: Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  height: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.lightBlue
                                        ]),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'Mixed Tulip Flowers',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32),
                                            bottomRight: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '25,000 IQD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 40,
                                  child: Container(
                                    height: 200,
//                                    margin: EdgeInsets.only(top: 16),
                                    padding: EdgeInsets.all(8),
                                    width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        2,
                                    decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Colors.blue,
//                                    Colors.lightBlue
//                                  ]
//                              ),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image:
                                              AssetImage('images/flower.png'),
                                              fit: BoxFit.fill)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 8.0),
                                            child: Image.asset(
                                              'images/sm_flower.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 270,
                            width: (MediaQuery.of(context).size.width - 40) / 2,
                            child: Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  height: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.lightBlue
                                        ]),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'Mixed Tulip Flowers',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32),
                                            bottomRight: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '25,000 IQD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 40,
                                  child: Container(
                                    height: 200,
//                                    margin: EdgeInsets.only(top: 16),
                                    padding: EdgeInsets.all(8),
                                    width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        2,
                                    decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Colors.blue,
//                                    Colors.lightBlue
//                                  ]
//                              ),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image:
                                              AssetImage('images/flower.png'),
                                              fit: BoxFit.fill)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 8.0),
                                            child: Image.asset(
                                              'images/sm_flower.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 270,
                            width: (MediaQuery.of(context).size.width - 40) / 2,
                            child: Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  height: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.lightBlue
                                        ]),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(32),
                                            topLeft: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'Mixed Tulip Flowers',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32),
                                            bottomRight: Radius.circular(32))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '25,000 IQD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 40,
                                  child: Container(
                                    height: 200,
//                                    margin: EdgeInsets.only(top: 16),
                                    padding: EdgeInsets.all(8),
                                    width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        2,
                                    decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Colors.blue,
//                                    Colors.lightBlue
//                                  ]
//                              ),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image:
                                              AssetImage('images/flower.png'),
                                              fit: BoxFit.fill)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 8.0),
                                            child: Image.asset(
                                              'images/sm_flower.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ]))
      ],
    );
  }
}
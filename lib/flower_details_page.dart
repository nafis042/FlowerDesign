import 'package:flutter/material.dart';
import 'package:wadaaro/flower_list_model.dart';



class FlowerDetails extends StatefulWidget {

  static String tag = 'flower_details';

  final FlowerListModel flowerListModel;

  const FlowerDetails({Key key, this.flowerListModel}) : super(key: key);

  @override
  FlowerDetailsState createState() => new FlowerDetailsState();
}


class FlowerDetailsState extends State<FlowerDetails> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {


    return new Scaffold(

      appBar: AppBar(
        title: Text("Order Summary", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: Container(
//            color: Colors.red,
            margin: EdgeInsets.only(left: 8),
            constraints: BoxConstraints(
                maxHeight: 42
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(32)
            ),
            width: 42,
//            padding: EdgeInsets.all(9),
            child: BackButton(
              color: Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
//              color: Colors.grey,
              constraints: BoxConstraints(
                maxHeight: 42
              ),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(32)
              ),
              width: 42,
              child: Icon(
                Icons.share,
                color: Colors.black,
//                size: 16,
              ),
            ),
          ),
          SizedBox(width: 16,)
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFFF9C00),
                Color(0xFFFFB101)
              ]
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16,),
              Container(
                height: 370,
//                color: Colors.red,
                width: (MediaQuery.of(context).size.width - 40),
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[

                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 160,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF403EE7),
                                  Color(0xFF6B68F5)
                                ]
                            ),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: 12,),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Image.asset(
                                'images/bg_flower.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            SizedBox(width: 16,),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child:

//                              Text(
//                                widget.flowerListModel.name_en + "\nBouquets",
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontSize: 14,
//                                    fontWeight: FontWeight.w500
//                                ),
//                              ),
                              RichText(
                                text: TextSpan(

                                    children: <TextSpan>[
                                TextSpan(text: widget.flowerListModel.name_en,style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: '\nBouquets',style: TextStyle(fontSize: 10))
                                ],
                              ),
                            )
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
                        height: 300,
                        padding: EdgeInsets.all(8),
                        width: (MediaQuery.of(context).size.width - 40),
                        decoration: BoxDecoration(

                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${widget.flowerListModel.image}'
                                  ),
                                  fit: BoxFit.fill
                              )
                          ),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
//                            child: Image.asset(
//                              'images/sm_flower.png',
//                              height: 40,
//                              width: 40,
//                            ),
//                          ),
//                        ],
//                      ),



                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 8,),
              Text(
                "${widget.flowerListModel.description_en}",
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
      ),



      bottomNavigationBar:
      new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFFF9C00),
                Color(0xFFFFB101)
              ]
          ),
        ),
        height: 200,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

           Row(
             mainAxisAlignment: MainAxisAlignment.center,

             children: <Widget>[
               Container(
                    height: 37,
                    width: 108,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFB101),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20)
                      ),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width:2,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              quantity += 1;
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ),
                        Container(
                            width: 38,
                            child: Center(
                                child: Text(
                                    "$quantity",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                )
                            )
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              quantity -= 1;
                              if(quantity < 0){
                                quantity = 0;
                              }
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 18,
                            ),
                          ),
                        ),

                      ],
                    ),
               ),
               SizedBox(width: 16,),
               Text(
                 "Total\n${quantity * widget.flowerListModel.price} USD",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 22
                 ),
               )
             ],
           ),
            SizedBox(height: 16,),
            MaterialButton(
              onPressed: (){
                print("make an offer button pressed");
              },
              color: Colors.white,
              height: 48,
              minWidth: MediaQuery.of(context).size.width - 64,
              elevation: 5,
              child: Text(
                "Make an Order",
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.all(Radius.circular(25))

              ),
            ),
            SizedBox(height: 48,)
          ],
        ),
      ),


    );
  }







}
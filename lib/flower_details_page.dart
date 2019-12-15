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
        leading: Container(
          child: BackButton(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Icon(
            Icons.share,
            color: Colors.black,
          ),
          SizedBox(width: 16,)
        ],
      ),

      body: Container(
        color: Colors.amber,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 370,
                width: (MediaQuery.of(context).size.width - 40),
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[

                    Positioned(
                      top: 0,
                      left: 16,
                      right: 0,
                      height: 160,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.lightBlue
                                ]
                            ),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 16,),
                            Text(
                              widget.flowerListModel.name_en,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    Positioned(
                      left: 16,
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

              SizedBox(height: 32,),
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
        color: Colors.amber,
        height: 130,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

           Row(
             mainAxisAlignment: MainAxisAlignment.center,

             children: <Widget>[
               Container(
                    height: 30,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15)
                      ),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
//                        SizedBox(width:1,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              quantity += 1;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
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

                        Text("$quantity"),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              quantity -= 1;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
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
                   fontSize: 18
                 ),
               )
             ],
           ),
            SizedBox(height: 8,),
            MaterialButton(
              onPressed: (){
                print("make an offer button pressed");
              },
              color: Colors.white,
              minWidth: MediaQuery.of(context).size.width - 64,
              child: Text(
                "Make an Order",
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.all(Radius.circular(20))

              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),


    );
  }







}
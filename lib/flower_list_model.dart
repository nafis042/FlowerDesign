import 'package:flutter/foundation.dart';

class FlowerListModel {
  final int id;
  final String name_en;
  final String name_ar;
  final String description_en;
  final String description_ar;
  final String image;
  final double price;
  final double height;
  final double width;
  final String color;
  final String color_ar;
  final String created_at;
  final int category;

  FlowerListModel({
    @required this.id,
    @required this.name_en,
    @required this.name_ar,
    @required this.description_en,
    @required this.description_ar,
    @required this.image,
    @required this.price,
    @required this.height,
    @required this.width,
    @required this.color,
    @required this.color_ar,
    @required this.created_at,
    @required this.category,
  });


  FlowerListModel.fromJson(Map json)
      : id = json['id'],
        name_en = json['name_en'],
        name_ar = json['name_ar'],
        description_en = json['description_en'],
        description_ar = json['description_ar'],
        image = json['image'],
        price = json['price'],
        height = json['height'],
        width = json['width'],
        color = json['color'],
        color_ar = json['color_ar'],
        created_at = json['created_at'],
        category = json['category'];


}

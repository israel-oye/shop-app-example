import 'package:flutter/material.dart';

class Product{
  final int id;
  final String name;
  final double price;
  final Color avatar;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.avatar,
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['id'], 
      name: json['name'], 
      price: json['price'].toDouble(), 
      avatar: Color(json['color']),
    );
  }

  Map<String, dynamic> toJson()=> {
    'id': id,
    'name': name,
    'price': price,
    'avatar': avatar.toARGB32(),
  };
}
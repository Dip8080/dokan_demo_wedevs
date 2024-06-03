import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key,
  required this.id,
  required this.description,
  required this.inStock,
  required this.name,
  required this.price,
  required this.publish_status,
  required this.short_description,
  required this.url
  });

  final int id;
  final String name;
  final String url;
  final String publish_status;
  final String short_description;
  final String description;
  final String price;
  final bool inStock;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.id,
    required this.description,
    required this.inStock,
    required this.name,
    required this.price,
    required this.publish_status,
    required this.short_description,
  });

  final int id;
  final String name;

  final String publish_status;
  final String short_description;
  final String description;
  final double price;
  final bool inStock;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${name}'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            
              SizedBox(height:3.h),
              Text(description , style: TextStyle(fontSize: 3.5.w),),
              SizedBox(height:3.h),
              Text('In Stock: ${inStock.toString()}'),
              SizedBox(height:3.h),
              Text('Price: ${price} \$'),
              SizedBox(height:3.h),
              Text('Publish Status: ${publish_status}'),
              SizedBox(height:3.h),
              Text('short_description : ${short_description}'),
            ],
          ),
        ),
      ),
    );
  }
}

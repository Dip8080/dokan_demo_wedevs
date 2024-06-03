import 'dart:convert';
import 'package:dokan_demo_wedevs/Features/product/model/book.dart';
import 'package:flutter/services.dart';
Future<List<Book>> loadBook() async {
  String jsonString = await rootBundle.loadString('assets/books.json');
  final jsonResponse = json.decode(jsonString);
  final books =
      jsonResponse['data'].map<Book>((json) => Book.fromJson(json)).toList();
  return books;
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Book {
  final int id;
  final String name;
  final String slug;
  final String postAuthor;
  final String permalink;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String type;
  final String status;
  final bool featured;
  final String catalogVisibility;
  final String description;
  final String shortDescription;
  final String sku;
  final double price;
  final bool onSale;
  final bool purchasable;
  final int totalSales;
  final bool virtual;
  final bool downloadable;
  final List<Download> downloads;
  final int downloadLimit;
  final int downloadExpiry;
  final String taxStatus;
  final bool manageStock;
  final bool inStock;
  final bool backordersAllowed;
  final bool backordered;
  final bool soldIndividually;
  final Dimensions dimensions;
  final bool shippingRequired;
  final bool shippingTaxable;
  final bool reviewsAllowed;
  final double averageRating;
  final int ratingCount;
  final List<int> relatedIds;
  final List<Category> categories;
  final List<ImageModel> images;
  final Store store;

  Book({
    required this.id,
    required this.name,
    required this.slug,
    required this.postAuthor,
    required this.permalink,
    required this.dateCreated,
    required this.dateModified,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.taxStatus,
    required this.manageStock,
    required this.inStock,
    required this.backordersAllowed,
    required this.backordered,
    required this.soldIndividually,
    required this.dimensions,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.relatedIds,
    required this.categories,
    required this.images,
    required this.store,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      postAuthor: json['post_author'],
      permalink: json['permalink'],
      dateCreated: DateTime.parse(json['date_created']),
      dateModified: DateTime.parse(json['date_modified']),
      type: json['type'],
      status: json['status'],
      featured: json['featured'],
      catalogVisibility: json['catalog_visibility'],
      description: json['description'],
      shortDescription: json['short_description'],
      sku: json['sku'],
      price: double.parse(json['price']),
      onSale: json['on_sale'],
      purchasable: json['purchasable'],
      totalSales: json['total_sales'],
      virtual: json['virtual'],
      downloadable: json['downloadable'],
      downloads: (json['downloads'] as List)
          .map((i) => Download.fromJson(i))
          .toList(),
      downloadLimit: json['download_limit'],
      downloadExpiry: json['download_expiry'],
      taxStatus: json['tax_status'],
      manageStock: json['manage_stock'],
      inStock: json['in_stock'],
      backordersAllowed: json['backorders_allowed'],
      backordered: json['backordered'],
      soldIndividually: json['sold_individually'],
      dimensions: Dimensions.fromJson(json['dimensions']),
      shippingRequired: json['shipping_required'],
      shippingTaxable: json['shipping_taxable'],
      reviewsAllowed: json['reviews_allowed'],
      averageRating: double.parse(json['average_rating']),
      ratingCount: json['rating_count'],
      relatedIds: List<int>.from(json['related_ids']),
      categories: (json['categories'] as List)
          .map((i) => Category.fromJson(i))
          .toList(),
      images: (json['images'] as List).map((i) => ImageModel.fromJson(i)).toList(),
      store: Store.fromJson(json['store']),
    );
  }
}

class Download {
  final String id;
  final String name;
  final String file;

  Download({required this.id, required this.name, required this.file});

  factory Download.fromJson(Map<String, dynamic> json) {
    return Download(
      id: json['id'],
      name: json['name'],
      file: json['file'],
    );
  }
}

class Dimensions {
  final String length;
  final String width;
  final String height;

  Dimensions({required this.length, required this.width, required this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      length: json['length'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class ImageModel {
  final int id;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String src;
  final String name;
  final String alt;

  ImageModel({
    required this.id,
    required this.dateCreated,
    required this.dateModified,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      dateCreated: DateTime.parse(json['date_created']),
      dateModified: DateTime.parse(json['date_modified']),
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }
}

class Store {
  final int id;
  final String name;
  final String url;
  final String avatar;
  final Address address;

  Store({
    required this.id,
    required this.name,
    required this.url,
    required this.avatar,
    required this.address,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      avatar: json['avatar'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String street1;
  final String street2;
  final String city;
  final String zip;
  final String country;
  final String state;

  Address({
    required this.street1,
    required this.street2,
    required this.city,
    required this.zip,
    required this.country,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street1: json['street_1'],
      street2: json['street_2'],
      city: json['city'],
      zip: json['zip'],
      country: json['country'],
      state: json['state'],
    );
  }
}



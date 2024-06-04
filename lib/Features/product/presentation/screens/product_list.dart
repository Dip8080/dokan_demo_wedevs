import 'dart:convert';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:dokan_demo_wedevs/Features/product/data/get_book_data.dart';
import 'package:dokan_demo_wedevs/Features/product/model/book.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/widgets/custom_drawer.dart';
import 'package:dokan_demo_wedevs/Features/profile/presentation/Screens/profile_screen.dart';
import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.userName, required this.email});

  final String userName;
  final String email;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int visit = 0;
  late Future<List<Book>> futureBooks;
  String _sortOption = 'newest';

  @override
  void initState() {
    super.initState();
    futureBooks = loadBook();
  }

  void _sortBooks(List<Book> books) {
    setState(() {
      if (_sortOption == 'newest') {
        books.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      } else if (_sortOption == 'oldest') {
        books.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
      } else if (_sortOption == 'price low > high') {
        books.sort((a, b) => a.price.compareTo(b.price));
      } else if (_sortOption == 'price hign > low') {
        books.sort((a, b) => b.price.compareTo(a.price));
      } else if (_sortOption == 'best selling') {
        books.sort((a, b) => a.averageRating.compareTo(b.averageRating));
      }
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
        ),
        backgroundColor: Colors.white,
        context: (context),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: 60.h,
              width: 100.w,
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(child: Container(
                    width: 14.w,
                    child: Divider(thickness: 3, color: AppColors.lightPrimary,))),
                  Text(
                    'Filter',
                    style:
                        TextStyle(fontSize: 4.5.w, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    children: <Widget>[
                      RadioListTile<String>(
                          title: Text('Newest'),
                          activeColor: Colors.red,
                          value: 'newest',
                          groupValue: _sortOption,
                          onChanged: (value) {
                            _sortOption = value!;
                            setState(() {});
                          }),
                      RadioListTile<String>(
                          activeColor: Colors.red,
                          title: Text('Oldest'),
                          value: 'oldest',
                          groupValue: _sortOption,
                          onChanged: (value) {
                            _sortOption = value!;
                            setState(() {});
                          }),
                      RadioListTile<String>(
                          activeColor: Colors.red,
                          title: Text('Price low > high'),
                          value: 'price low > high',
                          groupValue: _sortOption,
                          onChanged: (value) {
                            _sortOption = value!;
                            setState(() {});
                          }),
                      RadioListTile<String>(
                          activeColor: Colors.red,
                          title: Text('Price hign > low'),
                          value: 'price hign > low',
                          groupValue: _sortOption,
                          onChanged: (value) {
                            _sortOption = value!;
                            setState(() {});
                          }),
                      RadioListTile<String>(
                          activeColor: Colors.red,
                          title: Text('Best selling'),
                          value: 'best selling',
                          groupValue: _sortOption,
                          onChanged: (value) {
                            _sortOption = value!;
                            setState(() {});
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 7.h,
                          width: 40.w,
                          
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Center(
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 4.5.w , fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            futureBooks = futureBooks.then((books) {
                              _sortBooks(books);
                              return books;
                            });
                          });
                        },
                        child: Container(
                          height: 7.h,
                          width: 40.w,
                          
                          decoration: BoxDecoration(
                            color: AppColors.lightPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 4.5.w , fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          });
        });
  }

  List<TabItem> items = [
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.favorite_border,
      title: 'Wishlist',
    ),
    TabItem(
      icon: Icons.search_sharp,
      title: 'Shop',
    ),
    TabItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Cart',
    ),
    TabItem(
      icon: Icons.account_box,
      title: 'profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          },
        ),
        title: Text(
          'Product List',
          style: TextStyle(color: AppColors.lightPrimary , fontWeight: FontWeight.bold,letterSpacing: 1),
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.search,
            color: AppColors.darkBG,
          ),
          SizedBox(
            width: 3.5.w,
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showSortOptions();
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.only(left:2.w, right: 2.w),
                        height: 7.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // border:
                              // Border.all(color: AppColors.lightPrimary, width: 2),
                          color: Colors.white                              
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.candlestick_chart_outlined,
                                  color: Colors.grey,
                                  size: 8.w,
                                ),
                                Text(
                                  '${_sortOption}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 4.5.w),
                                ),
                              ]),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'short',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 4.5.w),
                                  ),
                                  Icon(
                                    Icons.sort_sharp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Container(
                height: 90.h,
                child: FutureBuilder(
                  future: futureBooks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColors.lightPrimary,
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final productData = snapshot?.data ?? [];
                      return Padding(
                        padding: EdgeInsets.only(top: 0, left: 4.w, right: 10),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                            ),
                            itemCount: productData?.length ?? 0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  //   return ImageDetails(id: productData[index].idproductName, title: productData[index].titleproductName, image: productData[index].urlproductName  ,);
                                  // })) ;
                                },
                                child: Container(
                                  // padding: EdgeInsets.all(2.w),
                                  margin: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     blurRadius: 7,
                                      //     offset: Offset(.5, 3),
                                      //   ),
                                      // ],
                                      // border: Border.all(color: Colors.purple),
                                      borderRadius: BorderRadius.circular(8)),
                                  width: 50.w,
                                  height: 60.h,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 1.w),
                                        width: 40.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(productData[
                                                          index]
                                                      .images[0]
                                                      .src ??
                                                  'https://i.ebayimg.com/images/g/s2cAAAzyLv1SvhXh/s-l600.jpg'),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          productData[index].name ??
                                              'demo name',
                                          style: TextStyle(
                                              fontSize: 3.5.w,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Flexible(
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Text(
                                              '150\$' ?? 'demo name',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decorationColor: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 4.w,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              '${productData[index].price.toString()}\$' ??
                                                  'demo name',
                                              style: TextStyle(
                                                  fontSize: 5.w,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color: AppColors.lightPrimary,
                                            size: 5.w,
                                          ),
                                          Icon(
                                            size: 5.w,
                                            Icons.star,
                                            color: AppColors.lightPrimary,
                                          ),
                                          Icon(
                                            size: 5.w,
                                            Icons.star,
                                            color: AppColors.lightPrimary,
                                          ),
                                          Icon(
                                            size: 5.w,
                                            Icons.star_half,
                                            color: AppColors.lightPrimary,
                                          ),
                                          Icon(
                                            size: 5.w,
                                            Icons.star_half,
                                            color: AppColors.lightPrimary,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 0, right: 0, left: 0, top: 0),
        child: BottomBarCreative(
          items: items,
          backgroundColor: Colors.white,
          color: Colors.black,
          colorSelected: AppColors.lightPrimary,
          indexSelected: visit,
          onTap: (int index) => setState(() {
            visit = index;
            switch (visit) {
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
                break;
            }
          }),
        ),
      ),
    );
  }
}

// Widget _buildPage(int index) {
//   switch (index) {
//     case 0:
//       return ProfileScreen();
//     case 1:
//     return ProfileScreen();
//       // return MedicineList();
//     case 2:
//     return ProfileScreen();
//       // return OrderScreen();
//     case 3:
//     return ProfileScreen();
//       // return ProfileScreenTwo();
//     default:
//     return ProfileScreen();
//       // return HomeMain();
//   }
// }
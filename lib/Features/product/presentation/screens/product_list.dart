import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dokan_demo_wedevs/Features/product/data/get_book_data.dart';
import 'package:dokan_demo_wedevs/Features/product/model/book.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/screens/product_details.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/widgets/custom_drawer.dart';
import 'package:dokan_demo_wedevs/Features/profile/presentation/Screens/profile_screen.dart';
import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

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
                  Center(
                      child: Container(
                          width: 14.w,
                          child: Divider(
                            thickness: 3,
                            color: AppColors.lightPrimary,
                          ))),
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
                                        color: Colors.black,
                                        fontSize: 4.5.w,
                                        fontWeight: FontWeight.bold))),
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
                                  color: Colors.white,
                                  fontSize: 4.5.w,
                                  fontWeight: FontWeight.bold),
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
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final Color backgroundColor =
        (brightness == Brightness.dark) ? Colors.grey.shade900 : Colors.white;
    final Color shadowColor = (brightness == Brightness.dark)
        ? Colors.grey.shade900
        : Colors.grey.shade200;
    final Color borderColor = (brightness == Brightness.dark)
        ? Colors.grey.shade900
        : Colors.grey.shade200;
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
              ),
            );
          },
        ),
        title: Text(
          'Product List',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.search,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Container(
                    margin: EdgeInsets.only(left: 1.5.w, bottom: 2.w),
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    height: 7.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: borderColor),
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
              ),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProductDetails(
                                      id: productData[index].id,
                                      description:
                                          productData[index].description,
                                      inStock: productData[index].inStock,
                                      name: productData[index].name,
                                      price: productData[index].price,
                                      publish_status: productData[index].status,
                                      short_description:
                                          productData[index].shortDescription,
                                    );
                                  }));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                      color: backgroundColor,
                                      border: Border.all(color: borderColor),
                                      boxShadow: [
                                        BoxShadow(
                                            color: shadowColor,
                                            spreadRadius: 0,
                                            blurRadius: 15,
                                            offset: const Offset(0, 10))
                                      ],
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
                                            // color: Colors.white,
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
                                      Text(
                                        productData[index].name ?? 'demo name',
                                        style: TextStyle(
                                            fontSize: 3.5.w,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '150\$' ?? 'demo name',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                decorationColor: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color: AppColors.mediumYellow,
                                            size: 4.w,
                                          ),
                                          Icon(
                                            size: 4.w,
                                            Icons.star,
                                            color: AppColors.mediumYellow,
                                          ),
                                          Icon(
                                            size: 4.w,
                                            Icons.star,
                                            color: AppColors.mediumYellow,
                                          ),
                                          Icon(
                                            size: 4.w,
                                            Icons.star_half,
                                            color: AppColors.mediumYellow,
                                          ),
                                          Icon(
                                            size: 4.w,
                                            Icons.star_half,
                                            color: AppColors.mediumYellow,
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
          backgroundColor: backgroundColor,
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

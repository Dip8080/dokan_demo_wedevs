import 'package:dokan_demo_wedevs/Features/product/model/book.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/widgets/custom_drawer.dart';
import 'package:dokan_demo_wedevs/app.dart';
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
  Future<List<Book>> futureProduct = loadBook();

  @override
  void initState() {
    super.initState();
  }

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
          style: TextStyle(color: AppColors.lightPrimary),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.w),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical( top: Radius.circular(0.0)),
                        ),
                        backgroundColor: Colors.white,
                        context: (context),
                        builder: (BuildContext context) {
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
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                      fontSize: 4.5.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Radio(value: 1, groupValue: 1, onChanged: (value) {}
                                        ),
                                        Text('Newest', style: TextStyle(fontSize: 4.5.w),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(value: 0, groupValue: 1, onChanged: (value) {}
                                        ),
                                        Text('Oldest', style: TextStyle(fontSize: 4.5.w),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(value: 0, groupValue: 1, onChanged: (value) {}
                                        ),
                                        Text('Price low > High', style: TextStyle(fontSize: 4.5.w),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(value: 0, groupValue: 1, onChanged: (value) {}
                                        ),
                                        Text('Price High > Low', style: TextStyle(fontSize: 4.5.w),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(value: 0, groupValue: 1, onChanged: (value) {}
                                        ),
                                        Text('Best selling', style: TextStyle(fontSize: 4.5.w),)
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 7.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 8.h,
                                      width: 40.w,
                                      color: Colors.grey.shade300,
                                      child: Center(child: Center(child: Text('Cancel' ,style: TextStyle(color: Colors.white , fontSize: 4.5.w))),),
                                    ),
                                    Container(
                                      height: 8.h,
                                      width: 40.w,
                                      color: AppColors.lightPrimary,
                                      child: Center(child: Text('Apply' , style: TextStyle(color: Colors.white , fontSize: 4.5.w),),),
                                    ),
                                    
                                  ],
                                )

                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 5.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.lightPrimary, width: 2)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.filter_alt,
                          color: Colors.grey,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(color: Colors.grey, fontSize: 4.5.w),
                        ),
                        SizedBox(
                          width: 55.w,
                        ),
                        Text(
                          'short',
                          style: TextStyle(color: Colors.grey, fontSize: 4.5.w),
                        ),
                        Icon(
                          Icons.sort_sharp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              height: 90.h,
              child: FutureBuilder(
                future: futureProduct,
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
                                width: 40.w,
                                height: 60.h,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 20.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(productData[index]
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
                                        productData[index].name ?? 'demo name',
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
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: AppColors.lightPrimary,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: AppColors.lightPrimary,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: AppColors.lightPrimary,
                                        ),
                                        Icon(
                                          Icons.star_half,
                                          color: AppColors.lightPrimary,
                                        ),
                                        Icon(
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
      drawer: CustomDrawer(),
    );
  }
}

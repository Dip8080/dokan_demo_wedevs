import 'package:dokan_demo_wedevs/Features/product/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key , required this.userName , required this.email});


  final String userName ;
  final String email ;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future <List<Book>> futureProduct = loadBook();

  @override
  void initState() {
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.userName}'),
        centerTitle: true,
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: FutureBuilder(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
           final productData = snapshot?.data ?? [] ;
            return  Padding(
              padding: EdgeInsets.only(top: 0, left: 4.w, right: 10),
              child: ListView.builder(
                  itemCount: productData?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return ImageDetails(id: productData[index].idproductName, title: productData[index].titleproductName, image: productData[index].urlproductName  ,);
                        // })) ;
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                            ),
                        width: 100.w,
                        height: 12.h,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(productData[index].images[0].src ?? 'https://i.ebayimg.com/images/g/s2cAAAzyLv1SvhXh/s-l600.jpg'),
                              )),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                            child: 
                                Text(
                                  productData[index].name ?? 'demo name',
                                  style: TextStyle(
                                      fontSize: 5.w,
                                      fontWeight: FontWeight.w700),
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     Text(productData[index].unitPriceproductName),
                                //     SizedBox(width: 2.w,),
                                //     Text(productData[index].qtyproductName),
                                //   ],
                                // )
                          
                            ),
                            IconButton(
                                onPressed: () {
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return UpdateProduct(
                                  //     productId: productData[index].id ?? '0',
                                  //     productName:
                                  //         productData[index].productName ?? 'demo name',
                                  //   );
                                  // }));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  // deleteProduct(productData[index].id ?? 0.toString());
                                },
                                icon: Icon(Icons.delete_outline_sharp) , color: Colors.red,)
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
    );
    
  }
}
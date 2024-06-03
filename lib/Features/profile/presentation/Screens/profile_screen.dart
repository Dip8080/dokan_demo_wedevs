import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dokan_demo_wedevs/Features/auth/data/auth_provider.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/screens/product_list.dart';
import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int visit = 4;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(fontSize: 6.w, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: <Widget>[
              Container(
                width: 100.w,
                height: 50.w,
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Consumer(builder: (context, ref, child) {
                      final userData = ref.watch(userDataProvider);

                      return userData.when(
                        data: (data) {
                          return Container(
                            child: Column(children: <Widget>[
                              Text(
                                '${data['user'] ?? 'User Name'}',
                                style: TextStyle(
                                    fontSize: 6.w, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${data['email'] ??'User Email'} ',
                                style: TextStyle(
                                    fontSize: 4.w,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ]),
                          );
                        },
                        loading: () => CircularProgressIndicator(),
                        error: (error, stackTrace) =>
                            Text('Error retrieving user data.'),
                      );
                    })
                  ],
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Card(
                
                // color: Colors.grey.shade100,
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  width: 100.w,
                
                  decoration:
                      BoxDecoration(
                      color: Colors.white
                      ),
                  child: Column(
                    children: [
                       ExpansionTile(
                          backgroundColor: Colors.transparent,
                          iconColor: AppColors.lightPrimary,
                          collapsedIconColor: Colors.grey,
                          childrenPadding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Row(children: <Widget>[
                            Icon(Icons.person_outline_sharp, size: 8.w,),
                            SizedBox(width: 3.w,),
                            Text('Account' , style: TextStyle(fontSize: 4.5.w , fontWeight: FontWeight.w500),)
                          ],),
                          children: <Widget>[
                            SizedBox(height: 2.5,),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                          ],
                      
                        ),

                        Container(
                          width: 75.w,
                          child: Divider()),

                       ExpansionTile(
                          
                          backgroundColor: Colors.white,
                          iconColor: AppColors.lightPrimary,
                          collapsedIconColor: Colors.grey,
                          childrenPadding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Row(children: <Widget>[
                            Icon(Icons.candlestick_chart_outlined, size: 9.w,),
                            SizedBox(width: 3.w,),
                            Text('Password' , style: TextStyle(fontSize: 4.5.w , fontWeight: FontWeight.w500),)
                          ],),
                          children: <Widget>[
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                          ],
                      
                        ),
                      Container(
                          width: 75.w,
                          child: Divider()),
                       ExpansionTile(
                          
                          backgroundColor: Colors.white,
                          iconColor: AppColors.lightPrimary,
                          collapsedIconColor: Colors.grey,
                          childrenPadding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Row(children: <Widget>[
                            Icon(Icons.notifications_outlined , size: 8.w,),
                            SizedBox(width: 3.w,),
                            Text('Notification' , style: TextStyle(fontSize: 4.5.w , fontWeight: FontWeight.w500),)
                          ],),
                          children: <Widget>[
                            
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                          ],
                      
                        ),
                      Container(
                          width: 75.w,
                          child: Divider()),
                       ExpansionTile(
                          backgroundColor: Colors.white,
                          iconColor: AppColors.lightPrimary,
                          collapsedIconColor: Colors.grey,
                          childrenPadding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Row(children: <Widget>[
                            Icon(Icons.favorite_outline,size: 8.w,),
                            SizedBox(width: 3.w,),
                            Text('Wishlist(00)' , style: TextStyle(fontSize: 4.5.w , fontWeight: FontWeight.w500),)
                          ],),
                          children: <Widget>[
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                            Text('this is body text', style: TextStyle(fontSize: 5.w),),
                          ],
                      
                        ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.black,
        colorSelected: AppColors.lightPrimary,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
          switch (visit) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductList(userName: '', email: '')),
              );
              break;
          }
        }),
      ),
    );
  }
}

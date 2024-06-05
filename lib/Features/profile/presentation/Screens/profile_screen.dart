import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dokan_demo_wedevs/Features/auth/data/auth_provider.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/screens/product_list.dart';
import 'package:dokan_demo_wedevs/Features/profile/data/profile_repository.dart';
import 'package:dokan_demo_wedevs/Features/profile/presentation/widgets/data_update_button.dart';
import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  var name = 'User Name';
  int? id;
  Future<void> fetchProfileData() async {
    final profileData = await ProfileRepository().getProfiledata();
    if (profileData != null) {
      setState(() {
        name = profileData['name'];
        id = profileData['id'];
      });
    }
  }

  @override
  void initState() {
    fetchProfileData();
    super.initState();
  }

  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final Color backgroundColor =
        (brightness == Brightness.dark) ? Colors.grey.shade900 : Colors.white;
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
                    Text(
                      '$name',
                      style:
                          TextStyle(fontSize: 6.w, fontWeight: FontWeight.bold),
                    ),
                    Consumer(builder: (context, ref, child) {
                      final userData = ref.watch(userDataProvider);

                      return userData.when(
                        data: (data) {
                          return Container(
                            child: Column(children: <Widget>[
                              Text(
                                '${data['email'] ?? 'User Email'} ',
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
                color: Colors.transparent,
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: backgroundColor),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: ExpansionTile(
                          backgroundColor: Colors.transparent,
                          iconColor: AppColors.lightPrimary,
                          collapsedIconColor: Colors.grey,
                          childrenPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person_outline_sharp,
                                size: 8.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                'Account',
                                style: TextStyle(
                                    fontSize: 4.5.w,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          children: <Widget>[
                            SizedBox(
                              height: 2.5,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'First Name',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 4.5.w),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  TextFormField(
                                    controller: _firstNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        hintText: 'enter your first name'),
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'first name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Last Name',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 4.5.w),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  TextFormField(
                                    controller: _lastNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        hintText: 'enter your last name'),
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Last Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 6.5.h,
                                    width: 36.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Center(
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 4.5.w,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    final String fullName =
                                        _firstNameController.text +
                                            ' ' +
                                            _lastNameController.text;
                                    if (_formKey.currentState!.validate()) {
                                      final Response response =
                                          await ProfileRepository()
                                              .updateProfile(
                                                  id ?? 1, {'name': fullName});

                                      if (response.statusCode == 200) {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        final snackbar = AnimatedSnackBar(
                                          builder: ((context) {
                                            return Container(
                                              width: 90.w,
                                              height: 6.5.h,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.green,
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.white,
                                                    size: 5.w,
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  const Text(
                                                      'Successfully updated profile name.'),
                                                ],
                                              ),
                                            );
                                          }),
                                        );
                                        snackbar.show(context);
                                        initState();
                                        snackbar.remove();
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 6.5.h,
                                    width: 36.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightPrimary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 4.5.w,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            isLoading == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Container(width: 75.w, child: Divider()),
                      ExpansionTile(
                        iconColor: AppColors.lightPrimary,
                        collapsedIconColor: Colors.grey,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.candlestick_chart_outlined,
                              size: 9.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 4.5.w, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Old Password',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 4.5.w),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: '********'),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'New Password',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 4.5.w),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  // controller: _emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: '********'),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Confirm New Password',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 4.5.w),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: '********'),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          data_update_button(context)
                        ],
                      ),
                      Container(width: 75.w, child: Divider()),
                      ExpansionTile(
                        iconColor: AppColors.lightPrimary,
                        collapsedIconColor: Colors.grey,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.notifications_outlined,
                              size: 8.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Notification',
                              style: TextStyle(
                                  fontSize: 4.5.w, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Notification Settings',
                              style: TextStyle(fontSize: 5.w),
                            ),
                          ),
                        ],
                      ),
                      Container(width: 75.w, child: Divider()),
                      ExpansionTile(
                        iconColor: AppColors.lightPrimary,
                        collapsedIconColor: Colors.grey,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite_outline,
                              size: 8.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Wishlist(00)',
                              style: TextStyle(
                                  fontSize: 4.5.w, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Wishlist Settings',
                              style: TextStyle(fontSize: 5.w),
                            ),
                          ),
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
        backgroundColor: backgroundColor,
        color: Colors.black,
        colorSelected: AppColors.lightPrimary,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
          switch (visit) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductList()),
              );
              break;
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}

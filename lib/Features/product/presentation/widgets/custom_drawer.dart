import 'package:dokan_demo_wedevs/Features/auth/data/auth_provider.dart';
import 'package:dokan_demo_wedevs/Features/auth/data/store_user_data.dart';
import 'package:dokan_demo_wedevs/Features/auth/presentation/screen/login.dart';
import 'package:dokan_demo_wedevs/Features/profile/presentation/Screens/profile_screen.dart';
import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final isAuthenticated = ref.watch(authProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
            },
          ),
          _buildDrawerItem(
            icon: Icons.shopping_cart,
            title: 'Cart',
            onTap: () {
            },
          ),
          _buildDrawerItem(
            icon: Icons.person_4_rounded,
            title: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ),
              );
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.privacy_tip_rounded,
            title: "Privacy Policy",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       // return ProductRiverpod();
              //       return PrivecyPolicy();
              //     },
              //   ),
              // );
            },
          ),
          // Divider(),
          // _buildDrawerItem(
          //   icon: Icons.logout,
          //   title: "logout",
          //   onTap: () {
          //     UserData().deleteUserData();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           // return ProductRiverpod();
          //           return LoginScreen() ;}
          //       ),
          //     );
          //   },
          // ),
          _buildDrawerItem(
            icon: isAuthenticated ? Icons.logout_sharp : Icons.login_sharp,
            title: isAuthenticated ? 'Logout' : 'Login',
            onTap: () {
              if (isAuthenticated) {
                UserData().deleteUserData();
                ref.read(authProvider.notifier).logout();
                final snackBar = SnackBar(
                  content: Text(
                    'You have been logged out !',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  action: SnackBarAction(
                    label: 'close',
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                  backgroundColor: AppColors.lightPrimary,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 300,
      child: DrawerHeader(
        decoration: BoxDecoration(
            // color: AppColors.lightAccent,
            // color: AppColors.lightGrey
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              // elevation: 5,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png'),
                // Replace with actual profile image
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final isAuthenticated = ref.watch(authProvider);
                final userData = ref.watch(userDataProvider);

                return userData.when(
                  data: (data) {
                    // print(data.le);
                    

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // '${isAuthenticated ?? data['user']}',
                          isAuthenticated ? "${data['user']}" : "User Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // '${data.token}',
                          isAuthenticated ? "${data['email']}" : "User Email",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) =>
                      Text('Error retrieving user data.'),
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.lightPrimary,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}

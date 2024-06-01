import 'dart:convert';

import 'package:dokan_demo_wedevs/Features/auth/data/auth_repository.dart';
import 'package:dokan_demo_wedevs/Features/auth/presentation/screen/registration.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Flexible(
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'D',
                      style: TextStyle(
                        fontSize: 8.w,
                        color: Color.fromARGB(255, 241, 98, 76),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'okan',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.w))
                      ]),
                ),
                SizedBox(height: 3.h),
                Text(
                  'SignIn',
                  style: TextStyle(fontSize: 5.w, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 50.h,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'email'),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter Your Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              hintText: 'password',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Write your unit price';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 80.w,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 40.w),
                                Text('Forgot Password ?')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          ElevatedButton(
                              onPressed: () async{
                                Map<String, dynamic> userData = {
                                  "username": _emailController.text,
                                  "password": _passwordController.text
                                };
                                print(userData);
                                if (_formKey.currentState!.validate()){
                                  
                                 final Response res = await AuthRepository().loginUser(userData);
                                 if(res.statusCode == 200) {
                                  final responseBody = jsonDecode(res.body);
                                  Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                    return ProductList(email: responseBody['user_email'], userName: responseBody['user_display_name'],);
                                  })));
                                 }
                                 else {
                                 showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text(
                                                'Failed to fetch data. Status code: ${res.statusCode}'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                 }
                                }
                              },
                              child: Text('Login')),
                          SizedBox(
                            height: 5.h,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return RegistrationScreen();
                                })));
                              },
                              child: Text(
                                'Register as a new User.',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
// https://docs.google.com/document/d/14RnMdTuIMUACR4yXEnM0af0gsvbHOeYESV-nrjPzJ6E/edit#heading=h.jx0u5j59mrz0
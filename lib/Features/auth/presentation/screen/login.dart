import 'dart:convert';
import 'package:dokan_demo_wedevs/Features/auth/data/auth_provider.dart';
import 'package:dokan_demo_wedevs/Features/auth/data/auth_repository.dart';
import 'package:dokan_demo_wedevs/Features/auth/presentation/screen/registration.dart';
import 'package:dokan_demo_wedevs/Features/product/presentation/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? isLoading ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.w),
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
                                color: Color.fromARGB(255, 241, 98, 76),
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
                                prefixIcon: Icon(Icons.person_outline),
                                hintText: 'User Name'),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter Your Name';
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
                              prefixIcon: Icon(Icons.password),
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
                          Wrap(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                        isLoading = true;
                                      });
                                  Map<String, dynamic> userData = {
                                    "username": _emailController.text,
                                    "password": _passwordController.text
                                  };
                                  print(userData);
                                  if (_formKey.currentState!.validate()) {
                                    final Response res = await AuthRepository()
                                        .loginUser(userData);
                                    if (res.statusCode == 200) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      final responseBody = jsonDecode(res.body);
                                      ref.read(authProvider.notifier).login();
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: ((context) {
                                        return ProductList(
                                       
                                        );
                                      })));
                                    } else {
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
                                child: Text('Login'),
                              ),
                              isLoading == true ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: CircularProgressIndicator(color: Colors.red,)),
                              ) : SizedBox(),
                              
                            ],
                          ),
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
import 'package:dokan_demo_wedevs/Features/auth/data/auth_repository.dart';
import 'package:dokan_demo_wedevs/Features/auth/presentation/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isLoading;
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
                'Register',
                style: TextStyle(fontSize: 5.w, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 70.h,
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              hintText: 'name'),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter Your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
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
                            prefixIcon: Icon(Icons.password),
                            hintText: 'password',
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'enter password !';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordConfirmController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: 'confirm password',
                          ),
                          validator: (String? value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                _passwordConfirmController.text !=
                                    _passwordController.text) {
                              return 'password doest not match !';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 3.h,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> user = {
                                  "username": _nameController.text,
                                  'email': _emailController.text,
                                  'password': _passwordController.text,
                                };
                                print('this is user in widget - ${user}');
                                final Response res =
                                    await AuthRepository().registerUser(user);
                                if (res.statusCode == 200) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
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
                            child: Text('Register')),
                        isLoading == true
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.red,
                                )),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 5.h,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            },
                            child: Text(
                              'Already Register ? please Login',
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }
}
// https://docs.google.com/document/d/14RnMdTuIMUACR4yXEnM0af0gsvbHOeYESV-nrjPzJ6E/edit#heading=h.jx0u5j59mrz0
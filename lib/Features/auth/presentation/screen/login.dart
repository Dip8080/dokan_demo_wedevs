import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email), hintText: 'email'),
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
                              hintText: 'password',),
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
                        ElevatedButton(onPressed: () {}, child: Text('Login')),
                        SizedBox(
                          height: 5.h,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Register as a new User.',
                              style:
                                  TextStyle(decoration: TextDecoration.underline),
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
}
// https://docs.google.com/document/d/14RnMdTuIMUACR4yXEnM0af0gsvbHOeYESV-nrjPzJ6E/edit#heading=h.jx0u5j59mrz0
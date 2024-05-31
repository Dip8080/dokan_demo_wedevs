import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                   text: 'okan' ,
                   style: TextStyle(fontWeight: FontWeight.bold , fontSize: 8.w)
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

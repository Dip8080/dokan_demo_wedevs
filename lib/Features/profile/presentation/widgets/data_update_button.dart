import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Row data_update_button(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          // Navigator.pop(context);
        },
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
                        fontWeight: FontWeight.bold))),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          height: 6.5.h,
          width: 36.w,
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 4.5.w,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
}

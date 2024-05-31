
import 'package:dokan_demo_wedevs/Features/auth/presentation/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Dokan extends StatelessWidget {
  const Dokan({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crud App',
        theme: _lightThemeData(),
        darkTheme: _dartThemeData(),
        themeMode: ThemeMode.system,
        home: const LoginScreen(),
      );
    });
  }

  ThemeData _lightThemeData() {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 241, 98, 76),
      brightness: Brightness.light,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white),
      ),
    );
  }

  ThemeData _dartThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // backgroundColor: Colors.purple,
            backgroundColor: Color.fromARGB(255, 247, 96, 85),
            foregroundColor: Colors.white),
      ),
    );
  }
}

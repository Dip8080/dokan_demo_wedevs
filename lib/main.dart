import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 6));
  FlutterNativeSplash.remove();
  runApp(
    ProviderScope(child: const Dokan())
  );
}



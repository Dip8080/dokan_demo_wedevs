import 'dart:async';

import 'package:dokan_demo_wedevs/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Future.delayed(const Duration(seconds: 4));
      FlutterNativeSplash.remove();
      runApp(ProviderScope(child: const Dokan()));
    },
    (Object error, StackTrace? stackTree) async {
      if (kDebugMode) {
        throw error;
      }
    },
  );
}

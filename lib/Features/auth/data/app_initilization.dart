import 'package:dokan_demo_wedevs/Features/auth/data/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final appInitializationProvider = FutureProvider((ref) async {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  final tokan = await _storage.read(key: 'auth_token');
  if (tokan == null) {
    ref.read(authProvider.notifier).logout();
  } else {  
    ref.read(authProvider.notifier).login();
  }
},);
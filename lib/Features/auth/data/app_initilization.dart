import 'package:dokan_demo_wedevs/Features/auth/data/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appInitializationProvider = FutureProvider((ref) async {
  var tokenValue;
  String TokenKey = 'token';
  final userData = ref.watch(userDataProvider).value;
  print(userData);
  for (String n in userData!.keys) {
    if (n == TokenKey) {
      tokenValue = userData[n];
      if (tokenValue != null) {
        ref.read(authProvider.notifier).login();
      } else {
        ref.read(authProvider.notifier).logout();
      }
    }
  }
},);
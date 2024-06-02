import 'package:dokan_demo_wedevs/Features/auth/data/store_user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  void login() {
    state = true;
  }

  void logout() async{
    await UserData().deleteUserData();
    state = false;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) {
    return FlutterSecureStorage();
  },
);

final userDataProvider = FutureProvider<Map<String, String>>(
  (ref) async {
    final storage = ref.read(secureStorageProvider);
    final userName = await storage.read(key: 'user') ?? '';
    final userEmail = await storage.read(key: 'email') ?? '';
    final token = await storage.read(key: 'token');
    if (token != null) {
      return {'user': userName, 'token': token, 'email': userEmail};
    } else {
      return {'user': '', 'token': '', 'email': ''};
    }
  },
);
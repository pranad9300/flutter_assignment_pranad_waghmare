import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

const String userCacheKey = '__user_cache__';

class AuthorizationLocalDataSource {
  AuthorizationLocalDataSource({
    required this.sharedPreferences,
  });

  /// Instance of [SharedPreferences] to operate on local data on the device.
  final SharedPreferences sharedPreferences;

  User getCurrentUser() {
    // call shared preferences method to get json encoded user cache.
    String? userCache = sharedPreferences.getString(userCacheKey);

    // decode user cache when not null other wise assign [User.empty]/
    User currentUser =
        userCache != null ? User.fromMap(json.decode(userCache)) : User.empty;

    // return current user.
    return currentUser;
  }

  Future<void> cacheCurrentUser(User currentUser) async =>
      await sharedPreferences.setString(
        userCacheKey,
        json.encode(currentUser.toMap()),
      );
}

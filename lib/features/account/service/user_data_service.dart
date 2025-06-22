import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_data.dart';

class UserDataService {
  Future<UserData> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString("Username") ?? "";
    final email = prefs.getString("Email") ?? "";
    final imageCache = prefs.getString("Image") ?? "";

    final userIdString = prefs.getString("UserId");
    final userId = userIdString != null ? int.tryParse(userIdString) ?? 0 : 0;

    final partyIdString = prefs.getString("PartyId");
    final partyId =
        partyIdString != null ? int.tryParse(partyIdString) ?? 0 : 0;

    final userData = UserData(
      username: username,
      email: email,
      imageCache: imageCache,
      userId: userId,
      partyId: partyId,
    );

    log("User data loaded: $userData");
    return userData;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

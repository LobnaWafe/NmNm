import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_face/features/authentication/data/user_model.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
 static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

//! this method to put data in local database using key

static Future<bool> saveData({required String key, required dynamic value}) async {
  if (value is bool) {
    return await sharedPreferences.setBool(key, value);
  } else if (value is String) {
    return await sharedPreferences.setString(key, value);
  } else if (value is int) {
    return await sharedPreferences.setInt(key, value);
  } else if (value is double) {
    return await sharedPreferences.setDouble(key, value);
  } else if (value is List<String>) {
    return await sharedPreferences.setStringList(key, value);
  } else {
    throw Exception("Unsupported type for saveData");
  }
}



//! this method to get data already saved in local database

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

//! remove data using specific key

static  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

//! this method to check if local database contains {key}
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData({required String key}) async {
    return sharedPreferences.clear();
  }

//! this fun to put data in local data base using key
static  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }

  ////////////////////


  // 🔹 Save User
  static Future<void> saveUser(UserModel userModel) async {
    final userJson = jsonEncode(userModel.toJson());
    await sharedPreferences.setString("user", userJson);
  }

  // 🔹 Get User
  static UserModel? getUser() {
    final userString = sharedPreferences.getString("user");
    if (userString == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return UserModel.fromJson(userMap);
  }

  // 🔹 Remove User
  static Future<void> removeUser() async {
    await sharedPreferences.remove("user");
  }
  
}
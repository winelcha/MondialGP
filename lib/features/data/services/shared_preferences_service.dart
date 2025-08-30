import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:untitled/features/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends GetxService {
  late SharedPreferences _prefs;

  Future<SharedPreferencesService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setUserType(UserType type) async {
    await _prefs.setString('user_type', type.toString().split('.').last);
  }

  UserType? getUserType() {
    final typeString = _prefs.getString('user_type');
    if (typeString == null) return null;

    return UserType.values.firstWhere(
          (e) => e.toString().split('.').last == typeString,
    );
  }

  Future<void> clearUserData() async {
    await _prefs.remove('user_type');
  }
}
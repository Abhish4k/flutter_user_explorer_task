import 'package:get_storage/get_storage.dart';
import 'package:user_explorer/app/data/models/user_models/user_model.dart';

class AppStorage {
  static final GetStorage _box = GetStorage();

  static const String _usersKey = 'users';

  static Future<void> saveUsers(List<UserModel> users) async {
    final List<Map<String, dynamic>> userData = users
        .map((UserModel user) => user.toJson())
        .toList();
    await _box.write(_usersKey, userData);
  }

  static List<UserModel> getUsers() {
    final List<dynamic>? rawData = _box.read<List<dynamic>>(_usersKey);
    if (rawData == null) return [];
    return rawData
        .map((dynamic e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> clear() async {
    await _box.remove(_usersKey);
  }
}

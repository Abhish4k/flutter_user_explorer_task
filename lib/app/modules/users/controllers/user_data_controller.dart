import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:user_explorer/app/utils/app_storage/app_storage.dart';
import 'package:user_explorer/app/utils/app_strings/app_strings.dart';
import 'package:user_explorer/app/utils/network_checker/network_checker.dart';
import '../../../data/models/user_models/user_model.dart';
import '../../../data/services/api_service.dart';

class UserDataController extends GetxController {
  final ApiService _api = ApiService();

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<UserModel> filtered = <UserModel>[].obs;
  final Rxn<UserModel> selectedUser = Rxn<UserModel>();
  final RxBool isLoading = false.obs;
  final RxBool isOffline = false.obs;
  final RxString error = ''.obs;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _listenToInternetConnectivity();
    fetchUsers();
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  void _listenToInternetConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      final bool online =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (online && isOffline.value) {
        isOffline.value = false;
        fetchUsers();
      } else if (!online && !isOffline.value) {
        isOffline.value = true;
        _loadFromCache();
      }
    });
  }

  Future<void> fetchUsers({int? id}) async {
    isLoading.value = true;
    error.value = '';

    final bool online = await NetworkChecker.isOnline();
    if (online) {
      try {
        final dynamic result = await _api.fetchUsers(id: id);
        if (result is List<UserModel>) {
          users.assignAll(result);
          filtered.assignAll(result);
          AppStorage.saveUsers(result);
        } else if (result is UserModel) {
          selectedUser.value = result;
        }
        isOffline.value = false;
      } catch (e) {
        error.value = e.toString();
        _loadFromCache();
      }
    } else {
      _loadFromCache();
    }
    isLoading.value = false;
  }

  void _loadFromCache() {
    final List<UserModel> cachedUsers = AppStorage.getUsers();
    if (cachedUsers.isNotEmpty) {
      users.assignAll(cachedUsers);
      filtered.assignAll(cachedUsers);
      isOffline.value = true;
    } else {
      error.value = AppStrings.noCachedAndNoInternet;
    }
  }

  void filterUsers(String query) {
    if (query.trim().isEmpty) {
      filtered.assignAll(users);
    } else {
      final String lowerCaseQuery = query.toLowerCase();
      final List<UserModel> matchedUsers = users
          .where((UserModel u) => u.name.toLowerCase().contains(lowerCaseQuery))
          .toList();
      filtered.assignAll(matchedUsers);
    }
  }

  void selectUser(UserModel user) {
    selectedUser.value = user;
  }
}

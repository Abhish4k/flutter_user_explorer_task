import 'package:get/get.dart';
import 'package:user_explorer/app/modules/users/controllers/user_data_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDataController>(() => UserDataController());
  }
}

import 'package:get/get.dart';
import 'package:user_explorer/app/modules/users/bindings/user_binding.dart';
import 'package:user_explorer/app/modules/users/views/user_details_view.dart';
import 'package:user_explorer/app/modules/users/views/user_list_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.USER_LIST,
      page: () => const UserListView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.USER_DETAILS,
      page: () => const UserDetailsView(),
      binding: UserBinding(),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_explorer/app/utils/app_strings/app_strings.dart';
import 'package:user_explorer/app/utils/app_colors/app_colors.dart';
import 'package:user_explorer/app/utils/app_theme/app_theme_controller.dart';
import '../controllers/user_data_controller.dart';
import '../../../routes/app_routes.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataController controller = Get.find<UserDataController>();
    final AppThemeController themeController = Get.find<AppThemeController>();

    return Obx(() {
      final bool isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark ? Colors.black : AppColors.scaffoldBg,
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          backgroundColor: isDark ? Colors.grey[900] : AppColors.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: themeController.toggleTheme,
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.error.value.isNotEmpty &&
              controller.filtered.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: AppColors.textGrey,
                    size: 64,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    controller.error.value.isNotEmpty
                        ? controller.error.value
                        : AppStrings.noCachedAndNoInternet,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white70 : AppColors.textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? Colors.tealAccent[700]
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: controller.fetchUsers,
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              if (controller.isOffline.value)
                Container(
                  color: AppColors.orangeColor,
                  width: Get.width,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    AppStrings.offlineMode,
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              Container(
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 6,
                      offset: const Offset(1, 1),
                    ),
                  ],
                  color: isDark ? Colors.grey[850] : AppColors.background,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  onChanged: controller.filterUsers,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark ? Colors.white70 : AppColors.blueGrey,
                    ),
                    hintText: AppStrings.searchHint,
                    hintStyle: TextStyle(
                      color: isDark ? Colors.white54 : AppColors.textGrey,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 12.0,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: isDark ? Colors.black : AppColors.background,
                  strokeWidth: 2.5,
                  onRefresh: () async => controller.fetchUsers(),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.filtered.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 15.0,
                    ),
                    itemBuilder: (context, index) {
                      final user = controller.filtered[index];
                      return userListItemWidget(
                        isDark: isDark,
                        name: user.name,
                        username: user.username,
                        email: user.email,
                        phoneNo: user.phone,
                        companyName: user.company.name,
                        onTap: () {
                          controller.selectUser(user);
                          Get.toNamed(Routes.USER_DETAILS);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }

  Widget userListItemWidget({
    required bool isDark,
    required String name,
    required String username,
    required String email,
    required String phoneNo,
    required String companyName,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: isDark ? Colors.grey[900] : AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.tealAccent : AppColors.blueGrey,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(color: AppColors.shadowLight, blurRadius: 4.0),
                ],
              ),
              child: Icon(
                Icons.person,
                color: isDark ? Colors.tealAccent : AppColors.blueGrey,
                size: 28.0,
              ),
            ),
            const SizedBox(width: 12.0),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white54 : AppColors.textGrey,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    phoneNo,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    companyName,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

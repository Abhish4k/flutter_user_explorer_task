import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_explorer/app/utils/app_colors/app_colors.dart';
import 'package:user_explorer/app/utils/app_strings/app_strings.dart';
import 'package:user_explorer/app/utils/app_theme/app_theme_controller.dart';
import '../controllers/user_data_controller.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataController controller = Get.find<UserDataController>();
    final AppThemeController themeController = Get.find<AppThemeController>();

    final user = controller.selectedUser.value;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            AppStrings.noUserSelected,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Obx(() {
      final bool isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark
            ? AppColors.darkScaffold
            : AppColors.lightScaffold,
        appBar: AppBar(
          title: Text(user.name),
          centerTitle: true,

          backgroundColor: isDark
              ? const Color(0xFF121212)
              : AppColors.lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: userDetailContainer(
            isDark,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userDetailRow(
                  isDark: isDark,
                  icon: Icons.person,
                  color: isDark ? AppColors.darkAccent : AppColors.lightPrimary,
                  title: user.username,
                  desc: user.name,
                ),
                dividerLine(isDark),
                userDetailRow(
                  isDark: isDark,
                  icon: Icons.email,
                  color: isDark ? AppColors.darkBlue : AppColors.blueGrey,
                  title: AppStrings.email,
                  desc: user.email,
                ),
                dividerLine(isDark),
                userDetailRow(
                  isDark: isDark,
                  icon: Icons.phone,
                  color: AppColors.success,
                  title: AppStrings.phone,
                  desc: user.phone,
                ),
                dividerLine(isDark),
                userDetailRow(
                  isDark: isDark,
                  icon: Icons.language,
                  color: isDark ? AppColors.darkAccent : AppColors.lightBlue,
                  title: AppStrings.website,
                  desc: user.website,
                ),
                dividerLine(isDark),
                userDetailRow(
                  isDark: isDark,
                  icon: Icons.business,
                  color: isDark ? AppColors.darkOrange : AppColors.lightOrange,
                  title: AppStrings.company,
                  desc: user.company.name,
                ),
                dividerLine(isDark),
                userDetailRow(
                  isDark: isDark,
                  icon: Icons.location_on,
                  color: isDark ? AppColors.darkRedAccent : AppColors.redAccent,
                  title: AppStrings.address,
                  desc:
                      '${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget userDetailContainer(bool isDark, Widget child) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 6.0,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget userDetailRow({
    required bool isDark,
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dividerLine(bool isDark) {
    return Container(
      height: 1.0,
      width: double.infinity,
      color: isDark
          ? AppColors.darkTextGrey.withValues(alpha: 0.3)
          : AppColors.dividerColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}

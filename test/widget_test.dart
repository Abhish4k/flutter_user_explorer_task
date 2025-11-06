import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:user_explorer/app/utils/app_theme/app_theme_controller.dart';
import 'package:user_explorer/main.dart';

void main() {
  testWidgets('App loads correctly with theme controller', (
    WidgetTester tester,
  ) async {
    final themeController = Get.put(AppThemeController());

    // Build our app
    await tester.pumpWidget(MyApp(themeController: themeController));

    // Basic verification — app builds
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

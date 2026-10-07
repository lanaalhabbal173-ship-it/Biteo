import 'package:biteoapp/firebase_options.dart';
import 'package:biteoapp/services/deep_link_service.dart';
import 'package:biteoapp/services/firebase_notification_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =====================================
  // GET STORAGE
  // =====================================

  await GetStorage.init();

  // =====================================
  // FIREBASE
  // =====================================

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );

  // =====================================
  // FIREBASE NOTIFICATIONS
  // =====================================

  final notificationService =
      FirebaseNotificationService();

  await notificationService.initialize();

  // =====================================
  // DEEP LINKS
  // =====================================

  await DeepLinkService().init();

  // =====================================
  // APP
  // =====================================

  runApp(
    const BiteoApp(),
  );
}

class BiteoApp extends StatelessWidget {
  const BiteoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Biteo",

      theme: ThemeData(
        scaffoldBackgroundColor:
            const Color(0xffFFF8F2),

        colorScheme:
            ColorScheme.fromSeed(
          seedColor:
              const Color(0xffff7a00),
        ),
      ),

      initialRoute: '/',

      getPages: AppPages.routes,
    );
  }
}
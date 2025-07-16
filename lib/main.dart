import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Test SuiteMedia Ifqy Gifha Azhar',
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.firstScreen,
    );
  }
}

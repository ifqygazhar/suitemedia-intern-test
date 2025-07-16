import 'package:get/get.dart';
import 'package:test/controller/binding/first_screen_binding.dart';
import 'package:test/controller/binding/second_screen_binding.dart';
import 'package:test/view/first_screen/first_screen.dart';
import 'package:test/view/second_screen/second_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String firstScreen = '/';
  static const String secondScreen = '/second';
  static const String thirdScreen = '/third';

  static final routes = [
    GetPage(
      name: firstScreen,
      page: () => const FirstScreen(),
      binding: FirstScreenBinding(),
    ),
    GetPage(
      name: secondScreen,
      page: () => const SecondScreen(),
      binding: SecondScreenBinding(),
    ),
  ];
}

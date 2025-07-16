import 'package:get/get.dart';
import 'package:test/controller/first_screen/first_screen_controller.dart';

class FirstScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstScreenController>(
      () => FirstScreenController(),
      fenix: false,
    );
  }
}

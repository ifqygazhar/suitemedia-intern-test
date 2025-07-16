import 'package:get/get.dart';
import 'package:test/controller/second_screen/second_screen_controller.dart';

class SecondScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondScreenController>(() => SecondScreenController());
  }
}

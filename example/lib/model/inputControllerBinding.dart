import 'package:get/get.dart';
import 'package:example/model/inputController.dart';

class InputControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InputController(), permanent: true);
  }
}

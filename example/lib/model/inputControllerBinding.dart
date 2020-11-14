import 'package:get/get.dart';
import 'package:example/model/inputController.dart';

import 'countryController.dart';

class InputControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InputController(), permanent: true);
    Get.put(CountryController());
  }
}

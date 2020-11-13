import 'package:example/model/countryController.dart';
import 'package:get/get.dart';
import 'countryController.dart';

class CountryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CountryController());
  }
}

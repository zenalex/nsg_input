import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/model/inputController.dart';
import 'package:nsg_input/nsg_input.dart';

import 'model/countryController.dart';

class InputWidget extends GetView<InputController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Test NsgInput page'), centerTitle: true),
        backgroundColor: Colors.blue,
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: getinputCountry(context),
              //GetBuilder<NsgController>(builder: null, didChangeDependencies: ,)
            )));
  }

  Widget getCountryItem(
      BuildContext context, int i, CountryController countryController) {
    return ListTile(
      title: Text(countryController.items[i].title),
    );
  }

  Widget getListView(BuildContext context) {
    final countryController = Get.find<CountryController>();
    return countryController.obx((state) => ListView.builder(
        itemCount: countryController.items.length,
        itemBuilder: (context, i) =>
            getCountryItem(context, i, countryController)));
  }

  Widget getinputCountry(BuildContext context) {
    final countryController = Get.find<CountryController>();
    return NsgInput(dataController: countryController);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/model/inputController.dart';

import 'model/countryController.dart';

class InputWidget extends GetView<InputController> {
  @override
  Widget build(BuildContext context) {
    final countryController = Get.find<CountryController>();
    return Scaffold(
        appBar: AppBar(title: Text('Test NsgInput page'), centerTitle: true),
        backgroundColor: Colors.blue,
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: countryController.obx((state) => ListView.builder(
                  itemCount: countryController.items.length,
                  itemBuilder: (context, i) =>
                      getCountryItem(context, i, countryController))),
              //GetBuilder<NsgController>(builder: null, didChangeDependencies: ,)
            )));
  }

  Widget getCountryItem(
      BuildContext context, int i, CountryController countryController) {
    return ListTile(
      title: Text(countryController.items[i].title),
    );
  }
}

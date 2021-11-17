import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/model/inputController.dart';
//import 'package:nsg_input/nsg_input.dart';

import 'model/countryController.dart';
import 'model/cityController.dart';
import 'model/countryItem.dart';

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
              child: Column(children: [
                getinputCountry(context),
                getinputCity(context),
              ]),
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
    return Text("СТРАНА");
    //TODO: отключил
    // NsgInput(
    //   dataController: countryController,
    //   flagFieldName: CountryItem.name_countryCode,
    //   showPicture: true,
    // );
  }

  Widget getinputCity(BuildContext context) {
    final countryController = Get.find<CityController>();
    return Text("Страна");
    //TODO: отключил
    //return NsgInput(dataController: countryController);
  }
}

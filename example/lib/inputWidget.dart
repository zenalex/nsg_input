import 'package:example/model/nsgController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/model/inputController.dart';

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
              Text('Test input widget'),
              //GetBuilder<NsgController>(builder: null, didChangeDependencies: ,)
            ]))));
  }
}

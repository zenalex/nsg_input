import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/inputWidget.dart';
import 'model/inputController.dart';
import 'model/inputControllerBinding.dart';
//import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //S.load(Locale('ru', ''));
    var app = GetMaterialApp(
        onGenerateTitle: (BuildContext context) => 'NSG_DATA TEST',
        debugShowCheckedModeBanner: false,
        home: MainScreen());
    return app;
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  void loginSuccessful(BuildContext context, dynamic parameter) {
    Navigator.pop<bool>(context, true);
  }

  // Формирование виджета
  @override
  Widget build(BuildContext context) {
    // А вот это вёрстка виджета,
    // немного похоже на QML хотя явно не JSON структура
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
          child: getBody(),
        ),
      ),
    );
  }

  Future init(BuildContext context) async {
    Get.put(InputController(), permanent: true);
  }

  String captchaText = '';
  Widget getBody() {
    var controller = Get.find<InputController>();
    return controller.obx((state) =>
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('isAnonymous = ${controller.provider.isAnonymous}'),
          Divider(),
          FlatButton(
              onPressed: () =>
                  Get.to(InputWidget(), binding: InputControllerBinding()),
              child: Container(
                color: Colors.lightGreen,
                child: Text('NsgInput test'),
              ))
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:nsg_input/country/nsg_input_country.dart';
import 'package:nsg_input/nsg_input.dart';
import 'package:nsg_input/nsg_input_item.dart';

import 'country/nsg_input_country_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NSG'),
      ),
      body: Center(
        child: Column(
          children: [getInput(context), getInputCountry(context)],
        ),
      ),
    );
  }

  Widget getInput(BuildContext context) {
    var list = List<NsgInputItem>();
    list.add(NsgInputItem(name: "English"));
    list.add(NsgInputItem(name: "Russian"));
    list.add(NsgInputItem(name: "Bulgarian"));

    var input = NsgInput(showPicture: false, elements: list);
    return input;
  }

  Widget getInputCountry(BuildContext context) {
    var list = List<NsgInputItem>();
    list.add(NsgInputCountryItem(name: "US"));
    list.add(NsgInputCountryItem(name: "RU"));
    list.add(NsgInputCountryItem(name: "BG"));

    var initValue = NsgInputCountryItem(name: "BG");

    var input = NsgInputCountry(
      showPicture: true,
      elements: list,
      initialSelection: initValue,
      onChanged: (value) => print((value as NsgInputCountryItem).countryName),
    );
    return input;
  }
}

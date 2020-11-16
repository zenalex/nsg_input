import 'package:flutter/material.dart';
import 'package:nsg_data/nsg_data.dart';

class NsgFlags {
  static Image getImage(
      NsgDataItem item, String fieldName, String packageName) {
    return Image.asset(
        "lib/country/flags/${item.fieldValues.fields[fieldName].toLowerCase()}.png",
        package: packageName);
  }
}

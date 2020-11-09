import 'package:flutter/material.dart';

/// Input element. This is the element that contains all the information
class NsgInputItem {
  /// text representation
  String name = '';
  Object get linkedObject => _linkedObject;
  set linkedObject(Object obj) {
    if (obj != null && name == '') name = obj.toString();
  }

  /// link to business object
  Object _linkedObject;
  String imagePath;
  Image _picture;

  @override
  bool operator ==(Object other) => other is NsgInputItem && other.name == name;

  @override
  int get hashCode => name.hashCode;

  Image get picture {
    if (_picture == null) {
      if (imagePath == '')
        _picture = Image.asset(
          "lib/assets/nodata.jpg",
          package: 'nsg_input',
        );
      else
        _picture = Image.asset(imagePath, package: 'nsg_input');
    }
    return _picture;
  }

  set picture(Image img) => _picture = img;

  @override
  String toString() => "$name";
  String get presentation => toString();

  NsgInputItem({String name, Image picture, Object linkedObject}) {
    this.name = name;
    this.picture = picture;
    this.linkedObject = linkedObject;
  }
}

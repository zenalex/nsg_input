import 'package:nsg_data/dataFields/stringField.dart';
import 'package:nsg_data/nsg_data.dart';

import 'countryItem.dart';

class CityItem extends NsgDataItem {
  static const name_id = 'Id';
  static const name_title = 'Title';
  static const name_countryId = 'CountryId';

  @override
  void initialize() {
    addfield(NsgDataStringField(name_id), primaryKey: true);
    addfield(NsgDataStringField(name_title));
    addfield(NsgDataReferenceField<CountryItem>(name_countryId));
  }

  @override
  NsgDataItem getNewObject() => CityItem();

  String get id => getFieldValue(name_id).toString();
  set id(String value) => setFieldValue(name_id, value);
  String get title => getFieldValue(name_title).toString();
  set title(String value) => setFieldValue(name_title, value);
  String get countryId => getFieldValue(name_countryId).toString();
  set countryId(String value) => setFieldValue(name_countryId, value);
  CountryItem get country => getReferent<CountryItem>(name_countryId);
  Future<CountryItem> countryAsync() async {
    return await getReferentAsync<CountryItem>(name_countryId);
  }

  @override
  String get apiRequestItems {
    return '/Api/Data/GetCity';
  }

  @override
  String toString() {
    if (isEmpty) {
      return super.toString();
    } else {
      return title;
    }
  }
}

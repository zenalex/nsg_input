import 'package:nsg_data/nsg_data.dart';

class CountryItem extends NsgDataItem {
  static const name_id = 'Id';
  static const name_title = 'Title';
  static const name_countryCode = 'CountryCode';

  @override
  void initialize() {
    addfield(NsgDataStringField('Id'), primaryKey: true); //GUID
    addfield(NsgDataStringField('Title')); //Russia, USA
    addfield(NsgDataStringField('CountryCode')); //Russia, USA
  }

  @override
  NsgDataItem getNewObject() => CountryItem();

  String get id => getFieldValue(name_id).toString();
  set id(String value) => setFieldValue(name_id, value);
  String get title => getFieldValue(name_title).toString();
  set title(String value) => setFieldValue(name_title, value);
  String get countryCode => getFieldValue(name_countryCode).toString();
  set countryCode(String value) => setFieldValue(name_countryCode, value);

  @override
  String get apiRequestItems {
    return '/Api/Data/GetCountry';
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

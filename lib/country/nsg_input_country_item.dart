import 'package:nsg_input/country/nsg_input_all_countries.dart';
import 'package:nsg_input/nsg_input_item.dart';

/// Input element. This is the element that contains all the information
class NsgInputCountryItem extends NsgInputItem2 {
  @override
  String toString() => '$name';
  String countryName = '';
  @override
  String get presentation => countryName == '' ? name : countryName;
  final tag;

  NsgInputCountryItem({String name, this.tag}) : super() {
    name = name.toUpperCase();
    this.name = name;
    assert(NsgCountries.countries.countryList.containsKey(name),
        'ERROR: unknown country code $name');
    var country = NsgCountries.countries.countryList[name];
    countryName = country.countryName;
    imagePath = country.getPicture();
    linkedObject = country;
  }

  // @override
  // bool operator ==(Object other) =>
  //     other is NsgInputCountryItem && other.countryName == countryName;

  // @override
  // int get hashCode => countryName.hashCode;

  static NsgInputCountryItem createFromCountry(NsgCountry country) {
    return NsgInputCountryItem(name: country.countryCode);
  }
}

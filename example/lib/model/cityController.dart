import 'cityItem.dart';
import 'countryItem.dart';
import 'package:nsg_data/nsg_data.dart';

class CityController extends NsgDataController<CityItem> {
  CityController(NsgDataController<CountryItem> masterController)
      : super(
            requestOnInit: true,
            autoRepeate: true,
            autoRepeateCount: 1000,
            masterController: masterController) {
    dataBinding = NsgDataBinding();
    dataBinding.masterFieldName = CountryItem.name_id;
  }
}

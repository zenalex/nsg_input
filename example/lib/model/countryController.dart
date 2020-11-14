import 'package:example/model/countryItem.dart';

import 'package:nsg_data/nsg_data.dart';

class CountryController extends NsgDataController<CountryItem> {
  CountryController()
      : super(requestOnInit: true, autoRepeate: true, autoRepeateCount: 1000);
}

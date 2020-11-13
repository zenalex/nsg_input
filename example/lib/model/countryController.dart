import 'package:example/model/countryItem.dart';

import 'nsgController.dart';

class CountryController extends NsgDataController<CountryItem> {
  CountryController()
      : super(requestOnInit: true, autoRepeate: true, autoRepeateCount: 1000);
}

import 'package:example/model/UserSettings.dart';
import 'package:example/model/cardItem.dart';
import 'package:example/model/cityItem.dart';
import 'package:example/model/countryItem.dart';
import 'package:get/get.dart';
import 'package:nsg_data/authorize/nsgPhoneLoginPage.dart';
import 'package:nsg_data/nsg_data.dart';

class InputController extends GetxController
    with StateMixin<InputControllerData> {
  late NsgDataProvider provider;
  @override
  void onInit() async {
    super.onInit();

    provider = NsgDataProvider();
    provider.serverUri = 'http://alex.nsgsoft.ru:5073';

    NsgDataClient.client
        .registerDataItem(UserSettingsItem(), remoteProvider: provider);
    NsgDataClient.client.registerDataItem(CardItem(), remoteProvider: provider);
    NsgDataClient.client.registerDataItem(CityItem(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(CountryItem(), remoteProvider: provider);

    //TODO: непонятно зачем. Разобраться, переделать
    //await provider.resetUserToken();
    //await provider.connect();

    // if (provider.isAnonymous) {
    //   await Get.to(NsgPhoneLoginPage(provider,
    //           widgetParams: NsgPhoneLoginParams.defaultParams))
    //       .then((value) => loadData());
    // } else {
    //   await loadData();
    // }
  }

  Future loadData() async {
    try {
      var userSettingsItem =
          await NsgDataRequest<UserSettingsItem>().requestItem();
      await NsgDataRequest()
          .loadAllReferents([userSettingsItem], [UserSettingsItem.name_cityId]);
      var city = userSettingsItem.city;
      if (city != null) {
        print('My city name = ' + city.title);
      }

      var data = InputControllerData();
      data.userSettings = userSettingsItem;
      change(data, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}

class InputControllerData {
  UserSettingsItem? userSettings;
}

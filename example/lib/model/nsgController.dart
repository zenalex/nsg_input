import 'package:example/model/nsgBaseControllerData.dart';
import 'package:example/model/nsgDataBinding.dart';
import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

class NsgController<T extends NsgDataItem> extends NsgBaseController {}

class NsgBaseController extends GetxController
    with StateMixin<NsgBaseControllerData> {
  final bool requestOnInit;

  ///Use update method on data update
  final bool useUpdate;

  ///Use change method on data update
  final bool useChange;
  //GetBuilder IDs to update
  final List<String> builderIDs;
  final NsgController masterController;
  final NsgDataBinding dataBindign;
  RxStatus currentStatus = RxStatus.loading();

  NsgDataItem _selectedItem;
  NsgDataItem get selectedItem => _selectedItem;
  set selectedItem(NsgDataItem newItem) {
    if (_selectedItem != newItem && selectedItemChanged != null) {
      selectedItemChanged(newItem);
    }
    _selectedItem = newItem;
  }

  //Referenses to load
  List<String> referenceList;
  void Function(NsgDataItem selectedItem) selectedItemChanged;

  NsgBaseController(
      {this.requestOnInit,
      this.useUpdate,
      this.useChange,
      this.builderIDs,
      this.masterController,
      this.dataBindign})
      : super();

  @override
  void onInit() {
    super.onInit();
    if (requestOnInit) requestItems();
  }

  List<NsgDataItem> _itemList;
  List<NsgDataItem> get itemList {
    if (_itemList == null) {
      _itemList = <NsgDataItem>[];
      requestItems();
    }
    return _itemList;
  }

  ///Request Items
  void requestItems() async {
    try {
      var request = NsgDataRequest(dataItemType: selectedItem.runtimeType);
      var newItemsList =
          await request.requestItems(loadReference: referenceList);
      //service method for descendants
      currentStatus = RxStatus.success();
      afterRequestItems(newItemsList);
      //notify builders
      if (useUpdate) update(builderIDs);
      if (useChange) {
        change(NsgBaseControllerData(controller: this), status: currentStatus);
      }
      //service method for descendants
      afterUpdate();
    } catch (e) {
      currentStatus = RxStatus.error(e.toString());
      if (useUpdate) update(builderIDs);
      if (useChange) {
        change(null, status: currentStatus);
      }
    }
  }

  ///is calling after new Items are putted in itemList
  void afterUpdate() {}

  ///is calling after new items are got from API before they are placed to ItemList
  void afterRequestItems(List<NsgDataItem> newItemsList) {}

  List<NsgDataItem> filter(List<NsgDataItem> newItemsList) {
    if (dataBindign == null) return newItemsList;
    if (masterController.selectedItem == null &&
        !masterController.selectedItem.fieldList.fields
            .containsKey(dataBindign.masterFieldName)) return newItemsList;
    var masterValue = masterController
        .selectedItem.fieldValues.fields[dataBindign.masterFieldName];

    var list = <NsgDataItem>[];
    newItemsList.forEach((element) {
      if (element.fieldValues.fields[dataBindign.slaveFieldName] ==
          masterValue) {
        list.add(element);
      }
    });
    return list;
  }
}

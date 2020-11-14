library nsg_input;

import 'package:flutter/material.dart';
import 'package:nsg_data/nsg_data.dart';

import 'nsg_selection_dialog.dart';

class NsgInput extends StatelessWidget {
  final List<NsgDataItem> favorite;
  final NsgBaseController dataController;

  ///Text style. By default Theme.of(context).textTheme.button
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showPictureOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle dialogTextStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(NsgDataItem) builder;
  final bool enabled;
  final TextOverflow textOverflow;

  /// the size of the selection dialog
  final Size dialogSize;

  /// used to customize the country list
  final List<NsgDataItem> objectsFilter;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyCountryWhenClosed],
  /// because longer country names are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showPicture;

  final bool hideMainText;

  final bool showPictureMain;

  final bool showPictureDialog;

  /// Width of the flag images
  final double pictureWidth;

  /// Use this property to change the order of the options
  final Comparator<Object> comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  final List<NsgDataItem> favoriteElements = [];

  NsgInput({
    this.dataController,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showPictureOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.alignLeft = false,
    this.showPicture = true,
    this.showPictureDialog,
    this.hideMainText = false,
    this.showPictureMain,
    this.builder,
    this.pictureWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.comparator,
    this.objectsFilter,
    this.hideSearch = false,
    this.dialogSize,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (builder != null)
      _widget = InkWell(
        onTap: () => showCountryCodePickerDialog(context),
        child: builder(dataController.selectedItem),
      );
    else {
      _widget = FlatButton(
        padding: padding,
        onPressed: enabled ? () => showCountryCodePickerDialog(context) : null,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showPictureMain != null ? showPictureMain : showPicture)
              Flexible(
                flex: alignLeft ? 0 : 1,
                fit: alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Padding(
                  padding: alignLeft
                      ? const EdgeInsets.only(right: 16.0, left: 8.0)
                      : const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    child: getImage(dataController.selectedItem),
                    width: pictureWidth,
                  ), //Рассчитать высоту картинки
                ),
              ),
            if (!hideMainText)
              Flexible(
                fit: alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Text(
                  dataController.selectedItem == null
                      ? ''
                      : dataController.selectedItem
                          .toString(), //TODO: presentation
                  style: textStyle ?? Theme.of(context).textTheme.button,
                  overflow: textOverflow,
                ),
              ),
          ],
        ),
      );
    }
    return _widget;
  }

  void showCountryCodePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => NsgSelectionDialog(
        dataController.itemList,
        favoriteElements,
        emptySearchBuilder: emptySearchBuilder,
        searchDecoration: searchDecoration,
        searchStyle: searchStyle,
        textStyle: dialogTextStyle,
        showPicture: showPicture != null ? showPicture : false,
        pictureWidth: pictureWidth,
        size: dialogSize,
        hideSearch: hideSearch,
      ),
    );
  }

  Image getImage(NsgDataItem selectedItem) {}
}

import 'package:flutter/material.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:nsg_input/nsg_input.dart';

class NsgInputCountry extends NsgInput {
  NsgInputCountry(
      {ValueChanged<NsgDataItem> onChanged,
      ValueChanged<NsgDataItem> onInit,
      List<NsgDataItem> favorite = const [],
      TextStyle textStyle,
      EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
      bool showPictureOnly = false,
      InputDecoration searchDecoration = const InputDecoration(),
      TextStyle searchStyle,
      TextStyle dialogTextStyle,
      WidgetBuilder emptySearchBuilder,
      Function(NsgDataItem) builder,
      bool enabled = true,
      TextOverflow textOverflow = TextOverflow.ellipsis,
      Size dialogSize,
      List<NsgDataItem> objectsFilter,
      bool alignLeft = false,
      bool showPicture = true,
      bool hideMainText = false,
      bool showPictureMain,
      bool showPictureDialog,
      double pictureWidth = 32.0,
      bool hideSearch = false,
      Key key})
      : super(
            favorite: favorite,
            textStyle: textStyle,
            padding: padding,
            showPictureOnly: showPictureOnly,
            searchDecoration: searchDecoration,
            searchStyle: searchStyle,
            dialogTextStyle: dialogTextStyle,
            emptySearchBuilder: emptySearchBuilder,
            alignLeft: alignLeft,
            showPicture: showPicture,
            showPictureDialog: showPictureDialog,
            hideMainText: hideMainText,
            showPictureMain: showPictureMain,
            builder: builder,
            pictureWidth: pictureWidth = 32.0,
            enabled: enabled = true,
            textOverflow: textOverflow,
            //comparator,
            objectsFilter: objectsFilter,
            hideSearch: hideSearch,
            dialogSize: dialogSize,
            key: key);
}

library country_code_picker;

import 'package:flutter/material.dart';
import 'package:nsg_input/nsg_input_item.dart';

import 'nsg_selection_dialog.dart';

class NsgInput extends StatefulWidget {
  final ValueChanged<NsgInputItem> onChanged;
  final ValueChanged<NsgInputItem> onInit;
  final NsgInputItem initialSelection;
  final List<NsgInputItem> elements;
  final List<NsgInputItem> favorite;

  ///Text style. By default Theme.of(context).textTheme.button
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showPictureOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle dialogTextStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(NsgInputItem) builder;
  final bool enabled;
  final TextOverflow textOverflow;

  /// the size of the selection dialog
  final Size dialogSize;

  /// used to customize the country list
  final List<NsgInputItem> objectsFilter;

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

  NsgInput({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.elements = const [],
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
  State<StatefulWidget> createState() {
    //return CountryCodePickerState(elements);
    return NsgInputState(elements);
  }
}

class NsgInputState extends State<NsgInput> {
  NsgInputItem selectedItem = NsgInputItem();
  List<NsgInputItem> elements = [];
  List<NsgInputItem> favoriteElements = [];

  NsgInputState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        onTap: showCountryCodePickerDialog,
        child: widget.builder(selectedItem),
      );
    else {
      _widget = FlatButton(
        padding: widget.padding,
        onPressed: widget.enabled ? showCountryCodePickerDialog : null,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showPictureMain != null
                ? widget.showPictureMain
                : widget.showPicture)
              Flexible(
                flex: widget.alignLeft ? 0 : 1,
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Padding(
                  padding: widget.alignLeft
                      ? const EdgeInsets.only(right: 16.0, left: 8.0)
                      : const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    child: selectedItem.picture,
                    width: widget.pictureWidth,
                  ), //Рассчитать высоту картинки
                ),
              ),
            if (!widget.hideMainText)
              Flexible(
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Text(
                  selectedItem.presentation,
                  style: widget.textStyle ?? Theme.of(context).textTheme.button,
                  overflow: widget.textOverflow,
                ),
              ),
          ],
        ),
      );
    }
    return _widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //this.elements = elements.map((e) => e.localize(context)).toList();
    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(NsgInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      //if (widget.initialSelection != null) {
      //   selectedItem = elements.firstWhere(
      //       (e) =>
      //           (e.code.toUpperCase() ==
      //               widget.initialSelection.toUpperCase()) ||
      //           (e.dialCode == widget.initialSelection) ||
      //           (e.name.toUpperCase() == widget.initialSelection.toUpperCase()),
      //       orElse: () => elements[0]);
      // } else {
      //   selectedItem = elements[0];
      //}
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere((e) => (e == widget.initialSelection),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    //   favoriteElements = elements
    //       .where((e) =>
    //           widget.favorite.firstWhere(
    //               (f) =>
    //                   e.code.toUpperCase() == f.toUpperCase() ||
    //                   e.dialCode == f ||
    //                   e.name.toUpperCase() == f.toUpperCase(),
    //               orElse: () => null) !=
    //           null)
    //       .toList();
  }

  void showCountryCodePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => NsgSelectionDialog(
        elements,
        favoriteElements,
        emptySearchBuilder: widget.emptySearchBuilder,
        searchDecoration: widget.searchDecoration,
        searchStyle: widget.searchStyle,
        textStyle: widget.dialogTextStyle,
        showPicture: widget.showPicture != null ? widget.showPicture : false,
        pictureWidth: widget.pictureWidth,
        size: widget.dialogSize,
        hideSearch: widget.hideSearch,
      ),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(NsgInputItem e) {
    if (widget.onChanged != null) {
      widget.onChanged(e);
    }
  }

  void _onInit(NsgInputItem e) {
    if (widget.onInit != null) {
      widget.onInit(e);
    }
  }
}

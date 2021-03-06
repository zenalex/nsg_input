import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nsg_data/nsg_data.dart';
import 'country/nsgFlags.dart';

/// selection dialog used for selection of the country code
class NsgSelectionDialog extends StatefulWidget {
  final NsgBaseController dataController;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle textStyle;
  final WidgetBuilder emptySearchBuilder;
  final bool showPicture;
  final double pictureWidth;
  final Size size;
  final bool hideSearch;
  final Image Function(
      NsgDataItem selectedItem, String fieldName, String packageName) getImage;
  final String flagFieldName;
  final String packageName;

  /// elements passed as favorite
  final List<NsgDataItem> favoriteElements;

  NsgSelectionDialog(
    this.dataController,
    this.favoriteElements, {
    Key key,
    this.emptySearchBuilder,
    InputDecoration searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.textStyle,
    this.showPicture,
    this.pictureWidth = 32,
    this.size,
    this.hideSearch = false,
    this.getImage = NsgFlags.getImage,
    this.flagFieldName,
    this.packageName = 'nsg_input',
  })  : assert(searchDecoration != null, 'searchDecoration must not be null!'),
        this.searchDecoration =
            searchDecoration.copyWith(prefixIcon: Icon(Icons.search)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _NsgSelectionDialogState();
}

class _NsgSelectionDialogState extends State<NsgSelectionDialog> {
  /// this is useful for filtering purpose
  List<NsgDataItem> filteredElements;

  @override
  Widget build(BuildContext context) => SimpleDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
              padding: const EdgeInsets.all(0),
              iconSize: 20,
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            if (!widget.hideSearch)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  style: widget.searchStyle,
                  decoration: widget.searchDecoration,
                  onChanged: _filterElements,
                ),
              ),
          ],
        ),
        children: [
          Container(
            width: widget.size?.width ?? MediaQuery.of(context).size.width,
            height:
                widget.size?.height ?? MediaQuery.of(context).size.height * 0.7,
            child: ListView(
              children: [
                widget.favoriteElements.isEmpty
                    ? const DecoratedBox(decoration: BoxDecoration())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...widget.favoriteElements.map(
                            (f) => SimpleDialogOption(
                              child: _buildOption(f),
                              onPressed: () {
                                _selectItem(f);
                              },
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                if (filteredElements.isEmpty)
                  _buildEmptySearchWidget(context)
                else
                  ...filteredElements.map(
                    (e) => SimpleDialogOption(
                      key: Key(e.toString()), //TODO: presentation
                      child: _buildOption(e),
                      onPressed: () {
                        _selectItem(e);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      );

  Widget _buildOption(NsgDataItem e) {
    return Container(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          if (widget.showPicture)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  child: NsgFlags.getImage(
                      e, widget.flagFieldName, widget.packageName),
                  width: widget.pictureWidth,
                ),
              ),
            ),
          Expanded(
            flex: 4,
            child: Text(
              e.toString(), //TODO: presentation
              overflow: TextOverflow.fade,
              style: widget.textStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder(context);
    }

    return Center(
      child: Text('No elements found'),
    );
  }

  @override
  void initState() {
    filteredElements = widget.dataController.dataItemList;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = widget.dataController.dataItemList
          .where((e) => e.toString().toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(NsgDataItem e) {
    widget.dataController.selectedItem = e;
    Navigator.pop(context, e);
  }
}

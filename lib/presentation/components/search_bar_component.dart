
import 'package:flutter/material.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class SearchBarComponent extends StatefulWidget {
  final double barHeight;
  final String? hintText;
  final TextEditingController searchController;
  final Function(String)? onSubmitted;
  final Function? onClear;
  final bool showText;
  final Function(String)? onChange;

  const SearchBarComponent(
      {
      this.barHeight = 40,
      this.hintText,
      required this.searchController,
      this.onSubmitted,
      this.onClear,
      this.onChange,
      this.showText = false});

  @override
  _SearchBarComponentState createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                textInputAction: TextInputAction.search,
                autofocus: false,
                onSubmitted: (value) {
                  widget.onSubmitted!(widget.searchController.text);
                },
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    setState(() {
                      _editing = true;
                    });
                    if (widget.onChange != null) {
                      widget.onChange!(widget.searchController.text);
                    }
                  }
                },
                controller: widget.searchController,
                style: MetaStyle(mapData: {
                  "color" : "0xFF2854A1",
                  "size": "14",
                  "family": "regular"
                }).getStyle(),
                decoration: InputDecoration(
                  hintStyle: MetaStyle(mapData: {
                    "text" : "Search Username",
                    "color" : "0xFF2854A1",
                    "size": "14",
                    "family": "regular"
                  }).getStyle(),
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  prefixIcon: InkWell(
                    onTap: () {
                      widget.onSubmitted!(widget.searchController.text);
                    },
                    child: Icon(Icons.search_outlined,color: Colors.black54,),
                  ),
                  suffixIcon: _editing
                      ? InkWell(
                          onTap: () {
                            widget.searchController.text = "";
                            setState(() {
                              _editing = false;
                              widget.onClear!();
                            });
                          },
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey,
                          ),
                        )
                      : SizedBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

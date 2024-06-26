import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String? searchText;
  final Function(String) typedText;
  final Function(dynamic)? selectedFilter;
  final Map<String, dynamic>? filterItems;
  const SearchWidget(
      {super.key,
      required this.typedText,
      this.searchText,
      this.filterItems,
      this.selectedFilter});
  // const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String? _selectedKey;
  dynamic _selectedValue;

  // List of items for the dropdown
  Map<String, dynamic>? _items;
  String hintText = "Search Food";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _items = widget.filterItems;
    if (_items != null) {
      _selectedKey = _items!.keys.first;
    }

    if (widget.searchText != null) {
      hintText = widget.searchText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset:
                const Offset(0, 3), // Positive vertical value for bottom shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.search),
            Flexible(
              child: TextFormField(
                // controller: _emailFieldController,
                decoration: InputDecoration(
                    hintText: hintText, border: InputBorder.none),
                onFieldSubmitted: (String value) {
                  widget.typedText(value);
                },
              ),
            ),
            if (_items != null)
              PopupMenuButton<String>(
                icon: Icon(Icons.filter_list),
                onSelected: (String key) {
                  setState(() {
                    _selectedKey = key;
                    _selectedValue = _items![key];
                    widget.selectedFilter!(_selectedValue);
                  });
                },
                itemBuilder: (BuildContext context) {
                  return _items!.keys.map((String key) {
                    return PopupMenuItem<String>(
                      value: key,
                      child: Text(
                        key,
                        style: TextStyle(
                            color: _selectedKey == key
                                ? Colors.red
                                : Colors.black),
                      ),
                    );
                  }).toList();
                },
              ),
          ],
        ),
      ),
    );
  }
}

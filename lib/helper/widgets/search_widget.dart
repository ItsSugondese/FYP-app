import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) typedText;
  const SearchWidget({super.key, required this.typedText});
  // const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
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
                decoration: const InputDecoration(
                    hintText: "Search food", border: InputBorder.none),
                onFieldSubmitted: (String value) {
                  widget.typedText(value);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

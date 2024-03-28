import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';

// ignore: must_be_immutable
class GlobalPayFilterWidget extends StatefulWidget {
  Function(dynamic) selectedFilter;
  final Map<String, dynamic> options;
  GlobalPayFilterWidget(
      {super.key, required this.selectedFilter, required this.options});

  @override
  State<GlobalPayFilterWidget> createState() => _GlobalPayFilterWidgetState();
}

class _GlobalPayFilterWidgetState extends State<GlobalPayFilterWidget> {
  late String _selectedKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedKey = widget.options.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.options.entries
                .map((e) => Container(
                      margin: EdgeInsets.only(
                          left: widget.options.keys.first == e.key ? 0 : 3.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                EdgeInsets
                                    .zero // Adjust the horizontal padding as needed
                                ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            backgroundColor: e.key == _selectedKey
                                ? MaterialStateProperty.all(
                                    CustomColors.defaultRedColor)
                                : MaterialStateProperty.all(Color(0xFFFAE7E6)),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {
                          // AutoRouter.of(context)
                          //     .push(const LoginScreenRoute());
                          setState(() {
                            _selectedKey = e.key;
                          });
                          widget.selectedFilter(e.value);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${e.key}",
                            style: TextStyle(
                                color: e.key == _selectedKey
                                    ? Colors.white
                                    : CustomColors.defaultRedColor,
                                // fontSize: LandingScreenConstants.buttonFontSize,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}

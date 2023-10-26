import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/everyone/test_service.dart';

@RoutePage()
class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final testService = TestService();
  Future<String>? testText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testText = testService.getFilter();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<String>(
        future: testText,
          builder: (context, snapshot){
            if(snapshot.hasData){
             return  Text("${snapshot.data}");
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }            else{
              return Text("Fuck you");
            }
          }
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:fyp/features/everyone/test_service.dart';

class TestClass extends StatefulWidget {
  const TestClass({Key? key}) : super(key: key);

  @override
  State<TestClass> createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
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


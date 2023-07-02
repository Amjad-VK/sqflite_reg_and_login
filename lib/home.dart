import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home_user extends StatelessWidget {
  final data;
  const home_user({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = data[0]['name'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome $name"),
      ),
      body: Center(
        child: Text('Success'),
      ),
    );
  }
}

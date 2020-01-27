import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {
  final String name;

  ErrorPage({
    Key key,
    this.name,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Text(
          "The screen named $name doesn't exist.",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

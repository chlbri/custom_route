import 'package:example/setup_routing.dart';
import 'package:flutter/material.dart';
import 'package:simple_router/custom_route.dart';

import 'screens/statefull/screen_1.dart';

void main() {
  setUpRouting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: CustomRoute.onGenerateRoute,
      initialRoute: CustomRoute.initialRoute,
      navigatorKey: CustomRoute.navigatorKey,
      title: 'Flutter Demo',
      home: Screen1(),
    );
  }
}

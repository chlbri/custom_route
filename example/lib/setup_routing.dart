import 'package:example/screens/statefull/screen_2.dart';
import 'package:example/screens/statefull/screen_3.dart';

import 'package:simple_router/custom_route.dart';

void setUpRouting() {
  final route2 = CustomRoute(
    routeName: "/screen2",
    builder: (_) => Screen2(),
  )..byMaterial();

  final route3 = CustomRoute(
    routeName: "/screen3",
    builder: (_) => Screen3(),
  )..byMaterial();

  CustomRoute.addAll([route2, route3]);
}

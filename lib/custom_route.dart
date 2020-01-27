import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/error_page.dart';
import 'src/route_type.dart';

class CustomRoute {
  RouteType _routeType;
  RoutePageBuilder _pageBuilder;
  RouteTransitionsBuilder _transitions;
  Duration _duration;
  bool _opaque = true, _barrierDismissible;
  Color _barrierColor;
  String _barrierLabel, title;

  final String routeName;
  final WidgetBuilder builder;
  final RouteSettings settings;
  final bool maintainState, fullscreenDialog;

  // CustomRoute._({
  //   @required this.routeName,
  //   @required this.builder,
  //   this.settings,
  //   this.maintainState = false,
  //   this.fullscreenDialog = false,
  // }) : assert(routeName != "/");

  CustomRoute({
    @required this.routeName,
    @required this.builder,
    this.settings,
    this.maintainState = false,
    this.fullscreenDialog = false,
  }) : assert(routeName != "/");

  void withTransition({
    //Transition bu,
    RoutePageBuilder pageBuilder,
    @required RouteTransitionsBuilder transitions,
    Duration duration = const Duration(seconds: 1),
    bool opaque = true,
    bool barrierDismissible = false,
    Color barrierColor,
    String barrierLabel,
  }) {
    this._routeType = RouteType.CUSTOM;
    this._pageBuilder = pageBuilder;
    this._transitions = transitions;
    this._duration = duration;
    this._opaque = opaque;
    this._barrierDismissible = barrierDismissible;
    this._barrierColor = barrierColor;
    this._barrierLabel = barrierLabel;
  }

  PageRouteBuilder get _withTransition {
    return PageRouteBuilder(
        pageBuilder: this._pageBuilder ??= (cxt, _, __) => this.builder(cxt),
        settings: this.settings,
        transitionDuration: this._duration,
        transitionsBuilder: this._transitions,
        opaque: this._opaque,
        barrierDismissible: this._barrierDismissible,
        barrierColor: this._barrierColor,
        barrierLabel: this._barrierLabel,
        maintainState: this.maintainState,
        fullscreenDialog: this.fullscreenDialog);
  }

  void byMaterial() {
    _routeType = RouteType.MATERIAL;
  }

  MaterialPageRoute get _byMaterial {
    return MaterialPageRoute(
        builder: this.builder,
        settings: this.settings,
        maintainState: this.maintainState,
        fullscreenDialog: this.fullscreenDialog);
  }

  void byCupertino(String title) {
    this.title = title;
    _routeType = RouteType.CUPERTINO;
  }

  CupertinoPageRoute get _byCupertino {
    return CupertinoPageRoute(
        builder: this.builder,
        settings: this.settings,
        title: this.title,
        maintainState: this.maintainState,
        fullscreenDialog: this.fullscreenDialog);
  }

  static Route onGenerateRoute(RouteSettings settings) {
    Route route;
    _routes.forEach((value) {
      if (value.routeName == settings.name) {
        switch (value._routeType) {
          case RouteType.MATERIAL:
            route = value._byMaterial;
            break;
          case RouteType.CUPERTINO:
            route = value._byCupertino;
            break;
          case RouteType.CUSTOM:
            route = value._withTransition;
            break;
        }
      }
    });
    if (route == null) {
      route = PageRouteBuilder(
          pageBuilder: (_, __, ___) => ErrorPage(
                name: settings.name,
              ));
    }
    return route;
  }

  static final _routes = Set<CustomRoute>();

  static bool add(CustomRoute value) => _routes.add(value);

  static void addAll(Iterable<CustomRoute> elements) =>
      _routes.addAll(elements);

  static const initialRoute = '/';

  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'CustomRoute');

  static NavigatorState get navigator => navigatorKey.currentState;

  static BuildContext get context => navigatorKey.currentContext;
}

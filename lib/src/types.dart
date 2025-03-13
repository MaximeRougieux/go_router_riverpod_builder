import 'package:flutter/widgets.dart';

typedef ErrorBuilder = Widget Function(BuildContext, Object, StackTrace);

typedef RouterBuilder = Widget Function(
  RouteInformationParser<Object> routeInformationParser,
  RouterDelegate<Object> routerDelegate,
  RouteInformationProvider? routeInformationProvider,
);

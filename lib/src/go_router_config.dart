import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class GoRouterConfig {
  const GoRouterConfig({
    this.extraCodec,
    this.onException,
    this.errorPageBuilder,
    this.errorBuilder,
    this.refreshListenable,
    this.routerNeglect = false,
    this.initialLocation,
    this.overridePlatformDefaultLocation = false,
    this.initialExtra,
    this.observers,
    this.debugLogDiagnostics = false,
    this.navigatorKey,
    this.restorationScopeId,
    this.requestFocus = true,
  });

  final Codec<Object?, Object?>? extraCodec;
  final void Function(BuildContext, GoRouterState, GoRouter)? onException;
  final Page Function(BuildContext, GoRouterState)? errorPageBuilder;
  final Widget Function(BuildContext, GoRouterState)? errorBuilder;
  final Listenable? refreshListenable;
  final bool routerNeglect;
  final String? initialLocation;
  final bool overridePlatformDefaultLocation;
  // Mimics GoRouter's initialExtra typing
  // ignore: no-object-declaration
  final Object? initialExtra;
  final List<NavigatorObserver>? observers;
  final bool debugLogDiagnostics;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? restorationScopeId;
  final bool requestFocus;
}

import 'package:flutter/widgets.dart';
import 'package:go_router_riverpod_builder/src/fallbacks/fallback_error_router_delegate.dart';
import 'package:go_router_riverpod_builder/src/fallbacks/fallback_route_information_parser.dart';
import 'package:go_router_riverpod_builder/src/types.dart';

class ErrorRouterBuilder extends StatefulWidget {
  const ErrorRouterBuilder({
    super.key,
    required this.routerBuilder,
    this.errorBuilder,
    required this.error,
    required this.stackTrace,
  });

  final RouterBuilder routerBuilder;
  final ErrorBuilder? errorBuilder;
  // Errors are unknown objects in Dart
  // ignore: no-object-declaration
  final Object error;
  final StackTrace stackTrace;

  @override
  State<ErrorRouterBuilder> createState() => _ErrorRouterBuilderState();
}

class _ErrorRouterBuilderState extends State<ErrorRouterBuilder> {
  late final FallbackErrorRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _routerDelegate = FallbackErrorRouterDelegate(
      errorBuilder: widget.errorBuilder,
      error: widget.error,
      stackTrace: widget.stackTrace,
    );
  }

  @override
  void dispose() {
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.routerBuilder(
      FallbackRouteInformationParser(),
      _routerDelegate,
      null,
    );
  }
}

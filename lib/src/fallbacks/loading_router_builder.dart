import 'package:flutter/widgets.dart';
import 'package:go_router_riverpod_builder/src/fallbacks/fallback_loading_router_delegate.dart';
import 'package:go_router_riverpod_builder/src/fallbacks/fallback_route_information_parser.dart';
import 'package:go_router_riverpod_builder/src/types.dart';

class LoadingRouterBuilder extends StatefulWidget {
  const LoadingRouterBuilder({
    super.key,
    required this.routerBuilder,
    this.loadingBuilder,
  });

  final RouterBuilder routerBuilder;
  final WidgetBuilder? loadingBuilder;

  @override
  State<LoadingRouterBuilder> createState() => _LoadingRouterBuilderState();
}

class _LoadingRouterBuilderState extends State<LoadingRouterBuilder> {
  late final FallbackLoadingRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();

    _routerDelegate = FallbackLoadingRouterDelegate(
      loadingBuilder: widget.loadingBuilder,
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

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_riverpod_builder/src/fallbacks/error_router_builder.dart';
import 'package:go_router_riverpod_builder/src/fallbacks/loading_router_builder.dart';
import 'package:go_router_riverpod_builder/src/go_router_config.dart';
import 'package:go_router_riverpod_builder/src/providers/routing_config_value_notifier_provider.dart';
import 'package:go_router_riverpod_builder/src/types.dart';

class GoRouterRiverpodBuilder extends ConsumerStatefulWidget {
  const GoRouterRiverpodBuilder({
    super.key,
    required this.routerBuilder,
    required this.routingConfigProvider,
    required this.goRouterConfig,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final FutureProvider<RoutingConfig> routingConfigProvider;

  final RouterBuilder routerBuilder;

  final GoRouterConfig goRouterConfig;
  final WidgetBuilder? loadingBuilder;
  final ErrorBuilder? errorBuilder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoRouterRiverpodBuilderState();
}

class _GoRouterRiverpodBuilderState
    extends ConsumerState<GoRouterRiverpodBuilder> {
  GoRouter? _goRouter;

  late final ProviderSubscription _subscription;

  // Errors are unknown objects in Dart
  // ignore: no-object-declaration
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();

    _subscription = ref.listenManual<AsyncValue<ValueNotifier<RoutingConfig>>>(
      fireImmediately: true,
      routingConfigValueNotifierProvider(widget.routingConfigProvider),
      (_, next) {
        if (_goRouter != null) return;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          next.whenOrNull(
            skipLoadingOnReload: true,
            data: (data) {
              if (!mounted) return;

              setState(() {
                _error = null;
                _stackTrace = null;

                _goRouter = GoRouter.routingConfig(
                  routingConfig: data,
                  initialLocation: widget.goRouterConfig.initialLocation,
                  observers: widget.goRouterConfig.observers,
                  onException: widget.goRouterConfig.onException,
                  debugLogDiagnostics:
                      widget.goRouterConfig.debugLogDiagnostics,
                  errorBuilder: widget.goRouterConfig.errorBuilder,
                  errorPageBuilder: widget.goRouterConfig.errorPageBuilder,
                  extraCodec: widget.goRouterConfig.extraCodec,
                  navigatorKey: widget.goRouterConfig.navigatorKey,
                  overridePlatformDefaultLocation:
                      widget.goRouterConfig.overridePlatformDefaultLocation,
                  refreshListenable: widget.goRouterConfig.refreshListenable,
                  requestFocus: widget.goRouterConfig.requestFocus,
                  restorationScopeId: widget.goRouterConfig.restorationScopeId,
                  routerNeglect: widget.goRouterConfig.routerNeglect,
                  initialExtra: widget.goRouterConfig.initialExtra,
                );
              });
            },
            error: (error, stackTrace) {
              if (!mounted) return;

              setState(() {
                _error = error;
                _stackTrace = stackTrace;
              });
            },
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _subscription.close();
    _goRouter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = _goRouter;

    if (goRouter != null)
      return widget.routerBuilder(
        goRouter.routeInformationParser,
        goRouter.routerDelegate,
        goRouter.routeInformationProvider,
      );

    final error = _error;
    final stackTrace = _stackTrace;

    if (error != null && stackTrace != null) {
      return ErrorRouterBuilder(
        routerBuilder: widget.routerBuilder,
        errorBuilder: widget.errorBuilder,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return LoadingRouterBuilder(
      routerBuilder: widget.routerBuilder,
      loadingBuilder: widget.loadingBuilder,
    );
  }
}

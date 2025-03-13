import 'package:flutter/material.dart';

import '../go_router_riverpod_builder.dart';

/// Dummy implementation of the [RouterDelegate] that will not handle the
/// current url and will display a [FullScreenLoader].
///
/// {@template loading_or_error_router_delegate}
/// This is used to show a loader, while keeping the current url for further
/// deeplink handling. Not using this will result in the url being "consumed"
/// and the deeplink, lost.
///
/// This is enough to make initial deeplinks work because the [GoRouterRiverpodBuilder]
/// waits for its various dependencies before returning its routing
/// config, so we're sure the deeplink is handled by the expected routing
/// config.
/// {@endtemplate}
class FallbackLoadingRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier {
  FallbackLoadingRouterDelegate({this.loadingBuilder});

  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    final loadingBuilder = this.loadingBuilder;

    return Scaffold(
      body: loadingBuilder != null
          ? loadingBuilder(context)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  // No need to implement this, as we're not handling any routes
  // ignore: no-empty-block
  Future<void> setNewRoutePath(void configuration) async {}

  @override
  Future<bool> popRoute() async {
    return false;
  }
}

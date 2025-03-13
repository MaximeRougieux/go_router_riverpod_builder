import 'package:flutter/material.dart';
import 'package:go_router_riverpod_builder/src/types.dart';

/// Fallback implementation of the [RouterDelegate] that will not handle the
/// current url and will display a widget build with [errorBuilder] when
/// provided.
///
/// If [errorBuilder] is not provided, the router will display the error and
/// stacktrace as a centered [Text].
class FallbackErrorRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier {
  FallbackErrorRouterDelegate({
    this.errorBuilder,
    required this.error,
    required this.stackTrace,
  });

  final ErrorBuilder? errorBuilder;
  // Error can be any objects
  // ignore: no-object-declaration
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    final errorBuilder = this.errorBuilder;

    return Scaffold(
      body: errorBuilder != null
          ? errorBuilder(context, error, stackTrace)
          : Center(child: Text('$error \n $stackTrace')),
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

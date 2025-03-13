import 'package:flutter/widgets.dart';

/// Fallback implementation of the [RouteInformationParser].
///
/// {@macro loading_or_error_router_delegate}
class FallbackRouteInformationParser extends RouteInformationParser<Object> {
  const FallbackRouteInformationParser();

  @override
  Future<Object> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return const Object();
  }
}

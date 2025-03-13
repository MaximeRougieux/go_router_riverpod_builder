import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routingConfigValueNotifierProvider = FutureProvider.autoDispose
    .family<ValueNotifier<RoutingConfig>, FutureProvider<RoutingConfig>>(
  (ref, routingConfigProvider) async {
    final routingConfig = await ref.read(routingConfigProvider.future);

    final routingConfigNotifier = ValueNotifier(routingConfig);

    ref.listen(
      routingConfigProvider,
      (_, next) {
        next.mapOrNull(
          data: (data) => routingConfigNotifier.value = data.value,
        );
      },
    );

    return routingConfigNotifier;
  },
);

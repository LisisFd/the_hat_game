import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';

import 'default_container.dart';

class DefaultTextContainer extends StatelessWidget {
  final Text child;

  const DefaultTextContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = MyAppTheme.of(context);
    Text newChild = Text(child.data ?? '',
        textAlign: TextAlign.center,
        style: theme.material.textTheme.bodyLarge?.merge(child.style));

    return DefaultContainer(
      padding: theme.custom.defaultAppPadding,
      margin: theme.custom.defaultAppMargin,
      child: newChild,
    );
  }
}

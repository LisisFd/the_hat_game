import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';

class MenuButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  const MenuButton({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var theme = MyAppTheme.of(context);
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(theme.material.textTheme.headlineLarge),
        ),
        child: child);
  }
}

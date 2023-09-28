import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';

class MenuButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  const MenuButton({super.key, required this.child, this.onPressed});

  ///TODO: add to theme button style
  @override
  Widget build(BuildContext context) {
    var theme = MyAppTheme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                MyAppTheme.getColorScheme().onSurface),
            elevation: MaterialStateProperty.all(2),
            minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
            textStyle: MaterialStateProperty.all(
                theme.material.textTheme.headlineLarge),
          ),
          child: child),
    );
  }
}

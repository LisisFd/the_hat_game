import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';

class ElevatedMenuButton extends StatelessWidget {
  final bool lightStyle;
  final Widget child;
  final void Function()? onPressed;

  const ElevatedMenuButton(
      {super.key, required this.child, this.onPressed, this.lightStyle = true});

  ///TODO: add to theme button style
  @override
  Widget build(BuildContext context) {
    var newChild = child;
    if (child is Text) {
      var textChild = child as Text;
      newChild = Text(
        textChild.data ?? '',
        style: textChild.style == null
            ? TextStyle(
                color: lightStyle
                    ? ThemeConstants.onLightBackground
                    : ThemeConstants.lightBackground)
            : textChild.style?.merge(
                TextStyle(
                    color: lightStyle
                        ? ThemeConstants.onLightBackground
                        : ThemeConstants.lightBackground),
              ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(lightStyle
                ? ThemeConstants.lightBackground
                : ColorPallet.colorBlue),
          ),
          child: newChild),
    );
  }
}

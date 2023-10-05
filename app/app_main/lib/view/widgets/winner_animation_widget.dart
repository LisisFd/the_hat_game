import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:lottie/lottie.dart';

class WinnerAnimationWidget extends StatefulWidget {
  final double? size;
  final bool complete;
  final void Function()? onStop;

  const WinnerAnimationWidget(
      {super.key, this.size, this.complete = false, this.onStop});

  @override
  State<WinnerAnimationWidget> createState() => _WinnerAnimationWidgetState();
}

class _WinnerAnimationWidgetState extends State<WinnerAnimationWidget>
    with TickerProviderStateMixin {
  LottieBuilder? _winner;
  AnimationController? _winnerController;

  @override
  void initState() {
    _winnerController = AnimationController(vsync: this);

    _winner = Lottie.asset(AppConfig.animationWinner,
        controller: _winnerController, onLoaded: (composition) {
      _winnerController?.duration = composition.duration;
      _winnerController?.repeat();
    });

    super.initState();
  }

  @override
  void dispose() {
    _winnerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: widget.size, child: _winner);
  }
}

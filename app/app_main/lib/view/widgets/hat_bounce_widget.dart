import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:lottie/lottie.dart';

class HatBounceWidget extends StatefulWidget {
  final double? size;
  final bool skipAnimation;
  final bool complete;
  final void Function()? onStop;

  const HatBounceWidget(
      {super.key,
      this.size,
      this.complete = false,
      this.onStop,
      this.skipAnimation = false});

  @override
  State<HatBounceWidget> createState() => _HatBounceWidgetState();
}

class _HatBounceWidgetState extends State<HatBounceWidget>
    with TickerProviderStateMixin {
  LottieBuilder? _hatBounce;
  AnimationController? _hatController;

  @override
  void initState() {
    _hatController = AnimationController(vsync: this);

    _hatBounce = Lottie.asset(AppConfig.animationHatBounce,
        controller: _hatController, onLoaded: (composition) {
      _hatController?.duration = composition.duration;
      if (!widget.skipAnimation) {
        _hatController?.forward();
        _hatController?.addStatusListener(_listener);
      }
    });

    super.initState();
  }

  void _listener(AnimationStatus status) {
    if (AnimationStatus.completed == status) {
      if (!widget.complete) {
        _hatController?.reset();
        _hatController?.forward();
      } else {
        widget.onStop?.call();
      }
    }
  }

  @override
  void dispose() {
    _hatController?.removeStatusListener(_listener);
    _hatController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: widget.size, child: _hatBounce);
  }
}

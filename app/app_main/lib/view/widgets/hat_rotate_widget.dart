import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';

class HatRotateWidget extends StatefulWidget {
  final void Function()? onComplete;
  final AnimationController? controller;
  final double? size;
  final bool skipAnimation;

  const HatRotateWidget(
      {super.key,
      this.size,
      this.onComplete,
      required this.skipAnimation,
      this.controller});

  @override
  State<HatRotateWidget> createState() => _HatRotateWidgetState();
}

class _HatRotateWidgetState extends State<HatRotateWidget>
    with TickerProviderStateMixin {
  AnimationController? scaleFirstController;
  AnimationController? scaleSecondController;
  double firstScale = 1;
  double secondScale = 0;
  bool _isEndFirst = false;

  @override
  void initState() {
    if (widget.skipAnimation) {
      _initWithoutAnimation();
    } else {
      _initWithAnimation();
    }

    super.initState();
  }

  void _initWithAnimation() {
    scaleSecondController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        upperBound: 1.5)
      ..value = 0;
    scaleFirstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..value = 1
      ..animateTo(0)
      ..addListener(() {
        setState(() {
          firstScale = scaleFirstController?.value ?? firstScale;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isEndFirst = true;
            scaleSecondController?.forward();
            scaleSecondController?.addListener(() {
              setState(() {
                secondScale = scaleSecondController?.value ?? secondScale;
              });
            });
            scaleSecondController?.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                widget.onComplete?.call();
              }
            });
          });
        }
      });
  }

  void _initWithoutAnimation() {
    _isEndFirst = true;
    secondScale = 1.5;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    scaleFirstController?.dispose();
    scaleSecondController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget firstHat = Transform.scale(
      scale: firstScale,
      child: SizedBox(
        width: widget.size,
        child: const Image(
          image: AppConfig.fillHatIcon,
        ),
      ),
    );
    Widget secondHat = Transform.scale(
      scale: secondScale,
      child: SizedBox(
        width: widget.size,
        child: const Image(
          image: AppConfig.bottomHat,
        ),
      ),
    );
    return !_isEndFirst ? firstHat : secondHat;
  }
}

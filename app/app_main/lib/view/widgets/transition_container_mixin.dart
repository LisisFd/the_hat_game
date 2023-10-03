import 'package:core_flutter/core_flutter.dart';

mixin TransitionContainerMixin {
  AnimationController? previewScaleController;
  Animation<double>? previewScaleAnimation;

  AnimationController? alignmentController;
  Animation<Alignment>? alignmentAnimation;

  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  void initControllers(TickerProvider vsync) {
    previewScaleController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    )..forward();
    previewScaleAnimation = CurvedAnimation(
      parent: previewScaleController ??
          AnimationController(
            vsync: vsync,
            duration: const Duration(milliseconds: 400),
          ),
      curve: Curves.fastOutSlowIn,
    );
    alignmentController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );
    scaleController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );
  }

  void resetControllers() {
    previewScaleController?.reset();
    previewScaleController?.forward();
    alignmentController?.reset();
  }

  void disposeControllers() {
    scaleController?.dispose();
    alignmentController?.dispose();
    previewScaleController?.dispose();
  }
}

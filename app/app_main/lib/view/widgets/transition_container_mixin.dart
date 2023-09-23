import 'package:core_flutter/core_flutter.dart';

mixin TransitionContainerMixin {
  late final AnimationController previewScaleController;
  late final Animation<double> previewScaleAnimation;

  late final AnimationController alignmentController;
  late Animation<Alignment> alignmentAnimation;

  late final AnimationController scaleController;
  late Animation<double> scaleAnimation;

  void initControllers(TickerProvider vsync) {
    previewScaleController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    )..forward();
    previewScaleAnimation = CurvedAnimation(
      parent: previewScaleController,
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
    previewScaleController.reset();
    previewScaleController.forward();
    alignmentController.reset();
  }

  void disposeControllers() {
    scaleController.dispose();
    alignmentController.dispose();
    previewScaleController.dispose();
  }
}

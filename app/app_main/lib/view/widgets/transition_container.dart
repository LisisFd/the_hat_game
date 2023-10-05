import 'package:core_flutter/core_flutter.dart';

import 'transition_container_mixin.dart';

const double _defaultScale = 1.0;

class TransitionContainer extends StatefulWidget {
  final Color color;
  final Widget child;
  final void Function(bool isRight)? onSkip;

  const TransitionContainer(
      {super.key, required this.color, required this.child, this.onSkip});

  @override
  State<TransitionContainer> createState() => TransitionContainerState();
}

class TransitionContainerState extends State<TransitionContainer>
    with TickerProviderStateMixin, TransitionContainerMixin {
  final GlobalKey _widgetKey = GlobalKey();
  void Function(AnimationStatus status)? _listener;
  bool _isSetUp = false;
  Alignment _dragAlignment = Alignment.center;
  Size? currentSize;
  Size? absoluteSize;

  double _position = 0;
  double _multi = _defaultScale;
  double _firstBreakPoint = 0.0;
  double _secondBreakPoint = 0.0;

  @override
  void initState() {
    initControllers(this);
    _addControllerListeners();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TransitionContainer oldWidget) {
    Key? oldChildKey = oldWidget.child.key;
    Key? newChildKey = widget.child.key;
    if (oldChildKey != newChildKey) {
      setState(() {
        resetControllers();
        _isSetUp = false;
        _dragAlignment = Alignment.center;
        _multi = _defaultScale;
        _position = 0;
        var listener = _listener;
        if (listener != null) {
          alignmentController?.removeStatusListener(listener);
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setUp() {
    if (!_isSetUp) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _createBreakPoints();
          _createAbsoluteSize();
          _updatePosition();
          _isSetUp = true;
        });
      });
    }
  }

  void _addControllerListeners() {
    alignmentController?.addListener(() {
      setState(() {
        _dragAlignment = alignmentAnimation?.value ?? Alignment.center;
      });
    });
    scaleController?.addListener(() {
      setState(() {
        _multi = scaleAnimation?.value ?? 1;
      });
    });
  }

  void _createBreakPoints() {
    final Size size = MediaQuery.of(context).size;
    double percent = size.width / 4;
    _firstBreakPoint = percent;
    _secondBreakPoint = size.width - percent;
  }

  void _createAbsoluteSize() {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    absoluteSize = renderBox.size;
    currentSize = renderBox.size;
  }

  void _updatePosition() {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    _position = renderBox
        .localToGlobal(
            Offset((currentSize?.width ?? 0) / 2, currentSize?.height ?? 0))
        .dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final sizeScreen = MediaQuery.of(context).size;
    double center = sizeScreen.width / 2;
    setState(() {
      _dragAlignment +=
          Alignment(details.delta.dx / (sizeScreen.width / 2) / _multi, 0);
      _updatePosition();
      if (_position > center) {
        _multi = 1 - _dragAlignment.x;
      } else if (_position < center) {
        _multi = 1 + _dragAlignment.x;
      }
      if (_multi < 0.5) {
        _multi = 0.5;
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_position < _firstBreakPoint || _position > _secondBreakPoint) {
      _startAnimation(true);
    } else {
      _startAnimation();
    }
  }

  void _startAnimation([bool withBreakPoints = false]) {
    double width = MediaQuery.of(context).size.width;
    _dragAlignment.x > 0;
    Alignment end;
    if (_dragAlignment.x > 0) {
      end = Alignment(_position / (width / 2), _dragAlignment.y);
    } else {
      end = Alignment(-(width / 2) / _position, _dragAlignment.y);
    }

    alignmentAnimation = alignmentController?.drive(AlignmentTween(
      begin: _dragAlignment,
      end: withBreakPoints ? end : Alignment.center,
    ));
    if (!withBreakPoints) {
      scaleAnimation = scaleController?.drive(Tween<double>(
        begin: _multi,
        end: _defaultScale,
      ));
      scaleController?.reset();
      scaleController?.forward();
    }
    listener(status) {
      _animationIsEnd(status, withBreakPoints, _dragAlignment.x > 0);
    }

    _listener = listener;
    alignmentController?.addStatusListener(listener);

    alignmentController?.reset();
    alignmentController?.forward();
  }

  void _animationIsEnd(
      AnimationStatus status, bool withBreakPoints, bool isPositive) {
    if (status == AnimationStatus.completed && withBreakPoints) {
      widget.onSkip?.call(isPositive);
    }
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    _setUp();
    return GestureDetector(
      onPanDown: (details) {
        alignmentController?.stop();
      },
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Align(
        alignment: _dragAlignment,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: screenSize.width / 2,
            maxHeight: screenSize.height / 4,
          ),
          height: absoluteSize?.height,
          child: Transform.scale(
            key: _widgetKey,
            scale: _multi,
            child: ScaleTransition(
              scale: previewScaleAnimation ??
                  CurvedAnimation(
                    parent: previewScaleController ??
                        AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 400),
                        ),
                    curve: Curves.fastOutSlowIn,
                  ),
              child: AnimatedOpacity(
                opacity: _isSetUp ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    color: widget.color,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

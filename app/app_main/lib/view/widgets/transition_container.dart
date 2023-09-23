import 'package:core_flutter/core_flutter.dart';

class TransitionContainer extends StatefulWidget {
  const TransitionContainer({super.key});

  @override
  State<TransitionContainer> createState() => TransitionContainerState();
}

class TransitionContainerState extends State<TransitionContainer>
    with TickerProviderStateMixin {
  late final AnimationController _alignmentController;
  late Animation<Alignment> _alignmentAnimation;
  late final AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _visible = false;

  Alignment _dragAlignment = const Alignment(0, 0);
  double _position = 0;
  final _v = 100.0;
  double height = 100;
  double width = 100;
  GlobalKey key = GlobalKey();
  double _firstBreakPoint = 0.0;
  double _secondBreakPoint = 0.0;

  @override
  void initState() {
    _alignmentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        setState(() {
          _dragAlignment = _alignmentAnimation.value;
        });
      });
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        setState(() {
          width = _scaleAnimation.value;
        });
      });
    super.initState();
  }

  void _createBreakPoints() {
    final Size size = MediaQuery.of(context).size;
    double percent = size.width / 4;
    _firstBreakPoint = percent;
    _secondBreakPoint = size.width - percent;
  }

  void _updatePosition() {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox;
    _position = renderBox.localToGlobal(Offset(width / 2, 0)).dx;
  }

  void start() {
    _alignmentController.forward();
  }

  @override
  void dispose() {
    _alignmentController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final size = MediaQuery.of(context).size;
    double center = size.width / 2;
    setState(() {
      _dragAlignment += Alignment(details.delta.dx / (size.width / 2), 0);
      _updatePosition();
      double multi = 1.0;
      if (_position > center) {
        multi = 1 - _dragAlignment.x;
      } else if (_position < center) {
        multi = 1 + _dragAlignment.x;
      }
      if (multi < 0.3) {
        multi = 0.3;
      }
      width = _v * multi;
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
    final size = MediaQuery.of(context).size;
    double center = size.width / 2;
    Alignment end;
    if (_position > center) {
      end = Alignment(_dragAlignment.x + 1, _dragAlignment.y);
    } else {
      end = Alignment(_dragAlignment.x - 1, _dragAlignment.y);
    }
    _alignmentAnimation = _alignmentController.drive(AlignmentTween(
      begin: _dragAlignment,
      end: withBreakPoints ? end : Alignment.center,
    ));
    if (!withBreakPoints) {
      _scaleAnimation = _alignmentController.drive(Tween<double>(
        begin: width,
        end: _v,
      ));
      _scaleController.reset();
      _scaleController.forward();
    }

    _alignmentController.reset();
    _alignmentController.forward();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _createBreakPoints();
      setState(() {
        _visible = true;
      });
    });

    return GestureDetector(
      onPanDown: (details) {
        _alignmentController.stop();
      },
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Align(
        alignment: _dragAlignment,
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 800),
          child: Container(
            key: key,
            color: Colors.redAccent,
            width: width,
            height: width,
          ),
        ),
      ),
    );
  }
}

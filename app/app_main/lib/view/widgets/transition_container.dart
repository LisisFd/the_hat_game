import 'package:core_flutter/core_flutter.dart';

class TransitionContainer extends StatefulWidget {
  const TransitionContainer({super.key});

  @override
  State<TransitionContainer> createState() => TransitionContainerState();
}

class TransitionContainerState extends State<TransitionContainer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;
  Alignment _dragAlignment = const Alignment(0, 0);
  double _position = 0;
  final _v = 100;
  double height = 100;
  double width = 100;
  GlobalKey key = GlobalKey();
  double _firstBreakPoint = 0.0;
  double _secondBreakPoint = 0.0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        setState(() {
          _dragAlignment = _alignmentAnimation.value;
        });
      });

    super.initState();
  }

  void _createBreakPoints() {
    final Size size = MediaQuery.of(context).size;
    double percent = size.width / 3;
    _firstBreakPoint = percent;
    _secondBreakPoint = size.width - percent;
  }

  void _updatePosition() {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox;
    _position = renderBox.localToGlobal(Offset(width / 2, 0)).dx;
  }

  void start() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAlignmentAnimation([bool withBreakPoints = false]) {
    final size = MediaQuery.of(context).size;
    double center = size.width / 2;
    Alignment end;
    if (_position > center) {
      end = Alignment(_dragAlignment.x + 1, _dragAlignment.y);
    } else {
      end = Alignment(0.0 - 0.1, _dragAlignment.y);
    }
    _alignmentAnimation = _controller.drive(AlignmentTween(
      begin: _dragAlignment,
      end: withBreakPoints ? end : Alignment.center,
    ));
    _controller.repeat();
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _createBreakPoints();
    });

    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: _onPanUpdate,
      onPanEnd: (details) {
        if (_position < _firstBreakPoint || _position > _secondBreakPoint) {
          _startAlignmentAnimation(true);
        } else {
          _startAlignmentAnimation();
        }
      },
      child: Align(
        alignment: _dragAlignment,
        child: Container(
          key: key,
          color: Colors.redAccent,
          width: width,
          height: width,
        ),
      ),
    );
  }
}

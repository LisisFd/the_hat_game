import 'package:app_core/app_core.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:lottie/lottie.dart';

class HelperGameWidget extends StatefulWidget {
  final void Function()? onClose;

  const HelperGameWidget({super.key, this.onClose});

  @override
  State<HelperGameWidget> createState() => _HelperGameWidgetState();
}

class _HelperGameWidgetState extends State<HelperGameWidget>
    with TickerProviderStateMixin {
  LottieBuilder? _swipeRight;
  LottieBuilder? _swipeLeft;
  AnimationController? _rightController;
  AnimationController? _leftController;
  bool _isSwipeRight = true;
  bool _isLoadedLeft = false;

  @override
  void initState() {
    _leftController = AnimationController(vsync: this);
    _rightController = AnimationController(vsync: this);
    _swipeRight = Lottie.asset(AppConfig.animationSwipeRight,
        controller: _rightController, onLoaded: (composition) {
      _rightController?.duration = composition.duration;
      _rightController?.forward();
    });
    _swipeLeft = Lottie.asset(AppConfig.animationSwipeLeft,
        controller: _leftController, onLoaded: (composition) {
      _leftController?.duration = composition.duration;
      _leftController?.forward();
      setState(() {
        _isLoadedLeft = true;
      });
    });

    _rightController?.addStatusListener(listener);
    _leftController?.addStatusListener(listener);
    super.initState();
  }

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _isSwipeRight = !_isSwipeRight;
      });
      if (_isSwipeRight) {
        _rightController
          ?..reset()
          ..forward();
      } else {
        if (!_isLoadedLeft) return;
        _leftController
          ?..reset()
          ..forward();
      }
    }
  }

  @override
  void dispose() {
    _leftController?.dispose();
    _rightController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyAppTheme.of(context);
    final localization = context.localization();
    return Container(
      padding: theme.custom.defaultAppPadding,
      color: Colors.black.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.clear),
                  color: Colors.white,
                ),
              )),
          Text(
            localization.helper_game_text,
            style: theme.material.textTheme.bodyLarge
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          (_isSwipeRight ? _swipeRight : _swipeLeft) ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
/*Swipe the piece of paper to the right if your team guessed the word and to the left if you decided to skip it*/
/*Смахните бумажку вправо, если ваша команда угадала слово, и влево, если вы решили его пропустить.*/
/*Змахніть папірець праворуч, якщо ваша команда вгадала слово, і вліво, якщо ви вирішили його пропустити.*/

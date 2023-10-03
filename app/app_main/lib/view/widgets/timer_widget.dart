import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/scheduler.dart';

// Duration? position = await player.getCurrentPosition();
// const alarmAudioPath = 'sounds/pip.mp3';
// if (_totalElapsed.inSeconds <= 3 && _totalElapsed.inSeconds >= 0) {
//   if (position == Duration.zero ||
//       position == const Duration(seconds: 1)) {
//     player.play(AssetSource(alarmAudioPath));
//   }
// }
// const asd = 'sounds/raund_end.mp3';

class TimerWidget extends StatefulWidget {
  final Duration? baseDuration;
  final void Function(Duration totalElapsed) onStop;
  final Duration currentDuration;

  const TimerWidget({
    Key? key,
    required this.onStop,
    required this.currentDuration,
    this.baseDuration,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  Duration _baseDuration = const Duration(seconds: 60);
  Duration _elapsed = Duration.zero;
  late Duration _previousElapsed;

  Duration get _totalElapsed => _previousElapsed - _elapsed;

  int get _minutes => _totalElapsed.inMinutes % 60;

  int get _seconds => _totalElapsed.inSeconds % 60;

  String get _viewMinutes =>
      _minutes < 10 ? _convertTime(_minutes) : _minutes.toString();

  String get _viewSecond =>
      _seconds < 10 ? _convertTime(_seconds) : _seconds.toString();

  String _convertTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  bool get isTicking => ticker?.isTicking ?? false;

  Ticker? ticker;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void start() {
    _previousElapsed -= _elapsed;
    ticker?.start();
  }

  void stop([bool isEnd = false]) {
    ticker?.stop();
    widget.onStop(!isEnd ? _totalElapsed : Duration.zero);
  }

  @override
  void initState() {
    _previousElapsed = widget.currentDuration;
    Duration? baseDuration = widget.baseDuration;
    if (baseDuration != null) {
      _baseDuration = baseDuration;
    }
    ticker = createTicker((elapsed) async {
      setState(() {
        _elapsed = elapsed;
        if (_totalElapsed.inSeconds == 0) {
          stop(true);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyAppTheme.of(context);
    String result = '$_viewMinutes:$_viewSecond';
    double size = 70;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned(
            top: size / 4,
            left: size / 4,
            child: CircularProgressIndicator(
                strokeWidth: 32,
                value: (_seconds == 0.0 ? _baseDuration.inSeconds : _seconds) /
                    _baseDuration.inSeconds),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                padding: theme.custom.defaultAppPadding / 4,
                decoration: BoxDecoration(
                    color: ThemeConstants.lightBackground,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(result)),
          ),
        ],
      ),
    );
  }
}

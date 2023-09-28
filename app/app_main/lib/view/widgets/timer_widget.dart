import 'package:audioplayers/audioplayers.dart';
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
  final void Function(Duration totalElapsed) onStop;
  final Duration currentDuration;

  const TimerWidget({
    Key? key,
    required this.onStop,
    required this.currentDuration,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
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

  bool get isTicking => ticker.isTicking;

  late final Ticker ticker;
  AudioPlayer player = AudioPlayer();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didChangeDependencies() {
    ticker = createTicker((elapsed) async {
      setState(() {
        _elapsed = elapsed;
        if (_totalElapsed.inSeconds == 0) {
          stop(true);
        }
      });
    });

    super.didChangeDependencies();
  }

  void start() {
    _previousElapsed -= _elapsed;
    ticker.start();
  }

  void stop([bool isEnd = false]) {
    ticker.stop();
    widget.onStop(!isEnd ? _totalElapsed : Duration.zero);
  }

  @override
  void initState() {
    _previousElapsed = widget.currentDuration;
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String result = '$_viewMinutes:$_viewSecond';
    return Text(result);
  }
}

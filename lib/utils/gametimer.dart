import 'dart:async';

class GameTimer {

  Timer timer;
  
  Duration Function(int units) duration;
  void Function(Duration) onTick;

  GameTimer({ this.duration, this.onTick });

  void start() {
    timer = Timer.periodic(
        duration(1),
        (Timer t) {
          onTick(duration(t.tick));
        }
      );
  }

  void stop() {
    timer.cancel();
  }

}

import 'dart:async';

import 'package:earth/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Start extends RectangleComponent with TapCallbacks, HasGameRef<MyGame> {
  Start() {
    width = 200;
    height = 150;
    x = 100;
    y = 100;
    position = Vector2(900, 400);
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
  }
}

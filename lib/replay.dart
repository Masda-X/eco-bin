import 'package:earth/game.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flutter/widgets.dart';

class Replay extends RectangleComponent
    with TapCallbacks, HasGameReference<MyGame> {
  Replay()
      : super(
          size: Vector2(100, 80),
          position: Vector2(1000, 1000),
          paint: Paint()..color = const Color(0xFFFF0000),
        );
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(100, 80);
    position = Vector2(1000, 1000);
  }

  @override
  void onTapDown(TapDownEvent event) {
    runApp(GameWidget(game: MyGame()));
    // game.removeFromParent(GameOver;);
  }
}

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
          position: Vector2(1000, 500),
          paint: Paint()..color = const Color(0xFFFF0000),
          priority: 5,
        );
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(100, 80);
    position = Vector2(1000, 500);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.resetGame();
    // game.world.removeFromParent();
    // runApp(GameWidget(game: MyGame()));
  }
}

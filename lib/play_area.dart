import 'dart:ui';

import 'package:earth/config.dart';
import 'package:earth/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlayArea extends RectangleComponent with HasGameReference<MyGame> {
  PlayArea()
      : super(
          paint: Paint()..color = Color.fromARGB(255, 9, 138, 7),
          children: [
            RectangleHitbox(
              size: Vector2(gameWidth, gameHeight),
            )
          ],
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(gameWidth, gameHeight);
    position = Vector2(0, 0);
    anchor = Anchor.topLeft;
  }
}

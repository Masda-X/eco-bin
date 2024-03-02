import 'dart:ui';

import 'package:earth/config.dart';
import 'package:earth/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlayArea extends RectangleComponent with HasGameReference<MyGame> {
  PlayArea()
      : super(
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 255, 255, 255),
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

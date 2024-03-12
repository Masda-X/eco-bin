import 'dart:ui';

import 'package:eco_bin/config.dart';
import 'package:eco_bin/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlayArea extends RectangleComponent with HasGameReference<MyGame> {
  PlayArea()
      : super(
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 230, 234, 179),
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
    // add(SpriteComponent(
    //     sprite: await Sprite.load('bg.png'),
    //     size: size,
    //     position: Vector2(0, 0),
    //     priority: 0));
  }
}

import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GameOver extends RectangleComponent {
  @override
  GameOver({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          size: Vector2(4000, 1080),
          position: Vector2(1000, -600),

          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 137, 12, 3),
          children: [
            RectangleHitbox(size: Vector2(4000, 1080)),
          ],
        );
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(4000, 1080);
    add(SpriteComponent(
      sprite: await Sprite.load('bg.png'),
      size: Vector2(4000, 4000),
      position: Vector2(0, 1000),
      priority: 3,
      // anchor: Anchor.topCenter, // BU ONEMLIDI  DO NOT ADD ANCHOR HERE
    ));
    // add(SpriteComponent(
    //   sprite: await Sprite.load('gameover.png'),
    //   size: Vector2(640, 635),
    //   position: Vector2(-10, -2),
    //   // anchor: Anchor.topCenter, // BU ONEMLIDI  DO NOT ADD ANCHOR HERE
    // ));
  }
}

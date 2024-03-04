import 'package:earth/game.dart';
import 'package:flame/components.dart';

import 'package:flutter/material.dart';

class Radi extends CircleComponent with HasGameRef<MyGame> {
  Radi({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 400,
          position: Vector2(960, 1000),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 15, 168, 206),
        );

  @override
  void update(double dt) {
    super.update(dt);
    angle += 0.01 * dt; // Adjust this value to control the speed of rotation
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(SpriteComponent(
      sprite: await Sprite.load('heart_a.png'),
      position: Vector2(-18, -18),
      size: Vector2(100, 100),
    ));
  }
}

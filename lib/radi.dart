import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Radi extends CircleComponent {
  @override
  Radi({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 400,
          position: Vector2(960, 1000),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 54, 244, 108),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(SpriteComponent(
      sprite: await Sprite.load('heart_a.png'),
      size: Vector2(100, 100),
      position: Vector2(-18, -18),
      // anchor: Anchor.topCenter, // BU ONEMLIDI  DO NOT ADD ANCHOR HERE
    ));
  }
}

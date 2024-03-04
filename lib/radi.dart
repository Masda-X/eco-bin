import 'package:earth/game.dart';
import 'package:flame/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Radi extends CircleComponent with HasGameRef<MyGame> {
  Radi({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 400,
          position: Vector2(960, 1000),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 15, 168, 206),
        );
  double angularVelocity = 0.0;
  final double angularAcceleration =
      0.0005; // Reduced for smaller distance on single press
  final double maxAngularVelocity = 0.2;
  final double friction = 0.99;

  // ...

  @override
  void update(double dt) {
    super.update(dt);

    // Apply angular acceleration if left or right arrow key is pressed
    if (gameRef.keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      angularVelocity -= angularAcceleration;
    }
    if (gameRef.keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      angularVelocity += angularAcceleration;
    }

    // Apply friction
    angularVelocity *= friction;

    // Clamp angular velocity to its maximum value
    angularVelocity =
        angularVelocity.clamp(-maxAngularVelocity, maxAngularVelocity);

    // Apply angular velocity to angle
    angle += angularVelocity;
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

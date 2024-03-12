import 'dart:math';
import 'package:eco_bin/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bin extends CircleComponent with HasGameRef<MyGame> {
  Bin({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 300,
          position: Vector2(960, 1000),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(0, 255, 255, 255),
        );
  double angularVelocity = 0.0;
  final double angularAcceleration = 0.0005;
  final double maxAngularVelocity = 0.2;
  final double friction = 0.99;
  final double bounceFactor = 0.5; // Determines the intensity of the bounce

  final double minAngle = -pi / 2; // Left limit (in radians)
  final double maxAngle = pi / 2; // Right limit (in radians)

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
    double newAngle = angle + angularVelocity;

    // If the new angle is outside the limits, reverse and reduce the angular velocity
    if (newAngle < minAngle || newAngle > maxAngle) {
      angularVelocity = -angularVelocity * bounceFactor;
      newAngle = angle + angularVelocity;
    }

    // Clamp the new angle to its limits
    angle = newAngle.clamp(minAngle, maxAngle);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(
      size: Vector2(100, 50),
      position: Vector2(250, -120),
    ));

    add(SpriteComponent(
      sprite: await Sprite.load('bin.png'),
      size: Vector2(150, 110),
      position: Vector2(225, -130),
    ));
  }
}

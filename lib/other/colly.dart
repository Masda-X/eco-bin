import 'dart:math';
import 'package:eco_bin/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Colly extends CircleComponent with HasGameRef<MyGame> {
  Colly({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 400,
          position: Vector2(960, 1000),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(0, 254, 254, 254),
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
  // ignore: unnecessary_overrides
  Future<void> onLoad() async {
    super.onLoad();
    // add(RectangleHitbox(
    //   size: Vector2(140, 100),
    //   position: Vector2(330, -120),
    // ));

    // add(SpriteComponent(
    //   sprite: await Sprite.load('heart_a.png'),
    //   size: Vector2(50, 50),
    //   position: Vector2(325, -130),
    // ));
  }
}

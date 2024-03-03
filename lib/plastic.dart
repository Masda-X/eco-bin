import 'dart:ui';

import 'package:earth/earth.dart';
import 'package:earth/game.dart';
import 'package:earth/play_area.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Plastic extends CircleComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  Plastic({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
            radius: 20,
            // ignore: prefer_const_constructors
            paint: Paint()..color = Color.fromARGB(0, 207, 181, 14),
            anchor: Anchor.center,
            children: [CircleHitbox()]);

  final Vector2 velocity;
  final double difficultyModifier;
  double rotationSpeed = 5;
  bool shouldRotate = false;
  double rotationDuration = 3.0; // Duration of rotation in seconds
  double rotationTimer = 0.0; // Timer for rotation

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (shouldRotate) {
      // Only rotate if shouldRotate is true
      double t = rotationTimer /
          rotationDuration; // Calculate the progress of the rotation
      double currentRotationSpeed =
          rotationSpeed * (1 - t); // Gradually decrease the rotation speed
      angle += currentRotationSpeed * dt;
      rotationTimer += dt;
      if (rotationTimer >= rotationDuration) {
        // Stop rotating after rotationDuration seconds
        shouldRotate = false;
        rotationTimer = 0.0;
      }
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(SpriteComponent(
      sprite: await game.loadSprite("plastic_a.png"),
      anchor: Anchor.center,
      size: Vector2(40, 85),
      position: Vector2(width / 2, height / 2), // BU ONEMLIDI
      priority: 1,
    ));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    shouldRotate = true;
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= other.position.y) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= other.position.x) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >=
          other.position.x + other.size.x) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >=
          other.position.y + other.size.y) {
        velocity.y = -velocity.y;
      }
    } else if (other is Earth) {
      (game).onPlasticHit();
      shouldRotate = true;
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      }
      if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      }
      if (position.x < other.position.x - other.size.x / 2) {
        velocity.x = -velocity.x;
      }
      if (position.x > other.position.x + other.size.x / 2) {
        velocity.x = -velocity.x;
      }
    }
    velocity.setFrom(velocity * difficultyModifier);
  }
}

// add(RemoveEffect(
        //     delay: 0.35,
        //     onComplete: () {
        //       // Modify from here
        //       game.playState = PlayState.gameOver;
        //     }));
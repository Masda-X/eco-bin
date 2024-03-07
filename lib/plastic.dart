import 'dart:ui';

import 'package:earth/colly.dart';
import 'package:earth/earth.dart';
import 'package:earth/game.dart';
import 'package:earth/play_area.dart';
import 'package:earth/radi.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// ignore: unused_import

class Plastic extends RectangleComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  final double speed;

  static const double plasticSize = 50.0;
  Plastic({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
    this.speed = 400,
  }) : super(
            size: Vector2(35, 55),
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
    game.world.add(this);

    // Move towards the Earth
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    shouldRotate = true;
    if (other is PlayArea) {
      shouldRotate = true;
      // final collisionPoint = intersectionPoints.first;

      // // Left Side Collision
      // if (collisionPoint.x == 0) {
      //   velocity.x = -velocity.x;
      //   velocity.y = velocity.y;
      // }
      // // Right Side Collision
      // if (collisionPoint.x == game.size.x) {
      //   velocity.x = -velocity.x;
      //   velocity.y = velocity.y;
      // }
      // // Top Side Collision
      // if (collisionPoint.y == 0) {
      //   velocity.x = velocity.x;
      //   velocity.y = -velocity.y;
      // }
      // // Bottom Side Collision
      // if (collisionPoint.y == game.size.y) {
      //   velocity.x = velocity.x;
      //   velocity.y = -velocity.y;
      // }
    } else if (other is Earth) {
      removeFromParent();
      (game).onPlasticHit();
      // shouldRotate = true;

      // Vector2 collisionNormal = (position - other.position).normalized();

      // velocity.reflect(collisionNormal);

      // while (other.containsPoint(position)) {
      //   position += collisionNormal;
      // }
    } else if (other is Radi) {
      // (game).onPlasticHit();
      // FlameAudio.play('pla_s.wav', volume: 0.05);
      removeFromParent();
    } else if (other is Colly) {}
    velocity.setFrom(velocity * difficultyModifier);
  }
}

// add(RemoveEffect(
        //     delay: 0.35,
        //     onComplete: () {
        //       // Modify from here
        //       game.playState = PlayState.gameOver;
        //     }));
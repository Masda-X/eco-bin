import 'dart:ui';

import 'package:eco_bin/other/colly.dart';
import 'package:eco_bin/earth.dart';
import 'package:eco_bin/game.dart';
import 'package:eco_bin/other/gameover.dart';
import 'package:eco_bin/play_area.dart';
import 'package:eco_bin/bin.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flame_noise/flame_noise.dart';
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
    this.speed = 100,
  }) : super(
            size: Vector2(40, 60),
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
      size: Vector2(50, 95),
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
      other.add(
        SequenceEffect(
          [
            MoveEffect.by(
              Vector2(10, 0),
              NoiseEffectController(
                duration: 1,
                noise: PerlinNoise(frequency: 20),
              ),
            ),
          ],
          infinite: false,
        ),
      );

      // (game).onPlasticHit();
      // shouldRotate = true;
    } else if (other is Bin) {
      gameRef.onBinHit();
      // (game).onPlasticHit();

      removeFromParent();
    } else if (other is Colly) {
    } else if (other is GameOver) {
      // (game).onPlasticHit();
      // FlameAudio.play('pla_s.wav', volume: 0.05);
      removeFromParent();
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
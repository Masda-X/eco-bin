import 'dart:ui';
import 'package:eco_bin/other/colly.dart';
import 'package:eco_bin/earth.dart';
import 'package:eco_bin/game.dart';
import 'package:eco_bin/play_area.dart';
import 'package:eco_bin/bin.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';

class Banana extends RectangleComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  final double speed;

  static const double bananaSize = 50.0;
  Banana({
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
      sprite: await game.loadSprite("banana.png"),
      anchor: Anchor.center,
      size: Vector2(50, 95),
      position: Vector2(width / 2, height / 2), // BU ONEMLIDI
      priority: 1,
    ));
    game.world.add(this);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    shouldRotate = true;
    if (other is PlayArea) {
      shouldRotate = true;
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
    } else if (other is Bin) {
      // (game).onPlasticHit();
      // FlameAudio.play('pla_s.wav', volume: 0.05);
      removeFromParent();
    } else if (other is Colly) {}
    velocity.setFrom(velocity * difficultyModifier);
  }
}

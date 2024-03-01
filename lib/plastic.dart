import 'dart:ui';

import 'package:earth/config.dart';
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
            radius: radius,
            paint: Paint()..color = const Color.fromARGB(255, 218, 31, 31),
            anchor: Anchor.center,
            children: [CircleHitbox()]);
  final Vector2 velocity;
  final double difficultyModifier;
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(SpriteComponent(
      sprite: await game.loadSprite("plastic_a.png"),
      anchor: Anchor.center,
      size: Vector2(gameWidth * 0.02, gameHeight * 0.07),
      position: Vector2(width / 2, height / 2), // BU ONEMLIDI
      priority: 1,
    ));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
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
      } else if (other is Earth) {
        (game).onPlasticHit();
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

        // add(RemoveEffect(
        //     delay: 0.35,
        //     onComplete: () {
        //       // Modify from here
        //       game.playState = PlayState.gameOver;
        //     }));
      }
      velocity.setFrom(velocity * difficultyModifier);
    }
  }
}

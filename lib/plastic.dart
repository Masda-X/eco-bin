import 'dart:ui';

import 'package:earth/config.dart';
import 'package:earth/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Plastic extends CircleComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  Plastic(
      {required this.velocity, required super.position, required double radius})
      : super(
            radius: radius,
            paint: Paint()..color = const Color.fromARGB(255, 218, 31, 31),
            anchor: Anchor.center,
            children: [CircleHitbox()]);
  final Vector2 velocity;
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
}

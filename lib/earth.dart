import 'package:earth/banana.dart';
import 'package:earth/game.dart';
import 'package:earth/health_bar.dart';
import 'package:earth/plastic.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flame/events.dart';

import 'package:flame_noise/flame_noise.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Earth extends CircleComponent
    with
        CollisionCallbacks,
        HoverCallbacks,
        DragCallbacks,
        TapCallbacks,
        DoubleTapCallbacks,
        HasGameRef<MyGame> {
  @override
  Earth({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 310,
          position: Vector2(960, 995),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(0, 244, 67, 54),
        );
  late HealthBar healthBar;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox(
      radius: 310,
    ));
    add(SpriteComponent(
      sprite: await Sprite.load('earth.png'),
      size: Vector2(640, 635),
      position: Vector2(-10, -2),
      // anchor: Anchor.topCenter, // BU ONEMLIDI  DO NOT ADD ANCHOR HERE
    ));
    // add(SpriteComponent(
    //   sprite: await Sprite.load('bar.png'),
    //   size: Vector2(840, 60),
    //   position: Vector2(-116, -670),
    //   // anchor: Anchor.topCenter, // BU ONEMLIDI  DO NOT ADD ANCHOR HERE
    // ));
    healthBar = HealthBar();
    gameRef.add(healthBar);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (kDebugMode) {
      print('Drag ended');
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (kDebugMode) {
      print('Drag started');
    }
  }

  @override
  void onTapUp(event) {}

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {}

  @override
  void onTapCancel(event) {}

  @override
  void onHoverEnter() {
    // angle += 180.0; // add(RotateEffect(angle: 1, duration: 1));
  }
  @override
  bool containsPoint(Vector2 point) {
    return position.distanceTo(point) <= size.x / 2;
  }

  int hitCount = 0;
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Plastic || other is Banana) {
      if (kDebugMode) {
        print('objectHit');
        for (var heart in healthBar.hearts) {
          heart.add(
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
        }
      }
      hitCount++;
      if (hitCount == 5) {
        game.world.removeFromParent();
        // runApp(GameWidget(game: MyGame()));
      }
      // Increment the counter when Earth is hit by Plastic
      else if (hitCount % 1 == 0) {
        // Check if hitCount is a multiple of 10
        healthBar.decreaseHealth();
      }
    }
  }
}

// ignore: unused_import
import 'package:earth/colly.dart';
import 'package:earth/game.dart';
import 'package:earth/radi.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// ignore: unused_import
import 'package:flame/effects.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
// ignore: unnecessary_import
import 'package:flame/palette.dart';

import 'package:flutter/material.dart';

class Test extends CircleComponent
    with
        CollisionCallbacks,
        HoverCallbacks,
        DragCallbacks,
        TapCallbacks,
        DoubleTapCallbacks,
        HasGameRef<MyGame> {
  @override
  Test({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 20,
          position: Vector2(960, 1000),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 222, 105, 33),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox(
      radius: 20,
    ));
    // add(
    //   MoveEffect.by(
    //     Vector2(0, 20),
    //     InfiniteEffectController(SineEffectController(period: 1)),
    //   ),
    // );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;

    const minX = 50; // 10% margin on the left
    const maxX = 1860; // 10% margin on the right
    const minY = 50; // 10% margin on the top
    const maxY = 1020; // 10% margin on the bottom
    position.x = position.x.clamp(minX.toDouble(), maxX.toDouble());
    position.y = position.y.clamp(minY.toDouble(), maxY.toDouble());
  }

  @override
  bool containsPoint(Vector2 point) {
    return position.distanceTo(point) <= size.x / 2;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Radi) {
      final collisionText = TextComponent(
        text: 'Collision!',
      );
      add(collisionText);

      Future.delayed(const Duration(seconds: 1), () {
        remove(collisionText);
      });

      // Change the color of the Test component
      // ignore: prefer_const_constructors
      // paint = Paint()..color = Color.fromARGB(255, 255, 255, 255);

      // // Change the color back to its default after 2 seconds
      // Future.delayed(const Duration(seconds: 1), () {
      //   // ignore: prefer_const_constructors
      //   paint = Paint()..color = Color.fromARGB(0, 244, 127, 54);
      // });
    }
    // if (other is Colly) {
    //   final collisionText = TextComponent(
    //     text: 'Boom!',
    //   );
    //   add(collisionText);

    //   // Remove the text after 1 second
    //   Future.delayed(const Duration(seconds: 1), () {
    //     remove(collisionText);
    //   });
    // }
  }

  bool paused = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (paused) {
      gameRef.resumeEngine();
      paused = false;
    } else {
      gameRef.pauseEngine();
      paused = true;
    }
  }
}

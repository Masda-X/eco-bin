import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Earth extends PositionComponent with DragCallbacks {
  @override
  Earth({required this.cornerRadius})
      : super(
          anchor: Anchor.center,
          size: Vector2.all(100),

          // paint: Paint()..color = Colors.red,
        );
  final Radius cornerRadius;
  // final Paint paint;

  @override
  Future<void> onLoad() async {
    add(CircleHitbox(
      radius: 60,
    ));
    add(SpriteComponent(
      sprite: await Sprite.load('earth.png'),
      size: Vector2(100, 100),
      // BU ONEMLIDI
    ));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;

    // const minX = gameWidth * 10 / 2; // 10% margin on the left
    // const maxX = gameWidth * 10 / 2; // 10% margin on the right
    // const minY = gameHeight * 10 / 2; // 10% margin on the top
    // const maxY = gameHeight * 10 / 2; // 10% margin on the bottom
    // position.x = position.x.clamp(minX, maxX);
    // position.y = position.y.clamp(minY, maxY);
  }
}

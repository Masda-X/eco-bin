import 'dart:ui';
import 'package:flame_noise/flame_noise.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Earth extends PositionComponent
    with
        DragCallbacks,
        TapCallbacks,
        DoubleTapCallbacks,
        HasGameRef<FlameGame> {
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

    add(
      MoveEffect.by(
        Vector2(0, 20),
        InfiniteEffectController(SineEffectController(period: 1)),
      ),
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;

    const minX = -900; // 10% margin on the left
    const maxX = 900; // 10% margin on the right
    const minY = -480; // 10% margin on the top
    const maxY = 480; // 10% margin on the bottom
    position.x = position.x.clamp(minX.toDouble(), maxX.toDouble());
    position.y = position.y.clamp(minY.toDouble(), maxY.toDouble());
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

  // ignore: non_constant_identifier_names
  bool Tapped = true;

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {
    // add(RemoveEffect(delay: 1));

    add(
      SequenceEffect(
        [
          MoveEffect.by(
            Vector2(50, 0),
            NoiseEffectController(
              duration: 1,
              noise: PerlinNoise(frequency: 20),
            ),
          ),
          // MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
          // MoveEffect.by(
          //   Vector2(0, 10),
          //   NoiseEffectController(
          //     duration: 1,
          //     noise: PerlinNoise(frequency: 10),
          //   ),
          // ),
        ],
        infinite: false,
      ),
    );
  }

  // angle += 1.0;

  @override
  void onTapCancel(event) {}
}

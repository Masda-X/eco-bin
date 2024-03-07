import 'package:earth/game.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame/events.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Earth extends CircleComponent
    with
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

  // final Paint paint;
  // final Vector2 position;

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
    game.world.add(this);
    // add(
    //   MoveEffect.by(
    //     Vector2(0, 20),
    //     InfiniteEffectController(SineEffectController(period: 1)),
    //   ),
    // );
  }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   position += event.localDelta;

  //   const minX = 50; // 10% margin on the left
  //   const maxX = 1860; // 10% margin on the right
  //   const minY = 50; // 10% margin on the top
  //   const maxY = 1020; // 10% margin on the bottom
  //   position.x = position.x.clamp(minX.toDouble(), maxX.toDouble());
  //   position.y = position.y.clamp(minY.toDouble(), maxY.toDouble());
  // }

  // FlameAudio.play('crash.wav');

  // void onCollisionStart(
  //     Set<Vector2> intersectionPoints, PositionComponent other) {
  //   if (other is Plastic || other is Banana) {
  //     add(
  //       SequenceEffect(
  //         [
  //           MoveEffect.by(
  //             Vector2(10, 0),
  //             NoiseEffectController(
  //               duration: 1,
  //               noise: PerlinNoise(frequency: 20),
  //             ),
  //           ),
  //           // MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
  //           // MoveEffect.by(
  //           //   Vector2(0, 10),
  //           //   NoiseEffectController(
  //           //     duration: 1,
  //           //     noise: PerlinNoise(frequency: 10),
  //           //   ),
  //           // ),
  //         ],
  //         infinite: false,
  //       ),
  //     );
  //   }
  // }

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
  void onDoubleTapDown(DoubleTapDownEvent event) {
    // add(RemoveEffect(delay: 1));

    // add(
    //   SequenceEffect(
    //     [
    //       MoveEffect.by(
    //         Vector2(50, 0),
    //         NoiseEffectController(
    //           duration: 1,
    //           noise: PerlinNoise(frequency: 20),
    //         ),
    //       ),
    //       MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
    //       MoveEffect.by(
    //         Vector2(0, 10),
    //         NoiseEffectController(
    //           duration: 1,
    //           noise: PerlinNoise(frequency: 10),
    //         ),
    //       ),
    //     ],
    //     infinite: false,
    //   ),
    // );
  }

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
}

import 'dart:math';

import 'package:earth/earth.dart';
import 'package:earth/game.dart';
import 'package:earth/plastic.dart';

import 'package:flame/components.dart';

import 'package:flame/events.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnemyCreator extends CircleComponent
    with
        HoverCallbacks,
        DragCallbacks,
        TapCallbacks,
        DoubleTapCallbacks,
        HasGameRef<MyGame> {
  @override
  EnemyCreator({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 400,
          position: Vector2(960, -200),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(255, 244, 67, 54),
        );

  late final Random _random;
  late final Vector2 gameSize;
  late final Plastic plastic;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _random = Random();
    gameSize = size;
    add(
      SpawnComponent(
        factory: (index) => createRandomPlastic(),
        period: _random.nextInt(3) +
            1.toDouble(), // Random interval between 1 to 3 seconds
        autoStart: true,
      ),
    );
  }

  Plastic createRandomPlastic() {
    // Randomly choose an edge: 0 for left, 1 for top, 2 for right
    int edge = _random.nextInt(3);
    Vector2 position;

    switch (edge) {
      case 0: // Left edge
        position =
            Vector2(-Plastic.plasticSize, _random.nextDouble() * gameSize.y);
        break;
      case 1: // Top edge
        position =
            Vector2(_random.nextDouble() * gameSize.x, -Plastic.plasticSize);
        break;
      case 2: // Right edge
        position = Vector2(gameSize.x + Plastic.plasticSize,
            _random.nextDouble() * gameSize.y);
        break;
      default:
        position = Vector2.zero();
    }

    return Plastic(
      position: position,
      radius: Plastic.plasticSize,
      difficultyModifier: 1,
      velocity: position - gameSize / 2,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;

    // const minX = 50; // 10% margin on the left
    // const maxX = 1860; // 10% margin on the right
    // const minY = 50; // 10% margin on the top
    // const maxY = 1020; // 10% margin on the bottom
    // position.x = position.x.clamp(minX.toDouble(), maxX.toDouble());
    // position.y = position.y.clamp(minY.toDouble(), maxY.toDouble());
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
  void onHoverEnter() {}
  @override
  bool containsPoint(Vector2 point) {
    return position.distanceTo(point) <= size.x / 2;
  }
}

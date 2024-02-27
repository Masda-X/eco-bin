import 'dart:ui';

import 'package:earth/earth.dart';
import 'package:flame/components.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame {
  MyGame({required this.zoom}) : super();

  final double zoom;
  late final Earth player;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.zoom = zoom;

    world.add(SpriteComponent(
      sprite: await loadSprite("bg.png"),
      anchor: Anchor.center,
      size: Vector2(1920, 1080),
      position: Vector2(0, 0), // BG harda olsun ONEMLI
    ));
    world.add(player = Earth(
      cornerRadius: const Radius.circular(60),
      // paint: Paint()..color = Colors.red,
    ));
  }
}

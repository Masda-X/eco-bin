import 'dart:ui';

import 'package:earth/config.dart';
import 'package:earth/earth.dart';
import 'package:flame/components.dart';

import 'package:flame/events.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks, MouseMovementDetector {
  MyGame({required this.zoom})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  final double zoom;
  late final Earth player;

  // ignore: non_constant_identifier_names

  @override
  Future<void> onLoad() async {
    camera.viewfinder.zoom = zoom;

    world.add(SpriteComponent(
      sprite: await loadSprite("bg.png"),
      anchor: Anchor.center,
      size: Vector2(1920, 1080),
      position: Vector2(0, 0), // BG harda olsun ONEMLI
    ));
    world.add(TextComponent(
      text: 'Click to Play',
    ));
  }

  bool isPlayerAdded = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (!isPlayerAdded) {
      world.add(player = Earth(
        cornerRadius: const Radius.circular(100),
        // paint: Paint()..color = Colors.red,
      ));
      isPlayerAdded = true;
      // remove(text = TextComponent(
      //   // remove the text
      //   text: 'Click to Play',
      // ));
    }
  }
}

  // Color backgroundColor() => Color.fromARGB(255, 230, 13, 13);
  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


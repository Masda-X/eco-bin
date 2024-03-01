import 'dart:ui';

import 'dart:math' as math;

import 'package:earth/config.dart';
import 'package:earth/earth.dart';
import 'package:earth/plastic.dart';
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
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

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
      for (int i = 0; i < 40; i++) {
        final randomX =
            rand.nextDouble() * (gameWidth - plasticRadius * 2) + plasticRadius;
        final randomY =
            rand.nextDouble() * (gameHeight * 0.6 - plasticRadius * 2) +
                plasticRadius;

        world.add(Plastic(
          radius: plasticRadius,
          position: Vector2(randomX, randomY),
          velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2)
              .normalized()
            ..scale(height / 4),
        ));
      }
    }
  }
}

  // Color backgroundColor() => Color.fromARGB(255, 230, 13, 13);
  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


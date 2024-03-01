import 'dart:ui';

import 'dart:math' as math;

import 'package:earth/config.dart';
import 'package:earth/earth.dart';
import 'package:earth/plastic.dart';
import 'package:earth/play_area.dart';
import 'package:flame/components.dart';

import 'package:flame/events.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, TapCallbacks, MouseMovementDetector {
  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  late final Earth player;
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // ignore: non_constant_identifier_names
  @override
  // ignore: prefer_const_constructors
  Color backgroundColor() => Color.fromARGB(255, 195, 220, 195);

  @override
  Future<void> onLoad() async {
    world.add(PlayArea());

    world.add(TextComponent(
      text: 'Click to Play',
      position: Vector2(gameWidth / 2, gameHeight / 2),
    ));
    camera.viewfinder.anchor = Anchor.topLeft;
  }

  bool isPlayerAdded = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (!isPlayerAdded) {
      world.add(player = Earth(
        cornerRadius: const Radius.circular(100),
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.red,
      ));
      isPlayerAdded = true;
      for (int i = 0; i < 40; i++) {
        final randomX =
            rand.nextDouble() * (gameWidth - plasticRadius * 2) + plasticRadius;
        final randomY =
            rand.nextDouble() * (gameHeight * 0.6 - plasticRadius * 2) +
                plasticRadius;

        world.add(Plastic(
          difficultyModifier: difficultyModifier,
          radius: plasticRadius,
          position: Vector2(randomX, randomY),
          velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2)
              .normalized()
            ..scale(height / 4),
        ));
      }
    }
  }

  void onPlasticHit() {
    // score.value -= 1;
  }
}


  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


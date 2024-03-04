import 'dart:math' as math;

import 'package:earth/config.dart';
import 'package:earth/earth.dart';
import 'package:earth/plastic.dart';
import 'package:earth/play_area.dart';
import 'package:earth/radi.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flame/events.dart';

import 'package:flame/game.dart';
// ignore: unused_import
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_noise/flame_noise.dart';
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
  late final Radi controller;
  late final Earth player;
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // ignore: non_constant_identifier_names
  @override
  // ignore: prefer_const_constructors
  Color backgroundColor() => Color.fromARGB(255, 229, 234, 179);

  @override
  Future<void> onLoad() async {
    world.add(PlayArea());

    // world.add(TextComponent(
    //   text: 'Click to Play',
    //   position: Vector2(gameWidth / 2, gameHeight / 2),
    // ));
    camera.viewfinder.anchor = Anchor.topLeft;
  }

  bool isPlayerAdded = false;
  bool isControllerAdded = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (!isPlayerAdded && !isControllerAdded) {
      world.add(player = Earth(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.red,
      ));
      world.add(controller = Radi(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.blue,
      ));

      isPlayerAdded = true;
      isControllerAdded = true;
      for (int i = 0; i < 10; i++) {
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
    // FlameAudio.play('crash.wav');
    player.add(
      SequenceEffect(
        [
          MoveEffect.by(
            Vector2(10, 0),
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
    // score.value -= 1;
  }
}


  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


import 'dart:math' as math;

import 'package:earth/colly.dart';
import 'package:earth/config.dart';
import 'package:earth/earth.dart';
import 'package:earth/plastic.dart';
import 'package:earth/play_area.dart';
import 'package:earth/radi.dart';
import 'package:earth/test.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:flame/events.dart';

import 'package:flame/game.dart';
// ignore: unused_import
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyGame extends FlameGame
    with
        HasCollisionDetection,
        TapCallbacks,
        MouseMovementDetector,
        KeyboardEvents {
  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );
  late final Test test;
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
  bool isTestAdded = false;
  bool isCollyAdded = false;
  @override
  void onTapDown(TapDownEvent event) {
    if (!isPlayerAdded && !isControllerAdded && !isCollyAdded) {
      world.add(player = Earth(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.red,
      ));
      world.add(controller = Radi(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.blue,
      ));
      world.add(Colly(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.yellow,
      ));

      List<Vector2> positions = [
        Vector2(gameWidth * 0.25, gameHeight * 0.25),
        Vector2(gameWidth * 0.75, gameHeight * 0.25),
        Vector2(gameWidth * 0.25, gameHeight * 0.75),
        Vector2(gameWidth * 0.75, gameHeight * 0.75),
      ];

      for (int i = 0; i < 4; i++) {
        Test test = Test(
          position: Vector2.zero(),
          paint: Paint()..color = Colors.green,
        );
        test.x = positions[i].x;
        test.y = positions[i].y;
        world.add(test);
      }

      isPlayerAdded = true;
      isControllerAdded = true;
      isCollyAdded = true;

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

  Set<LogicalKeyboardKey> keysPressed = {};
  bool keyJustPressed = false;

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    this.keysPressed = keysPressed;
    if (event is KeyDownEvent) {
      keyJustPressed = true;
    }
    return KeyEventResult.handled;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (keyJustPressed) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        final radi = world.children.query<Radi>().first;
        radi.angularVelocity -= radi.angularAcceleration;

        final colly = world.children.query<Colly>().first;
        colly.angularVelocity -= colly.angularAcceleration;
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        final radi = world.children.query<Radi>().first;
        radi.angularVelocity += radi.angularAcceleration;

        final colly = world.children.query<Colly>().first;
        colly.angularVelocity += colly.angularAcceleration;
      }
      keyJustPressed = false;
    }
  }
}


  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


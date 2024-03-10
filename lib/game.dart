import 'dart:math' as math;

import 'package:earth/config.dart';
import 'package:earth/earth.dart';

import 'package:earth/play_area.dart';
import 'package:earth/bin.dart';
import 'package:earth/start_button.dart';

import 'package:flame/components.dart';

import 'package:flame/events.dart';

import 'package:flame/game.dart';
// ignore: unused_import

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
  // @override
  // // ignore: overridden_fields
  // bool debugMode = true;
  // late final Test test;
  late Bin bin;

  late Earth earth;

  late Start startButton;

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // ignore: non_constant_identifier_names
  @override
  // ignore: prefer_const_constructors
  Color backgroundColor() => Color.fromARGB(255, 230, 234, 179);

  @override
  Future<void> onLoad() async {
    world.add(PlayArea());
    startButton = Start();
    world.add(startButton);
    world.add(earth = Earth(
      position: Vector2(gameWidth / 2, gameHeight / 2),
      paint: Paint()..color = Colors.red,
    ));
    world.add(bin = Bin(
      position: Vector2(gameWidth / 2, gameHeight / 2),
      paint: Paint()..color = Colors.blue,
    ));

    // world.add(TextComponent(
    //   text: 'Click to Play',
    //   position: Vector2(gameWidth / 2, gameHeight / 2),
    // ));
    camera.viewfinder.anchor = Anchor.topLeft;
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
        final radi = world.children.query<Bin>().first;
        radi.angularVelocity -= radi.angularAcceleration;

        // final colly = world.children.query<Colly>().first;
        // colly.angularVelocity -= colly.angularAcceleration;
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        final radi = world.children.query<Bin>().first;
        radi.angularVelocity += radi.angularAcceleration;

        // final colly = world.children.query<Colly>().first;
        // colly.angularVelocity += colly.angularAcceleration;
      }
      keyJustPressed = false;
    }
  }

  void resetGame() {
    world.removeAll(world.children.query<PlayArea>());
    world.removeAll(world.children.query<Earth>());
    world.removeAll(world.children.query<Bin>());
    world.removeAll(world.children.query<Start>());

    // onLoad();
  }
}


  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


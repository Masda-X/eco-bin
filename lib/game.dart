// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;

import 'package:earth/components.dart';
import 'package:earth/config.dart';

import 'package:earth/bar.dart';

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

  late Bar bar;

  late Timer interval;
  int elapsedSecs = 0;
  late TextComponent textComponent;
  late TextComponent scoreTextComponent;
  int score = 0;

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // ignore: non_constant_identifier_names
  @override
  Color backgroundColor() => Color.fromARGB(0, 230, 234, 179);

  @override
  Future<void> onLoad() async {
    super.onLoad();
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
    interval = Timer(
      1,
      onTick: () {
        elapsedSecs += 1;
        textComponent.text = 'Timer: $elapsedSecs';
      },
      repeat: true,
      autoStart: false,
    );
    bar = Bar();
    world.add(bar);
    // world.add(TextComponent(
    //   text: 'Click to Play',
    //   position: Vector2(gameWidth / 2, gameHeight / 2),
    // ));
    camera.viewfinder.anchor = Anchor.topLeft;
    textComponent = TextComponent(
      text: 'Timer: $elapsedSecs',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 45,
          fontFamily: 'Crunch Chips',
        ),
      ),
      position: Vector2(1600, 52),
      anchor: Anchor.topLeft,
      priority: 2,
    );

    world.add(textComponent);
    scoreTextComponent = TextComponent(
      text: 'Points: $score',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 45,
          fontFamily: 'Crunch Chips',
        ),
      ),
      position: Vector2(1600, 133), // Adjust the position as needed
      anchor: Anchor.topLeft,
      priority: 2,
    );

    world.add(scoreTextComponent);
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

    interval.update(dt);

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
    world.removeAll(world.children.query<CreatorLeft>());
    world.removeAll(world.children.query<CreatorRight>());
    world.removeAll(world.children.query<EnemyCreator>());
    world.removeAll(world.children.query<Plastic>());
  }

  void replayGame() {
    resetGame();
    onLoad();
  }

  void onStartClick() {
    interval.start();
  }

  void onHit5() {
    interval.stop();
    bar.position = Vector2(-755, 400);
    textComponent.position = Vector2(840, 452);
    scoreTextComponent.position = Vector2(840, 533);
  }

  void onBinHit() {
    score += 1;
    scoreTextComponent.text = 'Score: $score';
  }
}


  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


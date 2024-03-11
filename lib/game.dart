// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

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
  late TextComponent highScoreTextComponent;
  late TextComponent highElapsedSecsTextComponent;

  int score = 0;
  int highScore = 0;
  int highElapsedSecs = 0;

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  // ignore: non_constant_identifier_names
  @override
  Color backgroundColor() => Color.fromARGB(255, 230, 234, 179);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await loadHighScoreAndTime();
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
      position: Vector2(1600, 58),
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
      position: Vector2(1600, 139), // Adjust the position as needed
      anchor: Anchor.topLeft,
      priority: 2,
    );

    world.add(scoreTextComponent);
    highScoreTextComponent = TextComponent(
      text: 'Highest Points: $highScore',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 45,
          fontFamily: 'Crunch Chips',
        ),
      ),
      position: Vector2(956, 895), // Adjust the position as needed
      anchor: Anchor.center,
      priority: 2,
    );

    highElapsedSecsTextComponent = TextComponent(
      text: 'Highest Time: $highElapsedSecs',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 45,
          fontFamily: 'Crunch Chips',
        ),
      ),
      position: Vector2(965, 840), // Adjust the position as needed
      anchor: Anchor.center,
      priority: 2,
    );
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
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
          world.children.query<Bin>().isNotEmpty) {
        final radi = world.children.query<Bin>().first;
        radi.angularVelocity -= radi.angularAcceleration;

        // final colly = world.children.query<Colly>().first;
        // colly.angularVelocity -= colly.angularAcceleration;
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
          world.children.query<Bin>().isNotEmpty) {
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
    world.removeAll(world.children.query<Bar>());
    world.removeAll(world.children.query<TextComponent>());
    world.removeAll(world.children.query<TextComponent>());

    onLoad();
    score = 0;
    scoreTextComponent.text = 'Points: $score';
    elapsedSecs = 0;
    textComponent.text = 'Timer: $elapsedSecs';
  }

  void onStartClick() {
    interval.start();
  }

  void onHit5() {
    interval.stop();
    bar.position = Vector2(-755, 400);
    textComponent.position = Vector2(840, 458);
    scoreTextComponent.position = Vector2(840, 539);

    // Update high score and elapsed time if current values are higher
    if (score > highScore) {
      highScore = score;
    }
    if (elapsedSecs > highElapsedSecs) {
      highElapsedSecs = elapsedSecs;
    }
    saveHighScoreAndTime();
    highScoreTextComponent.text = 'your Highest Points: $highScore';
    highElapsedSecsTextComponent.text =
        'your Highest survival Time: $highElapsedSecs';
    world.add(highScoreTextComponent);
    world.add(highElapsedSecsTextComponent);
  }

  void onBinHit() {
    score += 1;
    scoreTextComponent.text = 'Points: $score';
    // FlameAudio.play('pla_s.wav');
  }

  Future<void> loadHighScoreAndTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    highScore = prefs.getInt('highPoints') ?? 0;
    highElapsedSecs = prefs.getInt('highElapsedSecs') ?? 0;
  }

  Future<void> saveHighScoreAndTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highPoints', highScore);
    await prefs.setInt('highElapsedSecs', highElapsedSecs);
  }
}


  // Future<Sprite> backgroundSprite() => Sprite.load("bg.png");


import 'dart:async';

import 'package:earth/colly.dart';
import 'package:earth/config.dart';
import 'package:earth/creator_left.dart';
import 'package:earth/creator_right.dart';
import 'package:earth/earth.dart';
import 'package:earth/enemy_creator.dart';
import 'package:earth/game.dart';
import 'package:earth/radi.dart';
import 'package:earth/test.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Start extends RectangleComponent with TapCallbacks, HasGameRef<MyGame> {
  // ignore: prefer_const_constructors
  Start() : super(paint: Paint()..color = Color.fromARGB(255, 33, 149, 243)) {
    width = 640;
    height = 135;
    x = 100;
    y = 100;
    position = Vector2(630, 450);
  }
  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
      sprite: await Sprite.load('play_button.png'),
      size: Vector2(640, 135),
      position: Vector2(0, 0),
    ));
  }

  late final Test test;
  late final Radi controller;
  late final Earth player;

  bool isPlayerAdded = false;
  bool isControllerAdded = false;
  bool isTestAdded = false;
  bool isCollyAdded = false;
  bool isEnemyCreatorAdded = false;
  bool isCreatorLeftAdded = false;
  bool isCreatorRightAdded = false;
  @override
  void onTapDown(TapDownEvent event) {
    if (!isPlayerAdded &&
        !isControllerAdded &&
        !isCollyAdded &&
        !isEnemyCreatorAdded &&
        !isCreatorLeftAdded &&
        !isCreatorRightAdded) {
      game.world.add(player = Earth(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.red,
      ));
      game.world.add(controller = Radi(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.blue,
      ));
      game.world.add(Colly(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.yellow,
      ));
      game.world.add(EnemyCreator(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.green,
      ));
      game.world.add(CreatorLeft(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.green,
      ));
      game.world.add(CreatorRight(
        position: Vector2(gameWidth / 2, gameHeight / 2),
        paint: Paint()..color = Colors.green,
      ));
      removeFromParent();

      // List<Vector2> positions = [
      //   Vector2(gameWidth * 0.25, gameHeight * 0.25),
      //   Vector2(gameWidth * 0.75, gameHeight * 0.25),
      //   Vector2(gameWidth * 0.25, gameHeight * 0.75),
      //   Vector2(gameWidth * 0.75, gameHeight * 0.75),
      // ];

      // for (int i = 0; i < 4; i++) {
      //   Test test = Test(
      //     position: Vector2.zero(),
      //     paint: Paint()..color = Colors.green,
      //   );
      //   test.x = positions[i].x;
      //   test.y = positions[i].y;
      //   world.add(test);
      // }

      isPlayerAdded = true;
      isControllerAdded = true;
      isCollyAdded = true;
      isEnemyCreatorAdded = true;
      isCreatorLeftAdded = true;
      isCreatorRightAdded = true;

      // for (int i = 0; i < 10; i++) {
      //   final randomX =
      //       rand.nextDouble() * (gameWidth - plasticRadius * 2) + plasticRadius;
      //   final randomY =
      //       rand.nextDouble() * (gameHeight * 0.6 - plasticRadius * 2) +
      //           plasticRadius;

      //   world.add(Plastic(
      //     difficultyModifier: difficultyModifier,
      //     radius: plasticRadius,
      //     position: Vector2(randomX, randomY),
      //     velocity: Vector2((rand.nextDouble() - 0.5) * width, height * 0.2)
      //         .normalized()
      //       ..scale(height / 4),
      //     earth: player,
      //   ));
      // }
    }
  }
}

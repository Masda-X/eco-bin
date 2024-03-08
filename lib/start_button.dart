import 'dart:async';
import 'dart:math';

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
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class Start extends RectangleComponent with TapCallbacks, HasGameRef<MyGame> {
  // ignore: prefer_const_constructors
  Start() : super(paint: Paint()..color = Color.fromARGB(0, 33, 149, 243)) {
    const smallR = 15.0;
    const bigR = 30.0;
    shape = Path()..moveTo(bigR, 0);
    for (var i = 1; i < 10; i++) {
      final r = i.isEven ? bigR : smallR;
      final a = i / 10 * tau;
      shape.lineTo(r * cos(a), r * sin(a));
    }
    shape.close();

    width = 640;
    height = 135;
    x = 100;
    y = 100;
    position = Vector2(630, 450);
  }
  late final Path shape;
  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
      sprite: await Sprite.load('play_button.png'),
      size: Vector2(640, 135),
      position: Vector2(0, 0),
    ));
    add(
      ScaleEffect.to(
        Vector2.all(1.2),
        InfiniteEffectController(
          SequenceEffectController([
            LinearEffectController(0.1),
            ReverseLinearEffectController(0.1),
            RandomEffectController.exponential(
              PauseEffectController(1, progress: 0),
              beta: 1,
            ),
          ]),
        ),
      ),
    );
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
    Future.delayed(const Duration(seconds: 3), () {
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
      }
    });
  }
}

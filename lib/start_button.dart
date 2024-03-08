import 'dart:async';

import 'package:earth/colly.dart';
import 'package:earth/config.dart';
import 'package:earth/creator_left.dart';
import 'package:earth/creator_right.dart';

import 'package:earth/enemy_creator.dart';
import 'package:earth/game.dart';

import 'package:earth/test.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

class Start extends RectangleComponent with TapCallbacks, HasGameRef<MyGame> {
  // ignore: prefer_const_constructors
  Start() : super(paint: Paint()..color = Color.fromARGB(0, 29, 144, 239)) {
    width = 440;
    height = 135;
    x = 100;
    y = 100;
    position = Vector2(954, 500);
    anchor = Anchor.center;
  }
  late final SpriteComponent sprite;
  @override
  FutureOr<void> onLoad() async {
    sprite = SpriteComponent(
        sprite: await Sprite.load('click.png'),
        size: Vector2(440, 50),
        position: Vector2(220, 68),
        anchor: Anchor.center);
    add(sprite);
    sprite.add(
      OpacityEffect.fadeOut(
        EffectController(
          duration: 0.7,
          reverseDuration: 1.0,
          infinite: true,
        ),
      ),
    );
  }

  late final Test test;

  bool isPlayerAdded = false;
  bool isControllerAdded = false;
  bool isTestAdded = false;
  bool isCollyAdded = false;
  bool isEnemyCreatorAdded = false;
  bool isCreatorLeftAdded = false;
  bool isCreatorRightAdded = false;
  @override
  void onTapDown(TapDownEvent event) {
    // Add the scale effect
    add(
      ScaleEffect.to(
        Vector2.all(0.9),
        SequenceEffectController([
          LinearEffectController(0.1),
          ReverseLinearEffectController(0.1),
        ]),
      ),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!isPlayerAdded &&
          !isControllerAdded &&
          !isCollyAdded &&
          !isEnemyCreatorAdded &&
          !isCreatorLeftAdded &&
          !isCreatorRightAdded) {
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
          game.world.add(test);
        }

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

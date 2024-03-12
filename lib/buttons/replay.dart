import 'dart:async';

import 'package:eco_bin/game.dart';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'package:flutter/widgets.dart';

class Replay extends RectangleComponent
    with TapCallbacks, HasGameReference<MyGame> {
  // ignore: prefer_const_constructors
  Replay() : super(paint: Paint()..color = Color.fromARGB(0, 29, 144, 239)) {
    width = 440;
    height = 135;
    x = 100;
    y = 100;
    position = Vector2(962, 700);
    anchor = Anchor.center;
  }
  late final SpriteComponent sprite;
  @override
  FutureOr<void> onLoad() async {
    sprite = SpriteComponent(
        sprite: await Sprite.load('replay.png'),
        position: Vector2(221, 70),
        anchor: Anchor.center);
    priority = 9;
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

  @override
  void onTapDown(TapDownEvent event) {
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
      game.replayGame();
      removeFromParent();
    });
    // game.world.removeFromParent();
    // runApp(GameWidget(game: MyGame()));
  }
}

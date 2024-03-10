import 'package:earth/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class Clock extends CircleComponent with HasGameRef<MyGame> {
  late SpriteComponent sprite;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = SpriteComponent(
        sprite: await Sprite.load('bar.png'),
        size: Vector2(290, 69),
        position: Vector2(1720, 78),
        anchor: Anchor.center);
    priority = 2;
    add(sprite);
    // sprite.add(
    //   OpacityEffect.fadeOut(
    //     EffectController(
    //       duration: 0.7,
    //       reverseDuration: 1.0,
    //       infinite: true,
    //     ),
    //   ),
    // );
  }
}

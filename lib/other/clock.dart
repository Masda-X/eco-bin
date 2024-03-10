import 'package:earth/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class Clock extends CircleComponent with HasGameRef<MyGame> {
  late SpriteComponent sprite;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = SpriteComponent(
        sprite: await Sprite.load('clock.png'),
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
}

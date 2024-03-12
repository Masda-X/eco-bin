import 'package:eco_bin/game.dart';
import 'package:flame/components.dart';

class Bar extends RectangleComponent with HasGameRef<MyGame> {
  late SpriteComponent sprite;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = SpriteComponent(
        sprite: await Sprite.load('bar.png'),
        position: Vector2(1720, 120),
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

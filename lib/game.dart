import 'package:earth/earth.dart';
import 'package:flame/components.dart';

import 'package:flame/game.dart';

class MyGame extends FlameGame {
  MyGame({required this.zoom}) : super();

  final double zoom;
  late final Earth player;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.zoom = zoom;

    world.add(SpriteComponent(
      sprite: await loadSprite("bg.png"),
      anchor: Anchor.center,
      size: Vector2(1920, 1080),
      position: Vector2(0, 0), // BG harda olsun ONEMLI
    ));
    world.add(player = Earth());
  }
}

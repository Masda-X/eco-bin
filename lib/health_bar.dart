import 'package:earth/game.dart';
import 'package:flame/components.dart';

class HealthBar extends PositionComponent with HasGameRef<MyGame> {
  // HealthBar() {
  //   priority = 10; // Higher values draw the component on top
  // }
  int health = 5;
  List<SpriteComponent> hearts = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    for (var i = 0; i < health; i++) {
      var heart = SpriteComponent(
          sprite: await Sprite.load('heart.png'),
          size: Vector2(60, 55),
          position: Vector2(i * 70.0 + 70, gameRef.size.y - 1030),
          priority: 2);

      hearts.add(heart);
      gameRef.world.add(heart);
    }
  }

  void decreaseHealth() {
    if (health > 0) {
      health--;
      hearts[health].removeFromParent();
    }
  }
}

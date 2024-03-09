import 'package:earth/game.dart';
import 'package:flame/components.dart';

class HealthBar extends PositionComponent with HasGameRef<MyGame> {
  int health = 30;
  List<SpriteComponent> hearts = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    for (var i = 0; i < health; i++) {
      var heart = SpriteComponent(
        sprite: await Sprite.load('heart_a.png'),
        size: Vector2(40, 35),
        position: Vector2(i * 50.0, 0), // Adjust position for each heart
      );
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

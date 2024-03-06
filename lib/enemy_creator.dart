import 'dart:math';

import 'package:earth/game.dart';
import 'package:earth/plastic.dart';
import 'package:flame/components.dart';

class EnemyCreator extends Component with HasGameRef<MyGame> {
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      SpawnComponent(
        factory: (index) => createRandomPlastic(),
        period: _random.nextInt(3) + 1.0,
        autoStart: true,
      ),
    );
  }

  Plastic createRandomPlastic() {
    // Randomly choose an edge: 0 for left, 1 for top, 2 for right
    int edge = _random.nextInt(3);
    Vector2 position;

    switch (edge) {
      case 0: // Left edge
        position = Vector2(
            -Plastic., _random.nextDouble() * gameRef.size.y);
        break;
      case 1: // Top edge
        position = Vector2(
            _random.nextDouble() * gameRef.size.x, -Plastic.plasticSize);
        break;
      case 2: // Right edge
        position = Vector2(gameRef.size.x + Plastic.plasticSize,
            _random.nextDouble() * gameRef.size.y);
        break;
      default:
        position = Vector2.zero();
    }

    return Plastic(position: position);
  }
}

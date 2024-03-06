import 'dart:math';
import 'package:earth/game.dart';
import 'package:earth/plastic.dart';
import 'package:earth/earth.dart';
import 'package:flame/components.dart';

class EnemyCreator extends Component with HasGameRef<MyGame> {
  final Random _random = Random();
  final Earth earth; // Add an Earth instance to the EnemyCreator

  EnemyCreator(this.earth);

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
    Vector2 position = Vector2(_random.nextDouble() * gameRef.size.x,
        _random.nextDouble() * gameRef.size.y);
    Vector2 velocity = Vector2(_random.nextDouble(), _random.nextDouble());
    double radius = 20.0; // Adjust this value as needed
    double difficultyModifier = 1.0; // Adjust this value as needed

    return Plastic(
      velocity: velocity,
      position: position,
      radius: radius,
      difficultyModifier: difficultyModifier,
      earth: earth,
    );
  }
}

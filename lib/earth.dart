import 'package:eco_bin/enemy/banana.dart';
import 'package:eco_bin/game.dart';
import 'package:eco_bin/health_bar.dart';
import 'package:eco_bin/enemy/plastic.dart';
import 'package:eco_bin/buttons/replay.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';

class Earth extends CircleComponent
    with
        CollisionCallbacks,
        HoverCallbacks,
        DragCallbacks,
        TapCallbacks,
        DoubleTapCallbacks,
        HasGameRef<MyGame> {
  @override
  Earth({required Vector2 position, required paint})
      : super(
          anchor: Anchor.center,
          radius: 310,
          position: Vector2(960, 995),
          // ignore: prefer_const_constructors
          paint: Paint()..color = Color.fromARGB(0, 244, 67, 54),
        );
  late HealthBar healthBar;
  late CircleHitbox myCircleHitbox;
  late SpriteComponent earthSprite;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    myCircleHitbox = CircleHitbox(
      radius: 310,
    );
    add(myCircleHitbox);
    earthSprite = SpriteComponent(
      sprite: await Sprite.load('earth.png'),
      size: Vector2(640, 635),
      position: Vector2(-10, -2),
    );
    add(earthSprite);
    healthBar = HealthBar();
    gameRef.add(healthBar);
  }

  @override
  // ignore: unnecessary_overrides
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
  }

  @override
  // ignore: unnecessary_overrides
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
  }

  @override
  void onTapUp(event) {}

  @override
  void onDoubleTapDown(DoubleTapDownEvent event) {}

  @override
  void onTapCancel(event) {}

  @override
  void onHoverEnter() {
    // angle += 180.0; // add(RotateEffect(angle: 1, duration: 1));
  }
  @override
  bool containsPoint(Vector2 point) {
    return position.distanceTo(point) <= size.x / 2;
  }

  Future<void> changeSprite(String path) async {
    earthSprite.sprite = await Sprite.load(path);
  }

  // Future<void> onBinHit() async {
  //   await changeSprite('happy_earth.png');
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   await changeSprite('earth.png');
  // }

  int hitCount = 0;
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Plastic || other is Banana) {
      changeSprite('sad_earth.png');
      Future.delayed(const Duration(seconds: 1), () async {
        await changeSprite('earth.png');
      });

      for (var heart in healthBar.hearts) {
        heart.add(
          SequenceEffect(
            [
              MoveEffect.by(
                Vector2(10, 0),
                NoiseEffectController(
                  duration: 1,
                  noise: PerlinNoise(frequency: 20),
                ),
              ),
            ],
            infinite: false,
          ),
        );
      }

      healthBar.decreaseHealth();
      hitCount++;
      if (hitCount == 3) {
        Future.delayed(const Duration(seconds: 1), () async {
          gameRef.onHit5();
          game.resetGame();
          priority = 4;
          myCircleHitbox.removeFromParent();
          game.world.add(Replay());

          // Reset hitCount to 0 after executing the block
          hitCount = 0;
        });
      }
    }
  }
}

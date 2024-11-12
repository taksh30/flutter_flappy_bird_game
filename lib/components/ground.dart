import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  // init
  Ground() : super();

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(2 * gameRef.size.x, 200);
    position = Vector2(0, game.size.y - groundHeight);

    sprite = await Sprite.load('ground.png');

    add(RectangleHitbox());
  }

  // on update
  @override
  void update(double dt) {
    // move ground to left
    position.x -= groundScrollingSpeed * dt;

    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}

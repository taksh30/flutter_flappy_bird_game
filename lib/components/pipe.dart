import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(size: size, position: position);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'upper_pipe.png' : 'lower_pipe.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // scroll pipe to left
    position.x -= groundScrollingSpeed * dt;

    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;

      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}

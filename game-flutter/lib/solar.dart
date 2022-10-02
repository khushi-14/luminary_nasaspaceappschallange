// ignore_for_file: file_names

import 'dart:math' show Random;

import "package:flame/components.dart";
import 'package:flame/geometry.dart';
import 'package:flutter_game/player.dart';
import 'package:flutter_game/space_shooter_game.dart';

// import 'main.dart';

class Solar extends SpriteComponent with HasGameRef<SpaceShooterGame>, HasHitboxes, Collidable {
  bool _isWallHit = false;
  bool _isPlayerHit = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Random _rng = Random();
    sprite  = await gameRef.loadSprite('solar.png');
    position.x = 75 + _rng.nextInt(gameRef.viewportResolution.x.round() - 160).toDouble();
    position.y = 40;
    width = 90;
    height = 90;
    anchor = Anchor.center;

    final shape = HitboxPolygon([
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(-1, 0),
    ]);
    addHitbox(shape);
  }

  @override
  void update(double dt) {
    position.y += 10;
    if (_isWallHit) {
      removeFromParent();
      if (gameRef.score > 0) {
        gameRef.score -= 0;
      }
      _isWallHit = false;
      return;
    }

    if (_isPlayerHit) {
      removeFromParent();
      _isPlayerHit = false;
      gameRef.score += 50;
      return;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {   //edit
    if (other is ScreenCollidable) {
      _isWallHit = true;
      print('asteroid wallhit');

      return;
    }

    if (other is Player) {
      // asteroid hit the player
      _isPlayerHit = true;
      print('asteroid hit the player');
      return;
    }
  }
}

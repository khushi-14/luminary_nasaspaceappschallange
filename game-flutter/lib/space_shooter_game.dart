// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/player.dart';
import 'package:flutter_game/shoot.dart';

import 'dart:math';
import 'dart:async' as asy;
import 'asteroid.dart';
import 'solar.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, KeyboardEvents, HasCollidables, DoubleTapDetector  {

  late TextComponent scoreText;
  late TextComponent timerText;

  late Player player;

  late asy.Timer starsTimer;
  late asy.Timer asteroidTimer;
  late asy.Timer solarTimer;
  late asy.Timer gameTimer;

  int score = 0;
  int gameTime = 30;

  Vector2 viewportResolution = Vector2(
    600,
    1024,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    document.addEventListener("visibilitychange", onVisibilityChange);

    camera.viewport = FixedResolutionViewport(viewportResolution);
    camera.setRelativeOffset(Anchor.topLeft);
    camera.speed = 1;

    add(ScreenCollidable());
    player = Player();

    // add score text on top
    final style = TextStyle(fontFamily: 'Fipps',color: BasicPalette.white.color, fontSize: 20);
    final regular = TextPaint(style: style);
    scoreText = TextComponent(text: 'Score: $score', textRenderer: regular)
      ..anchor = Anchor.topLeft
      ..x = 10
      ..y = 32.0;
    add(scoreText);

    // add timer text on top

    timerText = TextComponent(text: 'Time: $gameTime', textRenderer: regular)
      ..anchor = Anchor.topRight
      ..x = viewportResolution.x - 50
      ..y = 32.0;
    add(timerText);
    startGame();
  }

  void endGame() {
    player.removeFromParent();
    asteroidTimer.cancel();
    solarTimer.cancel();
    gameTimer.cancel();
    overlays.add('EndMenu');

  }

  void pauseGame() {
      //player.removeFromParent();
      asteroidTimer.cancel();
      solarTimer.cancel();
      gameTimer.cancel();
      starsTimer.cancel();
  }

  void resumeGame() {
    starsTimer =
        asy.Timer.periodic(const Duration(milliseconds: 100), (timer) {
          add(ParticleComponent(
            AcceleratedParticle(
              lifespan: 1.0,
              // Will fire off in the center of game canvas
              position:
              Vector2(Random().nextInt(viewportResolution.x.round()).toDouble(), 0),
              // With random initial speed of Vector2(-100..100, 0..-100)
              speed: Vector2(0, viewportResolution.length),
              // Accelerating downwards, simulating "gravity"
              // speed: Vector2(0, 100),
              child: CircleParticle(
                radius: 2.0,
                paint: Paint()
                  ..color = Colors.white,
              ),
            ),
          ));
        });
    asteroidTimer =
        asy.Timer.periodic(Duration(milliseconds: Random().nextInt(3000)), (timer) {
          Asteroid asteroid = Asteroid();
          add(asteroid);
        });
    gameTimer =
        asy.Timer.periodic(const Duration(milliseconds: 1000), (timer) {
          gameTime -= 1;
        });
    solarTimer =
        asy.Timer.periodic(Duration(milliseconds: Random().nextInt(2000)), (timer) {
          Solar solar = Solar();
          add(solar);
        });       
  }

  void startGame() {
    gameTime = 30;
    add(player);
    resumeGame();
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $score';
    timerText.text = 'Time: $gameTime';
    if (gameTime == 0) {
     endGame();
    }

  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }

  @override
  void onDoubleTap() {
    print("double tap");
    Shoot shoot = Shoot();
    add(shoot);
  }


  @override
  KeyEventResult onKeyEvent(RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,) {
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isSpace) {
      // spaceship shoots!
      Shoot shoot = Shoot();
      add(shoot);
      return KeyEventResult.handled;
    }
    if (isArrowRight) {
      player.position.x += 30;
      return KeyEventResult.handled;
    }
    if (isArrowLeft) {
      player.position.x -= 30;
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // resume the engine
          resumeEngine();
          print('resume');
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        print('pause');
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }

  void onVisibilityChange(Event e) {
    // do something
    if (document.visibilityState == 'visible') {
     print('foreground');
     resumeEngine();
     resumeGame();
    } else {
      print('background');
      pauseEngine();
      pauseGame();
    }
  }

}

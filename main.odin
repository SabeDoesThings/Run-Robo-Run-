package main;

import rl "vendor:raylib";

GameState :: enum {
    Title,
    Game,
    Dead,
}

currentState: GameState;

player: Player;
ground: Ground;
ground2: Ground;
bush: Bush;
score: i32;

resetGame :: proc() {
    ground.speed = 0;
    ground.pos = {0, f32(rl.GetScreenHeight()) / 1.5};

    ground2.speed = 0;
    ground2.pos = {f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight()) / 1.5};

    bush.speed = 0;
    bush.pos = {f32(rl.GetScreenWidth()) + 600, f32(rl.GetScreenHeight()) / 1.5 - 120};

    score = 0;
}

main :: proc() {
    rl.InitWindow(600, 600, "Run, Robo Run!");
    defer rl.CloseWindow();
    rl.InitAudioDevice();
    defer rl.CloseAudioDevice();
    rl.SetTargetFPS(60);

    //INIT
    score = 0;

    currentState = .Title;

    bgMusic := rl.LoadMusicStream("res/bgmusic.mp3");
    rl.PlayMusicStream(bgMusic);

    initPlayer(&player);
    initGround(&ground, {0, f32(rl.GetScreenHeight()) / 1.5});
    initGround(&ground2, {f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight()) / 1.5});
    initBush(&bush);

    for !rl.WindowShouldClose() {
        //UPDATE
        rl.UpdateMusicStream(bgMusic);

        if currentState == .Game {
            updatePlayer(&player);
            updateGround(&ground);
            updateGround(&ground2);
            updateBush(&bush);
        }

        if rl.IsKeyPressed(.ENTER) {
            currentState = .Game;

            resetGame();
        }

        rl.BeginDrawing();
            //DRAW
            rl.ClearBackground(rl.SKYBLUE);

            if currentState == .Dead {
                rl.DrawText("DEAD.\n\n\nClick 'Enter' to Restart", 10, rl.GetScreenHeight() / 2, 40, rl.RED);

                if rl.IsKeyPressed(.ENTER) {
                    currentState = .Game;

                    resetGame();
                }
            }

            if currentState == .Title {
                rl.DrawText("Click 'Enter' to Start", 10, rl.GetScreenHeight() / 2, 40, rl.WHITE);
            }
            
            if currentState == .Game {
                drawGround(&ground);
                drawGround(&ground2);
                drawBush(&bush);
                drawPlayer(&player);

                rl.DrawText(rl.TextFormat("Score: %i", score), 0, 0, 30, rl.WHITE);
            }
        rl.EndDrawing();
    }
}
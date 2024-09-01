package main;

import rl "vendor:raylib";
import "core:fmt";

Ground :: struct {
    pos: rl.Vector2,
    tex: rl.Texture2D,
    speed: f32,
}

@(private="file")
speedMul: f32 = 100;

initGround :: proc(g: ^Ground, pos: rl.Vector2) {
    scaleMul: i32 = 40; //640x128

    g.pos = pos;
    g.tex = rl.LoadTexture("res/ground.png");
    g.tex.width *= scaleMul;
    g.tex.height *= scaleMul;

    g.speed = 0;
}

drawGround :: proc(g: ^Ground) {
    rl.DrawTexture(g.tex, i32(g.pos.x), i32(g.pos.y), rl.WHITE);
}

updateGround :: proc(g: ^Ground) {
    if rl.IsKeyDown(.SPACE) && currentState == .Game {
        g.speed += speedMul * rl.GetFrameTime();
        if g.speed >= 2000 {
            g.speed = 2000;
        }

        if rl.CheckCollisionRecs(player.bounds, bush.bounds) {
            currentState = .Dead;
        }
    }
    else if rl.IsKeyReleased(.SPACE) {
        currentState = .Dead;
    }
    else {
        g.speed -= speedMul * rl.GetFrameTime();
        if g.speed <= 0 {
            g.speed = 0;
        }
    }

    g.pos.x -= g.speed * rl.GetFrameTime();

    if g.pos.x + 640 < 0 {
        g.pos.x += f32(rl.GetScreenWidth()) + 640;
    }
}
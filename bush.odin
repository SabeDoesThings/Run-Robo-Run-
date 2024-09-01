package main;

import rl "vendor:raylib";

Bush :: struct {
    pos: rl.Vector2,
    tex: rl.Texture2D,
    speed: f32,
    bounds: rl.Rectangle,
}

@(private="file")
speedMul: f32 = 100;

initBush :: proc(b: ^Bush) {
    scaleMul: i32 = 15; //120x120

    b.pos = {f32(rl.GetScreenWidth()) + 600, f32(rl.GetScreenHeight()) / 1.5 - 120};
    b.tex = rl.LoadTexture("res/bush.png");
    b.tex.width *= scaleMul;
    b.tex.height *= scaleMul;

    b.speed = 0;
}

drawBush :: proc(b: ^Bush) {
    rl.DrawTexture(b.tex, i32(b.pos.x), i32(b.pos.y), rl.WHITE);

    // Debugging the hitbox
    // rl.DrawRectangleLines(i32(b.bounds.x), i32(b.bounds.y), i32(b.bounds.width), i32(b.bounds.height), rl.RED);
}

updateBush :: proc(b: ^Bush) {
    b.bounds = {b.pos.x, b.pos.y, f32(b.tex.width) - 40, f32(b.tex.height)};

    if rl.IsKeyDown(.SPACE) && currentState == .Game {
        b.speed += speedMul * rl.GetFrameTime();
        if b.speed >= 2000 {
            b.speed = 2000;
        }
    }
    else {
        b.speed -= speedMul * rl.GetFrameTime();
        if b.speed <= 0 {
            b.speed = 0;
        }
    }

    b.pos.x -= b.speed * rl.GetFrameTime();

    if b.pos.x + 120 < 0 {
        b.pos.x += f32(rl.GetScreenWidth()) + 120 + f32(rl.GetRandomValue(0, 2000));

        score += 1;
    }
}
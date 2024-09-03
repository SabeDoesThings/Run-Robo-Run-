package main;

import rl "vendor:raylib";

Player :: struct {
    pos: rl.Vector2,
    tex: rl.Texture2D,
    grounded: bool,
    vel: rl.Vector2,
    bounds: rl.Rectangle,
}

initPlayer :: proc(p: ^Player) {
    scaleMul: i32 = 12; // 96x96

    p.pos = {0, f32(rl.GetScreenHeight()) / 2};
    p.tex = rl.LoadTexture("res/robo.png");
    p.tex.width *= scaleMul;
    p.tex.height *= scaleMul;
}

drawPlayer :: proc(p: ^Player) {
    rl.DrawTextureV(p.tex, p.pos, rl.WHITE);

    // Debugging the hitbox
    // rl.DrawRectangleLines(i32(p.bounds.x), i32(p.bounds.y), i32(p.bounds.width), i32(p.bounds.height), rl.RED);
}

updatePlayer :: proc(p: ^Player) {
    p.bounds = {p.pos.x, p.pos.y, f32(p.tex.width), f32(p.tex.height)};
    
    p.vel.y += 2000 * rl.GetFrameTime();

    if player.grounded && rl.IsKeyPressed(.UP) {
        player.vel.y = -800;
        player.grounded = false;
    }

    player.pos += player.vel * rl.GetFrameTime();

    if player.pos.y > (f32(rl.GetScreenHeight()) / 1.5) - 96 {
        player.pos.y = (f32(rl.GetScreenHeight()) / 1.5) - 96;
        player.grounded = true;
    }
}

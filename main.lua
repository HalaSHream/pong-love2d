
local windowWidth = 800
local windowHeight = 600

local player1 = {
    x = 30,
    y = 250,
    width = 15,
    height = 100,
    speed = 300,
    score = 0
}

local player2 = {
    x = 755,
    y = 250,
    width = 15,
    height = 100,
    speed = 300,
    score = 0
}

-- Ball
local ball = {
    x = 390,
    y = 290,
    width = 20,
    height = 20,
    dx = 250,
    dy = 180
}

local function checkCollision(a, b)
    return a.x < b.x + b.width
       and a.x + a.width > b.x
       and a.y < b.y + b.height
       and a.y + a.height > b.y
end

local function resetBall()
    ball.x = windowWidth / 2 - ball.width / 2
    ball.y = windowHeight / 2 - ball.height / 2

    ball.dx = -ball.dx
    ball.dy = 180
end

function love.load()
    love.window.setMode(windowWidth, windowHeight)
    love.window.setTitle("Pong Game")

    love.graphics.setBackgroundColor(0.08, 0.08, 0.12)
end

function love.update(dt)

    if love.keyboard.isDown("w") then
        player1.y = player1.y - player1.speed * dt
    end

    if love.keyboard.isDown("s") then
        player1.y = player1.y + player1.speed * dt
    end

    if love.keyboard.isDown("up") then
        player2.y = player2.y - player2.speed * dt
    end

    if love.keyboard.isDown("down") then
        player2.y = player2.y + player2.speed * dt
    end

    player1.y = math.max(
        0,
        math.min(player1.y, windowHeight - player1.height)
    )

    player2.y = math.max(
        0,
        math.min(player2.y, windowHeight - player2.height)
    )

    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
    end

    if ball.y + ball.height >= windowHeight then
        ball.y = windowHeight - ball.height
        ball.dy = -ball.dy
    end

    if ball.dx < 0 and checkCollision(ball, player1) then
        ball.x = player1.x + player1.width
        ball.dx = -ball.dx

        player1.score = player1.score + 1
    end

    if ball.dx > 0 and checkCollision(ball, player2) then
        ball.x = player2.x - ball.width
        ball.dx = -ball.dx

        player2.score = player2.score + 1
    end

    if ball.x + ball.width < 0 then
        player2.score = player2.score + 1
        resetBall()
    end

    if ball.x > windowWidth then
        player1.score = player1.score + 1
        resetBall()
    end
end

function love.draw()

    love.graphics.setColor(0, 0.85, 1)
    love.graphics.rectangle(
        "fill",
        player1.x,
        player1.y,
        player1.width,
        player1.height
    )

    love.graphics.setColor(1, 0.35, 0.65)
    love.graphics.rectangle(
        "fill",
        player2.x,
        player2.y,
        player2.width,
        player2.height
    )

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle(
        "fill",
        ball.x,
        ball.y,
        ball.width,
        ball.height
    )

    love.graphics.setColor(0.4, 0.4, 0.45)
    love.graphics.rectangle(
        "fill",
        windowWidth / 2 - 2,
        0,
        4,
        windowHeight
    )

    love.graphics.setColor(0, 0.85, 1)
    love.graphics.print(
        "Player 1: " .. player1.score,
        260, 20, 0, 1.5, 1.5
    )

    love.graphics.setColor(1, 0.35, 0.65)
    love.graphics.print(
        "Player 2: " .. player2.score,
        440, 20, 0, 1.5, 1.5
    )

    love.graphics.setColor(1, 1, 1)
end

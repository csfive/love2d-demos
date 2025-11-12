local love = require 'love'

local function createEye(x, y, radius, pupilRadius)
    radius = radius or 50
    pupilRadius = pupilRadius or 15

    return {
        x = x,
        y = y,
        radius = radius,
        pupilRadius = pupilRadius,
        -- 限制瞳孔的移动范围
        maxFollowDistance = radius * 0.6
    }
end

local function drawEye(eye)
    local dx = love.mouse.getX() - eye.x
    local dy = love.mouse.getY() - eye.y
    local d = math.sqrt(dx * dx + dy * dy)
    local followDistance = math.min(d, eye.maxFollowDistance)

    local angle = math.atan2(dy, dx)
    local pupilX = eye.x + followDistance * math.cos(angle)
    local pupilY = eye.y + followDistance * math.sin(angle)

    -- 向量归一化
    -- local pupilX, pupilY
    -- if d > 0 then
    --     local unitX = dx / d
    --     local unitY = dy / d
    --     pupilX = eye.x + unitX * followDistance
    --     pupilY = eye.y + unitY * followDistance
    -- else
    --     pupilX, pupilY = eye.x, eye.y
    -- end

    love.graphics.setColor(1, 1, 1)
    love.graphics.circle('fill', eye.x, eye.y, eye.radius)
    love.graphics.setColor(0, 0, .4)
    love.graphics.circle('fill', pupilX, pupilY, eye.pupilRadius)
end

local eyes = {}

function love.load()
    love.window.setTitle('Eyes')
    table.insert(eyes, createEye(200, 200, 70, 25))
    table.insert(eyes, createEye(380, 200, 70, 25))
end

function love.draw()
    for _, eye in ipairs(eyes) do
        drawEye(eye)
    end
end

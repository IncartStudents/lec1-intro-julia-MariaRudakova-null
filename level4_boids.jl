module Boids

using Plots

mutable struct Boid
    positionX::Float64  # Координата X
    positionY::Float64  # Координата Y
    velocityX::Float64  # Скорость по оси X
    velocityY::Float64  # Скорость по оси Y
end

mutable struct WorldState
    boids::Vector{Boid}
    height::Float64
    width::Float64

    function WorldState(n_boids, width, height)
        boids = Vector{Boid}(undef, n_boids)
        for i in 1:n_boids
            pos_x = rand() * width
            pos_y = rand() * height
            vel_x = (rand() * 2 - 1) * 5
            vel_y = (rand() * 2 - 1) * 5
            boids[i] = Boid(pos_x, pos_y, vel_x, vel_y)
        end
        new(boids, width, height)
    end
end

function update!(state::WorldState)
    # Собираем координаты всех бодисов
    positions = [(boid.positionX, boid.positionY) for boid in state.boids]

    for i in 1:length(state.boids)
        boid = state.boids[i]

        # Обновляем позицию
        boid.positionX += boid.velocityX
        boid.positionY += boid.velocityY

        # Проверяем границы и отражаем движение
        if boid.positionX < 0 || boid.positionX > state.width
            boid.velocityX = -boid.velocityX
        end
        if boid.positionY < 0 || boid.positionY > state.height
            boid.velocityY = -boid.velocityY
        end
    end

    return positions  # Возвращаем список координат бодисов
end

# Без изменений ниже этой строки

function (@main)(ARGS)
    w = 30
    h = 30
    n_boids = 10

    state = WorldState(n_boids, w, h)

    anim = @animate for time = 1:100
        boids = update!(state)
        scatter(boids, xlim = (0, state.width), ylim = (0, state.height))
    end
    gif(anim, "boids.gif", fps = 10)
end

export main

end

using .Boids
Boids.main("")

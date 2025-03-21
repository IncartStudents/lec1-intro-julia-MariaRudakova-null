
module GameOfLife
using Plots

mutable struct Life
    current_frame::Matrix{Int}
    next_frame::Matrix{Int}
end

function step!(state::Life)
    curr = state.current_frame
    next = state.next_frame

    # Реализация одного шага алгоритма "Игра жизни"
    for i in 1:size(curr, 1)
        for j in 1:size(curr, 2)
            neighbors = 0
            for x in [-1, 0, 1]
                for y in [-1, 0, 1]
                    if !(x == 0 && y == 0)
                        ni = mod1(i + x, size(curr, 1))  # Граничные условия (тор)
                        nj = mod1(j + y, size(curr, 2))
                        neighbors += curr[ni, nj]
                    end
                end
            end

            if curr[i, j] == 1  # Если клетка жива
                if neighbors < 2 || neighbors > 3
                    next[i, j] = 0  # Умирает от одиночества или перенаселённости
                else
                    next[i, j] = 1  # Выживает
                end
            else  # Если клетка мертва
                if neighbors == 3
                    next[i, j] = 1  # Оживление
                else
                    next[i, j] = 0  # Остается мертвой
                end
            end
        end
    end

    # Обновляем текущее состояние после завершения вычислений
    state.current_frame .= next

    return nothing
end

function (@main)(ARGS)
    n = 30
    m = 30
    init = rand(0:1, n, m)

    game = Life(init, zeros(n, m))

    anim = @animate for time = 1:100
        step!(game)
        cr = game.current_frame
        heatmap(cr)
    end
    gif(anim, "life.gif", fps = 10)
end

export main

end

using .GameOfLife
GameOfLife.main("")

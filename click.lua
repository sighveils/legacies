local VirtualInput = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")

local ativo = false

local cliquesPorCiclo = 40000
local delayAposCiclo = 1

local holdDelay = 0
local entreCliques = 0
local repeticoes = 2

-- toggle na tecla 2
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.Two then
        ativo = not ativo
    end
end)

task.spawn(function()
    while true do
        if ativo then
            for i = 1, cliquesPorCiclo do
                if not ativo then
                    break
                end

                local pos = UserInputService:GetMouseLocation()

                for r = 1, repeticoes do
                    if not ativo then
                        break
                    end

                    VirtualInput:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
                    task.wait(holdDelay)
                    VirtualInput:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
                end

                task.wait(entreCliques)
            end

            if ativo then
                task.wait(delayAposCiclo)
            end
        else
            task.wait(0.05)
        end
    end
end)

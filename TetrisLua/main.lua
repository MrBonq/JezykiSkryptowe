function startMenu()
  pause = true
  errortitle = "NewGame"
  errormessage = " "
  buttons = {"Exit", "Load", "Start", escapebutton = 4}
  pressedbutton = love.window.showMessageBox(errortitle, errormessage, buttons)
  if pressedbutton == 2 then
      loadGame()
    elseif pressedbutton == 1 then
      love.event.quit()
    elseif pressedbutton == 3 then
        pause = false
        newGame = true
    elseif pressedbutton == 4 then
      love.event.quit()
  end
end

function menu()
  pause = true
  errortitle = "PAUSE"
  errormessage = " "
  buttons = {"Exit", "Reset", "Save", "Load", "Resume", escapebutton = 6}
  pressedbutton = love.window.showMessageBox(errortitle, errormessage, buttons)
  if pressedbutton == 2 then
      reset()
    elseif pressedbutton == 1 then
      love.event.quit()
    elseif pressedbutton == 3 then
        saveGame()
    elseif pressedbutton == 4 then
        loadGame()
    elseif pressedbutton == 5 then
          pause = false
    elseif pressedbutton == 6 then
      love.event.quit()
  end
end

function love.load()
    red = 0/255
    green = 76/255
    blue = 153/255
    bgColor = {red, green, blue}
    love.graphics.setBackgroundColor(bgColor)
    lume = require "lume"
    completeLine = love.audio.newSource("completeLine.wav", "stream")
    defeat = love.audio.newSource("defeat.wav", "stream")
    score = 0;
    pause = false
    -- Types of blocks
    blocksTypes = {
        {
            {
                {' ', ' ', ' ', ' '},
                {'a', 'a', 'a', 'a'},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'a', ' ', ' '},
                {' ', 'a', ' ', ' '},
                {' ', 'a', ' ', ' '},
                {' ', 'a', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {' ', 'b', 'b', ' '},
                {' ', 'b', 'b', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'c', 'c', 'c', ' '},
                {' ', ' ', 'c', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'c', 'c', ' '},
                {' ', 'c', ' ', ' '},
                {' ', 'c', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'c', ' ', ' ', ' '},
                {'c', 'c', 'c', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', ' ', 'c', ' '},
                {' ', ' ', 'c', ' '},
                {' ', 'c', 'c', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', ' ', ' '},
                {'d', 'd', 'd', ' '},
                {'d', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {'d', 'd', ' ', ' '},
                {' ', 'd', ' ', ' '},
                {' ', 'd', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', ' ', 'd', ' '},
                {'d', 'd', 'd', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'd', ' ', ' '},
                {' ', 'd', ' ', ' '},
                {' ', 'd', 'd', ' '},
                {' ', ' ', ' ', ' '},
            },
        },
        {
            {
                {' ', ' ', 'e', ' '},
                {' ', 'e', 'e', ' '},
                {' ', 'e', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'e', 'e', ' '},
                {' ', ' ', 'e', 'e'},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },

        },
        {
            {
                {' ', 'f', ' ', ' '},
                {' ', 'f', 'f', ' '},
                {' ', ' ', 'f', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'f', 'f', ' '},
                {'f', 'f', ' ', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },

        },
        {
            {
                {' ', 'g', ' ', ' '},
                {' ', 'g', 'g', ' '},
                {' ', 'g', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'g', ' ', ' '},
                {'g', 'g', 'g', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', 'g', ' ', ' '},
                {'g', 'g', ' ', ' '},
                {' ', 'g', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },
            {
                {' ', ' ', ' ', ' '},
                {'g', 'g', 'g', ' '},
                {' ', 'g', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },

        },
        {

            {
                {' ', 'h', ' ', ' '},
                {'h', 'h', 'h', ' '},
                {' ', 'h', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },

        },
        {

            {
                {' ', ' ', ' ', ' '},
                {' ', 'i', ' ', ' '},
                {' ', ' ', ' ', ' '},
                {' ', ' ', ' ', ' '},
            },

        },

    }

    gridX = 10
    gridY = 18

    pieceXCount = 4
    pieceYCount = 4

    timerLimit = 0.5
    --check if block can move in direction X/Y
    function canMove(testX, testY, testRotation)
        for y = 1, pieceYCount do
            for x = 1, pieceXCount do
                local testBlockX = testX + x
                local testBlockY = testY + y
                if blocksTypes[pieceType][testRotation][y][x] ~= ' ' and (
                    testBlockX < 1
                    or testBlockX > gridX
                    or testBlockY > gridY
                    or inert[testBlockY][testBlockX] ~= ' ')
                    then
                    return false
                end
            end
        end
        return true
    end

    function newSequence()
        sequence = {}
        for pieceTypeIndex = 1, #blocksTypes do
            local position = love.math.random(#sequence + 1)
            table.insert(
                sequence,
                position,
                pieceTypeIndex
            )
        end
    end

    function newPiece()
        pieceX = 3
        pieceY = 0
        pieceRotation = 1
        pieceType = table.remove(sequence)

        if #sequence == 0 then
            newSequence()
        end
    end

    function gameOver()

      love.audio.play( defeat )
      local errortitle = "You Lose"
      local errormessage = "Your Score: " .. score
      local buttons = {"Exit", "Reset", escapebutton = 3}
      local pressedbutton = love.window.showMessageBox(errortitle, errormessage, buttons)
      if pressedbutton == 2 then
          reset()
      elseif pressedbutton == 1 then
          love.event.quit()
      elseif pressedbutton == 3 then
          love.event.quit()
      end
    end

    function reset()
        inert = {}
        for y = 1, gridY do
            inert[y] = {}
            for x = 1, gridX do
                inert[y][x] = ' '
            end
        end

        newSequence()
        newPiece()
        score = 0
        pause = false
        timer = 0
    end
    function saveGame()
      data = {}
      data.score = score
      data.board = {}
      for y = 1, gridY do
            data.board[y] = {}
            for x = 1, gridX do
                data.board[y][x] = inert[y][x]
            end
        end
        serialized = lume.serialize(data)
        print(serialized)
        -- The filetype actually doesn't matter, and can even be omitted.
        love.filesystem.write("savedata.txt", serialized)
        menu()
    end

    function loadGame()
      function drawBlock(block, x, y)
          local colors = {
              [' '] = {.87, .87, .87},
              a = {.47, .76, .94},
              b = {.93, .91, .42},
              c = {.49, .85, .76},
              d = {.92, .69, .47},
              e = {.83, .54, .93},
              f = {.97, .58, .77},
              g = {.66, .83, .46},
              h = {255, 0, 0},
              i = {0, 255, 0},
              preview = {.75, .75, .75},
          }
          local color = colors[block]
          love.graphics.setColor(color)

          local blockSize = 20
          local blockDrawSize = blockSize - 1
          love.graphics.rectangle(
              'fill',
              (x - 1) * blockSize,
              (y - 1) * blockSize,
              blockDrawSize,
              blockDrawSize
          )
      end
      mainData = love.filesystem.load("main.lua")
      mainData()
      newGame = false
      if love.filesystem.getInfo("savedata.txt") then
        file = love.filesystem.read("savedata.txt")
        data = lume.deserialize(file)
        score = data.score
        offsetX = 15
        offsetY = 5
        for y = 1, gridY do
            for x = 1, gridX do
                drawBlock(data.board[y][x], x + offsetX, y + offsetY)
            end
        end

        for y = 1, pieceYCount do
            for x = 1, pieceXCount do
                block = blocksTypes[pieceType][pieceRotation][y][x]
                if block ~= ' ' then
                    drawBlock(block, x + pieceX + offsetX, y + pieceY + offsetY)
                end
            end
        end

        for y = 1, pieceYCount do
            for x = 1, pieceXCount do
                local block = blocksTypes[sequence[#sequence]][1][y][x]
                if block ~= ' ' then
                    drawBlock('preview', x + 18, y + 1)
                end
            end
        end
        pause = false
      end
    end
    reset()
    startMenu()
end

function love.update(dt)

    timer = timer + dt
    -- Removed local timerLimit = 0.5
    if timer >= timerLimit then
        timer = 0
        if pause == false then
          local testY = pieceY + 1
          if canMove(pieceX, testY, pieceRotation) then
              pieceY = testY
          else
              for y = 1, pieceYCount do
                  for x = 1, pieceXCount do
                      local block =
                          blocksTypes[pieceType][pieceRotation][y][x]
                      if block ~= ' ' then
                          inert[pieceY + y][pieceX + x] = block
                      end
                  end
              end

              -- Find complete rows
              for y = 1, gridY do
                  local complete = true
                  for x = 1, gridX do
                      if inert[y][x] == ' ' then
                          complete = false

                          break
                      end
                  end

                  if complete then
                      for removeY = y, 2, -1 do
                          for removeX = 1, gridX do
                              inert[removeY][removeX] = inert[removeY - 1][removeX]
                          end
                      end

                      for removeX = 1, gridX do
                          inert[1][removeX] = ' '
                      end
                      score = score + 10
                      love.audio.play( completeLine )
                end
              end

              newPiece()

              if not canMove(pieceX, pieceY, pieceRotation) then
                  gameOver()
              end
            end
          end
    end
end

function love.keypressed(key)
    if key == 'up' then
        local testRotation = pieceRotation + 1
        if testRotation > #blocksTypes[pieceType] then
            testRotation = 1
        end
        if canMove(pieceX, pieceY, testRotation) then
            pieceRotation = testRotation
        end
    elseif key == 'left' then
        local testX = pieceX - 1
        if canMove(testX, pieceY, pieceRotation) then
            pieceX = testX
        end
    elseif key == 'right' then
        local testX = pieceX + 1

        if canMove(testX, pieceY, pieceRotation) then
            pieceX = testX
        end
    elseif key == 'down' then
      local testY = pieceY + 2
      if canMove(pieceX, testY, pieceRotation) then
          pieceY = pieceY + 2
      end
      elseif key == 'escape' then
        menu()
    end
end

function love.draw()
    function drawBlock(block, x, y)
        local colors = {
            [' '] = {.87, .87, .87},
            a = {.47, .76, .94},
            b = {.93, .91, .42},
            c = {.49, .85, .76},
            d = {.92, .69, .47},
            e = {.83, .54, .93},
            f = {.97, .58, .77},
            g = {.66, .83, .46},
            h = {255, 0, 0},
            i = {0, 255, 0},
            preview = {.75, .75, .75},
        }
        local color = colors[block]
        love.graphics.setColor(color)

        local blockSize = 20
        local blockDrawSize = blockSize - 1
        love.graphics.rectangle(
            'fill',
            (x - 1) * blockSize,
            (y - 1) * blockSize,
            blockDrawSize,
            blockDrawSize
        )
    end

     offsetX = 15
     offsetY = 5

  if newGame == true then
      for y = 1, gridY do
          for x = 1, gridX do
              drawBlock(inert[y][x], x + offsetX, y + offsetY)
          end
      end

      for y = 1, pieceYCount do
          for x = 1, pieceXCount do
              block = blocksTypes[pieceType][pieceRotation][y][x]
              if block ~= ' ' then
                  drawBlock(block, x + pieceX + offsetX, y + pieceY + offsetY)
              end
          end
      end

      for y = 1, pieceYCount do
          for x = 1, pieceXCount do
              local block = blocksTypes[sequence[#sequence]][1][y][x]
              if block ~= ' ' then
                  drawBlock('preview', x + 18, y + 1)
              end
          end
      end


    else
      loadGame()
  end
    font = love.graphics.newFont(36)
    local x, y = 320, 480
	  --local w, h = 400, 50
    love.graphics.setColor(255, 255, 255, 1)
	  love.graphics.print("Score: " .. score ,font, x, y)
end

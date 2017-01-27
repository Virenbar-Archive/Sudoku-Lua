--require("sudoku")
require("./lua/sudoku")
Debug = true
-------------
--Love Load--
-------------
function love.load()
  --love.graphics.setWireframe(Debug)
  Narray = {
  love.graphics.newImage("Images/0.bmp"),
  love.graphics.newImage("Images/1.bmp"),
  love.graphics.newImage("Images/2.bmp"),
  love.graphics.newImage("Images/3.bmp"),
  love.graphics.newImage("Images/4.bmp"),
  love.graphics.newImage("Images/5.bmp"),
  love.graphics.newImage("Images/6.bmp"),
  love.graphics.newImage("Images/7.bmp"),
  love.graphics.newImage("Images/8.bmp"),
  love.graphics.newImage("Images/9.bmp")}
  
  CurrentS = sudoku.init()
  AnswerS = sudoku.init()
  ----[[
  CurrentS = {
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,9}}
  --]]

  love.graphics.setNewFont(16)
  --love.graphics.setColor(0,0,0)
  love.graphics.setBackgroundColor(0,0,0)
  
  GDT = 0
  DT = 0
  Count = 0
  Message = ""
  sudoku.test()
  print(package.path)
end
---------------
--Love Update--
---------------
function love.update(dt)
  --love.timer.sleep(1)
  --love.timer.getTime
  DT = DT + dt
  GDT = GDT + dt
  if DT > 1 then 
    DT = 0 
    Count = Count + 1
  end
  CurrentS = sudoku.randomOne(CurrentS)
end
--Key pressed
function love.keypressed(keycode)
  if keycode then love.event.quit()
    end
end
-------------
--Love Draw--
-------------
function love.draw()
  sudoku.draw()
  if Debug then DebugDraw() 
  end
end
---------
--Debug--
---------
function DebugDraw()
  love.graphics.setColor(0,255,0)
  love.graphics.print("Hey".." "..Count.." "..GDT.." "..DT,0,450)
  love.graphics.print(Message,0,500)
  love.graphics.setColor(255,255,255)
end

function love.quit()
  print("Thanks for playing! Come back soon! "..GDT)
end
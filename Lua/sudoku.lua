sudoku = {}
--
function sudoku.test()
  Message = "Test"
end
--
function sudoku.init()
  local Sudoku = {}
  for i=1,9 do
    Sudoku[i] = {}
    for j=1,9 do
      Sudoku[i][j]=0
    end
  end
  return Sudoku
end
--
function sudoku.check3x3(i,j,x,y)
  for iC=x,x+2 do
    for jC=y,y+2 do
      if B[i][j]==B[iC][jC] then l3=l3+1 end
    end
  end  
end
--
----[[
function sudoku.generator()
  local Sudoku = sudoku.init()
  local CheckH = false
  local CheckV = false
  local CheckS = false
  W=0
  
  math.randomseed(os.time())
  W=W+1
  for i=1,9 do
    for j=1,9 do
      Q=0
      repeat
        local Try = 0
        local CheckH = false
        local CheckV = false
        local CheckS = false
        Try = math.random(1,9)
        for iC:=1 to 9 do
          if B[iC,j]=Try then l1:=l1+1 end
        end
        for jC:=1 to 9 do
          if B[i,jC]=B[i,j] then l2:=l2+1 end
        end
        for iC:=1 to 3 do
          for jC:=1 to 3 do
            if ((1+3*(i1-1))<=i) and (i<=(1+3*(i1-1)+2)) and ((1+3*(j1-1))<=j) and (j<=(1+3*(j1-1)+2)) then Check3x3(i,j,1+3*(i1-1),1+3*(j1-1)) end
          end
        end
        --[[if ((1<=ii) and (ii<=3) and (1<=jj) and (jj<=3)) then Check3x3(1,1) else
        if ((1<=ii) and (ii<=3) and (4<=jj) and (jj<=6)) then Check3x3(1,4) else
        if ((1<=ii) and (ii<=3) and (7<=jj) and (jj<=9)) then Check3x3(1,7) else
        if ((4<=ii) and (ii<=6) and (1<=jj) and (jj<=3)) then Check3x3(4,1) else
        if ((4<=ii) and (ii<=6) and (4<=jj) and (jj<=6)) then Check3x3(4,4) else
        if ((4<=ii) and (ii<=6) and (7<=jj) and (jj<=9)) then Check3x3(4,7) else
        if ((7<=ii) and (ii<=9) and (1<=jj) and (jj<=3)) then Check3x3(7,1) else
        if ((7<=ii) and (ii<=9) and (4<=jj) and (jj<=6)) then Check3x3(7,4) else
        if ((7<=ii) and (ii<=9) and (7<=jj) and (jj<=9)) then Check3x3(7,7);]]
        Q:=Q+1;
        if Q=50 then goto Error;//Возрат в начало процедуры end
      until (l1=1) and (l2=1) and (l3=1);
    end
  end
  Form1.Edit1.Text:='Судоку сгенерировано с '+IntToStr(W)+' попытки';
end 
--]]
function sudoku.draw()
  for i=1,9 do
    for j=1,9 do
      love.graphics.draw(Narray[CurrentS[i][j]+1],0+50*(i-1),0+50*(j-1))
    end
  end
end

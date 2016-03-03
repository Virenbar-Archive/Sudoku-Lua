unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    Sudoku   : TStringGrid;
    PlayAgain: TButton;
    Edit1    : TEdit;
    Edit2    : TEdit;
    Dif      : TComboBox;
    Start    : TButton;
    DifText  : TStaticText;
    EndGameB : TButton;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SudokuClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure PlayAgainClick(Sender: TObject);
    procedure EndGameBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A        : array[1..9,1..9] of integer;
  B        : array[1..9,1..9] of integer;
  Form1    : TForm1;
  ii,jj    : integer;
  W,EP     : integer;
  l1,l2,l3 : integer;
implementation
{$R *.dfm}

function CharToInt(ch:char):integer;
begin
  CharToInt := ord(ch)-ord('0');
end;

procedure Check3x3(i,j,x,y:integer);
var
  i1,j1:integer;
begin
  for i1:=x to x+2 do
    for j1:=y to y+2 do
      if B[i,j]=B[i1,j1] then l3:=l3+1;
end;

procedure Generator();
var
  Q,i,j,i1,j1:integer;
label
  Error;
begin
  W:=0;
  Randomize();
  Error:
  W:=W+1;
  for i:=1 to 9 do
    for j:=1 to 9 do
      B[i,j]:=0;
  for i:=1 to 9 do
    for j:=1 to 9 do
      begin
        Q:=0;
        repeat
        begin
          l1:=0;
          l2:=0;
          l3:=0;
          B[i,j]:=random(9)+1;
          //Form1.Edit2.Text:=IntToStr(B[i,j]);
          for i1:=1 to 9 do
            if B[i1,j]=B[i,j] then l1:=l1+1;
          for j1:=1 to 9 do
            if B[i,j1]=B[i,j] then l2:=l2+1;
          for i1:=1 to 3 do
            for j1:=1 to 3 do
              if ((1+3*(i1-1))<=i) and (i<=(1+3*(i1-1)+2)) and ((1+3*(j1-1))<=j) and (j<=(1+3*(j1-1)+2)) then Check3x3(i,j,1+3*(i1-1),1+3*(j1-1));
          {if ((1<=ii) and (ii<=3) and (1<=jj) and (jj<=3)) then Check3x3(1,1) else
          if ((1<=ii) and (ii<=3) and (4<=jj) and (jj<=6)) then Check3x3(1,4) else
          if ((1<=ii) and (ii<=3) and (7<=jj) and (jj<=9)) then Check3x3(1,7) else
          if ((4<=ii) and (ii<=6) and (1<=jj) and (jj<=3)) then Check3x3(4,1) else
          if ((4<=ii) and (ii<=6) and (4<=jj) and (jj<=6)) then Check3x3(4,4) else
          if ((4<=ii) and (ii<=6) and (7<=jj) and (jj<=9)) then Check3x3(4,7) else
          if ((7<=ii) and (ii<=9) and (1<=jj) and (jj<=3)) then Check3x3(7,1) else
          if ((7<=ii) and (ii<=9) and (4<=jj) and (jj<=6)) then Check3x3(7,4) else
          if ((7<=ii) and (ii<=9) and (7<=jj) and (jj<=9)) then Check3x3(7,7);}
          Q:=Q+1;
          if Q=50 then goto Error;//Возрат в начало процедуры
        end;
        until (l1=1) and (l2=1) and (l3=1);
      end;
Form1.Edit1.Text:='Судоку сгенерировано с '+IntToStr(W)+' попытки';
end;

procedure EmptyS(x:integer);
var
  i,i1,j1:integer;
begin
  for i:=1 to x do
  begin
    i1:=random(9)+1;
    j1:=random(9)+1;
    A[i1,j1]:=0;
  end;
end;

procedure CreateS(x:integer);
var
  i,j:integer;
begin
  Generator();
  for i:=1 to 9 do
    for j:=1 to 9 do
      A[i,j]:=B[i,j];
  case x of
  1:EmptyS(5);
  2:EmptyS(20);
  3:EmptyS(40);
  4:EmptyS(70);
  end;
end;

//загрузка судоку и ответов
procedure Load(x:integer);
var
  T:TextFile;
  i,j:integer;
  buf:char;
begin
  case x of
    1:assign(T,'lvl1.txt');
    2:assign(T,'lvl2.txt');
    3:assign(T,'lvl3.txt');
    4:assign(T,'lvl4.txt');
    else assign(T,'lvl1.txt');
  end;
  reset(T);
  for i:=1 to 9 do
    for j:=1 to 9 do
      begin
        read(T,buf);
        A[i,j]:=CharToInt(buf);
      end;
  readln(T,buf);
  for i:=1 to 9 do
    for j:=1 to 9 do
      begin
        read(T,buf);
        B[i,j]:=CharToInt(buf);
      end;
  close(T);
end;

//Выбор сложности
procedure Select(x:integer);
begin
  case x of
    1:Load(1);
    2:Load(2);
    3:Load(3);
    4:Load(4);
    5:CreateS(1);
    6:CreateS(2);
    7:CreateS(3);
    8:CreateS(4);
  end;
end;

//Вывод
procedure Draw();
var
  i,j:integer;
begin
  for i:=1 to 9 do
    for j:=1 to 9 do
      begin
        Form1.Sudoku.Cells[j-1,i-1]:=(' '+IntToStr(A[i,j]));
        If A[i,j]=0 then Form1.Sudoku.Cells[j-1,i-1]:=(' ');
      end;
end;

//конец
procedure EndGame();
begin
  with Form1 do
  begin
    Edit1.Text:='Поздравляем';
    Edit2.Text:='Вы решили судоку';
    DifText.Caption:='Играть снова';
    Sudoku.Visible:=false;
    PlayAgain.Visible:=true;
  end;
end;

//проверка
procedure Check();
var
  i,j,k:integer;
begin
  k:=0;
  for i:=1 to 9 do
    for j:=1 to 9 do
      if A[i,j]=B[i,j] then k:=k+1;
  //if
  //Form1.Edit1.Text:='Осталось '+IntToStr(81-k)+' неправельных цифр';
  if k=81 then EndGame();
end;

//Ввод цифр
procedure TForm1.Edit2Change(Sender: TObject);
var
  S:integer;
begin
  if TryStrToInt(Form1.Edit2.Text,S)then
    if (S>=0) and (S<=9) then
    begin
      A[ii,jj]:=S;
      Draw();
      Check();
    end
    else ShowMessage('Только цифры');
end;

//Запуск игры
procedure StartGame();
begin
with Form1 do
  begin
  Sudoku.Visible:=false;
  Edit1.Text:=' ';
  Edit1.Visible:=false;
  Edit2.Text:=' ';
  Edit2.Visible:=false;
  Dif.Visible:=true;
  DifText.Caption:='Выберите сложность';
  DifText.Visible:=true;
  Start.Visible:=true;
  PlayAgain.Visible:=false;
  EndGameB.Visible:=false;
  end;
end;

//нажатие на клетку
procedure TForm1.SudokuClick(Sender: TObject);
begin
  ii:=Sudoku.Row+1;
  jj:=Sudoku.Col+1;
  Form1.Edit1.Text:='Вы выбрали '+IntToStr(ii)+' строку, '+IntToStr(jj)+' столбец';
  Form1.Edit2.Text:=IntToStr(A[ii,jj]);
end;

//Начало игры
procedure TForm1.StartClick(Sender: TObject);
begin
  Sudoku.Visible:=true;
  Edit1.Visible:=true;
  Edit2.Visible:=true;
  Dif.Visible:=false;
  DifText.Visible:=false;
  Start.Visible:=false;
  EndGameB.Visible:=true;
  Select(Dif.ItemIndex+1);
  Draw();
  Check();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EP:=0;
  StartGame();
end;

procedure TForm1.PlayAgainClick(Sender: TObject);
begin
  StartGame();
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
  EP:=EP+1;
  if EP<10 then ShowMessage('Зачем вы нажали Enter?') else
  if EP<11 then ShowMessage('Хватит нажимать на Enter!') else
  if EP<12 then ShowMessage('Тебе делать нечего!') else
  if EP<13 then ShowMessage('drbyd!') else
  if EP<14 then ShowMessage('Давай нажми ещё раз!') else
  if EP<15 then Application.Terminate;
  end;
end;
{
400*320
120+80+120
90+140+90
15+290+15
}

procedure TForm1.EndGameBClick(Sender: TObject);
begin
  EndGame();
end;

end.

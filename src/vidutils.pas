unit VidUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Crt, termio, baseunix, unix;

procedure TextOut(X, Y: integer; Text: string);
procedure TextOutCentered(Lines: array of const);
procedure ClearScreen;
procedure RefreshWindowSize;

implementation

procedure TextOut(X, Y: integer; Text: string);
begin
  GotoXY(X, Y);
  Write(Text);
end;

procedure TextOutCentered(Lines: array of const);
var
  I, X, Y: integer;
  Line: string;
begin
  for I := Low(Lines) to High(Lines) do
  begin
    Line := string(Lines[I].VString);
    X := Round((ScreenWidth / 2) - (Length(Line) / 2));
    Y := Round(ScreenHeight / 2) + I - 1;
    TextOut(X, Y, Line);
  end;
  GotoXY(ScreenWidth, ScreenHeight);
end;

procedure ClearScreen;
var
  Y: integer;
begin
  for Y := ScreenHeight downto 1 do
  begin
    GotoXY(1, Y);
    ClrEol;
  end;
end;

procedure RefreshWindowSize;
{ This procedure is based on GetConsoleBuf of the Crt Unit }
var
  WinInfo: TWinSize;
begin
  fpIOCtl(TextRec(Output).Handle, TIOCGWINSZ, @Wininfo);
  if (Wininfo.ws_col = ScreenWidth) and (Wininfo.ws_row = ScreenHeight) then
    Exit;

  ScreenWidth := Wininfo.ws_col;
  ScreenHeight := Wininfo.ws_row;
  FreeMem(ConsoleBuf);
  GetMem(ConsoleBuf, ScreenHeight * ScreenWidth * 2);
  FillChar(ConsoleBuf^, ScreenHeight * ScreenWidth * 2, 0);
  Window(1, 1, ScreenWidth, ScreenHeight);
end;

end.

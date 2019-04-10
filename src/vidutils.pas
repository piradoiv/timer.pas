unit VidUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Crt, termio, baseunix, unix;

procedure ClearScreen;
procedure RefreshWindowSize;
procedure TextOut(X, Y: integer; Text: string);
procedure TextOutCentered(Lines: array of const);

implementation

//-----------------------------------------------------------------------------
// While there is a ClrScr method in the Crt package, this one doesn't
// adds garbage to the terminal history, specially in programs that
// are refreshing the screen constantly, like games
//-----------------------------------------------------------------------------
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

//-----------------------------------------------------------------------------
// This procedure is based on GetConsoleBuf of the Crt Unit, it's being
// used to handle the window resize
//-----------------------------------------------------------------------------
procedure RefreshWindowSize;
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

//-----------------------------------------------------------------------------
// Helper procedure to print a text directly in an specific position
//-----------------------------------------------------------------------------
procedure TextOut(X, Y: integer; Text: string);
begin
  GotoXY(X, Y);
  Write(Text);
end;

//-----------------------------------------------------------------------------
// Prints a multi-line message centered on screen
//-----------------------------------------------------------------------------
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

end.

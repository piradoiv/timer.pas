unit Views;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Crt, Numbers, Math, StrUtils, VidUtils;

procedure DrawTimer(AvailableSeconds: integer);

implementation

//-----------------------------------------------------------------------------
// The timer will be shown using different colors based on how
// much time we have left. Green by default, then it will alternate
// with yellow under 10 seconds, and red on negative numbers
//-----------------------------------------------------------------------------
procedure PrepareColor(var AvailableSeconds: integer);
var
  Color: word;
begin
  Color := Green;
  if (AvailableSeconds <= 10) and (AvailableSeconds mod 2 = 0) then
    Color := Brown;
  if AvailableSeconds < 0 then
    Color := Red;
  TextColor(Color);
  TextBackground(Color);
end;

//-----------------------------------------------------------------------------
// This will convert the amount of seconds available into a 00:00 kind of
// string
//
// TODO: Refactor this :)
//-----------------------------------------------------------------------------
function GetMessageFromAvailableSeconds(var AvailableSeconds: integer): string;
var
  Seconds: string;
  Minutes: string;
begin
  Minutes := ReplaceStr(IntToStr(Floor(AvailableSeconds / 60)), '-', '');
  if AvailableSeconds < 0 then
    Minutes := ReplaceStr(IntToStr(Ceil(AvailableSeconds / 60)), '-', '');
  Seconds := ReplaceStr(IntToStr(AvailableSeconds mod 60), '-', '');
  Minutes := AddChar('0', Minutes, 2);
  Seconds := AddChar('0', Seconds, 2);
  Result := Format('%s:%s', [Minutes, Seconds]);
  if AvailableSeconds < 0 then
    Result := Concat('-', Result);
end;

//-----------------------------------------------------------------------------
// This function maps a char to its equivalent fake font char
//-----------------------------------------------------------------------------
function MapCharacterToFontCharacter(const Character: char): string;
begin
  case Character of
    ':': Result := COLON;
    '-': Result := MINUS;
    '0': Result := ZERO;
    '1': Result := ONE;
    '2': Result := TWO;
    '3': Result := THREE;
    '4': Result := FOUR;
    '5': Result := FIVE;
    '6': Result := SIX;
    '7': Result := SEVEN;
    '8': Result := EIGHT;
    '9': Result := NINE;
    else
      Result := SPACE;
  end;
end;

//-----------------------------------------------------------------------------
// This is the procedure that actually draws each char to the screen, it
// also does its best to center the message
//
// TODO: This must be refactored removing the magic numbers if
//       we want to add more fonts
//-----------------------------------------------------------------------------
procedure DrawTimerUsingFont(const Message: string; const AvailableSeconds: integer);
var
  FontChar: string;
  OffsetX, OffsetY: integer;
  X, Y, I, J: integer;
begin
  OffsetX := Round((ScreenWidth / 2)) - Round((Length(Message) * 7) / 2) + 2;
  OffsetY := Round((ScreenHeight / 2)) - 4;
  if AvailableSeconds < 0 then
    Dec(OffsetX, 4);

  for I := 1 to Length(Message) do
  begin
    FontChar := MapCharacterToFontCharacter(Message[I]);
    for J := 1 to 60 do
    begin
      if FontChar[J] <> '1' then
        Continue;

      X := ((I - 1) * 7) + ((J - 1) mod 6);
      Y := Floor((J - 1) / 6);
      GotoXY(OffsetX + X, OffsetY + Y);
      Write(' ');
    end;
  end;
end;

//-----------------------------------------------------------------------------
// The public draw procedure. It delegates the hard work to the other
// procedures
//-----------------------------------------------------------------------------
procedure DrawTimer(AvailableSeconds: integer);
var
  Message: string;
begin
  RefreshWindowSize;
  TextBackground(Black);
  ClearScreen;
  PrepareColor(AvailableSeconds);
  Message := GetMessageFromAvailableSeconds(AvailableSeconds);
  DrawTimerUsingFont(Message, AvailableSeconds);
  GotoXY(1, ScreenHeight);
end;

end.

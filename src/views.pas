unit Views;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Crt, Numbers, Math, StrUtils, VidUtils;

procedure DrawTimer(AvailableSeconds: integer);

implementation

procedure DrawTimer(AvailableSeconds: integer);
var
  Color, Background: Word;
  Message: string;
  I, J, X, Y: integer;
  Minutes, Seconds: string;
  OffsetX, OffsetY: integer;
  Current: char;
  Character: string;
begin
  RefreshWindowSize;
  Color := Green;
  Background := Black;
  if AvailableSeconds <= 10 then
  begin
    Color := Brown;
    if AvailableSeconds mod 2 = 1 then
      Color := Green;
  end;

  if AvailableSeconds < 0 then
    Color := Red;

  TextColor(Color);
  TextBackground(Background);
  ClearScreen;
  TextBackground(Color);

  Minutes := ReplaceStr(IntToStr(Floor(AvailableSeconds / 60)), '-', '');
  if AvailableSeconds < 0 then
    Minutes := ReplaceStr(IntToStr(Ceil(AvailableSeconds / 60)), '-', '');
  Seconds := ReplaceStr(IntToStr(AvailableSeconds mod 60), '-', '');
  Minutes := AddChar('0', Minutes, 2);
  Seconds := AddChar('0', Seconds, 2);
  Message := Format('%s:%s', [Minutes, Seconds]);
  if AvailableSeconds < 0 then
    Message := Concat('-', Message);

  OffsetX := Round((ScreenWidth / 2)) - Round((Length(Message) * 7) / 2) + 2;
  if AvailableSeconds < 0 then
    Dec(OffsetX, 4);
  OffsetY := Round((ScreenHeight / 2)) - 4;

  for I := 1 to Length(Message) do
  begin
    Current := Message[I];
    case Current of
    ':': Character := COLON;
    '-': Character := MINUS;
    '0': Character := ZERO;
    '1': Character := ONE;
    '2': Character := TWO;
    '3': Character := THREE;
    '4': Character := FOUR;
    '5': Character := FIVE;
    '6': Character := SIX;
    '7': Character := SEVEN;
    '8': Character := EIGHT;
    '9': Character := NINE;
    end;

    for J := 1 to 60 do
    begin
      X := ((I - 1) * 7) + ((J - 1) mod 6);
      Y := Floor((J - 1) / 6);

      GotoXY(OffsetX + X, OffsetY + Y);
      if Character[J] = '1' then
        Write(' ');
    end;
  end;

  TextColor(Black);
  TextBackground(Black);
  GotoXY(1, ScreenHeight);
end;

end.


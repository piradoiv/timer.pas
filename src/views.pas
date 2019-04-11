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
//-----------------------------------------------------------------------------
function GetMessageFromAvailableSeconds(var AvailableSeconds: integer): string;
var
  Minutes, Seconds: integer;
  MinutesString, SecondsString: string;
begin
  DivMod(AvailableSeconds, 60, Minutes, Seconds);
  MinutesString := AddChar('0', IntToStr(Abs(Minutes)), 2);
  SecondsString := AddChar('0', IntToStr(Abs(Seconds)), 2);
  Result := Format('%s:%s', [MinutesString, SecondsString]);
  if AvailableSeconds < 0 then
    Result := Concat('-', Result);
end;

//-----------------------------------------------------------------------------
// This is the procedure that actually draws each char to the screen, it
// also does its best to center the message
//-----------------------------------------------------------------------------
procedure WriteUsingFont(const Message: string; Font: TFont);
var
  FontCharString: string;
  OffsetX, OffsetY: integer;
  X, Y, I, J: integer;
begin
  OffsetX := Round((ScreenWidth / 2) - (Length(Message) * Font.GetWidth + 1) / 2);
  OffsetY := Round((ScreenHeight / 2) - (Font.GetHeight / 2));

  for I := 1 to Length(Message) do
  begin
    FontCharString := Font.GetForChar(Message[I]);
    for J := 1 to Font.GetWidth * Font.GetHeight do
    begin
      if FontCharString[J] <> '1' then
        Continue;

      X := ((I - 1) * (Font.GetWidth + 1)) + ((J - 1) mod Font.GetWidth);
      Y := Floor((J - 1) / Font.GetWidth);
      TextOut(OffsetX + X, OffsetY + Y, Message[I]);
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
  Font: TFont;
begin
  RefreshWindowSize;
  TextBackground(Black);
  ClearScreen;
  PrepareColor(AvailableSeconds);
  Message := AddChar(' ', GetMessageFromAvailableSeconds(AvailableSeconds), 6) + ' ';

  if (ScreenWidth > 6 * 8) and (ScreenHeight > 12) then
    Font := TBigFont.Create
  else
    Font := TMediumFont.Create;

  WriteUsingFont(Message, Font);
  if Assigned(Font) then
    FreeAndNil(Font);

  GotoXY(1, ScreenHeight);
end;

end.

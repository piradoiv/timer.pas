unit Numbers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TFont = class
    function GetWidth: integer; virtual; abstract;
    function GetHeight: integer; virtual; abstract;
    function GetForChar(const Character: char): string; virtual; abstract;
  end;

  TBigFont = class(TFont)
    function GetWidth: integer; override;
    function GetHeight: integer; override;
    function GetForChar(const Character: char): string; override;
  end;

  TMediumFont = class(TFont)
    function GetWidth: integer; override;
    function GetHeight: integer; override;
    function GetForChar(const Character: char): string; override;
  end;

implementation

function TMediumFont.GetWidth: integer;
begin
  Result := 3;
end;

function TMediumFont.GetHeight: integer;
begin
  Result := 5;
end;

function TMediumFont.GetForChar(const Character: char): string;
begin
  case Character of
  ':': Result := '000010000010000';
  '-': Result := '000000111000000';
  '0': Result := '111101101101111';
  '1': Result := '010010010010010';
  '2': Result := '111001111100111';
  '3': Result := '111001111001111';
  '4': Result := '101101111001001';
  '5': Result := '111100111001111';
  '6': Result := '111100111101111';
  '7': Result := '111001001001001';
  '8': Result := '111101111101111';
  '9': Result := '111101111001001';
  else Result := '000000000000000';
  end;
end;

function TBigFont.GetWidth: integer;
begin
  Result := 6;
end;

function TBigFont.GetHeight: integer;
begin
  Result := 10;
end;

function TBigFont.GetForChar(const Character: char): string;
begin
  case Character of
  ':': Result := '000000001100001100000000000000000000000000001100001100000000';
  '-': Result := '000000000000000000000000111111111111000000000000000000000000';
  '0': Result := '111111111111110011110011110011110011110011110011111111111111';
  '1': Result := '001100001100001100001100001100001100001100001100001100001100';
  '2': Result := '111111111111000011000011111111111111110000110000111111111111';
  '3': Result := '111111111111000011000011111111111111000011000011111111111111';
  '4': Result := '110011110011110011110011111111111111000011000011000011000011';
  '5': Result := '111111111111110000110000111111111111000011000011111111111111';
  '6': Result := '111111111111110000110000111111111111110011110011111111111111';
  '7': Result := '111111111111000011000011000011000011000011000011000011000011';
  '8': Result := '111111111111110011110011111111111111110011110011111111111111';
  '9': Result := '111111111111110011110011111111111111000011000011000011000011';
  else Result := '000000000000000000000000000000000000000000000000000000000000';
  end;
end;

end.


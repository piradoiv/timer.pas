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

  { TBigFont }

  TBigFont = class(TFont)
    function GetWidth: integer; override;
    function GetHeight: integer; override;
    function GetForChar(const Character: char): string; override;
  end;

implementation

{ TFont }

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


program TimerProject;

uses
  SysUtils,
  Classes,
  CustApp,
  DateUtils,
  Views,
  Crt,
  VidUtils;

const
  DEFAULT_AMOUNT = 25 * 60;
  VK_ESC = #27;
  VK_ENTER = #13;

  procedure Cleanup;
  begin
    while KeyPressed do
      ReadKey;
    NormVideo;
    ClearScreen;
  end;

var
  StartTime: TDateTime;
  Previous, TimerSeconds, AvailableSeconds, ElapsedSeconds: integer;
  ScreenSize: TScreenSize;
  PreviousPixels, CurrentPixels: integer;
  Finished: boolean;
begin
  StartTime := Now;
  Finished := False;
  Previous := 0;
  PreviousPixels := 0;

  TimerSeconds := DEFAULT_AMOUNT;
  if ParamCount = 1 then
    TimerSeconds := Round(StrToFloat(ParamStr(1)) * 60);

  repeat
    repeat
      ElapsedSeconds := SecondsBetween(Now, StartTime);
      AvailableSeconds := TimerSeconds - ElapsedSeconds;
      ScreenSize := GetScreenSize;
      CurrentPixels := ScreenSize.Width * ScreenSize.Height;
      if (Previous <> AvailableSeconds) or (PreviousPixels <> CurrentPixels) then
        DrawTimer(AvailableSeconds);
      Previous := AvailableSeconds;
      PreviousPixels := ScreenWidth * ScreenHeight;
      Sleep(40);
    until KeyPressed;

    while KeyPressed do
      case ReadKey of
        'q': Finished := True;
        VK_ESC: Finished := True;
        VK_ENTER: StartTime := Now;
      end;
  until Finished;

  Cleanup;
end.

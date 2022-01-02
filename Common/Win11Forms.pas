{ *********************************************************************** }
{                                                                         }
{    Win11Forms 单元                                                      }
{                                                                         }
{   设计：Lsuper 2022.01.01                                               }
{   备注：                                                                }
{   参考：https://github.com/marcocantu/DelphiSessions Win11Forms.pas     }
{                                                                         }
{   Copyright (c) 1998-2022 Super Studio                                  }
{                                                                         }
{ *********************************************************************** }

unit Win11Forms;

interface

uses
  System.SysUtils, Winapi.Windows, VCL.Forms;

type
  TRoundedCornerType = (
    rcDefault, // Windows default or global app setting
    rcOff,     // disabled
    rcOn,      // active
    rcSmall    // active small size
  );

  TForm = class(VCL.Forms.TForm)
  private
    FRoundedCorners: TRoundedCornerType;
    FTitleDarkMode: Boolean;
  private
    class var FDefaultRoundedCorners: TRoundedCornerType;
  private
    function  GetFormCornerPreference: Integer;
    procedure SetRoundedCorners(const Value: TRoundedCornerType);
    procedure SetTitleDarkMode(const Value: Boolean);
    procedure UseImmersiveDarkMode(AHandle: HWND; AEnabled: Boolean);
  private
    procedure UpdateRoundedCorners;
    procedure UpdateTitleDarkMode;
  protected
    procedure CreateWnd; override;
  public
    class property DefaultRoundedCorners: TRoundedCornerType
      read FDefaultRoundedCorners write FDefaultRoundedCorners;

    property  RoundedCorners: TRoundedCornerType
      read FRoundedCorners write SetRoundedCorners;
    property  TitleDarkMode: Boolean
      read FTitleDarkMode write SetTitleDarkMode;
  end;

implementation

uses
  Winapi.Dwmapi;

const
  DWMWCP_DEFAULT        = 0; // Let the system decide whether or not to round window corners (default)
  DWMWCP_DONOTROUND     = 1; // Never round window corners
  DWMWCP_ROUND          = 2; // Round the corners if appropriate
  DWMWCP_ROUNDSMALL     = 3; // Round the corners if appropriate, with a small radius

{ TForm }

procedure TForm.CreateWnd;
begin
  inherited;
  UpdateRoundedCorners;
  UpdateTitleDarkMode;
end;

function TForm.GetFormCornerPreference: Integer;

  function RoundedCornerPreference(ACornerType: TRoundedCornerType): Integer;
  begin
    case ACornerType of
      rcOff: Result := DWMWCP_DONOTROUND;
      rcOn: Result := DWMWCP_ROUND;
      rcSmall: Result := DWMWCP_ROUNDSMALL;
    else
      Result := DWMWCP_DEFAULT;
    end;
  end;
begin
  if FRoundedCorners = rcDefault then
    Result := RoundedCornerPreference(FDefaultRoundedCorners)
  else Result := RoundedCornerPreference(FRoundedCorners);
end;

procedure TForm.SetRoundedCorners(const Value: TRoundedCornerType);
begin
  FRoundedCorners := Value;
  UpdateRoundedCorners;
end;

procedure TForm.SetTitleDarkMode(const Value: Boolean);
begin
  FTitleDarkMode := Value;
  UpdateTitleDarkMode;
end;

procedure TForm.UpdateRoundedCorners;
const
  DWMWA_WINDOW_CORNER_PREFERENCE = 33; // WINDOW_CORNER_PREFERENCE controls the policy that rounds top-level window corners
var
  CornerPreference: Integer;
begin
  if HandleAllocated then
  begin
    CornerPreference := GetFormCornerPreference;
    Winapi.Dwmapi.DwmSetWindowAttribute(Handle, DWMWA_WINDOW_CORNER_PREFERENCE, @CornerPreference, SizeOf(CornerPreference));
  end;
end;

procedure TForm.UpdateTitleDarkMode;
begin
  if HandleAllocated then
  begin
    UseImmersiveDarkMode(Handle, FTitleDarkMode);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//设计：Lsuper 2021.12.10
//功能：
//参数：
//参考：https://stackoverflow.com/questions/57124243/winforms-dark-title-bar-on-windows-10
////////////////////////////////////////////////////////////////////////////////
procedure TForm.UseImmersiveDarkMode(AHandle: HWND; AEnabled: Boolean);
const
  DWMWA_USE_IMMERSIVE_DARK_MODE_BEFORE_20H1 = 19;
  DWMWA_USE_IMMERSIVE_DARK_MODE             = 20;
var
  AB: Integer;
  DM: Integer;
begin
  if CheckWin32Version(10) and (TOSVersion.Build >= 17763) then
  begin
    AB := DWMWA_USE_IMMERSIVE_DARK_MODE_BEFORE_20H1;
    if TOSVersion.Build >= 18985 then
      AB := DWMWA_USE_IMMERSIVE_DARK_MODE;
    if AEnabled then
      DM := 1
    else DM := 0;
    Winapi.Dwmapi.DwmSetWindowAttribute(AHandle, AB, @DM, SizeOf(DM));
  end;
end;

end.

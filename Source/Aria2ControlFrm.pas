{ *********************************************************************** }
{                                                                         }
{   AriaNg WKE 自动化浏览器项目单元                                       }
{                                                                         }
{   设计：Lsuper 2017.09.11                                               }
{   备注：                                                                }
{   审核：                                                                }
{                                                                         }
{   Copyright (c) 1998-2022 Super Studio                                  }
{                                                                         }
{ *********************************************************************** }

unit Aria2ControlFrm;

interface

uses
  System.SysUtils, Winapi.Messages, Vcl.Forms, Langji.Wke.Webbrowser, Win11Forms,
  Aria2LocalStorage;

const
  UM_FILE_MONITOR       = WM_USER + 100;

type
  TAria2ControlForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLocalStorage: TAria2LocalStorage;
    FWebBrowser: TWkeWebBrowser;
    FLastTheme: string;
  private
    function  CompareVersion(const AVer1, AVer2: string): Integer;
    function  CheckAriaNgFileBuild(const AFile: string): Boolean;
    procedure ExtractAriaNgFile(const AFile: string);
    procedure ReloadLocalStorage;
  private
    procedure WkeWebBrowser1TitleChange(Sender: TObject; sTitle: string);
  protected
    procedure UMFileMonitor(var Message: TMessage); message UM_FILE_MONITOR;
  end;

var
  Aria2ControlForm: TAria2ControlForm;

implementation

{$R *.dfm}
{$R *.res} { index.html }

uses
  System.Classes, System.StrUtils, System.Types, Vcl.Controls, Langji.Wke.Lib,
  Aria2FileMonitor;

const
  defAriaNgFileOpenTag  = 'buildVersion:"v';
  defAriaNgFileCloseTag = '"';
  defAriaNgFileBuild    = '1.2.5';

  defAriaNgDarkMode     = 'dark';

  defLocalFilePathFmt   = '%s\%s';

  defWkeEngineFileName  = 'WKE.dll';

  defWkeStoragePathName = 'LocalStorage';
  defWkeStorageFileName = 'file.localstorage';

{ TAria2ControlForm }

function TAria2ControlForm.CheckAriaNgFileBuild(const AFile: string): Boolean;
var
  P1, P2: Integer;
  S: string;
begin
  Result := False;
  S := TAria2LocalStorage.LoadDataFromFile(AFile, TEncoding.UTF8, 512 * 1024);
  P1 := Pos(defAriaNgFileOpenTag, S);
  if P1 = 0 then
    Exit;
  Inc(P1, Length(defAriaNgFileOpenTag));
  P2 := PosEx(defAriaNgFileCloseTag, S, P1);
  if P2 = 0 then
    Exit;
  S := Copy(S, P1, P2 - P1);
  Result := CompareVersion(S, defAriaNgFileBuild) >= 0;
end;

function TAria2ControlForm.CompareVersion(const AVer1, AVer2: string): Integer;
type
  TFileVerRec = array[0..3] of Integer;

  function DecodeVersion(const AVerStr: string): TFileVerRec;
  var
    C, I: Integer;
    L: TStrings;
    S: string;
  begin
    FillChar(Result, SizeOf(TFileVerRec), 0);
    if AVerStr = '' then
      Exit;
    L := TStringList.Create;
    with L do
    try
      Delimiter := '.';
      DelimitedText := AVerStr;
      if L.Count > 4 then
        C := 4
      else C := L.Count;
      for I := 0 to C - 1 do
      begin
        S := Trim(L.Strings[I]);
        Result[I] := StrToIntDef(S, 0);
      end;
    finally
      Free;
    end;
  end;
var
  I: Integer;
  R1, R2: TFileVerRec;
begin
  R1 := DecodeVersion(AVer1);
  R2 := DecodeVersion(AVer2);
  for I := Low(TFileVerRec) to High(TFileVerRec) do
  begin
    Result := R1[I] - R2[I];
    if Result <> 0 then
      Exit;
  end;
  Result := 0;
end;

procedure TAria2ControlForm.ExtractAriaNgFile(const AFile: string);
var
  F: string;
  S: TResourceStream;
begin
  F := ExtractFileDir(AFile);
  if not DirectoryExists(F) then
    ForceDirectories(F);
  if not DirectoryExists(F) then
    Exit;
  S := TResourceStream.Create(HInstance, 'INDEX', RT_RCDATA);
  with TFileStream.Create(AFile, fmCreate) do
  try
    CopyFrom(S, S.Size);
  finally
    Free;
    S.Free;
  end;
end;

procedure TAria2ControlForm.FormCreate(Sender: TObject);
var
  S: string;
begin
  S := GetModuleName(0);
  S := ExtractFileDir(S);

  wkeLibFileName := Format(defLocalFilePathFmt, [S, defWkeEngineFileName]);

  FWebBrowser := TWkeWebBrowser.Create(Self);
  FWebBrowser.Parent := Self;
  FWebBrowser.Align := alClient;

  S := Format(defLocalFilePathFmt, [S, defWkeStoragePathName]);
  if not DirectoryExists(S) then
    ForceDirectories(S);
  FWebBrowser.CookiePath := S;
  FWebBrowser.CookieEnabled := True;
  FWebBrowser.LocalStoragePath := S;

  FWebBrowser.OnTitleChange := WkeWebBrowser1TitleChange;

  Self.RoundedCorners := rcOff;

  S := Format(defLocalFilePathFmt, [S, defWkeStorageFileName]);
  FLocalStorage := TAria2LocalStorage.Create(S);

  FLastTheme := '';
  ReloadLocalStorage;

  InstallFileMonitor(defWkeStorageFileName, Self.Handle, UM_FILE_MONITOR);
end;

procedure TAria2ControlForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLocalStorage);
end;

procedure TAria2ControlForm.FormShow(Sender: TObject);
var
  F: string;
begin
  F := GetModuleName(0);
  F := ExtractFilePath(F);
  F := F + 'App\index.html';
  if not FileExists(F) or not CheckAriaNgFileBuild(F) then
    ExtractAriaNgFile(F);
  if FileExists(F) then
    FWebBrowser.LoadFile(F);
  FWebBrowser.ZoomFactor := Screen.PixelsPerInch / 96;
  EnableFileMonitor(True);
end;

procedure TAria2ControlForm.ReloadLocalStorage;
var
  S: string;
begin
  S := FLocalStorage.GetOptions('theme');
  if S <> FLastTheme then
  begin
    FLastTheme := S;
    Self.TitleDarkMode := S = defAriaNgDarkMode;
  end;
end;

procedure TAria2ControlForm.UMFileMonitor(var Message: TMessage);
begin
  EnableFileMonitor(False);
  try
    ReloadLocalStorage;
  finally
    EnableFileMonitor(True);
  end;
end;

procedure TAria2ControlForm.WkeWebBrowser1TitleChange(Sender: TObject; sTitle: string);
begin
  Caption := sTitle;
end;

end.

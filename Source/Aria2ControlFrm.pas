{ *********************************************************************** }
{                                                                         }
{   AriaNg WKE 自动化浏览器项目单元                                       }
{                                                                         }
{   设计：Lsuper 2017.09.11                                               }
{   备注：                                                                }
{   审核：                                                                }
{                                                                         }
{   Copyright (c) 1998-2023 Super Studio                                  }
{                                                                         }
{ *********************************************************************** }

unit Aria2ControlFrm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Langji.Wke.Types, Langji.Wke.Webbrowser, Win11Forms;

type
  TAria2ControlForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLastTheme: string;
    FWebBrowser: TWkeWebBrowser;
  private
    function  CheckAriaNgFileBuild(const AFileName: string): Boolean;
    function  CompareVersion(const AVer1, AVer2: string): Integer;
    function  LoadAriaNgBuildFromStream(AStream: TStream): string;
    procedure ExtractAriaNgFile(const AFile: string);
    procedure ParseOptionEvent(const AEvent: string);
  private
    procedure WebBrowserAlertBox(Sender: TObject; sMsg: string);
    procedure WebBrowserLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
    procedure WebBrowserTitleChange(Sender: TObject; sTitle: string);
  end;

var
  Aria2ControlForm: TAria2ControlForm;

implementation

{$R *.dfm}
{$R *.res} { index.html }

uses
  System.StrUtils, Winapi.Windows, Vcl.Controls, JsonDataObjects, Langji.Wke.Lib;

const
  defAriaNgDarkMode     = 'dark';

  defLocalFilePathFmt   = '%s\%s';

  defWkeAria2FileName   = 'App\index.html';
  defWkeEngineFileName  = 'WKE.dll';
  defWkeStoragePathName = 'LocalStorage';

{ TAria2ControlForm }

function TAria2ControlForm.CheckAriaNgFileBuild(const AFileName: string): Boolean;
var
  FS, RS: TStream;
  FV, RV: string;
begin
  Result := False;
  if not FileExists(AFileName) then
    Exit;
  FS := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    RS := TResourceStream.Create(HInstance, 'INDEX', RT_RCDATA);
    try
      FV := LoadAriaNgBuildFromStream(FS);
      RV := LoadAriaNgBuildFromStream(RS);
      Result := CompareVersion(FV, RV) >= 0;
    finally
      RS.Free;
    end;
  finally
    FS.Free;
  end;
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
  F: string;
begin
  F := GetModuleName(0);
  F := ExtractFileDir(F);
  wkeLibFileName := Format(defLocalFilePathFmt, [F, defWkeEngineFileName]);

  FWebBrowser := TWkeWebBrowser.Create(Self);
  FWebBrowser.Parent := Self;
  FWebBrowser.Align := alClient;

  F := Format(defLocalFilePathFmt, [F, defWkeStoragePathName]);
  if not DirectoryExists(F) then
    ForceDirectories(F);
  FWebBrowser.CookiePath := F;
  FWebBrowser.CookieEnabled := True;
  FWebBrowser.LocalStoragePath := F;

  FWebBrowser.OnAlertBox := WebBrowserAlertBox;
  FWebBrowser.OnLoadEnd := WebBrowserLoadEnd;
  FWebBrowser.OnTitleChange := WebBrowserTitleChange;

  Self.RoundedCorners := rcOff;
end;

procedure TAria2ControlForm.FormShow(Sender: TObject);
var
  F: string;
begin
  F := GetModuleName(0);
  F := ExtractFilePath(F);
  F := F + defWkeAria2FileName;
  if not FileExists(F) or not CheckAriaNgFileBuild(F) then
    ExtractAriaNgFile(F);
  if FileExists(F) then
    FWebBrowser.LoadFile(F);
  FWebBrowser.ZoomFactor := Screen.PixelsPerInch / 96;
end;

function TAria2ControlForm.LoadAriaNgBuildFromStream(AStream: TStream): string;

  function ExtractAriaNgBuild(const AData: string): string;
  const
    defAriaNgFileOpenTag  = 'buildVersion:"v';
    defAriaNgFileCloseTag = '"';
  var
    P1, P2: Integer;
  begin
    P1 := Pos(defAriaNgFileOpenTag, AData);
    if P1 = 0 then
      Exit;
    Inc(P1, Length(defAriaNgFileOpenTag));
    P2 := PosEx(defAriaNgFileCloseTag, AData, P1);
    if P2 = 0 then
      Exit;
    Result := Copy(AData, P1, P2 - P1);
  end;

  function ExtractAriaNgPartData(AStream: TStream): string;
  var
    SR: TTextReader;
  begin
    Result := '';
    SR := TStreamReader.Create(AStream, TEncoding.UTF8, False, 512 * 1024);
    with SR do
    try
      Result := ReadToEnd;
    finally
      Free;
    end;
  end;
var
  S: string;
begin
  Assert(AStream <> nil);
  S := ExtractAriaNgPartData(AStream);
  Result := ExtractAriaNgBuild(S);
end;

procedure TAria2ControlForm.ParseOptionEvent(const AEvent: string);
var
  R: TJsonBaseObject;
  S: string;
begin
  R := TJsonObject.Parse(AEvent);
  try
    if not (R is TJsonObject) then
      Exit;
    S := TJsonObject(R).S['key'];
    if S <> 'AriaNg.Options' then
      Exit;
    S := TJsonObject(R).S['value'];
  finally
    R.Free;
  end;
  R := TJsonObject.Parse(S);
  try
    if not (R is TJsonObject) then
      Exit;
    S := TJsonObject(R).S['theme'];
  finally
    R.Free;
  end;
  if S <> FLastTheme then
  begin
    FLastTheme := S;
    Self.TitleDarkMode := S = defAriaNgDarkMode;
  end;
end;

procedure TAria2ControlForm.WebBrowserAlertBox(Sender: TObject; sMsg: string);
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugString(PChar('WebBrowserAlertBox: ' + AMessage));
{$ENDIF}
  ParseOptionEvent(sMsg);
end;

procedure TAria2ControlForm.WebBrowserLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
var
  S: string;
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugString(PChar('WebBrowserLoadEnd: ' + IntToStr(Ord(loadresult))));
{$ENDIF}
  if loadresult <> WKE_LOADING_SUCCEEDED then
    Exit;

  S := 'var ge = new Event("setItemEvent");' +
    'ge.key = "AriaNg.Options";' +
    'ge.value = localStorage.getItem("AriaNg.Options");' +
    'alert(JSON.stringify(ge));';
  FWebBrowser.ExecuteJavascript(S);

  S := 'var orignalSetItem = localStorage.setItem;' +
    'localStorage.setItem = function(key,newValue) {' +
    'var se = new Event("setItemEvent");' +
    'se.key = key;' +
    'se.value = newValue;' +
    'alert(JSON.stringify(se));' +
    'orignalSetItem.apply(this,arguments);' +
  '};';
  FWebBrowser.ExecuteJavascript(S);
end;

procedure TAria2ControlForm.WebBrowserTitleChange(Sender: TObject; sTitle: string);
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugString(PChar('WebBrowserTitleChange: ' + sTitle));
{$ENDIF}
  Caption := sTitle;
end;

end.

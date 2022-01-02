{ *********************************************************************** }
{                                                                         }
{   Aria 配置单元                                                         }
{                                                                         }
{   设计：Lsuper 2022.01.01                                               }
{   备注：                                                                }
{   审核：                                                                }
{                                                                         }
{   Copyright (c) 1998-2022 Super Studio                                  }
{                                                                         }
{ *********************************************************************** }

unit Aria2LocalStorage;

interface

uses
  System.SysUtils;

type
  TAria2LocalStorage = class(TObject)
  private
    FFileName: string;
  private
    function  ExtractConfigData(const AFileName, ATag: string;
      out AConfig: string): Boolean;
    function  ExtractConfigItem(const AConfig, AName: string;
      out AValue: string): Boolean;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;

    function  GetOptions(const AName: string): string;

    property  FileName: string
      read FFileName;
  end;

implementation

uses
  System.Classes, System.StrUtils, JsonDataObjects;

{ TAria2LocalStorage }

constructor TAria2LocalStorage.Create(const AFileName: string);
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugMessage('%s.Create', [ClassName]);
{$ENDIF}
  FFileName := AFileName;
end;

destructor TAria2LocalStorage.Destroy;
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugMessage('%s.Destroy', [ClassName]);
{$ENDIF}
  inherited;
end;

function TAria2LocalStorage.ExtractConfigData(const AFileName, ATag: string;
  out AConfig: string): Boolean;
const
  defWkeStorageOpenTag  = '--mb-sep--';
  defWkeStorageCloseTag = '--mb-sep--';
var
  P1, P2: Integer;
  M, S: string;
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugMessage('%s.ExtractConfigData', [ClassName]);
{$ENDIF}
  Result := False;
  with TStreamReader.Create(AFileName, TEncoding.UTF8, True) do
  try
    S := ReadToEnd;
  finally
    Free;
  end;
  M := ATag + defWkeStorageOpenTag;
  P1 := Pos(M, S);
  if P1 = 0 then
    Exit;
  Inc(P1, Length(M));
  M := defWkeStorageCloseTag;
  P2 := PosEx(M, S, P1);
  if P2 = 0 then
    Exit;
  AConfig := Copy(S, P1, P2 - P1);
  Result := True;
end;

function TAria2LocalStorage.ExtractConfigItem(const AConfig, AName: string;
  out AValue: string): Boolean;
var
  R: TJsonBaseObject;
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugMessage('%s.ExtractConfigItem', [ClassName]);
{$ENDIF}
  Result := False;
  R := TJsonObject.Parse(AConfig);
  try
    if not (R is TJsonObject) then
      Exit;
    AValue := TJsonObject(R).S[AName];
    Result := True;
  finally
    R.Free;
  end;
end;

function TAria2LocalStorage.GetOptions(const AName: string): string;
var
  C, V: string;
begin
{$IFDEF DEBUGMESSAGE}
  OutputDebugMessage('%s.GetOptions', [ClassName]);
{$ENDIF}
  Result := '';
  if FileExists(FFileName) then
  try
    if ExtractConfigData(FFileName, 'AriaNg.Options', C) then
      if ExtractConfigItem(C, AName, V) then
        Result := V;
  except
    ;
  end;
end;

end.

{ *********************************************************************** }
{                                                                         }
{   Aria2 FileMonitor 单元                                                }
{                                                                         }
{   设计：Lsuper 2022.01.01                                               }
{   备注：                                                                }
{   审核：                                                                }
{                                                                         }
{   Copyright (c) 1998-2022 Super Studio                                  }
{                                                                         }
{ *********************************************************************** }

unit Aria2FileMonitor;

interface

uses
  System.SysUtils, Winapi.Windows;

  procedure InstallFileMonitor(const AFileName: string; AWinHandle: HWND; AMessage: LongWord);
  procedure EnableFileMonitor(AEnable: Boolean);

implementation

uses
  HookUtils;

var
  InstEnable: Boolean;
  InstFileName: string;
  InstWinHandle: HWND;
  InstMessage: LongWord;

procedure InstallFileMonitor(const AFileName: string; AWinHandle: HWND; AMessage: LongWord);
begin
  InstEnable := False;
  InstFileName := AFileName;
  InstWinHandle := AWinHandle;
  InstMessage := AMessage;
end;

procedure EnableFileMonitor(AEnable: Boolean);
begin
  InstEnable := AEnable;
end;

procedure FireFileMonitor();
begin
  if (InstWinHandle <> 0) and (InstMessage <> 0) and IsWindow(InstWinHandle) then
  begin
    PostMessage(InstWinHandle, InstMessage, 0, 0);
  end;
end;

var
  CreateFileWNext: function (lpFileName: PWideChar; dwDesiredAccess, dwShareMode: DWORD;
    lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD;
    hTemplateFile: THandle): THandle; stdcall;
  CloseHandleNext: function (hObject: THandle): BOOL; stdcall;

  SaveLastHandle: THandle;

function CreateFileWCallBack(lpFileName: PWideChar; dwDesiredAccess, dwShareMode: DWORD;
  lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD;
  hTemplateFile: THandle): THandle; stdcall;
var
  S: string;
begin
  Result := CreateFileWNext(lpFileName, dwDesiredAccess, dwShareMode, lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile);
  if InstEnable and (InstFileName <> '') then
    if (lpFileName <> nil) and (Result <> INVALID_HANDLE_VALUE) and (dwDesiredAccess and GENERIC_WRITE <> 0) then
  begin
    S := ExtractFileName(lpFileName);
    if SameText(S, InstFileName) then SaveLastHandle := Result;
  end;
end;

function CloseHandleCallBack(hObject: THandle): BOOL; stdcall;
begin
  Result := CloseHandleNext(hObject);
  if InstEnable and Result and (hObject = SaveLastHandle) then
  begin
    FireFileMonitor();
    SaveLastHandle := 0;
  end;
end;

procedure Init;
begin
  HookProc(@Winapi.Windows.CreateFileW, @CreateFileWCallBack, @CreateFileWNext);
  HookProc(@Winapi.Windows.CloseHandle, @CloseHandleCallBack, @CloseHandleNext);
end;

procedure Done;
begin
  UnHookProc(@CreateFileWNext);
  UnHookProc(@CloseHandleNext);
end;

initialization
  Init;

finalization
  Done;

end.

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

program AriaNg;

{$IF CompilerVersion >= 21.0}
  {$WEAKLINKRTTI ON}
  {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}

uses
{
  FastMM4,
}
  System.SysUtils,
  Winapi.Windows,
  Vcl.Forms,

  JsonDataObjects in '..\Common\JsonDataObjects.pas',
  Win11Forms in '..\Common\Win11Forms.pas',

  Aria2LocalStorage in 'Aria2LocalStorage.pas',
  Aria2ControlFrm in 'Aria2ControlFrm.pas' {Aria2ControlForm};

{$R *.res}

{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE or IMAGE_FILE_RELOCS_STRIPPED}
{$SETPEOPTFLAGS $140}

begin
  Application.Title := 'AriaNg';
  Application.Initialize;
  Application.CreateForm(TAria2ControlForm, Aria2ControlForm);
  Application.Run;
end.

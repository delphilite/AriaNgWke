{ *********************************************************************** }
{                                                                         }
{   AriaNg WKE 自动化浏览器项目单元                                       }
{                                                                         }
{   设计：Lsuper 2017.09.11                                               }
{   备注：                                                                }
{   审核：                                                                }
{                                                                         }
{   Copyright (c) 1998-2019 Super Studio                                  }
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

  Aria2ControlFrm in 'Aria2ControlFrm.pas' {Aria2ControlForm};

{$R *.res}

{$SETPEFLAGS IMAGE_FILE_LARGE_ADDRESS_AWARE or IMAGE_FILE_RELOCS_STRIPPED}

begin
  Application.Title := 'AriaNg';
  Application.Initialize;
  Application.CreateForm(TAria2ControlForm, Aria2ControlForm);
  Application.Run;
end.

{*******************************************************}
{                                                       }
{       WKE FOR DELPHI                                  }
{                                                       }
{       版权所有 (C) 2018 Langji                        }
{                                                       }
{       QQ:231850275                                    }
{                                                       }
{*******************************************************}

unit Langji.Wke.Webbrowser;

//==============================================================================
// WKE FOR DELPHI
//==============================================================================

interface
{$I delphiver.inc}

uses
{$IFDEF DELPHI15_UP}
  System.SysUtils, System.Classes, Vcl.Controls, vcl.graphics, Vcl.Forms, System.Generics.Collections,
{$ELSE}
  SysUtils, Classes, Controls, Graphics, forms,
{$ENDIF}
  Messages, windows, Langji.Miniblink.libs, Langji.Miniblink.types, Langji.Wke.types, Langji.Wke.IWebBrowser,
  Langji.Wke.lib;

type
  TWkeWebBrowser = class;

  TOnNewWindowEvent = procedure(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures:
    PwkeWindowFeatures; var openflg: TNewWindowFlag; var webbrow: Twkewebbrowser) of object;

  TOnmbJsBindFunction = procedure(Sender: TObject; const msgid: Integer; const msgText: string) of object;

  TWkeApp = class(TComponent)
  private
    FCookieEnabled: boolean;
    FCookiePath: string;
    FUserAgent: string;
    FOnNewWindow: TOnNewWindowEvent;
    function GetWkeCookiePath: string;
    function GetWkeLibLocation: string;
    function GetWkeUserAgent: string;
    procedure SetCookieEnabled(const Value: boolean);
    procedure SetWkeCookiePath(const Value: string);
    procedure SetWkeLibLocation(const Value: string);
    procedure SetWkeUserAgent(const Value: string);
    procedure DoOnNewWindow(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures:
      PwkeWindowFeatures; var wvw: wkeWebView);
  public
    FWkeWebPages: TList{$IFDEF DELPHI15_UP}<TWkeWebBrowser>{$ENDIF} ;
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    procedure loaded; override;
    function CreateWebbrowser(Aparent: TWincontrol): TWkeWebBrowser; overload;
    function CreateWebbrowser(Aparent: TWincontrol; Ar: Trect): TWkeWebBrowser; overload;
    procedure CloseWebbrowser(Abrowser: TWkewebbrowser);
  published
    property WkelibLocation: string read GetWkeLibLocation write SetWkeLibLocation;
    property UserAgent: string read GetWkeUserAgent write SetWkeUserAgent;
    property CookieEnabled: boolean read FCookieEnabled write SetCookieEnabled;
    property CookiePath: string read GetWkeCookiePath write SetWkeCookiePath;
    property OnNewWindow: TOnNewWindowEvent read FOnNewWindow write FOnNewWindow;
  end;


  //浏览页面
  TWkeWebBrowser = class(TWinControl)
  private
    thewebview: TwkeWebView;
    FwkeApp: TWkeApp;
    FCanBack, FCanForward: boolean;
    FLocalUrl, FLocalTitle: string;   //当前Url Title
    FpopupEnabled: Boolean;        //允许弹窗
    FCookieEnabled: Boolean;
    FZoomValue: Integer;
    FLoadFinished: boolean;       //加载完
    FIsmain: Boolean;
    FPlatform: TwkePlatform;
    FDocumentIsReady: boolean;    //加载完

    FCookiePath: string;
    FLocalStorage: string;
    FUserAgent: string;
   // bCookiepathSet,bLocalStorageSet:boolean;
    FOnLoadEnd: TOnLoadEndEvent;
    FOnTitleChange: TOnTitleChangeEvent;
    FOnLoadStart: TOnBeforeLoadEvent;
    FOnUrlChange: TOnUrlChangeEvent;
    FOnCreateView: TOnCreateViewEvent;
    FOnDocumentReady: TNotifyEvent;
    FOnWindowClosing: TNotifyEvent;
    FOnWindowDestroy: TNotifyEvent;
    FOnAlertBox: TOnAlertBoxEvent;
    FOnConfirmBox: TOnConfirmBoxEvent;
    FOnPromptBox: TOnPromptBoxEvent;
    FOnDownload: TOnDownloadEvent;
    FOnMouseOverUrlChange: TOnUrlChangeEvent;
    FOnConsoleMessage: TOnConsoleMessgeEvent;
    FOnLoadUrlEnd: TOnLoadUrlEndEvent;
    FOnLoadUrlBegin: TOnLoadUrlBeginEvent;
    FOnmbBindFunction: TOnmbJsBindFunction;
    function GetZoom: Integer;
    procedure SetZoom(const Value: Integer);

     //webview
    procedure DoWebViewTitleChange(Sender: TObject; const sTitle: string);
    procedure DoWebViewUrlChange(Sender: TObject; const sUrl: string);
    procedure DoWebViewMouseOverUrlChange(Sender: TObject; sUrl: string);
    procedure DoWebViewLoadStart(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean);
    procedure DoWebViewLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
    procedure DoWebViewCreateView(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures:
      PwkeWindowFeatures; var wvw: Pointer);
    procedure DoWebViewAlertBox(Sender: TObject; smsg: string);
    function DoWebViewConfirmBox(Sender: TObject; smsg: string): boolean;
    function DoWebViewPromptBox(Sender: TObject; smsg, defaultres, Strres: string): boolean;
    procedure DoWebViewConsoleMessage(Sender: TObject; const AMessage, sourceName: string; sourceLine: Cardinal; const
      stackTrack: string);
    procedure DoWebViewDocumentReady(Sender: TObject);
    procedure DoWebViewWindowClosing(Sender: TObject);
    procedure DoWebViewWindowDestroy(Sender: TObject);
    function DoWebViewDownloadFile(Sender: TObject; sUrl: string): boolean;
    procedure DoWebViewLoadUrlEnd(Sender: TObject; sUrl: string; job: Pointer; buf: Pointer; len: Integer);
    procedure DoWebViewLoadUrlStart(Sender: TObject; sUrl: string; out bhook, bHandle: boolean);
    procedure DoWebViewJsCallBack(Sender: TObject; param: Pointer; es: TmbJsExecState; v: TmbJsValue);
    procedure DombJsBingFunction(Sender: TObject; const msgid: Integer; const response: string);
    procedure WM_SIZE(var msg: TMessage); message WM_SIZE;
    function GetCanBack: boolean;
    function GetCanForward: boolean;
    function GetCookieEnable: boolean;
    function GetLocationTitle: string;
    function GetLocationUrl: string;
 //   function GetMediaVolume: Single;
    function GetLoadFinished: Boolean;
    function GetWebHandle: Hwnd;
    /// <summary>
    ///   格式为：PRODUCTINFO=webxpress; domain=.fidelity.com; path=/; secure
    /// </summary>
    procedure SetCookie(const Value: string);
    function GetCookie: string;
    procedure SetLocaStoragePath(const Value: string);
    procedure SetHeadless(const Value: Boolean);
    procedure SetTouchEnabled(const Value: Boolean);
    procedure SetProxy(const Value: TwkeProxy);
    procedure SetDragEnabled(const Value: boolean);
    procedure setOnAlertBox(const Value: TOnAlertBoxEvent);
    procedure setWkeCookiePath(const Value: string);
    procedure SetNewPopupEnabled(const Value: Boolean);
    function getDocumentReady: boolean;
    function GetContentHeight: Integer;
    function GetContentWidth: Integer;
    procedure setUserAgent(const Value: string);

    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WndProc(var Msg: TMessage); override;
    procedure setPlatform(const Value: TwkePlatform);
    property SimulatePlatform: TwkePlatform read FPlatform write setPlatform;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateWebView;
    procedure GoBack;
    procedure GoForward;
    procedure Refresh;
    procedure Stop;
    procedure LoadUrl(const Aurl: string);
    /// <summary>
    ///   加载HTMLCODE
    /// </summary>
    procedure LoadHtml(const Astr: string);
    /// <summary>
    ///   加载文件
    /// </summary>
    procedure LoadFile(const AFile: string);
    /// <summary>
    ///   执行js 返回值 为执行成功与否
    /// </summary>
    function ExecuteJavascript(const js: string): boolean;

    /// <summary>
    ///   执行js并得到string返回值
    /// </summary>
    function GetJsTextResult(const js: string): string;
    /// <summary>
    ///   执行js并得到boolean返回值
    /// </summary>
    function GetJsBoolResult(const js: string): boolean;

    /// <summary>
    ///   取webview 的DC
    /// </summary>
    function GetWebViewDC: HDC;
    procedure SetFocusToWebbrowser;
    procedure ShowDevTool;                        //2018.3.14
    /// <summary>
    ///  取源码
    /// </summary>
    function GetSource: string;

    /// <summary>
    ///   模拟鼠标
    /// </summary>
    /// <param name=" msg">WM_MouseMove 等</param>
    /// <param name=" x,y">坐标</param>
    /// <param name=" flag">wke_lbutton 左键 、右键等 </param>
    procedure MouseEvent(const msg: Cardinal; const x, y: Integer; const flag: Integer = WKE_LBUTTON);
    /// <summary>
    ///   模拟键盘
    /// </summary>
    /// <param name=" flag">WKE_REPEAT等</param>
    procedure KeyEvent(const vkcode: Integer; const flag: integer = 0);
    property CanBack: boolean read GetCanBack;
    property CanForward: boolean read GetCanForward;
    property LocationUrl: string read GetLocationUrl;
    property LocationTitle: string read GetLocationTitle;
    property LoadFinished: Boolean read GetLoadFinished;       //加载完成
    property mainwkeview: TWkeWebView read thewebview;
    property WebViewHandle: Hwnd read GetWebHandle;
    property isMain: Boolean read FIsmain;
    property IsDocumentReady: boolean read getDocumentReady;
    property Proxy: TwkeProxy write SetProxy;
    property ZoomPercent: Integer read GetZoom write SetZoom;
    property Headless: Boolean write SetHeadless;
    property TouchEnabled: Boolean write SetTouchEnabled;
    property DragEnabled: boolean write SetDragEnabled;
    property ContentWidth: Integer read GetContentWidth;
    property ContentHeight: Integer read GetContentHeight;
  published
    property Align;
    property Color;
    property Visible;
    property WkeApp: TWkeApp read FwkeApp write FwkeApp;
    property UserAgent: string read FUserAgent write setUserAgent;
    property CookieEnabled: Boolean read FCookieEnabled write FCookieEnabled default true;
    property CookiePath: string read FCookiePath write setWkeCookiePath;
    /// <summary>
    ///   Cookie格式为：PRODUCTINFO=webxpress; domain=.fidelity.com; path=/; secure
    /// </summary>
    property Cookie: string read GetCookie write SetCookie;
    property LocalStoragePath: string write SetLocaStoragePath;
    property PopupEnabled: Boolean read FpopupEnabled write SetNewPopupEnabled default true;
    property OnTitleChange: TOnTitleChangeEvent read FOnTitleChange write FOnTitleChange;
    property OnUrlChange: TOnUrlChangeEvent read FOnUrlChange write FOnUrlChange;
    property OnBeforeLoad: TOnBeforeLoadEvent read FOnLoadStart write FOnLoadStart;
    property OnLoadEnd: TOnLoadEndEvent read FOnLoadEnd write FOnLoadEnd;
    property OnCreateView: TOnCreateViewEvent read FOnCreateView write FOnCreateView;
    property OnWindowClosing: TNotifyEvent read FOnWindowClosing write FOnWindowClosing;
    property OnWindowDestroy: TNotifyEvent read FOnWindowDestroy write FOnWindowDestroy;
    property OnDocumentReady: TNotifyEvent read FOnDocumentReady write FOnDocumentReady;
    property OnAlertBox: TOnAlertBoxEvent read FOnAlertBox write setOnAlertBox;
    property OnConfirmBox: TOnConfirmBoxEvent read FOnConfirmBox write FOnConfirmBox;
    property OnPromptBox: TOnPromptBoxEvent read FOnPromptBox write FOnPromptBox;
    property OnDownloadFile: TOnDownloadEvent read FOnDownload write FOnDownload;
    property OnMouseOverUrlChanged: TOnUrlChangeEvent read FOnMouseOverUrlChange write FOnMouseOverUrlChange; //2018.3.14
    property OnConsoleMessage: TOnConsoleMessgeEvent read FOnConsoleMessage write FOnConsoleMessage;
    property OnLoadUrlBegin: TOnLoadUrlBeginEvent read FOnLoadUrlBegin write FOnLoadUrlBegin;
    property OnLoadUrlEnd: TOnLoadUrlEndEvent read FOnLoadUrlEnd write FOnLoadUrlEnd;
    property OnmbJsBindFunction: TOnmbJsBindFunction read FOnmbBindFunction write FOnmbBindFunction;
  end;

implementation

uses
  dialogs, math;



//==============================================================================
// 回调事件
//==============================================================================

procedure doDucumentReadyCallback(webView: wkeWebView; param: Pointer; frameid: wkeFrameHwnd); cdecl;
begin
  if wkeIsMainFrame(webView, Cardinal(frameid)) then
    TWkeWebBrowser(param).DoWebViewDocumentReady(TWkeWebBrowser(param));
end;

procedure DoTitleChange(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewTitleChange(TWkeWebBrowser(param), wkeWebView.GetString(title));
end;

procedure DoUrlChange(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewUrlChange(TWkeWebBrowser(param), wkeWebView.GetString(url));
end;

procedure DoMouseOverUrlChange(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewMouseOverUrlChange(TWkeWebBrowser(param), wkeWebView.GetString(url));
end;

procedure DoLoadEnd(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult; failedReason:
  wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewLoadEnd(TWkeWebBrowser(param), wkeWebView.GetString(url), result);
end;

var
  tmpSource: string = '';
  FmbjsES: TmbJsExecState;
  Fmbjsvalue: TmbJsValue;
  FmbjsgetValue: boolean;

function DoGetSource(p1, p2, es: jsExecState): jsValue;
var
  s: string;
begin
  s := es.ToTempString(es.Arg(0));
  tmpSource := s;
  result := 0;
end;



function DoLoadStart(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString): Boolean; cdecl;
var
  cancel: boolean;
begin
  cancel := false;
  TWkeWebBrowser(param).DoWebViewLoadStart(TWkeWebBrowser(param), wkeWebView.GetString(url), navigationType, cancel);
  result := not cancel;
end;

function DoCreateView(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString;
  windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;
var
  pt: Pointer;
begin
  TWkeWebBrowser(param).DoWebViewCreateView(TWkeWebBrowser(param), wkeWebView.GetString(url), navigationType, windowFeatures, pt);
  result := wkeWebView(pt);
end;

procedure DoPaintUpdated(webView: wkeWebView; param: Pointer; hdc: hdc; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;
begin

end;

procedure DoAlertBox(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewAlertBox(TWkeWebBrowser(param), wkeWebView.GetString(msg));
end;

function DoConfirmBox(webView: wkeWebView; param: Pointer; msg: wkeString): Boolean; cdecl;
begin
  result := TWkeWebBrowser(param).DoWebViewConfirmBox(TWkeWebBrowser(param), wkeWebView.GetString(msg));
end;

function DoPromptBox(webView: wkeWebView; param: Pointer; msg: wkeString; defaultResult: wkeString; sresult: wkeString):
  Boolean; cdecl;
begin
  result := TWkeWebBrowser(param).DoWebViewPromptBox(TWkeWebBrowser(param), wkeWebView.GetString(msg), wkeWebView.GetString
    (defaultResult), wkeWebView.GetString(sresult));
end;

procedure DoConsoleMessage(webView: wkeWebView; param: Pointer; level: wkeMessageLevel; const AMessage, sourceName:
  wkeString; sourceLine: Cardinal; const stackTrack: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewConsoleMessage(TWkeWebBrowser(param), wkeWebView.GetString(AMessage), wkeWebView.GetString
    (sourceName), sourceLine, wkeWebView.GetString(stackTrack));
end;

procedure DocumentReady(webView: wkeWebView; param: Pointer); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewDocumentReady(TWkeWebBrowser(param));
end;

function DoWindowClosing(webWindow: wkeWebView; param: Pointer): Boolean; cdecl;
begin
  TWkeWebBrowser(param).DoWebViewWindowClosing(TWkeWebBrowser(param));
end;

procedure DoWindowDestroy(webWindow: wkeWebView; param: Pointer); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewWindowDestroy(TWkeWebBrowser(param));
end;

function DodownloadFile(webView: wkeWebView; param: Pointer; url: PansiChar): boolean; cdecl; // url: wkeString): boolean; cdecl;
begin
  result := TWkeWebBrowser(param).DoWebViewDownloadFile(TWkeWebBrowser(param), StrPas(url)); //   wkeWebView.GetString(url));
end;

procedure DoOnLoadUrlEnd(webView: wkeWebView; param: Pointer; const url: pansichar; job: Pointer; buf: Pointer; len:
  Integer); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewLoadUrlEnd(TWkeWebBrowser(param), StrPas(url), job, buf, len);
end;

function DoOnLoadUrlBegin(webView: wkeWebView; param: Pointer; url: PAnsiChar; job: Pointer): boolean; cdecl;
var
  bhook, bHandled: boolean;
begin
  bhook := false;
  bHandled := false;
  TWkeWebBrowser(param).DoWebViewLoadUrlStart(TWkeWebBrowser(param), StrPas(url), bhook, bHandled);
  if bhook then
    if Assigned(wkeNetHookRequest) then
      wkeNetHookRequest(job);
  result := bHandled;
end;

function DombOnLoadUrlBegin(webView: TmbWebView; param: Pointer; const url: PAnsiChar; job: Pointer): boolean; stdcall;
var
  bhook, bHandled: boolean;
begin
  bhook := false;
  bHandled := false;
  TWkeWebBrowser(param).DoWebViewLoadUrlStart(TWkeWebBrowser(param), StrPas(url), bhook, bHandled);
  if bhook then
    if Assigned(wkeNetHookRequest) then
      wkeNetHookRequest(job);
  result := bHandled;
end;


//----------------------------mb回调------------------------------------//

procedure DombTitleChange(webView: TmbWebView; param: Pointer; const title: PAnsiChar); stdcall;
var
  s: string;
begin
  s := UTF8Decode(strpas(title));
  TWkeWebBrowser(param).DoWebViewTitleChange(TWkeWebBrowser(param), s);
end;

procedure DombUrlChange(webView: TmbWebView; param: Pointer; const url: PAnsiChar; bcanback, bcanforward: boolean); stdcall;
begin
  TWkeWebBrowser(param).DoWebViewUrlChange(TWkeWebBrowser(param), UTF8Decode(strpas(url)));
end;

function DombLoadStart(webView: TmbWebView; param: Pointer; navigationType: TmbNavigationType; const url: PAnsiChar):
  boolean; stdcall;
var
  cancel: boolean;
begin
  cancel := false;
  TWkeWebBrowser(param).DoWebViewLoadStart(TWkeWebBrowser(param), UTF8Decode(strpas(url)), wkeNavigationType(navigationType),
    cancel);
  result := not cancel;
end;

procedure DombLoadEnd(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle; const url: PAnsiChar; lresult:
  TmbLoadingResult; const failedReason: PAnsiChar); stdcall;
begin
  if frameId = mbWebFrameGetMainFrame(webView) then
    TWkeWebBrowser(param).DoWebViewLoadEnd(TWkeWebBrowser(param), UTF8Decode(strpas(url)), wkeLoadingResult(lresult));
end;

function DombCreateView(webView: TmbWebView; param: Pointer; navigationType: TmbNavigationType; const url: PAnsiChar;
  const windowFeatures: PmbWindowFeatures): TmbWebView; stdcall;
var
  xhandle: Hwnd;
  wv: TmbWebview;
begin
  wv := nil;
  TWkeWebBrowser(param).DoWebViewCreateView(TWkeWebBrowser(param), UTF8Decode(strpas(url)), wkeNavigationType(navigationType),
    PwkeWindowFeatures(windowFeatures), wv);
  result := wv;
end;

procedure DombDocumentReady(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle); stdcall;
begin
  TWkeWebBrowser(param).DoWebViewDocumentReady(TWkeWebBrowser(param));
end;

procedure DoMbAlertBox(webView: TmbWebView; param: Pointer; const msg: PAnsiChar); stdcall;
begin
  TWkeWebBrowser(param).DoWebViewAlertBox(TWkeWebBrowser(param), UTF8Decode(strpas(msg)));
end;

function DombConfirmBox(webView: TmbWebView; param: Pointer; const msg: PAnsiChar): boolean; stdcall;
begin
  result := TWkeWebBrowser(param).DoWebViewConfirmBox(TWkeWebBrowser(param), UTF8Decode(strpas(msg)));
end;

function DombPromptBox(webView: TmbWebView; param: Pointer; const msg: PAnsiChar; const defaultResult: PAnsiChar;
  sresult: PAnsiChar): boolean; stdcall;
begin
  result := TWkeWebBrowser(param).DoWebViewPromptBox(TWkeWebBrowser(param), UTF8Decode(strpas(msg)), UTF8Decode(strpas(defaultResult)),
    UTF8Decode(strpas(sresult)));
end;

procedure DombConsole(webView: TmbWebView; param: Pointer; level: TmbConsoleLevel; const smessage: PAnsiChar; const
  sourceName: PAnsiChar; sourceLine: Cardinal; const stackTrace: PAnsiChar); stdcall;
begin
  TWkeWebBrowser(param).DoWebViewConsoleMessage(TWkeWebBrowser(param), UTF8Decode(strpas(smessage)), UTF8Decode(strpas(sourceName)),
    sourceLine, UTF8Decode(strpas(stackTrace)));
end;

function DombClose(webView: TmbWebView; param: Pointer; unuse: Pointer): boolean; stdcall;
begin
  TWkeWebBrowser(param).DoWebViewWindowClosing(TWkeWebBrowser(param));
end;

function DombDestory(webView: TmbWebView; param: Pointer; unuse: Pointer): boolean; stdcall;
begin
  result := false;
 // TWkeWebBrowser(param).DoWebViewWindowDestroy(TWkeWebBrowser(param));
end;

function DombPrint(webView: TmbWebView; param: Pointer; step: TmbPrintintStep; hdc: hdc; const settings:
  TmbPrintintSettings; pagecount: Integer): Boolean; stdcall;
begin

end;

//function DombDownload(webView: TmbWebView; param: Pointer; const url: PAnsiChar): boolean; stdcall;
//begin
//  result := TWkeWebBrowser(param).DoWebViewDownloadFile(TWkeWebBrowser(param), UTF8Decode(StrPas(url)));
//end;

procedure DoMbThreadDownload(webView: TmbWebView; param: Pointer; expectedContentLength: DWORD; const url, mime,
  disposition: PChar; job: Tmbnetjob; databind: PmbNetJobDataBind); stdcall;
begin
  TWkeWebBrowser(param).DoWebViewDownloadFile(TWkeWebBrowser(param), UTF8Decode(StrPas(url)));
end;

procedure DombGetCanBack(webView: TmbWebView; param: Pointer; state: TMbAsynRequestState; b: Boolean); stdcall;
begin
  if state = kMbAsynRequestStateOk then
    TWkeWebBrowser(param).FCanBack := b;
end;

procedure DombGetCanForward(webView: TmbWebView; param: Pointer; state: TMbAsynRequestState; b: Boolean); stdcall;
begin
  if state = kMbAsynRequestStateOk then
    TWkeWebBrowser(param).FCanForward := b;
end;

procedure Dombjscallback(webView: TmbWebView; param: Pointer; es: TmbJsExecState; v: TmbJsValue); stdcall;
begin
  //TWkeWebBrowser(param).DoWebViewJsCallBack(TWkeWebBrowser(param), param, es, v);
  FmbjsES := es;
  Fmbjsvalue := v;
  FmbjsgetValue := true;
end;

procedure DombJsBingCallback(webView: TmbWebView; param: Pointer; es: TmbJsExecState; queryId: Int64; customMsg: Integer;
  const request: PAnsiChar); stdcall;
begin
  if customMsg = mbgetsourcemsg then
  begin
    tmpSource := UTF8Decode(StrPas(request));
    FmbjsgetValue := true;
  end
  else
  begin
    TWkeWebBrowser(param).DombJsBingFunction(TWkeWebBrowser(param), customMsg, UTF8Decode(StrPas(request)));
    mbResponseQuery(webView, queryId, customMsg, PAnsiChar('DelphiCallback'));
  end;

end;



{ TWkeWebBrowser }

constructor TWkeWebBrowser.Create(AOwner: TComponent);
begin
  inherited;
  Color := clwhite;
  FZoomValue := 100;
  FCookieEnabled := true;
  FpopupEnabled := true;
  FUserAgent :=
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.1650.63 Safari/537.36 Langji.MiniBlink 1.1';
  FPlatform := wp_Win32;
  FLocalUrl := '';
  FLocalTitle := '';
  FLocalStorage := '';
  FCookiePath := '';
end;

destructor TWkeWebBrowser.Destroy;
begin
//  if (not Assigned(FwkeApp)) and (not wkeIsInDll) then
//  begin
//    if FIsmain then
//      WkeFinalizeAndUnloadLib;
//  end;
  inherited;
end;

procedure TWkeWebBrowser.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if (csDesigning in ComponentState) then
    exit;
  if not Assigned(FwkeApp) then
    Fismain := WkeLoadLibAndInit;
  CreateWebView;
end;

procedure TWkeWebBrowser.CreateWebView;
var
  wkeset: wkeSettings;
begin
  if UseFastMB then
  begin
    thewebview := mbCreateWebWindow(MB_WINDOW_TYPE_CONTROL, handle, 0, 0, Width, height);
    if Assigned(thewebview) then
    begin
      mbShowWindow(thewebview, true);
      SetWindowLong(mbGetHostHWND(thewebview), GWL_STYLE, GetWindowLong(mbGetHostHWND(thewebview), GWL_STYLE) or
        WS_CHILD or WS_TABSTOP or WS_CLIPCHILDREN or WS_CLIPSIBLINGS);

      mbResize(thewebview, Width, Height);

      mbOnTitleChanged(thewebview, DombTitleChange, Self);
      mbOnURLChanged(thewebview, DombUrlChange, Self);
      mbOnNavigation(thewebview, DombLoadStart, Self);
      mbOnLoadingFinish(thewebview, DombLoadEnd, Self);
     // if Assigned(FwkeApp) or Assigned(FOnCreateView) then
      mbOnCreateView(thewebview, DombCreateView, Self);
      mbOnDocumentReady(thewebview, DombDocumentReady, Self);
      if Assigned(FOnAlertBox) then
        mbOnAlertBox(thewebview, DoMbAlertBox, Self);
      if Assigned(FOnConfirmBox) then
        mbOnConfirmBox(thewebview, DombConfirmBox, Self);
      if Assigned(FOnPromptBox) then
        mbOnPromptBox(thewebview, DombPromptBox, Self);
      if Assigned(FOnConsoleMessage) then
        mbOnConsole(thewebview, DombCOnsole, Self);

      mbOnClose(thewebview, DombClose, Self);
      mbOnDestroy(thewebview, DombDestory, self);
      mbOnPrinting(thewebview, DombPrint, self);
      mbOnJsQuery(thewebview, DombJsBingCallback, self);
      mbOnDownloadInBlinkThread(thewebview, DoMbThreadDownload, Self);

      mbCanGoBack(thewebview, DombGetCanBack, self);
      mbCanGoForward(thewebview, DombGetCanForward, self);
      mbOnLoadUrlBegin(thewebview, DombOnLoadUrlBegin, Self);
      if FUserAgent <> '' then
        mbSetUserAgent(thewebview, PAnsiChar(AnsiString(FUserAgent)));
      if DirectoryExists(FCookiePath) then
        mbSetCookieJarPath(thewebview, PWideChar(FCookiePath));

      if DirectoryExists(FLocalStorage) then
        mbSetLocalStorageFullPath(thewebview, PWideChar(FLocalStorage));

      if FpopupEnabled then
        mbSetNavigationToNewWindowEnable(thewebview, true);
    end;
    exit;
  end;

  thewebview := wkeCreateWebWindow(WKE_WINDOW_TYPE_CONTROL, handle, 0, 0, Width, height);

  if Assigned(thewebview) then
  begin
    ShowWindow(thewebview.WindowHandle, SW_NORMAL);
    SetWindowLong(thewebview.WindowHandle, GWL_STYLE, GetWindowLong(thewebview.WindowHandle, GWL_STYLE) or WS_CHILD or
      WS_TABSTOP or WS_CLIPCHILDREN or WS_CLIPSIBLINGS);

    thewebview.SetOnTitleChanged(DoTitleChange, self);
    thewebview.SetOnURLChanged(DoUrlChange, self);
    thewebview.SetOnNavigation(DoLoadStart, self);
    thewebview.SetOnLoadingFinish(DoLoadEnd, self);
   // if Assigned(FwkeApp) or Assigned(FOnCreateView) then
    thewebview.SetOnCreateView(DoCreateView, self);
    thewebview.SetOnPaintUpdated(DoPaintUpdated, self);
    if Assigned(FOnAlertBox) then
      thewebview.SetOnAlertBox(DoAlertBox, self);
    if Assigned(FOnConfirmBox) then
      thewebview.SetOnConfirmBox(DoConfirmBox, self);
    if Assigned(FOnPromptBox) then
      thewebview.SetOnPromptBox(DoPromptBox, self);
    if Assigned(FOndownload) then
      thewebview.SetOnDownload(DoDownloadFile, Self);
    if Assigned(FOnMouseOverUrlChange) then
      wkeOnMouseOverUrlChanged(thewebview, DoMouseOverUrlChange, self);

    thewebview.SetOnConsoleMessage(DoConsoleMessage, self);
   // thewebview.SetOnDocumentReady(DocumentReady, self);   //这个没什么用
    wkeOnDocumentReady2(thewebview, doDucumentReadyCallback, Self);

    thewebview.SetOnWindowClosing(DoWindowClosing, self);
    thewebview.SetOnWindowDestroy(DoWindowDestroy, self);

    wkeOnLoadUrlBegin(thewebview, DoOnLoadUrlBegin, Self);
    wkeOnLoadUrlEnd(thewebview, DoOnLoadUrlEnd, self);

    if FUserAgent <> '' then
      wkeSetUserAgent(thewebview, PansiChar(AnsiString(FUserAgent)));
    wkeSetCookieEnabled(thewebview, FCookieEnabled);
    if DirectoryExists(FCookiePath) and Assigned(wkeSetCookieJarPath) then
      wkeSetCookieJarPath(thewebview, PwideChar(FCookiePath));
    if DirectoryExists(FLocalStorage) and Assigned(wkeSetLocalStorageFullPath) then
      wkeSetLocalStorageFullPath(thewebview, PWideChar(FLocalStorage));

    wkeSetNavigationToNewWindowEnable(thewebview, FpopupEnabled);
    wkeSetCspCheckEnable(thewebview, False);       //关闭跨域检查
    jsBindFunction('GetSource', DoGetSource, 1);

  end;
end;

procedure TWkeWebBrowser.DombJsBingFunction(Sender: TObject; const msgid: Integer; const response: string);
begin
  if Assigned(FOnmbBindFunction) then
    FOnmbBindFunction(self, msgid, response);
end;

procedure TWkeWebBrowser.DoWebViewAlertBox(Sender: TObject; smsg: string);
begin
  if Assigned(FOnAlertBox) then
    FOnAlertBox(Self, smsg);
end;

function TWkeWebBrowser.DoWebViewConfirmBox(Sender: TObject; smsg: string): boolean;
begin
  result := false;
  if Assigned(FOnConfirmBox) then
    FOnConfirmBox(self, smsg, result);
end;

procedure TWkeWebBrowser.DoWebViewConsoleMessage(Sender: TObject; const AMessage, sourceName: string; sourceLine:
  Cardinal; const stackTrack: string);
begin
  if Assigned(FOnConsoleMessage) then
    FOnConsoleMessage(Self, AMessage, sourceName, sourceLine);

end;

procedure TWkeWebBrowser.DoWebViewCreateView(Sender: TObject; sUrl: string; navigationType: wkeNavigationType;
  windowFeatures: PwkeWindowFeatures; var wvw: Pointer);
var
  newFrm: TForm;
  view: wkeWebView;
begin
//  if Assigned(FwkeApp) then
//  begin
//    ShowMessage('backs');
//    FwkeApp.DoOnNewWindow(self, sUrl, navigationType, windowFeatures, view);
//
//    wvw := view;
//    exit;
//  end;

  wvw := nil;
  if Assigned(FOnCreateView) then
  begin
    FOnCreateView(self, sUrl, navigationType, windowFeatures, view);
    wvw := view;
   // exit;
  end;

  if not Assigned(wvw) then
  begin
    if UseFastMB then
    begin
      wvw := mbCreateWebWindow(MB_WINDOW_TYPE_POPUP, 0, windowFeatures.x, windowFeatures.y, 800, 600);
      mbShowWindow(wvw, True);
      mbMoveToCenter(wvw);
    end
    else
    begin
      wvw := wkeCreateWebWindow(WKE_WINDOW_TYPE_POPUP, 0, windowFeatures.x, windowFeatures.y, windowFeatures.width,
        windowFeatures.height);
      wkeShowWindow(wvw, True);
      wkeSetWindowTitleW(wvw, PwideChar(sUrl));
    end;
  end
  else
  begin
    if UseFastMB then
    begin
      if (mbGetHostHWND(wvw) = 0) then
        wvw := thewebview;
    end
    else
    begin
      if wkeGetWindowHandle(wvw) = 0 then
        wvw := thewebview;
    end;
  end;
end;

procedure TWkeWebBrowser.DoWebViewDocumentReady(Sender: TObject);
begin
  FDocumentIsReady := true;
  if Assigned(FOnDocumentReady) then
    FOnDocumentReady(Self);
end;

function TWkeWebBrowser.DoWebViewDownloadFile(Sender: TObject; sUrl: string): boolean;
begin
  if Assigned(FOndownload) then
    FOnDownload(Self, sUrl);
end;

procedure TWkeWebBrowser.DoWebViewJsCallBack(Sender: TObject; param: Pointer; es: TmbJsExecState; v: TmbJsValue);
  //js返回值
begin

end;

procedure TWkeWebBrowser.DoWebViewLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
begin
  FLoadFinished := true;
  FLocalUrl := sUrl;
  if Assigned(FOnLoadEnd) then
    FOnLoadEnd(Self, sUrl, loadresult);
end;

procedure TWkeWebBrowser.DoWebViewLoadStart(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel:
  boolean);
begin
  FLoadFinished := false;
  FDocumentIsReady := false;
  FLocalUrl := sUrl;
  if Assigned(FOnLoadStart) then
    FOnLoadStart(self, sUrl, navigationType, Cancel);
end;

procedure TWkeWebBrowser.DoWebViewLoadUrlEnd(Sender: TObject; sUrl: string; job, buf: Pointer; len: Integer);
begin
  if Assigned(FOnLoadUrlEnd) then
    FOnLoadUrlEnd(self, sUrl, buf, len);
end;

procedure TWkeWebBrowser.DoWebViewLoadUrlStart(Sender: TObject; sUrl: string; out bhook, bHandle: boolean);
begin
  //bhook:=true 表示hook会触发onloadurlend 如果只是设置 bhandle=true表示 ，只是拦截这个URL
  if Assigned(FOnLoadUrlBegin) then
    FOnLoadUrlBegin(Self, sUrl, bhook, bHandle);
end;

procedure TWkeWebBrowser.DoWebViewMouseOverUrlChange(Sender: TObject; sUrl: string);
begin
  if Assigned(FOnMouseOverUrlChange) then
    FOnMouseOverUrlChange(self, sUrl);
end;

function TWkeWebBrowser.DoWebViewPromptBox(Sender: TObject; smsg, defaultres, Strres: string): boolean;
begin
  if Assigned(FOnPromptBox) then
    FOnPromptBox(self, smsg, defaultres, Strres, result);
end;

procedure TWkeWebBrowser.DoWebViewTitleChange(Sender: TObject; const sTitle: string);
begin
  FLocalTitle := sTitle;
  if Assigned(FOnTitleChange) then
    FOnTitleChange(self, sTitle);
end;

procedure TWkeWebBrowser.DoWebViewUrlChange(Sender: TObject; const sUrl: string);
begin
  if Assigned(FOnUrlChange) then
    FOnUrlChange(self, sUrl);
end;

procedure TWkeWebBrowser.DoWebViewWindowClosing(Sender: TObject);
begin
  if Assigned(FOnWindowClosing) then
    FOnWindowClosing(Self);
end;

procedure TWkeWebBrowser.DoWebViewWindowDestroy(Sender: TObject);
begin
  if Assigned(FOnWindowDestroy) then
    FOnWindowDestroy(Self);
end;



function TWkeWebBrowser.ExecuteJavascript(const js: string): boolean;          //执行js
var
  newjs: ansistring;
  r: jsValue;
  es: jsExecState;
  x: Integer;
begin
  if UseFastMB then
  begin
    result := false;
    newjs := UTF8Encode('try { ' + js + '; return 1; } catch(err){ return 0;}');
    if Assigned(thewebview) then
    begin
      FmbjsgetValue := false;
      mbRunJs(thewebview, mbWebFrameGetMainFrame(thewebview), PAnsiChar(newjs), True, Dombjscallback, self, nil);
      x := 0;
      repeat
        Sleep(120);
        Application.ProcessMessages;
      until (x > 15) or Fmbjsgetvalue;
      if Fmbjsgetvalue then
      begin
        if '1' = strpas(mbJsToString(FmbjsES, Fmbjsvalue)) then
          result := true;
      end;

    end;
    exit;
  end;

  result := false;
  newjs := 'try { ' + js + '; return 1; } catch(err){ return 0;}';
  if Assigned(thewebview) then
  begin
    r := thewebview.RunJS(newjs);
    es := thewebview.GlobalExec;
    if es.IsNumber(r) then
    begin
      if es.Toint(r) = 1 then
        result := true;
    end;
  end;
end;

function TWkeWebBrowser.GetJsTextResult(const js: string): string;
var
  r: jsValue;
  es: jsExecState;
  x: Integer;
begin
  result := '';

  if UseFastMB then
  begin
    if Assigned(thewebview) then
    begin
      FmbjsgetValue := false;
      mbRunJs(thewebview, mbWebFrameGetMainFrame(thewebview), PAnsiChar(ansistring(js)), True, Dombjscallback, self, nil);
      x := 0;
      repeat
        Sleep(50);
        Application.ProcessMessages;
      until (x > 15) or Fmbjsgetvalue;
      if Fmbjsgetvalue then
      begin
        result := strpas(mbJsToString(FmbjsES, Fmbjsvalue));
      end;
    end;
    exit;
  end;

  if Assigned(thewebview) then
  begin
    r := thewebview.RunJS(js);
    Sleep(100);
    es := thewebview.GlobalExec;
    if es.IsString(r) then
      result := es.ToTempString(r);
  end;
end;

function TWkeWebBrowser.GetJsBoolResult(const js: string): boolean;
var
  r: jsValue;
  es: jsExecState;
  x: integer;
begin
  result := false;
  if UseFastMB then
  begin
    if Assigned(thewebview) then
    begin
      FmbjsgetValue := false;
      mbRunJs(thewebview, mbWebFrameGetMainFrame(thewebview), PAnsiChar(ansistring(js)), True, Dombjscallback, self, nil);
      x := 0;
      repeat
        Sleep(120);
        Application.ProcessMessages;
      until (x > 15) or Fmbjsgetvalue;
      if Fmbjsgetvalue then
      begin
        result := mbJsToboolean(FmbjsES, Fmbjsvalue);
      end;
    end;
    exit;
  end;

  if Assigned(thewebview) then
  begin
    r := thewebview.RunJS(js);
    es := thewebview.GlobalExec;
    if es.IsBoolean(r) then
      result := es.ToBoolean(r);
  end;
end;

function TWkeWebBrowser.GetCanBack: boolean;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := FCanBack
    else
      result := thewebview.CanGoBack;
  end;
end;

function TWkeWebBrowser.GetCanForward: boolean;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := FCanForward
    else
      result := thewebview.CanGoForward;
  end;
end;

function TWkeWebBrowser.GetContentHeight: Integer;
begin
  result := 0;
  if UseFastMB then
    exit;
  if Assigned(thewebview) then
    result := wkeGetContentHeight(thewebview);
end;

function TWkeWebBrowser.GetContentWidth: Integer;
begin
  result := 0;
  if UseFastMB then
    exit;
  if Assigned(thewebview) then
    result := wkeGetContentWidth(thewebview);
end;

function TWkeWebBrowser.GetCookie: string;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := mbGetCookieOnBlinkThread(thewebview)
    else
      result := thewebview.Cookie;
  end;
end;

function TWkeWebBrowser.GetCookieEnable: boolean;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := true
    else
      result := thewebview.CookieEnabled;
  end;

end;

function TWkeWebBrowser.getDocumentReady: boolean;
begin
  result := false;
  if Assigned(thewebview) then
  begin
    if not UseFastMB then
      FDocumentIsReady := wkeIsDocumentReady(thewebview);
    result := FDocumentIsReady;
  end;
end;

function TWkeWebBrowser.GetLoadFinished: Boolean;
begin
  result := FLoadFinished;
end;

function TWkeWebBrowser.GetLocationTitle: string;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := FLocalTitle
    else
      result := wkeGetTitleW(thewebview);
  end;

end;

function TWkeWebBrowser.GetLocationUrl: string;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := FLocalUrl
    else
      result := wkeGetUrl(thewebview);
  end;

end;

function TWkeWebBrowser.GetSource: string;        //取源码
begin
//  if Assigned(thewebview) then
//    result := wkeGetSource(thewebview);
  tmpSource := '';
  if Assigned(thewebview) then
  begin
    if UseFastMB then
    begin
      FmbjsgetValue := False;
      mbRunJs(thewebview, mbWebFrameGetMainFrame(thewebview),
        'function onNative(customMsg, response) {console.log("on~~mbQuery:" + response);} ' +
        'window.mbQuery(0x4001, document.getElementsByTagName("html")[0].outerHTML, onNative);', True, Dombjscallback, self, nil);
      repeat
        Sleep(200);
        Application.ProcessMessages;
      until FmbjsgetValue;
    end
    else
    begin
      ExecuteJavascript('GetSource(document.getElementsByTagName("html")[0].outerHTML);');
    end;
    Sleep(100);
    result := tmpSource;
  end;
end;

function TWkeWebBrowser.GetWebHandle: Hwnd;
begin
  result := 0;
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := mbGetHostHWND(thewebview)
    else
      result := thewebview.WindowHandle;
  end;

end;

function TWkeWebBrowser.GetWebViewDC: hdc;
begin
  result := 0;
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := GetDC(mbGetHostHWND(thewebview))
    else
      result := wkeGetViewDC(thewebview);
  end;

end;

procedure TWkeWebBrowser.setUserAgent(const Value: string);
begin
  FUserAgent := Value;
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetUserAgent(thewebview, PAnsiChar(AnsiString(Value)))
    else
      wkeSetUserAgent(thewebview, PAnsiChar(AnsiString(Value)))
  end;
end;

procedure TWkeWebBrowser.setWkeCookiePath(const Value: string);
begin
  if DirectoryExists(Value) then
    FCookiePath := Value;

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetCookieJarFullPath(thewebview, PwideChar(Value))
    else
      wkeSetCookieJarPath(thewebview, PwideChar(Value));
  end;
end;

function TWkeWebBrowser.getZoom: Integer;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      result := Trunc(power(1.2, mbGetZoomFactor(thewebview)) * 100)
    else
      result := Trunc(power(1.2, thewebview.ZoomFactor) * 100)
  end
  else
    result := 100;
end;

procedure TWkeWebBrowser.GoBack;
var
  wv: TmbWebview;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
    begin
      if FCanBack then
        mbGoBack(thewebview);
    end
    else
    begin
      if thewebview.CanGoBack then
        thewebview.GoBack;
    end;
  end;
end;

procedure TWkeWebBrowser.GoForward;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
    begin
      if FCanForward then
        mbGoForward(thewebview);
    end
    else
    begin
      if thewebview.CanGoForward then
        thewebview.GoForward;
    end;
  end;
end;

procedure TWkeWebBrowser.KeyEvent(const vkcode, flag: integer);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
    begin
      mbFireKeyDownEvent(thewebview, vkcode, flag, False);
      Sleep(10);
      mbFireKeyUpEvent(thewebview, vkcode, flag, False);
    end
    else
    begin
      wkeFireKeyDownEvent(thewebview, vkcode, flag, False);
      Sleep(10);
      wkeFireKeyUpEvent(thewebview, vkcode, flag, False);
    end;
  end;
end;

procedure TWkeWebBrowser.LoadFile(const AFile: string);
begin
  if Assigned(thewebview) and FileExists(AFile) then
  begin
    FLoadFinished := false;
    if UseFastMB then
      mbLoadURL(thewebview, PAnsiChar(AnsiString(UTF8Encode('file:///' + AFile))))
    else
      thewebview.LoadFile(AFile);
  end;

end;

procedure TWkeWebBrowser.LoadHtml(const Astr: string);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbLoadHtmlWithBaseUrl(thewebview, PAnsiChar(AnsiString(Astr)), 'about:blank')
    else
      thewebview.LoadHTML(Astr);
  end;

end;

procedure TWkeWebBrowser.LoadUrl(const Aurl: string);
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbLoadURL(thewebview, PAnsiChar(AnsiString(UTF8Encode(Aurl))))
    else
    begin
      thewebview.LoadURL(Aurl);
      thewebview.MoveWindow(0, 0, Width, Height);
    end;
  end;
end;

procedure TWkeWebBrowser.MouseEvent(const msg: Cardinal; const x, y, flag: Integer);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbFireMouseEvent(thewebview, msg, x, y, flag)
    else
      wkeFireMouseEvent(thewebview, msg, x, y, flag);
  end;
end;

procedure TWkeWebBrowser.Refresh;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbReload(thewebview)
    else
      thewebview.Reload;
  end;
end;

procedure TWkeWebBrowser.SetCookie(const Value: string);          //设置cookie----------
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetCookie(thewebview, PAnsiChar(FLocalUrl), PAnsiChar(Value))
    else
      thewebview.setcookie(Value);
  end;
end;

procedure TWkeWebBrowser.SetFocusToWebbrowser;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      SendMessage(mbGetHostHWND(thewebview), WM_ACTIVATE, 1, 0)
    else
    begin
      thewebview.SetFocus;
      SendMessage(thewebview.WindowHandle, WM_ACTIVATE, 1, 0);
    end;
  end;
end;

procedure TWkeWebBrowser.SetDragEnabled(const Value: boolean);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetDragDropEnable(thewebview, Value)
    else
      wkeSetDragEnable(thewebview, Value);
  end;

end;

procedure TWkeWebBrowser.SetHeadless(const Value: Boolean);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetHeadlessEnabled(thewebview, Value)
    else
      wkeSetHeadlessEnabled(thewebview, Value);
  end;

end;

procedure TWkeWebBrowser.SetTouchEnabled(const Value: Boolean);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      Exit
    else
      wkeSetTouchEnabled(thewebview, Value);
  end;
end;

procedure TWkeWebBrowser.SetLocaStoragePath(const Value: string);
begin
  if Value <> FLocalStorage then
  begin
    FLocalStorage := Value;
    if Assigned(thewebview) then
    begin
      if UseFastMB then
        mbSetLocalStorageFullPath(thewebview, PWideChar(Value))
      else
        wkeSetLocalStorageFullPath(thewebview, PWideChar(Value));
      FLocalStorage := Value;
    end;
  end;

end;

procedure TWkeWebBrowser.SetNewPopupEnabled(const Value: Boolean);
begin
  FpopupEnabled := Value;
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetNavigationToNewWindowEnable(thewebview, Value)
    else
      wkeSetNavigationToNewWindowEnable(thewebview, Value);
  end;
end;

procedure TWkeWebBrowser.setOnAlertBox(const Value: TOnAlertBoxEvent);
begin
  FOnAlertBox := Value;
  if Assigned(thewebview) then
    thewebview.SetOnAlertBox(DoAlertBox, self);
end;

procedure TWkeWebBrowser.setPlatform(const Value: TwkePlatform);
begin
  if not Assigned(thewebview) then
    Exit;
  if UseFastMB then
    exit;
  if FPlatform <> Value then
  begin
    case Value of
      wp_Win32:
        wkeSetDeviceParameter(thewebview, PAnsiChar('navigator.platform'), PAnsiChar('Win32'), 0, 0);
      wp_Android:
        begin
          wkeSetDeviceParameter(thewebview, PAnsiChar('navigator.platform'), PAnsiChar('Android'), 0, 0);
          wkeSetDeviceParameter(thewebview, PAnsiChar('screen.width'), PAnsiChar('800'), 400, 0);
          wkeSetDeviceParameter(thewebview, PAnsiChar('screen.height'), PAnsiChar('1600'), 800, 0);
        end;
      wp_Ios:
        wkeSetDeviceParameter(thewebview, PAnsiChar('navigator.platform'), PAnsiChar('Android'), 0, 0);
    end;
    FPlatform := Value;
  end;
end;

procedure TWkeWebBrowser.SetProxy(const Value: TwkeProxy);
var
  xproxy: TmbProxy;
  shost: ansistring;
begin

  if Assigned(thewebview) then
  begin
    if UseFastMB then
    begin
      with xproxy do
      begin
        mtype := TmbProxyType(Value.AType);
        shost := Value.hostname;
        StrPCopy(hostname, shost);
        port := Value.port;
        shost := Value.username;
        StrPCopy(username, shost);
        shost := Value.password;
        StrPCopy(password, shost);
      end;
      mbSetProxy(thewebview, @xproxy)
    end
    else
      wkeSetproxy(@Value);
     // wkeSetViewProxy(thewebview, @Value);
  end;

end;

procedure TWkeWebBrowser.ShowDevTool;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetDebugConfig(thewebview, 'showDevTools', PAnsiChar(AnsiToUtf8(ExtractFilePath(ParamStr(0)) +
        '\front_end\inspector.html')))
    else
      wkeSetDebugConfig(thewebview, 'showDevTools', PAnsiChar(AnsiToUtf8(ExtractFilePath(ParamStr(0)) +
        '\front_end\inspector.html')));
  end;

end;

procedure TWkeWebBrowser.SetZoom(const Value: Integer);
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbSetZoomFactor(thewebview, LogN(1.2, Value / 100))
    else
      thewebview.ZoomFactor := LogN(1.2, Value / 100);
  end;
end;

procedure TWkeWebBrowser.Stop;
begin
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      mbStopLoading(thewebview)
    else
      thewebview.StopLoading;
  end;

end;

procedure TWkeWebBrowser.WM_SIZE(var msg: TMessage);
begin
  inherited;
  if Assigned(thewebview) then
  begin
    if UseFastMB then
      MoveWindow(mbGetHostHWND(thewebview), 0, 0, Width, Height, true)
    else
      thewebview.MoveWindow(0, 0, Width, Height);
  end;

end;

procedure TWkeWebBrowser.WndProc(var Msg: TMessage);
var
  hndl: Hwnd;
begin
  case Msg.Msg of
    WM_SETFOCUS:
      begin
        hndl := GetWindow(Handle, GW_CHILD);
        if hndl <> 0 then
          PostMessage(hndl, WM_SETFOCUS, Msg.WParam, 0);
        inherited WndProc(Msg);
      end;
    CM_WANTSPECIALKEY:                                  // VK_RETURN,
      if not (TWMKey(Msg).CharCode in [VK_LEFT..VK_DOWN, VK_ESCAPE, VK_TAB]) then    //2018.07.26
        Msg.Result := 1
      else
        inherited WndProc(Msg);
    WM_GETDLGCODE:
      Msg.Result := DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
  else
    inherited WndProc(Msg);
  end;

end;









//procedure ShowLastError;
//var
//  ErrorCode: DWORD;
//  ErrorMessage: Pointer;
//begin
//  ErrorCode := GetLastError;
//  FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER or Format_MESSAGE_FROM_SYSTEM, nil, ErrorCode, 0, @ErrorMessage, 0, nil);
//  showmessage('GetLastError Result: ' + IntToStr(ErrorCode) + #13 + 'Error Description: ' + string(Pchar(ErrorMessage)));
//end;

{ TWkeApp }

constructor TWkeApp.Create(Aowner: TComponent);
begin
  inherited;
  FWkeWebPages := TList{$IFDEF DELPHI15_UP}<TWkeWebBrowser>{$ENDIF}.create;
end;

destructor TWkeApp.Destroy;
begin
  FWkeWebPages.Clear;
  FWkeWebPages.Free;
  WkeFinalizeAndUnloadLib;
  inherited;
end;

procedure TWkeApp.loaded;
begin
  inherited;
  if csDesigning in Componentstate then
    exit;
  WkeLoadLibAndInit;

end;

procedure TWkeApp.CloseWebbrowser(Abrowser: TWkewebbrowser);
begin
  FWkeWebPages.Remove(Abrowser);
end;

function TWkeApp.CreateWebbrowser(Aparent: TWincontrol; Ar: Trect): TWkeWebBrowser;
var
  newBrowser: TWkeWebBrowser;
begin
  if wkeLibHandle = 0 then
    RaiseLastOSError;
  newBrowser := TWkeWebBrowser.Create(Aparent);
  newBrowser.WkeApp := self;
  newBrowser.Parent := Aparent;
  newBrowser.BoundsRect := Ar;
  newBrowser.OnCreateView := DoOnNewWindow;
  //设置初始值
  if FUserAgent <> '' then
    newBrowser.UserAgent := FUserAgent;
  newBrowser.CookieEnabled := FCookieEnabled;
  if DirectoryExists(FCookiePath) then
    newBrowser.CookiePath := FCookiePath;
  FWkeWebPages.Add(newBrowser);
  result := newBrowser;
  wkeSetNavigationToNewWindowEnable(newBrowser.thewebview, true);

  wkeSetCspCheckEnable(newBrowser.thewebview, False);
end;

function TWkeApp.CreateWebbrowser(Aparent: TWincontrol): TWkeWebBrowser;
var
  newBrowser: TWkeWebBrowser;
begin
  newBrowser := CreateWebbrowser(Aparent, Rect(0, 0, 100, 100));
  newBrowser.Align := alClient;
  result := newBrowser;
end;

procedure TWkeApp.DoOnNewWindow(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures:
  PwkeWindowFeatures; var wvw: wkeWebView);
var
  Openflag: TNewWindowFlag;
  NewwebPage: TWkeWebBrowser;
begin
  Openflag := nwf_NewPage;
  NewwebPage := nil;
  if Assigned(FOnNewWindow) then
    FOnNewWindow(Self, sUrl, navigationType, windowFeatures, Openflag, NewwebPage);
  case Openflag of
    nwf_Cancel:
      wvw := nil;
    nwf_NewPage:
      begin
        if NewwebPage <> nil then
          wvw := NewwebPage.thewebview;
      end;
    nwf_OpenInCurrent:
      wvw := TWkeWebBrowser(Sender).thewebview;
  end;
end;

function TWkeApp.GetWkeCookiePath: string;
begin
  result := FCookiePath;
end;

function TWkeApp.GetWkeLibLocation: string;
begin
  result := wkeLibFileName;
end;

function TWkeApp.GetWkeUserAgent: string;
begin
  result := FUserAgent;
end;

procedure TWkeApp.SetCookieEnabled(const Value: boolean);
begin
  FCookieEnabled := Value;
end;

procedure TWkeApp.SetWkeCookiePath(const Value: string);
begin
  FCookiepath := Value;
end;

procedure TWkeApp.SetWkeLibLocation(const Value: string);
begin
  if FileExists(Value) then
    wkeLibFileName := Value;
end;

procedure TWkeApp.SetWkeUserAgent(const Value: string);
begin
  FUserAgent := Value;
end;

end.


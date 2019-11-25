{ ******************************************************* }
{ }
{ WKE FOR DELPHI }
{ }
{ 版权所有 (C) 2018 Langji }
{ }
{ QQ:231850275 }
{ }
{ ******************************************************* }

unit Langji.Wke.Webbrowser;

// ==============================================================================
// WKE FOR DELPHI
// ==============================================================================

interface

{$I delphiver.inc}

uses
{$IFDEF DELPHI15_UP}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.graphics, Vcl.Forms, System.Generics.Collections,
{$ELSE}
  SysUtils, Classes, Controls, graphics, Forms,
{$ENDIF}
  Messages, windows, Langji.Wke.types, Langji.Wke.lib;
// Langji.Miniblink.libs, Langji.Miniblink.types,

type
  TWkeApp = class;

  TWkeWebBrowser = class;

  TOnNewWindowEvent = procedure(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures:
    PwkeWindowFeatures; var openflg: TNewWindowFlag; var webbrow: TWkeWebBrowser) of object;

  TOnmbJsBindFunction = procedure(Sender: TObject; const msgid: Integer; const msgText: string) of object;

  // 浏览页面
  TWkeWebBrowser = class(TWinControl)
  private
    thewebview: TwkeWebView;
    FwkeApp: TWkeApp;
  //  FCanBack, FCanForward: boolean;
    FLocalUrl, FLocalTitle: string; // 当前Url Title
    FpopupEnabled: boolean; // 允许弹窗
    FCookieEnabled: boolean;
    FZoomValue: Integer;
    FLoadFinished: boolean; // 加载完
    FIsmain: boolean;
    FPlatform: TwkePlatform;
    FDocumentIsReady: boolean; // 加载完

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

    // webview
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
    procedure WM_SIZE(var msg: TMessage); message WM_SIZE;
    function GetCanBack: boolean;
    function GetCanForward: boolean;
    function GetCookieEnable: boolean;
    function GetLocationTitle: string;
    function GetLocationUrl: string;
    // function GetMediaVolume: Single;
    function GetLoadFinished: boolean;
    function GetWebHandle: Hwnd;
    /// <summary>
    /// 格式为：PRODUCTINFO=webxpress; domain=.fidelity.com; path=/; secure
    /// </summary>
    procedure SetCookie(const Value: string);
    function GetCookie: string;
    procedure SetLocaStoragePath(const Value: string);
    procedure SetHeadless(const Value: boolean);
    procedure SetTouchEnabled(const Value: boolean);
    procedure SetProxy(const Value: TwkeProxy);
    procedure SetDragEnabled(const Value: boolean);
    procedure setWkeCookiePath(const Value: string);
    procedure SetNewPopupEnabled(const Value: boolean);
    function getDocumentReady: boolean;
    function GetContentHeight: Integer;
    function GetContentWidth: Integer;
    procedure setUserAgent(const Value: string);

    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WndProc(var msg: TMessage); override;
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
    /// 加载HTMLCODE
    /// </summary>
    procedure LoadHtml(const Astr: string);
    /// <summary>
    /// 加载文件
    /// </summary>
    procedure LoadFile(const AFile: string);
    /// <summary>
    /// 执行js 返回值 为执行成功与否
    /// </summary>
    function ExecuteJavascript(const js: string): boolean;

    /// <summary>
    /// 执行js并得到string返回值
    /// </summary>
    function GetJsTextResult(const js: string): string;
    /// <summary>
    /// 执行js并得到boolean返回值
    /// </summary>
    function GetJsBoolResult(const js: string): boolean;

    /// <summary>
    /// 取webview 的DC
    /// </summary>
    function GetWebViewDC: HDC;
    procedure SetFocusToWebbrowser;
    procedure ShowDevTool; // 2018.3.14
    /// <summary>
    /// 取源码
    /// </summary>
    function GetSource: string;

    /// <summary>
    /// 模拟鼠标
    /// </summary>
    /// <param name=" msg">WM_MouseMove 等</param>
    /// <param name=" x,y">坐标</param>
    /// <param name=" flag">wke_lbutton 左键 、右键等 </param>
    procedure MouseEvent(const msg: Cardinal; const x, y: Integer; const flag: Integer = WKE_LBUTTON);
    /// <summary>
    /// 模拟键盘
    /// </summary>
    /// <param name=" flag">WKE_REPEAT等</param>
    procedure KeyEvent(const vkcode: Integer; const flag: Integer = 0);
    property CanBack: boolean read GetCanBack;
    property CanForward: boolean read GetCanForward;
    property LocationUrl: string read GetLocationUrl;
    property LocationTitle: string read GetLocationTitle;
    property LoadFinished: boolean read GetLoadFinished; // 加载完成
    property mainwkeview: TwkeWebView read thewebview;
    property WebViewHandle: Hwnd read GetWebHandle;
    property isMain: boolean read FIsmain;
    property IsDocumentReady: boolean read getDocumentReady;
    property Proxy: TwkeProxy write SetProxy;
    property ZoomPercent: Integer read GetZoom write SetZoom;
    property Headless: boolean write SetHeadless;
    property TouchEnabled: boolean write SetTouchEnabled;
    property DragEnabled: boolean write SetDragEnabled;
    property ContentWidth: Integer read GetContentWidth;
    property ContentHeight: Integer read GetContentHeight;
  published
    property Align;
    property Color;
    property Visible;
    property WkeApp: TWkeApp read FwkeApp write FwkeApp;
    property UserAgent: string read FUserAgent write setUserAgent;
    property CookieEnabled: boolean read FCookieEnabled write FCookieEnabled default true;
    property CookiePath: string read FCookiePath write setWkeCookiePath;
    /// <summary>
    /// Cookie格式为：PRODUCTINFO=webxpress; domain=.fidelity.com; path=/; secure
    /// </summary>
    property Cookie: string read GetCookie write SetCookie;
    property LocalStoragePath: string write SetLocaStoragePath;
    property PopupEnabled: boolean read FpopupEnabled write SetNewPopupEnabled default true;
    property OnTitleChange: TOnTitleChangeEvent read FOnTitleChange write FOnTitleChange;
    property OnUrlChange: TOnUrlChangeEvent read FOnUrlChange write FOnUrlChange;
    property OnBeforeLoad: TOnBeforeLoadEvent read FOnLoadStart write FOnLoadStart;
    property OnLoadEnd: TOnLoadEndEvent read FOnLoadEnd write FOnLoadEnd;
    property OnCreateView: TOnCreateViewEvent read FOnCreateView write FOnCreateView;
    property OnWindowClosing: TNotifyEvent read FOnWindowClosing write FOnWindowClosing;
    property OnWindowDestroy: TNotifyEvent read FOnWindowDestroy write FOnWindowDestroy;
    property OnDocumentReady: TNotifyEvent read FOnDocumentReady write FOnDocumentReady;
    property OnAlertBox: TOnAlertBoxEvent read FOnAlertBox write FOnAlertBox;
    property OnConfirmBox: TOnConfirmBoxEvent read FOnConfirmBox write FOnConfirmBox;
    property OnPromptBox: TOnPromptBoxEvent read FOnPromptBox write FOnPromptBox;
    property OnDownloadFile: TOnDownloadEvent read FOnDownload write FOnDownload;
    property OnMouseOverUrlChanged: TOnUrlChangeEvent read FOnMouseOverUrlChange write FOnMouseOverUrlChange; // 2018.3.14
    property OnConsoleMessage: TOnConsoleMessgeEvent read FOnConsoleMessage write FOnConsoleMessage;
    property OnLoadUrlBegin: TOnLoadUrlBeginEvent read FOnLoadUrlBegin write FOnLoadUrlBegin;
    property OnLoadUrlEnd: TOnLoadUrlEndEvent read FOnLoadUrlEnd write FOnLoadUrlEnd;
    property OnmbJsBindFunction: TOnmbJsBindFunction read FOnmbBindFunction write FOnmbBindFunction;
  end;

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
    procedure setWkeCookiePath(const Value: string);
    procedure SetWkeLibLocation(const Value: string);
    procedure SetWkeUserAgent(const Value: string);
    procedure DoOnNewWindow(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures:
      PwkeWindowFeatures; var wvw: wkeWebView);
  public
    FWkeWebPages: TList{$IFDEF DELPHI15_UP}<TWkeWebBrowser>{$ENDIF};
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure loaded; override;
    function CreateWebbrowser(Aparent: TWinControl): TWkeWebBrowser; overload;
    function CreateWebbrowser(Aparent: TWinControl; Ar: Trect): TWkeWebBrowser; overload;
    procedure CloseWebbrowser(Abrowser: TWkeWebBrowser);
  published
    property WkelibLocation: string read GetWkeLibLocation write SetWkeLibLocation;
    property UserAgent: string read GetWkeUserAgent write SetWkeUserAgent;
    property CookieEnabled: boolean read FCookieEnabled write SetCookieEnabled;
    property CookiePath: string read GetWkeCookiePath write setWkeCookiePath;
    property OnNewWindow: TOnNewWindowEvent read FOnNewWindow write FOnNewWindow;
  end;

implementation

uses
  dialogs, math;



// ==============================================================================
// 回调事件
// ==============================================================================

procedure doDucumentReadyCallback(webView: wkeWebView; param: Pointer; frameid: wkeFrameHwnd); cdecl;
begin
  if wkeIsMainFrame(webView, Cardinal(frameid)) then
    TWkeWebBrowser(param).DoWebViewDocumentReady(TWkeWebBrowser(param));
end;

procedure DoTitleChange(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewTitleChange(TWkeWebBrowser(param), WkeStringtoString(title));
end;

procedure DoUrlChange(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewUrlChange(TWkeWebBrowser(param), WkeStringtoString(url));
end;

procedure DoMouseOverUrlChange(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewMouseOverUrlChange(TWkeWebBrowser(param), WkeStringtoString(url));
end;

procedure DoLoadEnd(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult; failedReason:
  wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewLoadEnd(TWkeWebBrowser(param), WkeStringtoString(url), result);
end;

var
  tmpSource: string = '';

function DoGetSource(p1, p2, es: jsExecState): jsValue;
begin
  tmpSource :=  Utf8ToAnsi( jsToTempString(es, jsArg(es, 0)));
  result := 0;
end;

function DoLoadStart(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString): boolean; cdecl;
var
  Cancel: boolean;
begin
  Cancel := false;
  TWkeWebBrowser(param).DoWebViewLoadStart(TWkeWebBrowser(param), WkeStringtoString(url), navigationType, Cancel);
  result := not Cancel;
end;

function DoCreateView(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString;
  windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;
var
  pt: Pointer;
begin
  TWkeWebBrowser(param).DoWebViewCreateView(TWkeWebBrowser(param), WkeStringtoString(url), navigationType, windowFeatures, pt);
  result := wkeWebView(pt);
end;

procedure DoPaintUpdated(webView: wkeWebView; param: Pointer; HDC: HDC; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;
begin

end;

procedure DoAlertBox(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewAlertBox(TWkeWebBrowser(param), WkeStringtoString(msg));
end;

function DoConfirmBox(webView: wkeWebView; param: Pointer; msg: wkeString): boolean; cdecl;
begin
  result := TWkeWebBrowser(param).DoWebViewConfirmBox(TWkeWebBrowser(param), WkeStringtoString(msg));
end;

function DoPromptBox(webView: wkeWebView; param: Pointer; msg: wkeString; defaultResult: wkeString; sresult: wkeString):
  boolean; cdecl;
begin
  result := TWkeWebBrowser(param).DoWebViewPromptBox(TWkeWebBrowser(param), WkeStringtoString(msg), WkeStringtoString(defaultResult),
    WkeStringtoString(sresult));
end;

procedure DoConsoleMessage(webView: wkeWebView; param: Pointer; level: wkeMessageLevel; const AMessage, sourceName:
  wkeString; sourceLine: Cardinal; const stackTrack: wkeString); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewConsoleMessage(TWkeWebBrowser(param), WkeStringtoString(AMessage), WkeStringtoString(sourceName),
    sourceLine, WkeStringtoString(stackTrack));
end;

procedure DocumentReady(webView: wkeWebView; param: Pointer); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewDocumentReady(TWkeWebBrowser(param));
end;

function DoWindowClosing(webWindow: wkeWebView; param: Pointer): boolean; cdecl;
begin
  TWkeWebBrowser(param).DoWebViewWindowClosing(TWkeWebBrowser(param));
end;

procedure DoWindowDestroy(webWindow: wkeWebView; param: Pointer); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewWindowDestroy(TWkeWebBrowser(param));
end;

function DodownloadFile(webView: wkeWebView; param: Pointer; url: PansiChar): boolean; cdecl; // url: wkeString): boolean; cdecl;
begin
  result := TWkeWebBrowser(param).DoWebViewDownloadFile(TWkeWebBrowser(param), StrPas(url)); // WkeStringtoString(url));
end;

procedure DoOnLoadUrlEnd(webView: wkeWebView; param: Pointer; const url: PansiChar; job: Pointer; buf: Pointer; len:
  Integer); cdecl;
begin
  TWkeWebBrowser(param).DoWebViewLoadUrlEnd(TWkeWebBrowser(param), StrPas(url), job, buf, len);
end;

function DoOnLoadUrlBegin(webView: wkeWebView; param: Pointer; url: PansiChar; job: Pointer): boolean; cdecl;
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

{ TWkeWebBrowser }

constructor TWkeWebBrowser.Create(AOwner: TComponent);
begin
  inherited;
  Color := clwhite;
  FZoomValue := 100;
  FCookieEnabled := true;
  FpopupEnabled := true;
  FUserAgent :=
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.1650.63 Safari/537.36 Langji.WKE 1.2';
  FPlatform := wp_Win32;
  FLocalUrl := '';
  FLocalTitle := '';
  FLocalStorage := '';
  FCookiePath := '';
end;

destructor TWkeWebBrowser.Destroy;
begin
  inherited;
end;

procedure TWkeWebBrowser.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if (csDesigning in ComponentState) then
    exit;
  if not Assigned(FwkeApp) then
    FIsmain := WkeLoadLibAndInit;
  CreateWebView;
end;

procedure TWkeWebBrowser.CreateWebView;

begin
  thewebview := wkeCreateWebWindow(WKE_WINDOW_TYPE_CONTROL, handle, 0, 0, Width, height);
  if Assigned(thewebview) then
  begin
    ShowWindow(GetWebHandle, SW_NORMAL);
    SetWindowLong(GetWebHandle, GWL_STYLE, GetWindowLong(GetWebHandle, GWL_STYLE) or WS_CHILD or WS_TABSTOP or
      WS_CLIPCHILDREN or WS_CLIPSIBLINGS);

    wkeOnTitleChanged(thewebview, DoTitleChange, Self);
    wkeOnURLChanged(thewebview, DoUrlChange, Self);
    wkeOnNavigation(thewebview, DoLoadStart, Self);
    wkeOnLoadingFinish(thewebview, DoLoadEnd, Self);
    wkeOnDocumentReady2(thewebview, doDucumentReadyCallback, Self);

    wkeOnWindowClosing(thewebview, DoWindowClosing, Self);
    wkeOnWindowDestroy(thewebview, DoWindowDestroy, Self);

    wkeOnPaintUpdated(thewebview, DoPaintUpdated, Self);
    if Assigned(FOnCreateView) then
      wkeOnCreateView(thewebview, DoCreateView, Self);
    if Assigned(FOnAlertBox) then
      wkeOnAlertBox(thewebview, DoAlertBox, Self);
    if Assigned(FOnConfirmBox) then
      wkeOnConfirmBox(thewebview, DoConfirmBox, Self);
    if Assigned(FOnPromptBox) then
      wkeOnPromptBox(thewebview, DoPromptBox, Self);

    wkeOnConsoleMessage(thewebview, DoConsoleMessage, Self);
    wkeOnLoadUrlBegin(thewebview, DoOnLoadUrlBegin, self);
    wkeOnLoadUrlEnd(thewebview, DoOnLoadUrlEnd, self);

    if Assigned(FOnDownload) then
      wkeOnDownload(thewebview, DodownloadFile, self);

    if Assigned(FOnMouseOverUrlChange) then
      wkeOnMouseOverUrlChanged(thewebview, DoMouseOverUrlChange, self);
    if FUserAgent <> '' then
     {$IFDEF UNICODE}
      wkeSetUserAgentw(thewebview, PChar(FUserAgent));
    {$ELSE}
    wkeSetUserAgent(thewebview, PansiChar(AnsiString(FUserAgent)));
    {$ENDIF}
    wkeSetCookieEnabled(thewebview, FCookieEnabled);

    if DirectoryExists(FCookiePath) and Assigned(wkeSetCookieJarPath) then
      wkeSetCookieJarPath(thewebview, PwideChar(FCookiePath));
    if DirectoryExists(FLocalStorage) and Assigned(wkeSetLocalStorageFullPath) then
      wkeSetLocalStorageFullPath(thewebview, PwideChar(FLocalStorage));

    wkeSetNavigationToNewWindowEnable(thewebview, FpopupEnabled);
    wkeSetCspCheckEnable(thewebview, false); // 关闭跨域检查
    jsBindFunction('GetSource', DoGetSource, 1);

  end;
end;



procedure TWkeWebBrowser.DoWebViewAlertBox(Sender: TObject; smsg: string);
begin
  if Assigned(FOnAlertBox) then
    FOnAlertBox(self, smsg);
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
    FOnConsoleMessage(self, AMessage, sourceName, sourceLine);

end;

procedure TWkeWebBrowser.DoWebViewCreateView(Sender: TObject; sUrl: string; navigationType: wkeNavigationType;
  windowFeatures: PwkeWindowFeatures; var wvw: Pointer);
var
 // newFrm: TForm;
  view: wkeWebView;
begin
  wvw := nil;
  if Assigned(FOnCreateView) then
  begin
    FOnCreateView(self, sUrl, navigationType, windowFeatures, view);
    wvw := view;
  end;
  if not Assigned(wvw) then
  begin
    wvw := wkeCreateWebWindow(WKE_WINDOW_TYPE_POPUP, 0, windowFeatures.x, windowFeatures.y, windowFeatures.Width,
      windowFeatures.height);
    wkeShowWindow(wvw, true);
    wkeSetWindowTitleW(wvw, PwideChar(sUrl));
  end
  else
  begin
    if wkeGetWindowHandle(wvw) = 0 then
      wvw := thewebview;
  end;
end;

procedure TWkeWebBrowser.DoWebViewDocumentReady(Sender: TObject);
begin
  FDocumentIsReady := true;
  if Assigned(FOnDocumentReady) then
    FOnDocumentReady(self);
end;

function TWkeWebBrowser.DoWebViewDownloadFile(Sender: TObject; sUrl: string): boolean;
begin
  if Assigned(FOnDownload) then
    FOnDownload(self, sUrl);
end;

procedure TWkeWebBrowser.DoWebViewLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
begin
  FLoadFinished := true;
  FLocalUrl := sUrl;
  if Assigned(FOnLoadEnd) then
    FOnLoadEnd(self, sUrl, loadresult);
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
  // bhook:=true 表示hook会触发onloadurlend 如果只是设置 bhandle=true表示 ，只是拦截这个URL
  if Assigned(FOnLoadUrlBegin) then
    FOnLoadUrlBegin(self, sUrl, bhook, bHandle);
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
    FOnWindowClosing(self);
end;

procedure TWkeWebBrowser.DoWebViewWindowDestroy(Sender: TObject);
begin
  if Assigned(FOnWindowDestroy) then
    FOnWindowDestroy(self);
end;

function TWkeWebBrowser.ExecuteJavascript(const js: string): boolean; // 执行js
var
  newjs: AnsiString;
  r: jsValue;
  es: jsExecState;
begin
  result := false;
  newjs := 'try { ' + js + '; return 1; } catch(err){ return 0;}';
  if Assigned(thewebview) then
  begin
    r := wkeRunJS(thewebview, PansiChar(ansitoutf8(newjs)));
    es := wkeGlobalExec(thewebview);
    if jsIsNumber(r) then
    begin
      if jsToint(es, r) = 1 then
        result := true;
    end;
  end;

end;

function TWkeWebBrowser.GetJsTextResult(const js: string): string;
var
  r: jsValue;
  es: jsExecState;
begin
  result := '';
  if Assigned(thewebview) then
  begin
    r := wkeRunJS(thewebview, PansiChar(ansitoutf8(js)));
    es := wkeGlobalExec(thewebview);
    if jsIsString(r) then
      result := jsToTempString(es, r);
  end;
end;

function TWkeWebBrowser.GetJsBoolResult(const js: string): boolean;
var
  r: jsValue;
  es: jsExecState;
begin
  if Assigned(thewebview) then
  begin
    r := wkeRunJS(thewebview, PansiChar(ansitoutf8(js)));
    es := wkeGlobalExec(thewebview);
    if jsIsBoolean(r) then
      result := jsToBoolean(es, r);
  end;
end;

function TWkeWebBrowser.GetCanBack: boolean;
begin
  if Assigned(thewebview) then
    result := wkeCanGoBack(thewebview);
end;

function TWkeWebBrowser.GetCanForward: boolean;
begin
  if Assigned(thewebview) then
    result := wkeCanGoForward(thewebview);
end;

function TWkeWebBrowser.GetContentHeight: Integer;
begin
  result := 0;
  if Assigned(thewebview) then
    result := wkeGetContentHeight(thewebview);
end;

function TWkeWebBrowser.GetContentWidth: Integer;
begin
  result := 0;
  if Assigned(thewebview) then
    result := wkeGetContentWidth(thewebview);
end;

function TWkeWebBrowser.GetCookie: string;
begin
  if Assigned(thewebview) then
  begin
    {$IFDEF UNICODE}
    result := wkeGetCookieW(thewebview);
    {$ELSE}
    result := Utf8ToAnsi(wkeGetCookie(thewebview));
    {$ENDIF}
  end;
end;

function TWkeWebBrowser.GetCookieEnable: boolean;
begin
  if Assigned(thewebview) then
    result := wkeIsCookieEnabled(thewebview);
end;

function TWkeWebBrowser.getDocumentReady: boolean;
begin
  result := false;
  if Assigned(thewebview) then
  begin
    result := FDocumentIsReady;
  end;
end;

function TWkeWebBrowser.GetLoadFinished: boolean;
begin
  result := FLoadFinished;
end;

function TWkeWebBrowser.GetLocationTitle: string;
begin
  if Assigned(thewebview) then
  begin
    {$IFDEF UNICODE}
    result := wkeGetTitleW(thewebview);
    {$ELSE}
    result := Utf8ToAnsi(wkeGetTitle(thewebview));
    {$ENDIF}

  end;

end;

function TWkeWebBrowser.GetLocationUrl: string;
begin
  if Assigned(thewebview) then
  begin
    result := Utf8ToAnsi(wkeGetUrl(thewebview));
  end;
end;

function TWkeWebBrowser.GetSource: string; // 取源码
begin
  tmpSource := '';
  if Assigned(thewebview) then
  begin
    ExecuteJavascript('GetSource(document.getElementsByTagName("html")[0].outerHTML);');
    Sleep(100);
    result := tmpSource;
  end;
end;

function TWkeWebBrowser.GetWebHandle: Hwnd;
begin
  result := 0;
  if Assigned(thewebview) then
    result := wkeGetWindowHandle(thewebview);
end;

function TWkeWebBrowser.GetWebViewDC: HDC;
begin
  result := 0;
  if Assigned(thewebview) then
    result := wkeGetViewDC(thewebview);
end;

procedure TWkeWebBrowser.setUserAgent(const Value: string);
begin
  FUserAgent := Value;
  if Assigned(thewebview) then
  begin
    {$IFDEF UNICODE}
    wkeSetUserAgentW(thewebview, PChar(Value));
    {$ELSE}
    wkeSetUserAgent(thewebview, PansiChar(AnsiString(Value)));
    {$ENDIF}
  end;
end;

procedure TWkeWebBrowser.setWkeCookiePath(const Value: string);
begin
  if DirectoryExists(Value) then
    FCookiePath := Value;
  if Assigned(thewebview) then
    wkeSetCookieJarPath(thewebview, PwideChar(Value));
end;

function TWkeWebBrowser.GetZoom: Integer;
begin
  if Assigned(thewebview) then
  begin
   // result := Trunc(power(1.2, thewebview.ZoomFactor) * 100)
    result := Trunc(wkeGetZoomFactor(thewebview));
  end
  else
    result := 100;
end;

procedure TWkeWebBrowser.GoBack;
begin
  if Assigned(thewebview) then
  begin
    if Self.CanBack then
      wkeGoBack(thewebview);
  end;
end;

procedure TWkeWebBrowser.GoForward;
begin
  if Assigned(thewebview) then
  begin
    if CanForward then
      wkeGoForward(thewebview);
  end;
end;

procedure TWkeWebBrowser.KeyEvent(const vkcode, flag: Integer);
begin
  if Assigned(thewebview) then
  begin
    wkeFireKeyDownEvent(thewebview, vkcode, flag, false);
    Sleep(10);
    wkeFireKeyUpEvent(thewebview, vkcode, flag, false);
  end;
end;

procedure TWkeWebBrowser.LoadFile(const AFile: string);
begin
  if Assigned(thewebview) and FileExists(AFile) then
  begin
    FLoadFinished := false;
{$IFDEF UNICODE}
    wkeLoadFileW(thewebview, PChar(AFile));
{$ELSE}
    wkeLoadFile(thewebview, PansiChar(ansitoutf8(AFile)));
{$ENDIF}
  end;

end;

procedure TWkeWebBrowser.LoadHtml(const Astr: string);
begin
  if Assigned(thewebview) then
  begin
    {$IFDEF UNICODE}
    wkeLoadHTMLw(thewebview, PChar(Astr));
{$ELSE}
    wkeLoadHTML(thewebview, PansiChar(ansitoutf8(Astr)));
{$ENDIF}
  end;

end;

procedure TWkeWebBrowser.LoadUrl(const Aurl: string);
begin
  if Assigned(thewebview) then
  begin
    {$IFDEF UNICODE}
    wkeLoadURLw(thewebview, PChar(Aurl));
{$ELSE}
    wkeLoadURL(thewebview, PansiChar(ansitoutf8(Aurl)));
{$ENDIF}
    MoveWindow(GetWebHandle, 0, 0, Width, height, true);
  end;
end;

procedure TWkeWebBrowser.MouseEvent(const msg: Cardinal; const x, y, flag: Integer);
begin
  if Assigned(thewebview) then
    wkeFireMouseEvent(thewebview, msg, x, y, flag);
end;

procedure TWkeWebBrowser.Refresh;
begin
  if Assigned(thewebview) then
    wkeReload(thewebview);
end;

procedure TWkeWebBrowser.SetCookie(const Value: string); // 设置cookie----------
begin
  if Assigned(thewebview) then
    wkeSetCookie(thewebview, PAnsiChar(AnsiToUtf8(LocationUrl)), PAnsiChar(AnsiToUtf8(Value)));
end;

procedure TWkeWebBrowser.SetFocusToWebbrowser;
begin
  if Assigned(thewebview) then
  begin
    wkeSetFocus(thewebview);
    SendMessage(WebViewHandle, WM_ACTIVATE, 1, 0);
  end;
end;

procedure TWkeWebBrowser.SetDragEnabled(const Value: boolean);
begin
  if Assigned(thewebview) then
    wkeSetDragEnable(thewebview, Value);
end;

procedure TWkeWebBrowser.SetHeadless(const Value: boolean);
begin
  if Assigned(thewebview) then
    wkeSetHeadlessEnabled(thewebview, Value);
end;

procedure TWkeWebBrowser.SetTouchEnabled(const Value: boolean);
begin
  if Assigned(thewebview) then
    wkeSetTouchEnabled(thewebview, Value);
end;

procedure TWkeWebBrowser.SetLocaStoragePath(const Value: string);
begin
  if Value <> FLocalStorage then
  begin
    FLocalStorage := Value;
    if Assigned(thewebview) then
    begin
      wkeSetLocalStorageFullPath(thewebview, PwideChar(Value));
      FLocalStorage := Value;
    end;
  end;

end;

procedure TWkeWebBrowser.SetNewPopupEnabled(const Value: boolean);
begin
  FpopupEnabled := Value;
  if Assigned(thewebview) then
    wkeSetNavigationToNewWindowEnable(thewebview, Value);
end;

procedure TWkeWebBrowser.setPlatform(const Value: TwkePlatform);
begin
  if not Assigned(thewebview) then
    exit;
  if FPlatform <> Value then
  begin
    case Value of
      wp_Win32:
        wkeSetDeviceParameter(thewebview, PansiChar('navigator.platform'), PansiChar('Win32'), 0, 0);
      wp_Android:
        begin
          wkeSetDeviceParameter(thewebview, PansiChar('navigator.platform'), PansiChar('Android'), 0, 0);
          wkeSetDeviceParameter(thewebview, PansiChar('screen.width'), PansiChar('800'), 400, 0);
          wkeSetDeviceParameter(thewebview, PansiChar('screen.height'), PansiChar('1600'), 800, 0);
        end;
      wp_Ios:
        wkeSetDeviceParameter(thewebview, PansiChar('navigator.platform'), PansiChar('Iphone'), 0, 0);
    end;
    FPlatform := Value;
  end;
end;

procedure TWkeWebBrowser.SetProxy(const Value: TwkeProxy);
begin
  if Assigned(thewebview) then
  begin
    wkeSetproxy(@Value);
    // wkeSetViewProxy(thewebview, @Value);
  end;

end;

procedure TWkeWebBrowser.ShowDevTool;
begin
  if Assigned(thewebview) then
  begin
    wkeSetDebugConfig(thewebview, 'showDevTools', PansiChar(AnsiToUtf8(ExtractFilePath(ParamStr(0)) +
      '\front_end\inspector.html')));
  end;
end;

procedure TWkeWebBrowser.SetZoom(const Value: Integer);
begin
  if Assigned(thewebview) then
  begin
   // thewebview.ZoomFactor := LogN(1.2, Value / 100);
    wkeSetZoomFactor(thewebview, Value);
  end;
end;

procedure TWkeWebBrowser.Stop;
begin
  if Assigned(thewebview) then
    wkeStopLoading(thewebview);

end;

procedure TWkeWebBrowser.WM_SIZE(var msg: TMessage);
begin
  inherited;
  if Assigned(thewebview) then
    MoveWindow(WebViewHandle, 0, 0, Width, height, true);
end;

procedure TWkeWebBrowser.WndProc(var msg: TMessage);
var
  hndl: Hwnd;
begin
  case msg.msg of
    WM_SETFOCUS:
      begin
        hndl := GetWindow(handle, GW_CHILD);
        if hndl <> 0 then
          PostMessage(hndl, WM_SETFOCUS, msg.WParam, 0);
        inherited WndProc(msg);
      end;
    CM_WANTSPECIALKEY: // VK_RETURN,
      if not (TWMKey(msg).CharCode in [VK_LEFT..VK_DOWN, VK_ESCAPE, VK_TAB]) then // 2018.07.26
        msg.result := 1
      else
        inherited WndProc(msg);
    WM_GETDLGCODE:
      msg.result := DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
  else
    inherited WndProc(msg);
  end;

end;









// procedure ShowLastError;
// var
// ErrorCode: DWORD;
// ErrorMessage: Pointer;
// begin
// ErrorCode := GetLastError;
// FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER or Format_MESSAGE_FROM_SYSTEM, nil, ErrorCode, 0, @ErrorMessage, 0, nil);
// showmessage('GetLastError Result: ' + IntToStr(ErrorCode) + #13 + 'Error Description: ' + string(Pchar(ErrorMessage)));
// end;

{ TWkeApp }

constructor TWkeApp.Create(AOwner: TComponent);
begin
  inherited;
  FWkeWebPages := TList{$IFDEF DELPHI15_UP}<TWkeWebBrowser>{$ENDIF}.Create;
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
  if csDesigning in ComponentState then
    exit;
  WkeLoadLibAndInit;

end;

procedure TWkeApp.CloseWebbrowser(Abrowser: TWkeWebBrowser);
begin
  FWkeWebPages.Remove(Abrowser);
end;

function TWkeApp.CreateWebbrowser(Aparent: TWinControl; Ar: Trect): TWkeWebBrowser;
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
  // 设置初始值
  if FUserAgent <> '' then
    newBrowser.UserAgent := FUserAgent;
  newBrowser.CookieEnabled := FCookieEnabled;
  if DirectoryExists(FCookiePath) then
    newBrowser.CookiePath := FCookiePath;
  FWkeWebPages.Add(newBrowser);
  result := newBrowser;
  wkeSetNavigationToNewWindowEnable(newBrowser.thewebview, true);

  wkeSetCspCheckEnable(newBrowser.thewebview, false);
end;

function TWkeApp.CreateWebbrowser(Aparent: TWinControl): TWkeWebBrowser;
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
    FOnNewWindow(self, sUrl, navigationType, windowFeatures, Openflag, NewwebPage);
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

procedure TWkeApp.setWkeCookiePath(const Value: string);
begin
  FCookiePath := Value;
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


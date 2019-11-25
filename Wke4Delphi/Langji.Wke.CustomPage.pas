{ ******************************************************* }
{ }
{ WKE FOR DELPHI }
{ }
{ 版权所有 (C) 2018 Langji }
{ }
{ QQ:231850275 }
{ }
{ ******************************************************* }

unit Langji.Wke.CustomPage;

interface

{$I delphiver.inc}

uses
{$IFDEF DELPHI15_UP}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.graphics, Vcl.Forms,
{$ELSE}
  SysUtils, Classes, Controls, graphics, Forms,
{$ENDIF}
  Messages, windows,Langji.Wke.lib, Langji.Wke.types;

type
  TCustomWkePage = class(TComponent)
  private
    thewebview: TwkeWebView;
    FZoomValue: Integer;
    FLoadFinished: boolean;
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
    FCookieEnabled: boolean;
    FwkeCookiePath: string;
    FwkeUserAgent: string;
    FHtmlFile: string;
    FWindowTop: Integer;
    FWindowHeight: Integer;
    FWindowLeft: Integer;
    FWindowWidth: Integer;
    FOnPromptBox: TOnPromptBoxEvent;
    FOnConsoleMessage: TOnConsoleMessgeEvent;
    FisReady: boolean;
    function GetZoom: Integer;
    procedure SetZoom(const Value: Integer);

    // webview   callbacks
    procedure DoWebViewTitleChange(Sender: TObject; sTitle: string);
    procedure DoWebViewUrlChange(Sender: TObject; sUrl: string);
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
    function GetCanBack: boolean;
    function GetCanForward: boolean;
    function GetCookieEnable: boolean;
    function GetLocationTitle: string;
    function GetLocationUrl: string;
    function GetTransparent: boolean;
    procedure SetTransparent(const Value: boolean);
    function GetLoadFinished: boolean;
    function GetWebHandle: Hwnd;
    procedure SetCaption(const Value: string);
    procedure SetHeadless(const Value: boolean);
    function GetCookie: string;
    procedure SetCookie(const Value: string);
    { Private declarations }

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowWebPage;
    procedure ClosePage;
    procedure HidePage;
    procedure CreateWebView; virtual; abstract;
    procedure GoBack;
    procedure GoForward;
    procedure Refresh;
    procedure Stop;
    procedure LoadUrl(const Aurl: string);
    procedure LoadHtml(const Astr: string);
    procedure LoadFile(const AFile: string);
    procedure SetFocusToWebbrowser;
    function ExecuteJavascript(const js: string): boolean;
    function GetSource(const delay: Integer = 200): string;

    /// <summary>
    /// 执行js并得到string返回值
    /// </summary>
    function GetJsTextResult(const js: string): string;
    property CanBack: boolean read GetCanBack;
    property CanForward: boolean read GetCanForward;
    property LocationUrl: string read GetLocationUrl;
    property LocationTitle: string read GetLocationTitle;
    property LoadFinished: boolean read GetLoadFinished; // 加载完成
    property Transparent: boolean read GetTransparent write SetTransparent;
    property Mainwkeview: TwkeWebView read thewebview;
  published
    property Caption: string write SetCaption;
    property WindowLeft: Integer read FWindowLeft write FWindowLeft;
    property WindowTop: Integer read FWindowTop write FWindowTop;
    property WindowWidth: Integer read FWindowWidth write FWindowWidth;
    property WindowHeight: Integer read FWindowHeight write FWindowHeight;
    property UserAgent: string read FwkeUserAgent write FwkeUserAgent;
    property HtmlFile: string read FHtmlFile write FHtmlFile;
    property WindowHandle: Hwnd read GetWebHandle;
    property isReady: boolean read FisReady write FisReady;
    property Headless: boolean write SetHeadless;
    property CookieEnabled: boolean read FCookieEnabled write FCookieEnabled default true;
    property CookiePath: string read FwkeCookiePath write FwkeCookiePath;
    property Cookie: string read GetCookie write SetCookie;
    property ZoomPercent: Integer read GetZoom write SetZoom;
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
    property OnConsoleMessage: TOnConsoleMessgeEvent read FOnConsoleMessage write FOnConsoleMessage;
  end;

  TWkeTransparentPage = class(TCustomWkePage)
  protected
    procedure CreateWebView; override;
  end;

  TWkePopupPage = class(TCustomWkePage)
  private
    FVisible, FHeadLess: boolean;
  protected

    procedure CreateWebView; override;
  end;

  TWkeGetSource = class
  private
    Fwke: TWkePopupPage;
    function GetSourceHtml: string;
    function GetSourceText: string;

    function getReady: boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure ShowWebPage(const bVisible, bHeadLess: boolean);
    procedure LoadUrl(const Aurl: string);
    property SourceHtml: string read GetSourceHtml;
    property SourceText: string read GetSourceText;
    property isReady: boolean read getReady;
  end;

  /// <summary>
  /// wke打开网页取源码，用于js动态网页
  /// <param name="AshowWindow ">是否显示窗口</param>
  /// <param name="AHeadLess">无渲染模式</param>
  /// <param name="Adelay">打开网址后等待几 ms再取源码</param>
  /// </summary>
function GetSourceByWke(const Aurl: string; const AshowWindow: boolean; const ADelay: Integer): string; overload;

function GetSourceByWke(const Aurl: string; const AshowWindow, AHeadLess: boolean; const ADelay: Integer): string; overload;

function GetSourceTextByWke(const Aurl: string; const AshowWindow, AHeadLess: boolean; const ADelay: Integer): string;

var
  tmpSource: string = '';

implementation

uses
  math;

procedure doDucumentReadyCallback(webView: wkeWebView; param: Pointer; frameid: wkeFrameHwnd); cdecl;
begin
  if wkeIsMainFrame(webView, Cardinal(frameid)) then
    TCustomWkePage(param).DoWebViewDocumentReady(TCustomWkePage(param));
end;

procedure DoTitleChange(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewTitleChange(TCustomWkePage(param), WkeStringtoString(title));
end;

procedure DoUrlChange(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewUrlChange(TCustomWkePage(param), WkeStringtoString(url));
end;

procedure DoLoadEnd(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult; failedReason:
  wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewLoadEnd(TCustomWkePage(param), WkeStringtoString(url), result);
end;

function DoLoadStart(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString): boolean; cdecl;
var
  Cancel: boolean;
begin
  Cancel := false;
  TCustomWkePage(param).DoWebViewLoadStart(TCustomWkePage(param), WkeStringtoString(url), navigationType, Cancel);
  result := not Cancel;
end;

function DoCreateView(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString;
  windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;
var
  pt: Pointer;
begin
  TCustomWkePage(param).DoWebViewCreateView(TCustomWkePage(param), WkeStringtoString(url), navigationType, windowFeatures, pt);
  result := wkeWebView(pt);
end;

procedure DoPaintUpdated(webView: wkeWebView; param: Pointer; hdc: hdc; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;
begin

end;

procedure DoAlertBox(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewAlertBox(TCustomWkePage(param), WkeStringtoString(msg));
end;

function DoConfirmBox(webView: wkeWebView; param: Pointer; msg: wkeString): boolean; cdecl;
begin
  result := TCustomWkePage(param).DoWebViewConfirmBox(TCustomWkePage(param), WkeStringtoString(msg));
end;

function DoPromptBox(webView: wkeWebView; param: Pointer; msg: wkeString; defaultResult: wkeString; sresult: wkeString):
  boolean; cdecl;
begin
  result := TCustomWkePage(param).DoWebViewPromptBox(TCustomWkePage(param), WkeStringtoString(msg), WkeStringtoString(defaultResult),
    WkeStringtoString(sresult));
end;

procedure DoConsoleMessage(webView: wkeWebView; param: Pointer; level: wkeMessageLevel; const AMessage, sourceName:
  wkeString; sourceLine: Cardinal; const stackTrack: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewConsoleMessage(TCustomWkePage(param), WkeStringtoString(AMessage), WkeStringtoString(sourceName),
    sourceLine, WkeStringtoString(stackTrack));
end;

procedure DoDocumentReady(webView: wkeWebView; param: Pointer); cdecl;
begin
  TCustomWkePage(param).DoWebViewDocumentReady(TCustomWkePage(param));
end;

function DoWindowClosing(webWindow: wkeWebView; param: Pointer): boolean; cdecl;
begin
  TCustomWkePage(param).DoWebViewWindowClosing(TCustomWkePage(param));
end;

procedure DoWindowDestroy(webWindow: wkeWebView; param: Pointer); cdecl;
begin
  TCustomWkePage(param).DoWebViewWindowDestroy(TCustomWkePage(param));
end;

function DoGetSource(p1, p2, es: jsExecState): jsValue;
begin
  tmpSource :=Utf8ToAnsi( jsToTempString(es, jsArg(es, 0)));
  result := 0;
end;

{ TCustomWkePage }

constructor TCustomWkePage.Create(AOwner: TComponent);
begin
  inherited;
  FZoomValue := 100;
  FCookieEnabled := true;
  FWindowLeft := 10;
  FWindowTop := 10;
  FWindowWidth := 640;
  FWindowHeight := 480;
  FwkeUserAgent :=
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36 Langji.Wke 1.2';
end;

destructor TCustomWkePage.Destroy;
begin
  try
    if Assigned(thewebview) then
      wkeDestroyWebWindow(thewebview);
  except
  end;
  inherited;
end;



procedure TCustomWkePage.ShowWebPage;
begin
  if not IsWindow(wkeGetWindowHandle(thewebview)) then
    CreateWebView;
  ShowWindow(wkeGetWindowHandle(thewebview), SW_NORMAL);
  if FileExists(FHtmlFile) then
{$IFDEF UNICODE}
    wkeLoadFileW(thewebview, PChar(FHtmlFile));
{$ELSE}
  wkeLoadFile(thewebview, PChar(ansitoutf8(FHtmlFile)));
{$ENDIF}
end;

procedure TCustomWkePage.ClosePage;
begin
  try
    if Assigned(thewebview) then
      wkeDestroyWebWindow(thewebview);
  except
  end;
end;

procedure TCustomWkePage.DoWebViewAlertBox(Sender: TObject; smsg: string);
begin
  if Assigned(FOnAlertBox) then
    FOnAlertBox(Self, smsg);
end;

function TCustomWkePage.DoWebViewConfirmBox(Sender: TObject; smsg: string): boolean;
begin
  result := false;
  if Assigned(FOnConfirmBox) then
    FOnConfirmBox(Self, smsg, result);
end;

procedure TCustomWkePage.DoWebViewConsoleMessage(Sender: TObject; const AMessage, sourceName: string; sourceLine:
  Cardinal; const stackTrack: string);
begin
  if Assigned(FOnConsoleMessage) then
    FOnConsoleMessage(Self, AMessage, sourceName, sourceLine);
end;

procedure TCustomWkePage.DoWebViewCreateView(Sender: TObject; sUrl: string; navigationType: wkeNavigationType;
  windowFeatures: PwkeWindowFeatures; var wvw: Pointer);
var
  newvw: TwkeWebView;
begin
  wvw := nil;
  newvw := nil;
  if Assigned(FOnCreateView) then
    FOnCreateView(Self, sUrl, navigationType, windowFeatures, newvw);
end;

procedure TCustomWkePage.DoWebViewDocumentReady(Sender: TObject);
begin
  FisReady := true;
  if Assigned(FOnDocumentReady) then
    FOnDocumentReady(Self);
end;

procedure TCustomWkePage.DoWebViewLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
begin
  if Assigned(FOnLoadEnd) then
    FOnLoadEnd(Self, sUrl, loadresult);
  FLoadFinished := true;
end;

procedure TCustomWkePage.DoWebViewLoadStart(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel:
  boolean);
begin
  FisReady := false;
  if Assigned(FOnLoadStart) then
    FOnLoadStart(Self, sUrl, navigationType, Cancel);
  FLoadFinished := false;
end;

function TCustomWkePage.DoWebViewPromptBox(Sender: TObject; smsg, defaultres, Strres: string): boolean;
begin
  if Assigned(FOnPromptBox) then
    FOnPromptBox(Self, smsg, defaultres, Strres, result);
end;

procedure TCustomWkePage.DoWebViewTitleChange(Sender: TObject; sTitle: string);
begin
  if Assigned(FOnTitleChange) then
    FOnTitleChange(Self, sTitle);
end;

procedure TCustomWkePage.DoWebViewUrlChange(Sender: TObject; sUrl: string);
begin
  if Assigned(FOnUrlChange) then
    FOnUrlChange(Self, sUrl);
end;

procedure TCustomWkePage.DoWebViewWindowClosing(Sender: TObject);
begin
  if Assigned(FOnWindowClosing) then
    FOnWindowClosing(Self);
end;

procedure TCustomWkePage.DoWebViewWindowDestroy(Sender: TObject);
begin
  if Assigned(FOnWindowDestroy) then
    FOnWindowDestroy(Self);
end;

function TCustomWkePage.ExecuteJavascript(const js: string): boolean;
var
  newjs: string;
  r: jsValue;
  es: jsExecState;
begin
  result := false;
  newjs := 'try { ' + js + ' return 1; } catch(err){ return 0;}';
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

function TCustomWkePage.GetCanBack: boolean;
begin
  if Assigned(thewebview) then
    result := wkeCanGoBack(thewebview);
end;

function TCustomWkePage.GetCanForward: boolean;
begin
  if Assigned(thewebview) then
    result := wkeCanGoForward(thewebview);
end;

function TCustomWkePage.GetCookie: string;
begin
  if Assigned(thewebview) then
    result :=Utf8ToAnsi( wkeGetCookie(thewebview));
end;

function TCustomWkePage.GetCookieEnable: boolean;
begin
  if Assigned(thewebview) then
    result := wkeIsCookieEnabled(thewebview);
end;

function TCustomWkePage.GetJsTextResult(const js: string): string;
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
      result := Utf8ToAnsi(jsToTempString(es, r));
  end;
end;

function TCustomWkePage.GetLoadFinished: boolean;
begin
  result := FLoadFinished;
end;

function TCustomWkePage.GetLocationTitle: string;
begin
  if Assigned(thewebview) then
    {$IFDEF UNICODE}
    result := wkeGetTitleW(thewebview);
    {$ELSE}
    result := Utf8ToAnsi(wkeGetTitle(thewebview));
    {$ENDIF}
end;

function TCustomWkePage.GetLocationUrl: string;
begin
  if Assigned(thewebview) then
    result := Utf8ToAnsi(wkeGetURL(thewebview));
end;

function TCustomWkePage.GetSource(const delay: Integer = 200): string;
    // 获取源码
begin
  result := '';
  if Assigned(thewebview) then
    ExecuteJavascript('GetSource(document.getElementsByTagName("html")[0].outerHTML);');
  Sleep(delay);
  result := tmpSource;
end;

function TCustomWkePage.GetTransparent: boolean;
begin
  if Assigned(thewebview) then
    result := wkeIsTransparent(thewebview)
  else
    result := false;
end;

function TCustomWkePage.GetWebHandle: Hwnd;
begin
  result := 0;
  if Assigned(thewebview) then
    result := wkeGetWindowHandle(thewebview);
end;

procedure TCustomWkePage.SetTransparent(const Value: boolean);
begin
  if Assigned(thewebview) then
    wkeSetTransparent(thewebview, Value);
end;

function TCustomWkePage.GetZoom: Integer;
begin
  if Assigned(thewebview) then
    result := Trunc(wkeGetZoomFactor(thewebview))
    // Trunc(power(1.2, thewebview.ZoomFactor) * 100)
  else
    result := 100;
end;

procedure TCustomWkePage.GoBack;
begin
  if Assigned(thewebview) then
    wkeGoBack(thewebview);
end;

procedure TCustomWkePage.GoForward;
begin
  if Assigned(thewebview) then
    wkeGoForward(thewebview);
end;

procedure TCustomWkePage.HidePage;
begin
  if Assigned(thewebview) then
    ShowWindow(GetWebHandle, SW_HIDE);
end;

procedure TCustomWkePage.LoadFile(const AFile: string);
begin
  if Assigned(thewebview) then
{$IFDEF UNICODE}
    wkeLoadFileW(thewebview, PChar(AFile));
{$ELSE}
  wkeLoadFile(thewebview, PansiChar(ansitoutf8(AFile));
{$ENDIF}
end;

procedure TCustomWkePage.LoadHtml(const Astr: string);
begin
  if Assigned(thewebview) then
{$IFDEF UNICODE}
    wkeLoadHTMLw(thewebview, PChar(Astr));
{$ELSE}
  wkeLoadHTML(thewebview, PansiChar(ansitoutf8(Astr)));
{$ENDIF}
end;

procedure TCustomWkePage.LoadUrl(const Aurl: string);
begin
  if Assigned(thewebview) then
{$IFDEF UNICODE}
    wkeLoadURLw(thewebview, PChar(Aurl));
{$ELSE}
  wkeLoadURL(thewebview, PansiChar(ansitoutf8(Aurl));
{$ENDIF}
end;

procedure TCustomWkePage.Refresh;
begin
  if Assigned(thewebview) then
    wkeReload(thewebview);
end;

procedure TCustomWkePage.SetCaption(const Value: string);
begin
  if Assigned(thewebview) then
{$IFDEF UNICODE}
    wkeSetWindowTitleW(thewebview, PChar(Value));
{$ELSE}
  wkeSetWindowTitle(thewebview, PansiChar(ansitoutf8(Value));
{$ENDIF}
end;

procedure TCustomWkePage.SetCookie(const Value: string);
begin
  if Assigned(thewebview) then
    wkeSetCookie(thewebview, PAnsiChar(AnsiToUtf8(LocationUrl)), PAnsiChar(AnsiToUtf8(Value)));
end;

procedure TCustomWkePage.SetFocusToWebbrowser;
begin
  if Assigned(thewebview) then
    wkeSetFocus(thewebview);
end;

procedure TCustomWkePage.SetHeadless(const Value: boolean);
begin
  if Assigned(thewebview) then
    wkeSetHeadlessEnabled(thewebview, Value);
end;

procedure TCustomWkePage.SetZoom(const Value: Integer);
begin
  if Assigned(thewebview) then
    wkeSetZoomFactor(thewebview, Value);
    // thewebview.ZoomFactor := LogN(1.2, Value / 100);
end;

procedure TCustomWkePage.Stop;
begin
  if Assigned(thewebview) then
    wkeStopLoading(thewebview);
end;

    { TWkeTransparentPage }

procedure TWkeTransparentPage.CreateWebView;
begin
  thewebview := wkeCreateWebWindow(WKE_WINDOW_TYPE_TRANSPARENT, 0, FWindowLeft, FWindowTop, FWindowWidth, FWindowHeight);
  if Assigned(thewebview) then
  begin
    ShowWindow(GetWebHandle, SW_NORMAL);
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

    if FwkeUserAgent <> '' then
    {$IFDEF UNICODE}
      wkeSetUserAgentw(thewebview, PChar(FwkeUserAgent));
    {$ELSE}
    wkeSetUserAgent(thewebview, PansiChar(AnsiString(FwkeUserAgent)));
    {$ENDIF}
    wkeSetCookieEnabled(thewebview, FCookieEnabled);
    wkeSetNavigationToNewWindowEnable(thewebview, false);
    if DirectoryExists(FwkeCookiePath) and Assigned(wkeSetCookieJarPath) then
      wkeSetCookieJarPath(thewebview, PwideChar(FwkeCookiePath));

    wkeSetCspCheckEnable(thewebview, false); // 关闭跨域检查
    jsBindFunction('GetSource', DoGetSource, 1);
  end;

end;

    { TWkePopupPage }

procedure TWkePopupPage.CreateWebView;
begin
  thewebview := wkeCreateWebWindow(WKE_WINDOW_TYPE_POPUP, 0, FWindowLeft, FWindowTop, FWindowWidth, FWindowHeight);
  if Assigned(thewebview) then
  begin
    if not FVisible then
      ShowWindow(GetWebHandle, SW_HIDE)
    else
      ShowWindow(GetWebHandle, SW_NORMAL);

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

    if FwkeUserAgent <> '' then
     {$IFDEF UNICODE}
      wkeSetUserAgentw(thewebview, PChar(FwkeUserAgent));
    {$ELSE}
    wkeSetUserAgent(thewebview, PansiChar(AnsiString(FwkeUserAgent)));
    {$ENDIF}
    wkeSetCookieEnabled(thewebview, FCookieEnabled);
    wkeSetNavigationToNewWindowEnable(thewebview, false);
    if DirectoryExists(FwkeCookiePath) and Assigned(wkeSetCookieJarPath) then
      wkeSetCookieJarPath(thewebview, PwideChar(FwkeCookiePath));
    wkeSetHeadlessEnabled(thewebview,FHeadLess );
    wkeSetCspCheckEnable(thewebview, false); // 关闭跨域检查
    jsBindFunction('GetSource', DoGetSource, 1);
  end;
end;

    { TWkeGetSource }

constructor TWkeGetSource.Create;
begin
  Fwke := TWkePopupPage.Create(nil);
  Fwke.WindowLeft := 0; // -600;
  Fwke.WindowTop := 0; // -480;
  Fwke.WindowWidth := 600;
  Fwke.WindowHeight := 480;
  Fwke.UserAgent :=
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3747.0 Safari/537.36';
    // Fwke.OnAlertBox :=DoAlertBox;
    // 设置
    // FHeadless := false;
end;

destructor TWkeGetSource.Destroy;
begin
  Fwke.Free;
  inherited;
end;



function TWkeGetSource.getReady: boolean;
begin
  result := Fwke.isReady;
end;

function TWkeGetSource.GetSourceHtml: string;
begin
  result := Fwke.GetSource;
end;

function TWkeGetSource.GetSourceText: string;
begin
  Fwke.ExecuteJavascript('GetSource(document.getElementsByTagName("html")[0].outerText);');
  Sleep(100);
  result := tmpSource;
end;

procedure TWkeGetSource.LoadUrl(const Aurl: string);
begin
  Fwke.LoadUrl(Aurl);
  repeat
    Sleep(100);
    Application.ProcessMessages;
  until not Fwke.LoadFinished;
end;

procedure TWkeGetSource.ShowWebPage(const bVisible, bHeadLess: boolean);
begin
  Fwke.FHeadless := bHeadLess;
  Fwke.FVisible := bVisible;
  Fwke.CreateWebView;

end;

procedure Dodelay(const ADelay: Integer);
var
  i: Integer;
begin
  for i := 0 to ADelay div 100 - 1 do
  begin
    Sleep(100);
    Application.ProcessMessages;
  end;
end;

function GetSourceByWke(const Aurl: string; const AshowWindow, AHeadLess: boolean; const ADelay: Integer): string; overload;
var
  ntry: Integer;
begin
  result := '';
  with TWkeGetSource.Create do
  begin
    try
      ShowWebPage(AshowWindow, AHeadLess);
      LoadUrl(Aurl);
      ntry := 0;
      while not isReady do
      begin
        Sleep(100);
        Application.ProcessMessages;
        Inc(ntry);
        if ntry > 100 then
          break;
      end;
      Dodelay(ADelay);
      result := SourceHtml;
    finally
      Free;
    end;
  end;
end;

function GetSourceByWke(const Aurl: string; const AshowWindow: boolean; const ADelay: Integer): string;
begin
  result := GetSourceByWke(Aurl, AshowWindow, false, ADelay);
end;

function GetSourceTextByWke(const Aurl: string; const AshowWindow, AHeadLess: boolean; const ADelay: Integer): string;
var
  ntry: Integer;
begin
  result := '';
  with TWkeGetSource.Create do
  begin
    try
      ShowWebPage(AshowWindow, AHeadLess);
      LoadUrl(Aurl);
      ntry := 0;
      while not isReady do
      begin
        Sleep(100);
        Application.ProcessMessages;
        Inc(ntry);
        if ntry > 100 then
          break;
      end;
      Sleep(100);
      result := SourceText;
    finally
      Free;
    end;
  end;
end;

    {
      如果要使用本单元，
      请将下面的代码加入你要使用的单元初始化节

      initialization
        WkeLoadLibAndInit;




    }

end.


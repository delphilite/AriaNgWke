{*******************************************************}
{                                                       }
{       WKE FOR DELPHI                                  }
{                                                       }
{       版权所有 (C) 2018 Langji                        }
{                                                       }
{       QQ:231850275                                    }
{                                                       }
{*******************************************************}

unit Langji.Wke.CustomPage;

interface
{$I delphiver.inc}

uses
{$IFDEF DELPHI15_UP}
  System.SysUtils, System.Classes, Vcl.Controls, vcl.graphics, Vcl.Forms,
{$ELSE}
  SysUtils, Classes, Controls, Graphics, Forms,
{$ENDIF}
  Messages, windows, Langji.Wke.types, Langji.Wke.IWebBrowser, Langji.Wke.lib;

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
    FCookieEnabled: Boolean;
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

     //webview   callbacks
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
    function GetMediaVolume: Single;
    function GetTransparent: boolean;
    procedure SetTransparent(const Value: Boolean);
    function GetLoadFinished: Boolean;
    function GetWebHandle: Hwnd;
    procedure SetCaption(const Value: string);
    procedure SetHeadless(const Value: Boolean);
    function GetCookie: string;
    procedure SetCookie(const Value: string);
    { Private declarations }
  protected
    procedure loaded; override;
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
    ///   执行js并得到string返回值
    /// </summary>
    function GetJsTextResult(const js: string): string;
    property CanBack: boolean read GetCanBack;
    property CanForward: boolean read GetCanForward;
    property LocationUrl: string read GetLocationUrl;
    property LocationTitle: string read GetLocationTitle;
    property LoadFinished: Boolean read GetLoadFinished;       //加载完成
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property Mainwkeview: TWkeWebView read thewebview;
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
    property Headless: Boolean write SetHeadless;
    property CookieEnabled: Boolean read FCookieEnabled write FCookieEnabled default true;
    property CookiePath: string read FwkeCookiePath write FWkeCookiePath;
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
    FVisible, FHeadLess: Boolean;
  protected
    procedure CreateWebView; override;
  end;

  TWkeGetSource = class
  private
    Fwke: TWkePopupPage;
    function GetSourceHtml: string;
    function GetSourceText: string;
    procedure DoAlertBox(Sender: TObject; sMsg: string);
    function getReady: boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure ShowWebPage(const bVisible, bHeadLess: Boolean);
    procedure LoadUrl(const Aurl: string);
    property SourceHtml: string read GetSourceHtml;
    property SourceText: string read GetSourceText;
    property isReady: boolean read getReady;
  end;

/// <summary>
///  wke打开网页取源码，用于js动态网页
/// <param name="AshowWindow ">是否显示窗口</param>
/// <param name="AHeadLess">无渲染模式</param>
/// <param name="Adelay">打开网址后等待几 ms再取源码</param>
/// </summary>
function GetSourceByWke(const Aurl: string; const AshowWindow: Boolean; const ADelay: Integer): string; overload;

function GetSourceByWke(const Aurl: string; const AshowWindow, AHeadLess: Boolean; const ADelay: Integer): string; overload;

function GetSourceTextByWke(const Aurl: string; const AshowWindow, AHeadLess: Boolean; const ADelay: Integer): string;

var
  tmpSource: string = '';

implementation

uses //Vcl.Dialogs,
  math;

procedure doDucumentReadyCallback(webView: wkeWebView; param: Pointer; frameid: wkeFrameHwnd); cdecl;
begin
  if wkeIsMainFrame(webView, Cardinal(frameid)) then
    TCustomWkePage(param).DoWebViewDocumentReady(TCustomWkePage(param));
end;

procedure DoTitleChange(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewTitleChange(TCustomWkePage(param), wkeWebView.GetString(title));
end;

procedure DoUrlChange(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewUrlChange(TCustomWkePage(param), wkeWebView.GetString(url));
end;

procedure DoLoadEnd(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult; failedReason:
  wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewLoadEnd(TCustomWkePage(param), wkeWebView.GetString(url), result);
end;

function DoLoadStart(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString): Boolean; cdecl;
var
  cancel: boolean;
begin
  cancel := false;
  TCustomWkePage(param).DoWebViewLoadStart(TCustomWkePage(param), wkeWebView.GetString(url), navigationType, cancel);
  result := not cancel;
end;

function DoCreateView(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString;
  windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;
var
  pt: Pointer;
begin
  TCustomWkePage(param).DoWebViewCreateView(TCustomWkePage(param), wkeWebView.GetString(url), navigationType, windowFeatures, pt);
  result := wkeWebView(pt);
end;

procedure DoPaintUpdated(webView: wkeWebView; param: Pointer; hdc: hdc; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;
begin

end;

procedure DoAlertBox(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewAlertBox(TCustomWkePage(param), wkeWebView.GetString(msg));
end;

function DoConfirmBox(webView: wkeWebView; param: Pointer; msg: wkeString): Boolean; cdecl;
begin
  result := TCustomWkePage(param).DoWebViewConfirmBox(TCustomWkePage(param), wkeWebView.GetString(msg));
end;

function DoPromptBox(webView: wkeWebView; param: Pointer; msg: wkeString; defaultResult: wkeString; sresult: wkeString):
  Boolean; cdecl;
begin
  result := TCustomWkePage(param).DoWebViewPromptBox(TCustomWkePage(param), wkeWebView.GetString(msg), wkeWebView.GetString
    (defaultResult), wkeWebView.GetString(sresult));
end;

procedure DoConsoleMessage(webView: wkeWebView; param: Pointer; level: wkeMessageLevel; const AMessage, sourceName:
  wkeString; sourceLine: Cardinal; const stackTrack: wkeString); cdecl;
begin
  TCustomWkePage(param).DoWebViewConsoleMessage(TCustomWkePage(param), wkeWebView.GetString(AMessage), wkeWebView.GetString
    (sourceName), sourceLine, wkeWebView.GetString(stackTrack));
end;

procedure DoDocumentReady(webView: wkeWebView; param: Pointer); cdecl;
begin
  TCustomWkePage(param).DoWebViewDocumentReady(TCustomWkePage(param));
end;

function DoWindowClosing(webWindow: wkeWebView; param: Pointer): Boolean; cdecl;
begin
  TCustomWkePage(param).DoWebViewWindowClosing(TCustomWkePage(param));
end;

procedure DoWindowDestroy(webWindow: wkeWebView; param: Pointer); cdecl;
begin
  TCustomWkePage(param).DoWebViewWindowDestroy(TCustomWkePage(param));
end;

function DoGetSource(p1, p2, es: jsExecState): jsValue;
var
  s: string;
begin
  s := es.ToTempString(es.Arg(0));
  tmpSource := s;
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
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36 Langji.Wke 1.0';
end;

destructor TCustomWkePage.Destroy;
begin
  wkeDestroyWebWindow(thewebview);
  inherited;
end;

procedure TCustomWkePage.loaded;
begin
  inherited;
end;

procedure TCustomWkePage.ShowWebPage;
begin

  if not IsWindow(thewebview.WindowHandle) then
    CreateWebView;
  ShowWindow(thewebview.WindowHandle, SW_NORMAL);
  if FileExists(FHtmlFile) then
    thewebview.LoadFile(FHtmlFile);
end;

procedure TCustomWkePage.ClosePage;
begin
  CloseWindow(thewebview.WindowHandle);
  if Assigned(thewebview) then
    wkeDestroyWebWindow(thewebview);
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
    FOnConfirmBox(self, smsg, result);
end;

procedure TCustomWkePage.DoWebViewConsoleMessage(Sender: TObject; const AMessage, sourceName: string; sourceLine:
  Cardinal; const stackTrack: string);
begin
  if Assigned(FOnConsoleMessage) then
    FOnConsoleMessage(self, AMessage, sourceName, sourceLine);
end;

procedure TCustomWkePage.DoWebViewCreateView(Sender: TObject; sUrl: string; navigationType: wkeNavigationType;
  windowFeatures: PwkeWindowFeatures; var wvw: Pointer);
  var newvw:TWkeWebView;
begin
  wvw:=nil; newvw  :=nil;
  if Assigned(FOnCreateView) then
    FOnCreateView(self, sUrl, navigationType, windowFeatures, newvw);
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
    FOnLoadStart(self, sUrl, navigationType, Cancel);
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
    FOnTitleChange(self, sTitle);
end;

procedure TCustomWkePage.DoWebViewUrlChange(Sender: TObject; sUrl: string);
begin
  if Assigned(FOnUrlChange) then
    FOnUrlChange(self, sUrl);
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
    r := thewebview.RunJS(newjs);
    es := thewebview.GlobalExec;
    if es.IsNumber(r) then
    begin
      if es.Toint(r) = 1 then
        result := true;
    end;
  end;
end;

function TCustomWkePage.GetCanBack: boolean;
begin
  if Assigned(thewebview) then
    result := thewebview.CanGoBack;
end;

function TCustomWkePage.GetCanForward: boolean;
begin
  if Assigned(thewebview) then
    result := thewebview.CanGoForward;
end;

function TCustomWkePage.GetCookie: string;
begin
  if Assigned(thewebview) then
    result := thewebview.Cookie;
end;

function TCustomWkePage.GetCookieEnable: boolean;
begin
  if Assigned(thewebview) then
    result := thewebview.CookieEnabled;
end;

function TCustomWkePage.GetJsTextResult(const js: string): string;
var
  r: jsValue;
  es: jsExecState;
begin
  result := '';
  if Assigned(thewebview) then
  begin
    r := thewebview.RunJS(js);
    es := thewebview.GlobalExec;
    if es.IsString(r) then
      result := es.ToTempString(r);
  end;
end;

function TCustomWkePage.GetLoadFinished: Boolean;
begin
  result := FLoadFinished;
end;

function TCustomWkePage.GetLocationTitle: string;
begin
  if Assigned(thewebview) then
    result := wkeGetName(thewebview);
end;

function TCustomWkePage.GetLocationUrl: string;
begin
  if Assigned(thewebview) then
    result := wkeGetURL(thewebview);
end;

function TCustomWkePage.GetMediaVolume: Single;
begin
  if Assigned(thewebview) then
    result := thewebview.MediaVolume;
end;

function TCustomWkePage.GetSource(const delay: Integer = 200): string;    //获取源码
begin
  result := '';
  if Assigned(thewebview) then
    ExecuteJavascript('GetSource(document.getElementsByTagName("html")[0].outerHTML);');
  Sleep(delay);
  result := tmpSource;
  //showmessage(tmpSource);
end;

function TCustomWkePage.GetTransparent: boolean;
begin
  if Assigned(thewebview) then
    result := thewebview.Transparent
  else
    result := false;
end;

function TCustomWkePage.GetWebHandle: HWnd;
begin
  result := 0;
  if Assigned(thewebview) then
    result := thewebview.WindowHandle;
end;

procedure TCustomWkePage.SetTransparent(const Value: Boolean);
begin
  if Assigned(thewebview) then
    thewebview.Transparent := Value;
end;

function TCustomWkePage.getZoom: Integer;
begin
  if Assigned(thewebview) then
    result := Trunc(power(1.2, thewebview.ZoomFactor) * 100)
  else
    result := 100;
end;

procedure TCustomWkePage.GoBack;
begin
  if Assigned(thewebview) then
  begin
    if thewebview.CanGoBack then
      thewebview.GoBack;
  end;
end;

procedure TCustomWkePage.GoForward;
begin
  if Assigned(thewebview) then
  begin
    if thewebview.CanGoForward then
      thewebview.GoForward;
  end;
end;

procedure TCustomWkePage.HidePage;
begin
  if Assigned(thewebview) then
    ShowWindow(thewebview.WindowHandle, SW_HIDE);
end;

procedure TCustomWkePage.LoadFile(const AFile: string);
begin
  if Assigned(thewebview) then
    thewebview.LoadFile(AFile);
end;

procedure TCustomWkePage.LoadHtml(const Astr: string);
begin
  if Assigned(thewebview) then
    thewebview.LoadHTML(Astr);
end;

procedure TCustomWkePage.LoadUrl(const Aurl: string);
begin
  if Assigned(thewebview) then
  begin
    thewebview.LoadURL(Aurl);
  end;
end;

procedure TCustomWkePage.Refresh;
begin
  if Assigned(thewebview) then
    thewebview.Reload;
end;

procedure TCustomWkePage.SetCaption(const Value: string);
begin
  if Assigned(thewebview) then
    thewebview.WindowTitle := Value;
end;

procedure TCustomWkePage.SetCookie(const Value: string);
begin
  if Assigned(thewebview) then
    thewebview.setcookie(Value);
end;

procedure TCustomWkePage.SetFocusToWebbrowser;
begin
  if Assigned(thewebview) then
    thewebview.SetFocus;
end;

procedure TCustomWkePage.SetHeadless(const Value: Boolean);
begin
  if Assigned(thewebview) then
    wkeSetHeadlessEnabled(thewebview, Value);
end;

procedure TCustomWkePage.SetZoom(const Value: Integer);
begin
  if Assigned(thewebview) then
    thewebview.ZoomFactor := LogN(1.2, Value / 100);
end;

procedure TCustomWkePage.Stop;
begin
  if Assigned(thewebview) then
    thewebview.StopLoading;
end;



{ TWkeTransparentPage }

procedure TWkeTransparentPage.CreateWebView;
begin
  thewebview := wkeCreateWebWindow(WKE_WINDOW_TYPE_TRANSPARENT, 0, FWindowLeft, FWindowTop, FWindowWidth, FWindowHeight);
  if Assigned(thewebview) then
  begin
    ShowWindow(thewebview.WindowHandle, SW_NORMAL);
    thewebview.SetOnTitleChanged(DoTitleChange, self);
    thewebview.SetOnURLChanged(DoUrlChange, self);
    thewebview.SetOnNavigation(DoLoadStart, self);
    thewebview.SetOnLoadingFinish(DoLoadEnd, self);
    if Assigned(FOnCreateView) then
      thewebview.SetOnCreateView(DoCreateView, self);
    thewebview.SetOnPaintUpdated(DoPaintUpdated, self);
    if Assigned(FOnAlertBox) then
      thewebview.SetOnAlertBox(DoAlertBox, self);
    if Assigned(FOnConfirmBox) then
      thewebview.SetOnConfirmBox(DoConfirmBox, self);
    if Assigned(FOnPromptBox) then
      thewebview.SetOnPromptBox(DoPromptBox, self);
    thewebview.SetOnConsoleMessage(DoConsoleMessage, self);
   // thewebview.SetOnDocumentReady(DoDocumentReady, self);
    wkeOnDocumentReady2(thewebview, doDucumentReadyCallback, Self);
    thewebview.SetOnWindowClosing(DoWindowClosing, self);
    thewebview.SetOnWindowDestroy(DoWindowDestroy, self);
    if FwkeUserAgent <> '' then
      wkeSetUserAgent(thewebview, PansiChar(AnsiString(FwkeUserAgent)));
    wkeSetCookieEnabled(thewebview, FCookieEnabled);
    wkeSetNavigationToNewWindowEnable(thewebview, false);
    if DirectoryExists(FwkeCookiePath) and Assigned(wkeSetCookieJarPath) then
      wkeSetCookieJarPath(thewebview, PwideChar(FwkeCookiePath));

    wkeSetCspCheckEnable(thewebview, False);       //关闭跨域检查
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
      ShowWindow(thewebview.WindowHandle, SW_HIDE)
    else
      ShowWindow(thewebview.WindowHandle, SW_NORMAL);
    thewebview.SetOnTitleChanged(DoTitleChange, self);
    thewebview.SetOnURLChanged(DoUrlChange, self);
    thewebview.SetOnNavigation(DoLoadStart, self);
    thewebview.SetOnLoadingFinish(DoLoadEnd, self);
    if Assigned(FOnCreateView) then
      thewebview.SetOnCreateView(DoCreateView, self);
    thewebview.SetOnPaintUpdated(DoPaintUpdated, self);
    if Assigned(FOnAlertBox) then
      thewebview.SetOnAlertBox(DoAlertBox, self);
    if Assigned(FOnConfirmBox) then
      thewebview.SetOnConfirmBox(DoConfirmBox, self);
    if Assigned(FOnPromptBox) then
      thewebview.SetOnPromptBox(DoPromptBox, self);
    thewebview.SetOnConsoleMessage(DoConsoleMessage, self);
   // thewebview.SetOnDocumentReady(DoDocumentReady, self);
    wkeOnDocumentReady2(thewebview, doDucumentReadyCallback, Self);
    thewebview.SetOnWindowClosing(DoWindowClosing, self);
    thewebview.SetOnWindowDestroy(DoWindowDestroy, self);
    if FwkeUserAgent <> '' then
      wkeSetUserAgent(thewebview, PansiChar(AnsiString(FwkeUserAgent)));
    wkeSetCookieEnabled(thewebview, FCookieEnabled);
    if DirectoryExists(FwkeCookiePath) and Assigned(wkeSetCookieJarPath) then
      wkeSetCookieJarPath(thewebview, PwideChar(FwkeCookiePath));
    wkeSetCspCheckEnable(thewebview, False);       //关闭跨域检查
    wkeSetHeadlessEnabled(thewebview, FHeadLess);
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
  //设置
  //FHeadless := false;
end;

destructor TWkeGetSource.Destroy;
begin
  Fwke.Free;
  inherited;
end;

procedure TWkeGetSource.DoAlertBox(Sender: TObject; sMsg: string);
begin
//do nothing
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

procedure TWkeGetSource.ShowWebPage(const bVisible, bHeadLess: Boolean);
begin
  Fwke.Headless := bHeadLess;
  Fwke.FVisible := bVisible;
  Fwke.CreateWebView;

end;

procedure Dodelay(const ADelay: Integer);
var
  i: integer;
begin
  for i := 0 to ADelay div 100 - 1 do
  begin
    Sleep(100);
    Application.ProcessMessages;
  end;
end;

function GetSourceByWke(const Aurl: string; const AshowWindow, AHeadLess: Boolean; const ADelay: Integer): string; overload;
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

function GetSourceByWke(const Aurl: string; const AshowWindow: Boolean; const ADelay: Integer): string;
begin
  result := GetSourceByWke(Aurl, AshowWindow, false, ADelay);
end;

function GetSourceTextByWke(const Aurl: string; const AshowWindow, AHeadLess: Boolean; const ADelay: Integer): string;
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

finalization
  if not wkeIsInDll then
      WkeFinalizeAndUnloadLib;


        }

end.


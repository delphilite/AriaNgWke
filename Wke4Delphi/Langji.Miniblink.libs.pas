{*******************************************************}
{                                                       }
{       miniblink for delphi                            }
{                                                       }
{       版权所有 (C) 2018 langji                        }
{            QQ:231850275                               }
{*******************************************************}

unit Langji.Miniblink.libs;

interface

uses       // Dialogs,
  windows, Classes, Langji.Miniblink.types;

var
  mbLibFileName: string = 'mb.dll';
  mbLibHandle: THandle = 0;
  mbInDll: Boolean = false;
  mbPluginDir: string = '';
  mbProxy: TmbProxy;
  mbUseProxy: Boolean;

//==============================================================================
// MiniBlink API
//==============================================================================

  mbInit: procedure(settings: PmbSettings); stdcall;
  mbUninit: procedure(); stdcall;
  mbCreateWebView: function(): TmbWebView; stdcall;
  mbDestroyWebView: procedure(webview: TmbWebView); stdcall;
  mbCreateWebWindow: function(mbtype: TmbWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): TmbWebView; stdcall;
  mbSetDebugConfig: procedure(webView: TmbWebView; constdebugString: PAnsiChar; const param: PAnsiChar); stdcall;
  mbNetSetData: procedure(job: TmbNetJob; buf: Pointer; len: Integer); stdcall;
  mbCreateWebCustomWindow: function(parent: HWND; style, styleex: DWORD; x, y, w, h: Integer): TmbWebView; stdcall;
  mbMoveToCenter: procedure(webView: TmbWebView); stdcall;
  mbCreateString: function(const pstr: PChar; len: Cardinal): TmbstringPtr; stdcall;
  mbDeleteString: procedure(const mbdelstr: TmbstringPtr); stdcall;
  mbSetProxy: procedure(webView: TmbWebView; const proxy: PmbProxy); stdcall;
  mbNetSetMIMEType: procedure(jobPtr: TmbNetJob; const mtype: PChar); stdcall;
  mbSetCookieJarFullPath: procedure(webView: TmbWebView; const path: PWideChar); stdcall;
  mbSetLocalStorageFullPath: procedure(webView: TmbWebView; const path: PWideChar); stdcall;
  mbGetZoomFactor: function(webView: TmbWebView): Real; stdcall;
  mbGetCookieOnBlinkThread: function(webView: TmbWebView): pchar stdcall;

//"调用此函数后;网络层收到数据会存储在一buf内;接收数据完成后响应OnLoadUrlEnd事件.#此调用严重影响性能;慎用" \
//    "此函数和mbNetSetData的区别是，mbNetHookRequest会在接受到真正网络数据后再调用回调，并允许回调修改网络数据。"\
//    "而mbNetSetData是在网络数据还没发送的时候修改") \
  mbNetHookRequest: procedure(job: TmbNetJob); stdcall;
  mbNetChangeRequestUrl: procedure(jobPtr: TmbNetJob; const url: PAnsiChar); stdcall;
  mbSetNavigationToNewWindowEnable: procedure(webView: TmbWebView; b: boolean); stdcall;
  mbSetHandle: procedure(webView: TmbWebView; wnd: HWND); stdcall;
  mbSetHandleOffset: procedure(webView: TmbWebView; x: Integer; y: Integer); stdcall;
  mbGetHostHWND: function(webView: TmbWebView): HWND; stdcall;
  mbSetHeadlessEnabled: procedure(webView: TmbWebView; b: boolean); stdcall;
  mbSetCspCheckEnable: procedure(webView: TmbWebView; b: boolean); stdcall;
  mbSetMemoryCacheEnable: procedure(webView: TmbWebView; b: Boolean); stdcall;
  mbSetDragDropEnable: procedure(webView: TmbWebView; b: Boolean); stdcall;   // "可关闭拖拽到其他进程") \
  mbSetCookie: procedure(webView: TmbWebView; const url: PAnsiChar; const cookie: PAnsiChar); stdcall;
// "cookie格式必须是:Set-cookie: PRODUCTINFO=webxpress; domain=.fidelity.com; path=/; secure") \
  mbSetCookieEnabled: procedure(webView: TmbWebView; enable: Boolean); stdcall;
  mbSetCookieJarPath: procedure(webView: TmbWebView; const path: PWideChar); stdcall;
  mbSetUserAgent: procedure(webView: TmbWebView; const userAgent: PAnsiChar); stdcall;
  mbSetZoomFactor: procedure(webView: TmbWebView; factor: Single); stdcall;
  mbSetResourceGc: procedure(webView: TmbWebView; intervalSec: Integer); stdcall;
  mbCanGoForward: procedure(webView: TmbWebView; callback: mbCanGoBackForwardCallback; param: Pointer); stdcall;
  mbCanGoBack: procedure(webView: TmbWebView; callback: mbCanGoBackForwardCallback; param: Pointer); stdcall;
  mbGetCookie: procedure(webView: TmbWebView; callback: mbGetCookieCallback; param: Pointer); stdcall;
  mbResize: procedure(webView: TmbWebView; w: integer; h: Integer); stdcall;
  mbOnNavigation: procedure(webView: TmbWebView; callback: mbNavigationCallback; param: Pointer); stdcall;
  mbOnCreateView: procedure(webView: TmbWebView; callback: mbCreateViewCallback; param: Pointer); stdcall;
  mbOnDocumentReady: procedure(webView: TmbWebView; callback: mbDocumentReadyCallback; param: Pointer); stdcall;
  mbOnPaintUpdated: procedure(webView: TmbWebView; callback: mbPaintUpdatedCallback; callbackparam: Pointer); stdcall;
  mbOnLoadUrlBegin: procedure(webView: TmbWebView; callback: mbLoadUrlBeginCallback; callbackparam: Pointer); stdcall;
  mbOnLoadUrlEnd: procedure(webView: TmbWebView; callback: mbLoadUrlEndCallback; callbackparam: Pointer); stdcall;
  mbOnTitleChanged: procedure(webView: TmbWebView; callback: mbTitleChangedCallback; callbackparam: Pointer); stdcall;
  mbOnURLChanged: procedure(webView: TmbWebView; callback: mbURLChangedCallback; callbackparam: Pointer); stdcall;
  mbOnLoadingFinish: procedure(webView: TmbWebView; callback: mbLoadingFinishCallback; param: Pointer); stdcall;
  mbOnDownloadInBlinkThread: procedure(webView: TmbWebView; callback: mbDownloadInBlinkThreadCallback; param: Pointer); stdcall;
  mbOnAlertBox: procedure(webView: TmbWebView; callback: mbAlertBoxCallback; param: Pointer); stdcall;
  mbOnConfirmBox: procedure(webView: TmbWebView; callback: mbConfirmBoxCallback; param: Pointer); stdcall;
  mbOnPromptBox: procedure(webView: TmbWebView; callback: mbPromptBoxCallback; param: Pointer); stdcall;
  mbOnNetGetFavicon: procedure(webView: TmbWebView; callback: mbNetGetFaviconCallback; param: Pointer); stdcall;
  mbOnConsole: procedure(webView: TmbWebView; callback: mbConsoleCallback; param: Pointer); stdcall;
  mbOnClose: procedure(webView: TmbWebView; callback: mbCloseCallback; param: Pointer); stdcall;
  mbOnDestroy: procedure(webView: TmbWebView; callback: mbDestroyCallback; param: Pointer); stdcall;
  mbOnPrinting: procedure(webView: TmbWebView; callback: mbPrintingCallback; param: Pointer); stdcall;
  mbGoBack: procedure(webView: TmbWebView); stdcall;
  mbGoForward: procedure(webView: TmbWebView); stdcall;
  mbStopLoading: procedure(webView: TmbWebView); stdcall;
  mbReload: procedure(webView: TmbWebView); stdcall;
  mbPerformCookieCommand: procedure(webView: TmbWebView; command: TmbCookieCommand); stdcall;
  mbEditorSelectAll: procedure(webView: TmbWebView); stdcall;
  mbEditorCopy: procedure(webView: TmbWebView); stdcall;
  mbEditorCut: procedure(webView: TmbWebView); stdcall;
  mbEditorPaste: procedure(webView: TmbWebView); stdcall;
  mbEditorDelete: procedure(webView: TmbWebView); stdcall;
  mbFireMouseEvent: function(webview: TmbWebView; imessage: Cardinal; x: Integer; y: Integer; flags: Cardinal): boolean; stdcall;
  mbFireContextMenuEvent: function(webview: TmbWebView; x: Integer; y: Integer; flags: Cardinal): boolean; stdcall;
  mbFireMouseWheelEvent: function(webview: TmbWebView; x: Integer; y: Integer; flags: Cardinal): boolean; stdcall;
  mbFireKeyUpEvent: function(webview: TmbWebView; virtualKeyCode: Cardinal; flags: Cardinal; systemKey: boolean): boolean; stdcall;
  mbFireKeyDownEvent: function(webview: TmbWebView; virtualKeyCode: Cardinal; flags: Cardinal; systemKey: boolean): boolean; stdcall;
  mbFireKeyPressEvent: function(webview: TmbWebView; charCode: Cardinal; flags: Cardinal; systemKey: boolean): boolean; stdcall;
  mbFireWindowsMessage: function(webview: TmbWebView; hWnd: Hwnd; imessage: Word; wParam: WPARAM; lParam: LPARAM; result: Pointer): boolean; stdcall;
  mbSetEnableNode: procedure(webview: TmbWebView; b: Boolean); stdcall;
  mbSetFocus: procedure(webView: TmbWebView); stdcall;
  mbKillFocus: procedure(webView: TmbWebView); stdcall;
  mbShowWindow: procedure(webWindow: TmbWebView; show: Boolean); stdcall;
  mbLoadURL: procedure(webView: TmbWebView; const url: PAnsiChar); stdcall;
  mbLoadHtmlWithBaseUrl: procedure(webView: TmbWebView; const html: PAnsiChar; const baseUrl: PAnsiChar); stdcall;
  mbGetLockedViewDC: procedure(webView: TmbWebView); stdcall;
  mbUnlockViewDC: procedure(webView: TmbWebView); stdcall;
  mbWake: procedure(webView: TmbWebView); stdcall;
  mbJsToDouble: function(es: TmbJsExecState; v: TmbJsValue): Double; stdcall;
  mbJsToBoolean: function(es: TmbJsExecState; v: TmbJsValue): Boolean; stdcall;
  mbJsToString: function(es: TmbJsExecState; v: TmbJsValue): PAnsiChar; stdcall;
  mbOnJsQuery: procedure(webView: TmbWebView; callback: mbJsQueryCallback; param: Pointer); stdcall;
  mbResponseQuery: procedure(webView: TmbWebView; queryId: int64; customMsg: integer; const response: PAnsiChar); stdcall;
  mbRunJs: procedure(webView: TmbWebView; frameId: TmbWebFrameHandle; const script: PAnsiChar; isInClosure: boolean; callback: mbRunJsCallback; param: Pointer; unuse: Pointer); stdcall;
  mbRunJsSync: function(webView: TmbWebView; frameId: TmbWebFrameHandle; const script: PAnsiChar; isInClosure: Boolean): TmbJsValue; stdcall;
  mbWebFrameGetMainFrame: function(webView: TmbWebView): TmbWebFrameHandle; stdcall;
  mbIsMainFrame: function(webView: TmbWebView; frameId: TmbWebFrameHandle): boolean; stdcall;
  mbUtilSerializeToMHTML: procedure(webView: TmbWebView; calback: mbGetMHTMLCallback; param: Pointer); stdcall;
  mbUtilCreateRequestCode: function(registerinfo: PChar): PChar; stdcall;
  mbUtilIsRegistered: function(defaultpath: PWideChar): boolean; stdcall;
  mbUtilPrint: function(webView: TmbWebView; frameid: TmbWebFrameHandle; const printparams: PmbprintSettings): boolean; stdcall;
  mbUtilBase64Encode: function(const pstr: PChar): PChar; stdcall;
  mbUtilBase64Decode: function(const pstr: PChar): PChar; stdcall;
  mbUtilPrintToPdf: procedure(webView: TmbWebView; frameid: TmbWebFrameHandle; const printparams: PmbprintSettings; callback: mbPrintPdfDataCallBack); stdcall;
  mbUtilPrintToBitmap: procedure(webView: TmbWebView; frameid: TmbWebFrameHandle; const printparams: PmbprintSettings; callback: mbPrintPdfDataCallBack); stdcall;

  mbGetTitle : function(webWindow: TmbWebView): PAnsiChar; stdcall;

  mbGetUrl : function(webWindow: TmbWebView): PAnsiChar; stdcall;


function LoadmbLibrary(const mbFile: string = 'mb.dll'): Boolean;

function mbUserInit: boolean;

procedure mbUserUninit;

implementation

uses
  Math, sysutils;

procedure AddPathEnvironment(const Apath: string);
var
  oldpath: string;
begin
  oldpath := GetEnvironmentVariable('path');
  oldpath := oldpath + ';' + Apath;
  SetEnvironmentVariable('path', PChar(oldpath));
end;

function LoadmbLibrary(const mbFile: string): Boolean;
var
  mbdll: string;
begin
  Result := false;
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
  mbdll := mbFile;
  if mbFile = '' then
    mbdll := mbLibFileName;

 // mbLibHandle := GetModuleHandle(PChar(ExtractFileName(mbLibFileName)));
  if mbLibHandle = 0 then
  begin
   // OutputDebugString(PChar('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>文件dll:'+mbdll));
    if Fileexists(mbdll) then
    begin
      mbLibFileName := mbdll;
      mbLibHandle := GetModuleHandle(PChar(ExtractFileName(mbLibFileName)));
    end;
    if (mbLibHandle = 0) and FileExists(mbdll) then
    begin
      mbLibHandle := LoadLibrary(PChar(mbdll));
      AddPathEnvironment(ExtractFilePath(mbdll));
    end;
  end;
//
  if mbLibHandle = 0 then
  begin
    raise Exception.Create('Load mb.dll Error,Please Check it');
    Exit;
  end;

  mbInit := GetprocAddress(mbLibHandle, 'mbInit');
  mbUninit := GetprocAddress(mbLibHandle, 'mbUninit');
  mbCreateWebView := GetprocAddress(mbLibHandle, 'mbCreateWebView');
  mbDestroyWebView := GetprocAddress(mbLibHandle, 'mbDestroyWebView');
  mbCreateWebWindow := GetprocAddress(mbLibHandle, 'mbCreateWebWindow');
  mbSetDebugConfig := GetprocAddress(mbLibHandle, 'mbSetDebugConfig');
  mbNetSetData := GetprocAddress(mbLibHandle, 'mbNetSetData');
  mbNetHookRequest := GetprocAddress(mbLibHandle, 'mbNetHookRequest');
  mbNetChangeRequestUrl := GetprocAddress(mbLibHandle, 'mbNetChangeRequestUrl');
  mbSetNavigationToNewWindowEnable := GetprocAddress(mbLibHandle, 'mbSetNavigationToNewWindowEnable');
  mbSetHandle := GetprocAddress(mbLibHandle, 'mbSetHandle');
  mbGetHostHWND := GetprocAddress(mbLibHandle, 'mbGetHostHWND');
  mbSetHandleOffset := GetprocAddress(mbLibHandle, 'mbSetHandleOffset');
  mbSetCspCheckEnable := GetprocAddress(mbLibHandle, 'mbSetCspCheckEnable');
  mbSetMemoryCacheEnable := GetprocAddress(mbLibHandle, 'mbSetMemoryCacheEnable');
  mbSetDragDropEnable := GetprocAddress(mbLibHandle, 'mbSetDragDropEnable');
  mbSetCookie := GetprocAddress(mbLibHandle, 'mbSetCookie');
//  mbSetHeadlessEnabled := GetprocAddress(mbLibHandle, 'mbSetHeadlessEnabled');

  mbSetCookieEnabled := GetprocAddress(mbLibHandle, 'mbSetCookieEnabled');
  mbSetCookieJarPath := GetprocAddress(mbLibHandle, 'mbSetCookieJarPath');
  mbSetUserAgent := GetprocAddress(mbLibHandle, 'mbSetUserAgent');
  mbSetZoomFactor := GetprocAddress(mbLibHandle, 'mbSetZoomFactor');
  mbSetResourceGc := GetprocAddress(mbLibHandle, 'mbSetResourceGc');
  mbCanGoForward := GetprocAddress(mbLibHandle, 'mbCanGoForward');
 // if not Assigned(mbCanGoForward ) then  showmessage('mbCanGoForward');

  mbCanGoBack := GetprocAddress(mbLibHandle, 'mbCanGoBack');
  mbGetCookie := GetprocAddress(mbLibHandle, 'mbGetCookie');
  mbResize := GetprocAddress(mbLibHandle, 'mbResize');
  mbOnNavigation := GetprocAddress(mbLibHandle, 'mbOnNavigation');
  mbOnCreateView := GetprocAddress(mbLibHandle, 'mbOnCreateView');
  mbOnDocumentReady := GetprocAddress(mbLibHandle, 'mbOnDocumentReady');
  mbOnPaintUpdated := GetprocAddress(mbLibHandle, 'mbOnPaintUpdated');
  mbOnLoadUrlBegin := GetprocAddress(mbLibHandle, 'mbOnLoadUrlBegin');
  mbOnLoadUrlEnd := GetprocAddress(mbLibHandle, 'mbOnLoadUrlEnd');
  mbOnTitleChanged := GetprocAddress(mbLibHandle, 'mbOnTitleChanged');
  mbOnURLChanged := GetprocAddress(mbLibHandle, 'mbOnURLChanged');
  mbOnLoadingFinish := GetprocAddress(mbLibHandle, 'mbOnLoadingFinish');
  mbGoBack := GetprocAddress(mbLibHandle, 'mbGoBack');
  mbGoForward := GetprocAddress(mbLibHandle, 'mbGoForward');
  mbStopLoading := GetprocAddress(mbLibHandle, 'mbStopLoading');
  mbReload := GetprocAddress(mbLibHandle, 'mbReload');
  mbPerformCookieCommand := GetprocAddress(mbLibHandle, 'mbPerformCookieCommand');
  mbEditorSelectAll := GetprocAddress(mbLibHandle, 'mbEditorSelectAll');
  mbEditorCopy := GetprocAddress(mbLibHandle, 'mbEditorCopy');
  mbEditorCut := GetprocAddress(mbLibHandle, 'mbEditorCut');
  mbEditorPaste := GetprocAddress(mbLibHandle, 'mbEditorPaste');
  mbEditorDelete := GetprocAddress(mbLibHandle, 'mbEditorDelete');
  mbFireMouseEvent := GetprocAddress(mbLibHandle, 'mbFireMouseEvent');
  mbFireContextMenuEvent := GetprocAddress(mbLibHandle, 'mbFireContextMenuEvent');
  mbFireMouseWheelEvent := GetprocAddress(mbLibHandle, 'mbFireMouseWheelEvent');
  mbFireKeyUpEvent := GetprocAddress(mbLibHandle, 'mbFireKeyUpEvent');
  mbFireKeyDownEvent := GetprocAddress(mbLibHandle, 'mbFireKeyDownEvent');
  mbFireKeyPressEvent := GetprocAddress(mbLibHandle, 'mbFireKeyPressEvent');
  mbFireWindowsMessage := GetprocAddress(mbLibHandle, 'mbFireWindowsMessage');

  mbSetFocus := GetprocAddress(mbLibHandle, 'mbSetFocus');
  mbKillFocus := GetprocAddress(mbLibHandle, 'mbKillFocus');
  mbShowWindow := GetprocAddress(mbLibHandle, 'mbShowWindow');
  mbLoadURL := GetprocAddress(mbLibHandle, 'mbLoadURL');
  mbLoadHtmlWithBaseUrl := GetprocAddress(mbLibHandle, 'mbLoadHtmlWithBaseUrl');
  mbGetLockedViewDC := GetprocAddress(mbLibHandle, 'mbGetLockedViewDC');
  mbUnlockViewDC := GetprocAddress(mbLibHandle, 'mbUnlockViewDC');
  mbWake := GetprocAddress(mbLibHandle, 'mbWake');
  mbGetTitle := GetprocAddress(mbLibHandle, 'mbGetTitle');
  mbGetUrl := GetprocAddress(mbLibHandle, 'mbGetUrl');

  mbJsToDouble := GetprocAddress(mbLibHandle, 'mbJsToDouble');
  mbJsToBoolean := GetprocAddress(mbLibHandle, 'mbJsToBoolean');
  mbJsToString := GetprocAddress(mbLibHandle, 'mbJsToString');
  mbOnJsQuery := GetprocAddress(mbLibHandle, 'mbOnJsQuery');
  mbResponseQuery := GetprocAddress(mbLibHandle, 'mbResponseQuery');
  mbRunJs := GetprocAddress(mbLibHandle, 'mbRunJs');
  mbRunJsSync := GetprocAddress(mbLibHandle, 'mbRunJsSync');
  mbWebFrameGetMainFrame := GetprocAddress(mbLibHandle, 'mbWebFrameGetMainFrame');
  mbIsMainFrame := GetprocAddress(mbLibHandle, 'mbIsMainFrame');
  mbUtilSerializeToMHTML := GetprocAddress(mbLibHandle, 'mbUtilSerializeToMHTML');

  mbCreateWebCustomWindow := GetprocAddress(mbLibHandle, 'mbCreateWebCustomWindow');
  mbMoveToCenter := GetprocAddress(mbLibHandle, 'mbMoveToCenter');
  mbCreateString := GetprocAddress(mbLibHandle, 'mbCreateString');
  mbDeleteString := GetprocAddress(mbLibHandle, 'mbDeleteString');

  mbNetSetMIMEType := GetprocAddress(mbLibHandle, 'mbNetSetMIMEType');
  mbSetCookieJarFullPath := GetprocAddress(mbLibHandle, 'mbSetCookieJarFullPath');
  mbSetLocalStorageFullPath := GetprocAddress(mbLibHandle, 'mbSetLocalStorageFullPath');
  mbGetZoomFactor := GetprocAddress(mbLibHandle, 'mbGetZoomFactor');
  mbGetCookieOnBlinkThread := GetprocAddress(mbLibHandle, 'mbGetCookieOnBlinkThread');

  mbOnDownloadInBlinkThread := GetprocAddress(mbLibHandle, 'mbOnDownloadInBlinkThread');
  mbOnAlertBox := GetprocAddress(mbLibHandle, 'mbOnAlertBox');
  mbOnConfirmBox := GetprocAddress(mbLibHandle, 'mbOnConfirmBox');
  mbOnPromptBox := GetprocAddress(mbLibHandle, 'mbOnPromptBox');
  //mbOnNetGetFavion := GetprocAddress(mbLibHandle, 'mbOnNetGetFavion'); //去掉了？
  mbOnConsole := GetprocAddress(mbLibHandle, 'mbOnConsole');
  mbOnClose := GetprocAddress(mbLibHandle, 'mbOnClose');
  mbOnDestroy := GetprocAddress(mbLibHandle, 'mbOnDestroy');
  mbOnPrinting := GetprocAddress(mbLibHandle, 'mbOnPrinting');
  mbSetEnableNode := GetprocAddress(mbLibHandle, 'mbSetEnableNode');

  mbUtilCreateRequestCode := GetprocAddress(mbLibHandle, 'mbUtilCreateRequestCode');
  mbUtilIsRegistered := GetprocAddress(mbLibHandle, 'mbUtilIsRegistered');
  mbUtilPrint := GetprocAddress(mbLibHandle, 'mbUtilPrint');
  mbUtilBase64Encode := GetprocAddress(mbLibHandle, 'mbUtilBase64Encode');
  mbUtilBase64Decode := GetprocAddress(mbLibHandle, 'mbUtilBase64Decode');
  mbUtilPrintToPdf := GetprocAddress(mbLibHandle, 'mbUtilPrintToPdf');
  mbUtilPrintToBitmap := GetprocAddress(mbLibHandle, 'mbUtilPrintToBitmap');
  result := (mbLibHandle <> 0)
end;

procedure mbUserAddPluginDir(const Adir: string);
begin
  AddPathEnvironment(Adir);
end;

function mbUserInit: boolean;
var
  uset: TmbSettings;
begin
  result := false;
  if mbLibHandle <> 0 then
    exit;
  if LoadmbLibrary() then
  begin
    uset.proxy := mbProxy;
    uset.mask := 0;   //MB_SETTING_PROXY
    uset.blinkThreadInitCallback := nil;
    uset.blinkThreadInitCallbackParam := nil;
    mbInit(@uset);

    if (mbPluginDir <> '') and DirectoryExists(mbPluginDir) then
    begin
      mbUserAddPluginDir(mbPluginDir);
    end;
    result := true;
  end;
end;

procedure mbUserUninit;
begin
  if mbLibHandle <> 0 then
  begin
    mbUninit;
    FreeLibrary(mbLibHandle);
    mbLibHandle := 0;
  end;
end;

end.


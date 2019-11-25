unit Langji.Wke.types;

{$MINENUMSIZE 4}

interface

uses
  windows;

const
  // wkeMouseFlags
  WKE_LBUTTON = $01;
  WKE_RBUTTON = $02;
  WKE_SHIFT = $04;
  WKE_CONTROL = $08;
  WKE_MBUTTON = $10;

  // wkeKeyFlags
  WKE_EXTENDED = $0100;
  WKE_REPEAT = $4000;

  // wkeMouseMsg
  WKE_MSG_MOUSEMOVE = $0200;
  WKE_MSG_LBUTTONDOWN = $0201;
  WKE_MSG_LBUTTONUP = $0202;
  WKE_MSG_LBUTTONDBLCLK = $0203;
  WKE_MSG_RBUTTONDOWN = $0204;
  WKE_MSG_RBUTTONUP = $0205;
  WKE_MSG_RBUTTONDBLCLK = $0206;
  WKE_MSG_MBUTTONDOWN = $0207;
  WKE_MSG_MBUTTONUP = $0208;
  WKE_MSG_MBUTTONDBLCLK = $0209;
  WKE_MSG_MOUSEWHEEL = $020A;

  // WKE_SETTING_PAINTCALLBACK_IN_OTHER_THREAD=4;

type
  utf8 = AnsiChar;

  Putf8 = PAnsiChar;

  wchar_t = WideChar;

  Pwchar_t = PWideChar;

  jsValue = int64;

  PjsValue = PInt64;

  wkeString = Pointer;

  wkeFrameHwnd = Pointer;

  wkeProxyType = (WKE_PROXY_NONE, WKE_PROXY_HTTP, WKE_PROXY_SOCKS4,
    WKE_PROXY_SOCKS4A, WKE_PROXY_SOCKS5, WKE_PROXY_SOCKS5HOSTNAME);

  TwkeProxyType = wkeProxyType;

  wkeSettingMask = (WKE_SETTING_PROXY = 1,
    WKE_SETTING_PAINTCALLBACK_IN_OTHER_THREAD = 4);

  TwkeSettingMask = wkeSettingMask;

  wkeNavigationType = (WKE_NAVIGATION_TYPE_LINKCLICK,
    WKE_NAVIGATION_TYPE_FORMSUBMITTE, WKE_NAVIGATION_TYPE_BACKFORWARD,
    WKE_NAVIGATION_TYPE_RELOAD, WKE_NAVIGATION_TYPE_FORMRESUBMITT,
    WKE_NAVIGATION_TYPE_OTHER);

  TwkeNavigationType = wkeNavigationType;

  wkeLoadingResult = (WKE_LOADING_SUCCEEDED, WKE_LOADING_FAILED,
    WKE_LOADING_CANCELED);

  TwkeLoadingResult = wkeLoadingResult;

  wkeCookieCommand = (wkeCookieCommandClearAllCookies,
    wkeCookieCommandClearSessionCookies, wkeCookieCommandFlushCookiesToFile,
    wkeCookieCommandReloadCookiesFromFile);

  wkeWindowType = (WKE_WINDOW_TYPE_POPUP, WKE_WINDOW_TYPE_TRANSPARENT,
    WKE_WINDOW_TYPE_CONTROL);

  TwkeWindowType = wkeWindowType;

  jsType = (JSTYPE_NUMBER, JSTYPE_STRING, JSTYPE_BOOLEAN, JSTYPE_OBJECT,
    JSTYPE_FUNCTION, JSTYPE_UNDEFINED);

  TjsType = jsType;

  wkeRect = packed record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;

  PwkeRect = ^TwkeRect;

  TwkeRect = wkeRect;

  // typedef struct _wkeProxy {
  // wkeProxyType type;
  // char hostname[100];
  // unsigned short port;
  // char username[50];
  // char password[50];
  // } wkeProxy;

  wkeProxy = packed record
    AType: wkeProxyType;
    hostname: array [0 .. 99] of AnsiChar;
    port: Word;
    username: array [0 .. 49] of AnsiChar;
    password: array [0 .. 49] of AnsiChar;
  end;

  PwkeProxy = ^TwkeProxy;

  TwkeProxy = wkeProxy;

  wkeSettings = packed record
    proxy: wkeProxy;
    mask: Longint;
  end;

  PwkeSettings = ^TwkeSettings;

  TwkeSettings = wkeSettings;

  wkeWindowFeatures = packed record
    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
    menuBarVisible: Boolean;
    statusBarVisible: Boolean;
    toolBarVisible: Boolean;
    locationBarVisible: Boolean;
    scrollbarsVisible: Boolean;
    resizable: Boolean;
    fullscreen: Boolean;
  end;

  PwkeWindowFeatures = ^TwkeWindowFeatures;

  TwkeWindowFeatures = wkeWindowFeatures;

  wkeMessageLevel = (WKE_MESSAGE_LEVEL_TIP, WKE_MESSAGE_LEVEL_LOG,
    WKE_MESSAGE_LEVEL_WARNING, WKE_MESSAGE_LEVEL_ERROR,
    WKE_MESSAGE_LEVEL_DEBUG);

  wkeMessageSource = (WKE_MESSAGE_SOURCE_HTML, WKE_MESSAGE_SOURCE_XML,
    WKE_MESSAGE_SOURCE_JS, WKE_MESSAGE_SOURCE_NETWORK,
    WKE_MESSAGE_SOURCE_CONSOLE_API, WKE_MESSAGE_SOURCE_OTHER);

  wkeMessageType = (WKE_MESSAGE_TYPE_LOG, WKE_MESSAGE_TYPE_DIR,
    WKE_MESSAGE_TYPE_DIR_XML, WKE_MESSAGE_TYPE_TRACE,
    WKE_MESSAGE_TYPE_START_GROUP, WKE_MESSAGE_TYPE_START_GROUP_COLLAPSED,
    WKE_MESSAGE_TYPE_END_GROUP, WKE_MESSAGE_TYPE_ASSERT);

  PwkeConsoleMessage = ^wkeConsoleMessage;

  wkeConsoleMessage = packed record
    source: wkeMessageSource;
    type_: wkeMessageType;
    level: wkeMessageLevel;
    message_: wkeString;
    url: wkeString;
    lineNumber: Longint;
  end;

  // Add 20180523
  pwkeMemBuf = packed record
    size: Integer;
    data: Pointer;
    length: Cardinal;
  end;

  wkeHttBodyElementType = (wkeHttBodyElementTypeData,
    wkeHttBodyElementTypeFile);

  wkePostBodyElement = packed record
    size: Integer;
    type_: wkeHttBodyElementType;
    data: pwkeMemBuf;
    filepath: wkeString;
    filestart: int64;
    filelength: int64;
  end;

  pwkePostBodyElement = ^wkePostBodyElement;

  // typedef enum _wkeRequestType {
  // kWkeRequestTypeInvalidation,
  // kWkeRequestTypeGet,
  // kWkeRequestTypePost,
  // kWkeRequestTypePut,
  // } wkeRequestType;

  wkeRequestType = (kWkeRequestTypeInvalidation, kWkeRequestTypeGet,
    kWkeRequestTypePost, kWkeRequestTypePut);

  // typedef struct _wkeWindowCreateInfo {
  // int size;
  // HWND parent;
  // DWORD style;
  // DWORD styleEx;
  // int x;
  // int y;
  // int width;
  // int height;
  // COLORREF color;

  wkeWindowCreateInfo = packed record
    size: Integer;
    parent: HWND;
    style: DWORD;
    styleex: DWORD;
    x, y, width, height: Integer;
    color: TColorRef;
  end;

  pwkeWindowCreateInfo = ^wkeWindowCreateInfo;


  // typedef struct _wkePostBodyElements {
  // int size;
  // wkePostBodyElement** element;
  // size_t elementSize;
  // bool isDirty;
  // } wkePostBodyElements;

  TwkePostBodyElements = packed record
    size: Integer;
    element: pwkePostBodyElement;
    elementSize: Cardinal;
    isDirty: Boolean;
  end;

  pwkePostBodyElements = ^TwkePostBodyElements;

{$IF not Declared(SIZE_T)}
  SIZE_T = Cardinal;
{$IFEND}
  // typedef void* (*FILE_OPEN) (const char* path);

  FILE_OPEN = function(path: PAnsiChar): Pointer; cdecl;
  // typedef void (*FILE_CLOSE) (void* handle);

  FILE_CLOSE = procedure(handle: Pointer); cdecl;
  // typedef size_t (*FILE_SIZE) (void* handle);

  FILE_SIZE = function(handle: Pointer): SIZE_T; cdecl;
  // typedef int (*FILE_READ) (void* handle, void* buffer, size_t size);

  FILE_READ = function(handle: Pointer; buffer: Pointer; size: SIZE_T)
    : Integer; cdecl;
  // typedef int (*FILE_SEEK) (void* handle, int offset, int origin);

  FILE_SEEK = function(handle: Pointer; offset, origin: Integer)
    : Integer; cdecl;

  wkeWebView = Pointer;

  TwkeWebView = wkeWebView;

  JScript = Pointer;

  jsExecState = JScript;


  // typedef bool(WKE_CALL_TYPE * wkeCookieVisitor)(
  // void* params,
  // const char* name,
  // const char* value,
  // const char* domain,
  // const char* path, // If |path| is non-empty only URLs at or below the path will get the cookie value.
  // int secure, // If |secure| is true the cookie will only be sent for HTTPS requests.
  // int httpOnly, // If |httponly| is true the cookie will only be sent for HTTP requests.
  // int* expires // The cookie expiration date is only valid if |has_expires| is true.
  // );

  wkeCookieVisitor = function(params: Pointer;
    const name, value, domain, path: PAnsiChar; secure, httpOnly: Integer;
    expires: PInteger): Boolean; cdecl;

  wkeTitleChangedCallback = procedure(webView: wkeWebView; param: Pointer;
    title: wkeString); cdecl;

  wkeURLChangedCallback = procedure(webView: wkeWebView; param: Pointer;
    url: wkeString); cdecl;

  wkeURLChangedCallback2 = procedure(webView: wkeWebView; param: Pointer;
    frameid: wkeFrameHwnd; url: wkeString); cdecl;
  // 2018.02.07

  wkePaintUpdatedCallback = procedure(webView: wkeWebView; param: Pointer;
    hdc: hdc; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;

  wkeAlertBoxCallback = procedure(webView: wkeWebView; param: Pointer;
    msg: wkeString); cdecl;

  wkeConfirmBoxCallback = function(webView: wkeWebView; param: Pointer;
    msg: wkeString): Boolean; cdecl;

  wkePromptBoxCallback = function(webView: wkeWebView; param: Pointer;
    msg: wkeString; defaultResult: wkeString; sresult: wkeString)
    : Boolean; cdecl;

  wkeNavigationCallback = function(webView: wkeWebView; param: Pointer;
    navigationType: wkeNavigationType; url: wkeString): Boolean; cdecl;

  wkeCreateViewCallback = function(webView: wkeWebView; param: Pointer;
    navigationType: wkeNavigationType; url: wkeString;
    windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;

  wkeDocumentReadyCallback = procedure(webView: wkeWebView;
    param: Pointer); cdecl;

  wkeDocumentReadyCallback2 = procedure(webView: wkeWebView; param: Pointer;
    frameid: wkeFrameHwnd); cdecl; // 2018.02.07

  wkeLoadingFinishCallback = procedure(webView: wkeWebView; param: Pointer;
    url: wkeString; result: wkeLoadingResult; failedReason: wkeString); cdecl;

  wkeWindowClosingCallback = function(webWindow: wkeWebView; param: Pointer)
    : Boolean; cdecl;

  wkeWindowDestroyCallback = procedure(webWindow: wkeWebView;
    param: Pointer); cdecl;

  // wkeWebView webView, void* param, wkeConsoleLevel level, const wkeString message, const wkeString sourceName, unsigned sourceLine, const wkeString stackTrace);
  wkeConsoleMessageCallback = procedure(webView: wkeWebView; param: Pointer;
    level: wkeMessageLevel; const AMessage, sourceName: wkeString;
    sourceLine: Cardinal; const stackTrack: wkeString); cdecl;

  // typedef bool(*wkeLoadUrlBeginCallback)(wkeWebView webView, void* param, const char *url, void *job);
  // typedef void(*wkeLoadUrlEndCallback)(wkeWebView webView, void* param, const char *url, void *job, void* buf, int len);
  // typedef void(*wkeDidCreateScriptContextCallback)(wkeWebView webView, void* param, wkeWebFrameHandle frameId, void* context, int extensionGroup, int worldId);
  // typedef void(*wkeWillReleaseScriptContextCallback)(wkeWebView webView, void* param, wkeWebFrameHandle frameId, void* context, int worldId);
  // typedef bool(*wkeNetResponseCallback)(wkeWebView webView, void* param, const char* url, void* job);
  // typedef bool(*wkeDownloadCallback)(wkeWebView webView, void* param, const char* url);
  wkeDownloadCallback = function(webView: wkeWebView; param: Pointer;
    url: PAnsiChar): Boolean; cdecl; // wkeString): boolean;

  wkeOnCallUiThread = procedure(webView: wkeWebView; paramOnInThread: Pointer);
    cdecl; // 2018.02.07

  wkeCallUiThread = procedure(webView: wkeWebView; func: wkeOnCallUiThread;
    param: Pointer); cdecl; // 2018.02.07

  wkeLoadUrlBeginCallback = function(webView: wkeWebView; param: Pointer;
    url: PAnsiChar; job: Pointer): Boolean; cdecl;
  // 2018.02.07

  wkeLoadUrlEndCallback = procedure(webView: wkeWebView; param: Pointer;
    const url: PAnsiChar; job: Pointer; buf: Pointer; len: Integer); cdecl;
  // 2018.02.07

  wkeNetResponseCallback = function(webView: wkeWebView; param: Pointer;
    url: wkeString; job: Pointer): Boolean; cdecl; // 2018.02.07

  jsGetPropertyCallback = function(es: jsExecState; AObject: jsValue;
    propertyName: PAnsiChar): jsValue; cdecl;

  jsSetPropertyCallback = function(es: jsExecState; AObject: jsValue;
    propertyName: PAnsiChar; value: jsValue): Boolean; cdecl;

  jsCallAsFunctionCallback = function(es: jsExecState; AObject: jsValue;
    args: PjsValue; argCount: Integer): jsValue; cdecl;

  PjsData = ^TjsData;

  jsFinalizeCallback = procedure(data: PjsData); cdecl;

  jsData = packed record
    typeName: array [0 .. 99] of AnsiChar; // char
    propertyGet: jsGetPropertyCallback;
    propertySet: jsSetPropertyCallback;
    finalize: jsFinalizeCallback;
    callAsFunction: jsCallAsFunctionCallback;
  end;

  TjsData = jsData;
  // #define JS_CALL __fastcall
  // typedef jsValue (JS_CALL *jsNativeFunction) (jsExecState es);
  // 这里有两种写法，按照vc __fastcall的约定与delphi register约定的不一样
{$IFDEF UseVcFastCall}
  jsNativeFunction = function(es: jsExecState): jsValue;
{$ELSE}
  // 前两个参数用来占位用

  jsNativeFunction = function(p1, p2, es: jsExecState): jsValue;
{$ENDIF}
  TNewWindowFlag = (nwf_NewPage, nwf_OpenInCurrent, nwf_Cancel);

  TwkePlatform = (wp_Win32, wp_Android, wp_Ios);

  // 事件定义
  TOnTitleChangeEvent = procedure(Sender: TObject; sTitle: string) of object;

  TOnUrlChangeEvent = procedure(Sender: TObject; sUrl: string) of object;

  TOnLoadEndEvent = procedure(Sender: TObject; sUrl: string;
    loadresult: wkeLoadingResult) of object;

  TOnBeforeLoadEvent = procedure(Sender: TObject; sUrl: string;
    navigationType: wkeNavigationType; var Cancel: Boolean) of object;

  TOnCreateViewEvent = procedure(Sender: TObject; sUrl: string;
    navigationType: wkeNavigationType; windowFeatures: PwkeWindowFeatures;
    var wvw: wkeWebView) of object;

  TOnAlertBoxEvent = procedure(Sender: TObject; sMsg: string) of object;

  TOnConfirmBoxEvent = procedure(Sender: TObject; sMsg: string;
    var bresult: Boolean) of object;

  TOnPromptBoxEvent = procedure(Sender: TObject;
    sMsg, defaultres, Strres: string; var bresult: Boolean) of object;

  TOnDownloadEvent = procedure(Sender: TObject; sUrl: string) of object;

  TOnConsoleMessgeEvent = procedure(Sender: TObject; const sMsg, source: string;
    const sline: Integer) of object;

  TOnLoadUrlEndEvent = procedure(Sender: TObject; sUrl: string; buf: Pointer;
    len: Integer) of object;

  TOnLoadUrlBeginEvent = procedure(Sender: TObject; sUrl: string;
    out bHook, bHandled: Boolean) of object;

implementation

end.

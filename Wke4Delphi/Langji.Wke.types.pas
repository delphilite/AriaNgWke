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

  wkeProxyType = (WKE_PROXY_NONE, WKE_PROXY_HTTP, WKE_PROXY_SOCKS4, WKE_PROXY_SOCKS4A, WKE_PROXY_SOCKS5, WKE_PROXY_SOCKS5HOSTNAME);

  TwkeProxyType = wkeProxyType;

  wkeSettingMask = (WKE_SETTING_PROXY = 1,
     WKE_SETTING_PAINTCALLBACK_IN_OTHER_THREAD = 4
  );

  TwkeSettingMask = wkeSettingMask;

  wkeNavigationType = (WKE_NAVIGATION_TYPE_LINKCLICK, WKE_NAVIGATION_TYPE_FORMSUBMITTE, WKE_NAVIGATION_TYPE_BACKFORWARD,
    WKE_NAVIGATION_TYPE_RELOAD, WKE_NAVIGATION_TYPE_FORMRESUBMITT, WKE_NAVIGATION_TYPE_OTHER);

  TwkeNavigationType = wkeNavigationType;

  wkeLoadingResult = (WKE_LOADING_SUCCEEDED, WKE_LOADING_FAILED, WKE_LOADING_CANCELED);

  TwkeLoadingResult = wkeLoadingResult;

  wkeCookieCommand = (wkeCookieCommandClearAllCookies, wkeCookieCommandClearSessionCookies,
    wkeCookieCommandFlushCookiesToFile, wkeCookieCommandReloadCookiesFromFile);

  wkeWindowType = (WKE_WINDOW_TYPE_POPUP, WKE_WINDOW_TYPE_TRANSPARENT, WKE_WINDOW_TYPE_CONTROL);

  TwkeWindowType = wkeWindowType;

  jsType = (JSTYPE_NUMBER, JSTYPE_STRING, JSTYPE_BOOLEAN, JSTYPE_OBJECT, JSTYPE_FUNCTION, JSTYPE_UNDEFINED);

  TjsType = jsType;

  wkeRect = packed record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;

  PwkeRect = ^TwkeRect;

  TwkeRect = wkeRect;

//  typedef struct _wkeProxy {
//    wkeProxyType type;
//    char hostname[100];
//    unsigned short port;
//    char username[50];
//    char password[50];
//} wkeProxy;


  wkeProxy = packed record
    AType: wkeProxyType;
    hostname: array[0..99] of AnsiChar;
    port: Word;
    username: array[0..49] of AnsiChar;
    password: array[0..49] of AnsiChar;
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

  wkeMessageLevel = (WKE_MESSAGE_LEVEL_TIP, WKE_MESSAGE_LEVEL_LOG, WKE_MESSAGE_LEVEL_WARNING, WKE_MESSAGE_LEVEL_ERROR,
    WKE_MESSAGE_LEVEL_DEBUG);

  wkeMessageSource = (WKE_MESSAGE_SOURCE_HTML, WKE_MESSAGE_SOURCE_XML, WKE_MESSAGE_SOURCE_JS, WKE_MESSAGE_SOURCE_NETWORK,
    WKE_MESSAGE_SOURCE_CONSOLE_API, WKE_MESSAGE_SOURCE_OTHER);

  wkeMessageType = (WKE_MESSAGE_TYPE_LOG, WKE_MESSAGE_TYPE_DIR, WKE_MESSAGE_TYPE_DIR_XML, WKE_MESSAGE_TYPE_TRACE,
    WKE_MESSAGE_TYPE_START_GROUP, WKE_MESSAGE_TYPE_START_GROUP_COLLAPSED, WKE_MESSAGE_TYPE_END_GROUP, WKE_MESSAGE_TYPE_ASSERT);

  PwkeConsoleMessage = ^wkeConsoleMessage;

  wkeConsoleMessage = packed record
    source: wkeMessageSource;
    type_: wkeMessageType;
    level: wkeMessageLevel;
    message_: wkeString;
    url: wkeString;
    lineNumber: LongInt;
  end;

 //Add 20180523
  pwkeMemBuf = packed record
    size:Integer;
    data:Pointer;
    length:Cardinal ;
  end;

  wkeHttBodyElementType= (wkeHttBodyElementTypeData,wkeHttBodyElementTypeFile);

  wkePostBodyElement= packed record
    size:Integer;
    type_:wkeHttBodyElementType;
    data:pwkeMemBuf;
    filepath:wkeString;
    filestart:Int64;
    filelength:Int64;
  end;
  pwkePostBodyElement =   ^wkePostBodyElement ;

//typedef enum _wkeRequestType {
//    kWkeRequestTypeInvalidation,
//    kWkeRequestTypeGet,
//    kWkeRequestTypePost,
//    kWkeRequestTypePut,
//} wkeRequestType;

   wkeRequestType =(    kWkeRequestTypeInvalidation,
    kWkeRequestTypeGet,
    kWkeRequestTypePost,
    kWkeRequestTypePut);

//  typedef struct _wkeWindowCreateInfo {
//    int size;
//    HWND parent;
//    DWORD style;
//    DWORD styleEx;
//    int x;
//    int y;
//    int width;
//    int height;
//    COLORREF color;


 wkeWindowCreateInfo=packed record
   size:Integer;
   parent:HWND;
   style:DWORD;
   styleex:DWORD;
   x,y,width,height:Integer;
   color:TColorRef;
 end;
 pwkeWindowCreateInfo= ^wkeWindowCreateInfo;


// typedef struct _wkePostBodyElements {
//    int size;
//    wkePostBodyElement** element;
//    size_t elementSize;
//    bool isDirty;
//} wkePostBodyElements;

  TwkePostBodyElements= packed record
    size:Integer;
    element  :PwkePostBodyElement;
    elementSize  :Cardinal;
    isDirty :BOOLean;
  end;

  pwkePostBodyElements =^TwkePostBodyElements;

{$IF not Declared(SIZE_T)}
  SIZE_T = Cardinal;
{$IFEND}


//typedef void* (*FILE_OPEN) (const char* path);

  FILE_OPEN = function(path: PAnsiChar): Pointer; cdecl;
//typedef void (*FILE_CLOSE) (void* handle);

  FILE_CLOSE = procedure(handle: Pointer); cdecl;
//typedef size_t (*FILE_SIZE) (void* handle);

  FILE_SIZE = function(handle: Pointer): size_t; cdecl;
//typedef int (*FILE_READ) (void* handle, void* buffer, size_t size);

  FILE_READ = function(handle: Pointer; buffer: Pointer; size: size_t): Integer; cdecl;
//typedef int (*FILE_SEEK) (void* handle, int offset, int origin);

  FILE_SEEK = function(handle: Pointer; offset, origin: Integer): Integer; cdecl;

  wkeWebView = class;

  JScript = class;

  jsExecState = JScript;


//  typedef bool(WKE_CALL_TYPE * wkeCookieVisitor)(
//    void* params,
//    const char* name,
//    const char* value,
//    const char* domain,
//    const char* path, // If |path| is non-empty only URLs at or below the path will get the cookie value.
//    int secure, // If |secure| is true the cookie will only be sent for HTTPS requests.
//    int httpOnly, // If |httponly| is true the cookie will only be sent for HTTP requests.
//    int* expires // The cookie expiration date is only valid if |has_expires| is true.
//    );

  wkeCookieVisitor=function( params:Pointer; const name,value,domain,path:PAnsiChar; secure,httpOnly:Integer;   expires:PInteger):Boolean; cdecl;

  wkeTitleChangedCallback = procedure(webView: wkeWebView; param: Pointer; title: wkeString); cdecl;

  wkeURLChangedCallback = procedure(webView: wkeWebView; param: Pointer; url: wkeString); cdecl;
  wkeURLChangedCallback2 = procedure(webView: wkeWebView; param: Pointer;frameid:wkeFrameHwnd; url: wkeString); cdecl;    //2018.02.07

  wkePaintUpdatedCallback = procedure(webView: wkeWebView; param: Pointer; hdc: HDC; x: Integer; y: Integer; cx: Integer; cy: Integer); cdecl;

  wkeAlertBoxCallback = procedure(webView: wkeWebView; param: Pointer; msg: wkeString); cdecl;

  wkeConfirmBoxCallback = function(webView: wkeWebView; param: Pointer; msg: wkeString): Boolean; cdecl;

  wkePromptBoxCallback = function(webView: wkeWebView; param: Pointer; msg: wkeString; defaultResult: wkeString; sresult: wkeString): Boolean; cdecl;

  wkeNavigationCallback = function(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString): Boolean; cdecl;

  wkeCreateViewCallback = function(webView: wkeWebView; param: Pointer; navigationType: wkeNavigationType; url: wkeString; windowFeatures: PwkeWindowFeatures): wkeWebView; cdecl;

  wkeDocumentReadyCallback = procedure(webView: wkeWebView; param: Pointer); cdecl;
  wkeDocumentReadyCallback2 = procedure(webView: wkeWebView; param: Pointer;frameid:wkeFrameHwnd); cdecl;          //2018.02.07

  wkeLoadingFinishCallback = procedure(webView: wkeWebView; param: Pointer; url: wkeString; result: wkeLoadingResult;
    failedReason: wkeString); cdecl;

  wkeWindowClosingCallback = function(webWindow: wkeWebView; param: Pointer): Boolean; cdecl;
  wkeWindowDestroyCallback = procedure(webWindow: wkeWebView; param: Pointer); cdecl;

 // wkeWebView webView, void* param, wkeConsoleLevel level, const wkeString message, const wkeString sourceName, unsigned sourceLine, const wkeString stackTrace);
  wkeConsoleMessageCallback = procedure(webView: wkeWebView; param: Pointer; level: wkeMessageLevel; const AMessage,
    sourceName: wkeString; sourceLine: Cardinal; const stackTrack: wkeString); cdecl;

//  typedef bool(*wkeLoadUrlBeginCallback)(wkeWebView webView, void* param, const char *url, void *job);
//typedef void(*wkeLoadUrlEndCallback)(wkeWebView webView, void* param, const char *url, void *job, void* buf, int len);
//typedef void(*wkeDidCreateScriptContextCallback)(wkeWebView webView, void* param, wkeWebFrameHandle frameId, void* context, int extensionGroup, int worldId);
//typedef void(*wkeWillReleaseScriptContextCallback)(wkeWebView webView, void* param, wkeWebFrameHandle frameId, void* context, int worldId);
//typedef bool(*wkeNetResponseCallback)(wkeWebView webView, void* param, const char* url, void* job);
//typedef bool(*wkeDownloadCallback)(wkeWebView webView, void* param, const char* url);
  wkeDownloadCallback = function(webView: wkeWebView; param: Pointer; url:PansiChar):boolean; cdecl;  // wkeString): boolean;

  wkeOnCallUiThread = procedure(webView: wkeWebView; paramOnInThread: Pointer); cdecl;                 //2018.02.07
  wkeCallUiThread = procedure(webView: wkeWebView; func: wkeOnCallUiThread; param: Pointer); cdecl;  //2018.02.07

  wkeLoadUrlBeginCallback = function(webView: wkeWebView; param: Pointer; url: PAnsiChar ; job:
    Pointer): boolean; cdecl;  //2018.02.07

  wkeLoadUrlEndCallback = procedure(webView: wkeWebView; param: Pointer;const url: pansichar; job:
    Pointer; buf: Pointer; len: Integer); cdecl;  //2018.02.07

  wkeNetResponseCallback = function(webView: wkeWebView; param: Pointer; url: wkeString; job:
    Pointer): boolean; cdecl;  //2018.02.07



  jsGetPropertyCallback = function(es: jsExecState; AObject: jsValue; propertyName: PAnsiChar): jsValue; cdecl;

  jsSetPropertyCallback = function(es: jsExecState; AObject: jsValue; propertyName: PAnsiChar; value:
    jsValue): Boolean; cdecl;

  jsCallAsFunctionCallback = function(es: jsExecState; AObject: jsValue; args: PjsValue; argCount:
    Integer): jsValue; cdecl;

  PjsData = ^TjsData;

  jsFinalizeCallback = procedure(data: PjsData); cdecl;

  jsData = packed record
    typeName: array[0..99] of AnsiChar; //char
    propertyGet: jsGetPropertyCallback;
    propertySet: jsSetPropertyCallback;
    finalize: jsFinalizeCallback;
    callAsFunction: jsCallAsFunctionCallback;
  end;

  TjsData = jsData;
  // #define JS_CALL __fastcall
  //typedef jsValue (JS_CALL *jsNativeFunction) (jsExecState es);
  // 这里有两种写法，按照vc __fastcall的约定与delphi register约定的不一样
 {$IFDEF UseVcFastCall}

  jsNativeFunction = function(es: jsExecState): jsValue;
 {$ELSE}
     // 前两个参数用来占位用
  jsNativeFunction = function(p1, p2, es: jsExecState): jsValue;
 {$ENDIF}

  TNewWindowFlag = (nwf_NewPage, nwf_OpenInCurrent, nwf_Cancel);
  TwkePlatform =(wp_Win32,wp_Android,wp_Ios);

  //事件定义
  TOnTitleChangeEvent = procedure(Sender: TObject; sTitle: string) of object;

  TOnUrlChangeEvent = procedure(Sender: TObject; sUrl: string) of object;

  TOnLoadEndEvent = procedure(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult) of object;

  TOnBeforeLoadEvent = procedure(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean) of object;

  TOnCreateViewEvent = procedure(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures: PwkeWindowFeatures; var wvw: wkeWebView) of object;

  TOnAlertBoxEvent = procedure(Sender: TObject; sMsg: string) of object;

  TOnConfirmBoxEvent = procedure(Sender: TObject; sMsg: string; var bresult: boolean) of object;

  TOnPromptBoxEvent =procedure(Sender: TObject; smsg, defaultres, Strres: string;var bresult:boolean) of object;

  TOnDownloadEvent  = procedure(Sender: TObject; sUrl: string) of object;
  TOnConsoleMessgeEvent =procedure( Sender: TObject;const sMsg, source:string ;const sline:integer) of object;

  TOnLoadUrlEndEvent = procedure(Sender: TObject; sUrl: string;  buf: Pointer; len: Integer) of object;
  TOnLoadUrlBeginEvent = procedure(Sender: TObject; sUrl: string;  out bHook,bHandled:boolean) of object;



//==============================================================================
// webview
//==============================================================================

  wkeWebView = class
  private
    class function GetVersion: Integer;
    class function GetVersionString: string;
    function GetName: string;
    procedure SetName(const AName: string);
    function IsTransparent: Boolean;
    procedure SetTransparent(ATransparent: Boolean);
    procedure SetUserAgent(const AUserAgent: string);
  //  function IsLoadingSucceeded: Boolean;
  //  function IsLoadingFailed: Boolean;
  //  function IsLoadingCompleted: Boolean;
    function IsDocumentReady: Boolean;
    function GetTitle: string;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetContentWidth: Integer;
    function GetContentHeight: Integer;
  //  procedure SetDirty(dirty: Boolean);
  //  function IsDirty: Boolean;
    function GetViewDC: HDC;
    function GetCookie: string;
    procedure SetCookieEnabled(enable: Boolean);
    function IsCookieEnabled: Boolean;
    procedure SetMediaVolume(volume: Single);
    function GetMediaVolume: Single;
    function GetCaretRect: wkeRect;
    procedure SetZoomFactor(factor: Single);
    function GetZoomFactor: Single;
    procedure SetEditable(editable: Boolean);
    function GetWindowHandle: HWND;
    procedure SetWindowTitle(const ATitle: string);
    function GetLocalUrl: string;
    procedure SetLocaStoragePath(const Value: string);
  public
    class procedure Initialize;
    class procedure InitializeEx(settings: PwkeSettings);
    class procedure Configure(settings: PwkeSettings);
    class procedure Finalize;
    class procedure Update;
    class procedure SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
    class function CreateWebView: wkeWebView;
    class function CreateWebWindow(AType: wkeWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): wkeWebView;
    procedure DestroyWebWindow;
    procedure DestroyWebView;
    procedure LoadURL(const AURL: string);
    procedure PostURL(const AURL, APostData: string; PostLen: Integer);
    procedure LoadHTML(const AHTML: string);
    procedure LoadFile(const AFileName: string);
    procedure Load(const AStr: string);
    procedure StopLoading;
    procedure Reload;
    procedure Resize(w: Integer; h: Integer);
   // procedure AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
   // procedure LayoutIfNeeded;
    procedure Paint(bits: Pointer; bufWid: Integer; bufHei: Integer; xDst: Integer; yDst: Integer; w: Integer; h: Integer; xSrc: Integer; ySrc: Integer; bCopyAlpha: Boolean);
    procedure Paint2(bits: Pointer; pitch: Integer);
  //  procedure RepaintIfNeeded;
    function CanGoBack: Boolean;
    function GoBack: Boolean;
    function CanGoForward: Boolean;
    function GoForward: Boolean;
    procedure EditorSelectAll;
    procedure EditorCopy;
    procedure EditorCut;
    procedure EditorPaste;
    procedure EditorDelete;
    function FireMouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
    function FireContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
    function FireMouseWheelEvent(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
    function FireKeyUpEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function FireKeyDownEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    function FireKeyPressEvent(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
    procedure SetFocus;
    procedure SetCookie(const scookie:string);  //2018.01.17新增

    procedure KillFocus;
    function RunJS(const AScript: string): jsValue;
    function GlobalExec: jsExecState;
    procedure Sleep;
    procedure Wake;
    function IsAwake: Boolean;
    class function GetString(AString: wkeString): string;
    class procedure SetString(AString: wkeString; const AStr: string);
    procedure SetOnTitleChanged(callback: wkeTitleChangedCallback; callbackParam: Pointer);
    procedure SetOnURLChanged(callback: wkeURLChangedCallback; callbackParam: Pointer);
    procedure SetOnPaintUpdated(callback: wkePaintUpdatedCallback; callbackParam: Pointer);
    procedure SetOnAlertBox(callback: wkeAlertBoxCallback; callbackParam: Pointer);
    procedure SetOnConfirmBox(callback: wkeConfirmBoxCallback; callbackParam: Pointer);
    procedure SetOnPromptBox(callback: wkePromptBoxCallback; callbackParam: Pointer);
    procedure SetOnNavigation(callback: wkeNavigationCallback; param: Pointer);
    procedure SetOnCreateView(callback: wkeCreateViewCallback; param: Pointer);
    procedure SetOnConsoleMessage(callback: wkeConsoleMessageCallback; callbackParam: Pointer);
    procedure SetOnDocumentReady(callback: wkeDocumentReadyCallback; param: Pointer);
    procedure SetOnLoadingFinish(callback: wkeLoadingFinishCallback; param: Pointer);
    procedure SetOnWindowClosing(callback: wkeWindowClosingCallback; param: Pointer);
    procedure SetOnWindowDestroy(callback: wkeWindowDestroyCallback; param: Pointer);
    procedure SetOnDownload(callback:wkeDownloadCallback; param: Pointer);
    procedure ShowWindow(show: Boolean);
    procedure EnableWindow(enable: Boolean);
    procedure MoveWindow(x: Integer; y: Integer; width: Integer; height: Integer);
    procedure MoveToCenter;
    procedure ResizeWindow(width: Integer; height: Integer);
  public
    property Name: string read GetName write SetName;
    property Version: Integer read GetVersion;
    property VersionString: string read GetVersionString;
    property Transparent: Boolean read IsTransparent write SetTransparent;
    property UserAgent: string write SetUserAgent;
   // property LoadingSucceeded: Boolean read IsLoadingSucceeded;
  //  property LoadingFailed: Boolean read IsLoadingFailed;
  //  property LoadingCompleted: Boolean read IsLoadingCompleted;
    property DocumentReady: Boolean read IsDocumentReady;
    property Title: string read GetTitle;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property ContentWidth: Integer read GetContentWidth;
    property ContentHeight: Integer read GetContentHeight;
  //  property Dirty: Boolean read IsDirty write SetDirty;
    property ViewDC: HDC read GetViewDC;
    property Cookie: string read GetCookie write SetCookie;         //2018.01.17
    property CookieEnabled: Boolean read IsCookieEnabled write SetCookieEnabled;
    property LocalStoragePath:string  write SetLocaStoragePath;    //2018.1.20
    property MediaVolume: Single read GetMediaVolume write SetMediaVolume;
    property CaretRect: wkeRect read GetCaretRect;
    property ZoomFactor: Single read GetZoomFactor write SetZoomFactor;
    property Editable: Boolean write SetEditable;
    property WindowHandle: HWND read GetWindowHandle;
    property WindowTitle: string write SetWindowTitle;
    property LocalUrl:string read GetLocalUrl;
  end;

  TWkeWebView = wkeWebView;




//------------------------------------------------------------------------------
// Js
//------------------------------------------------------------------------------

  JScript = class
  public
    class procedure BindFunction(const AName: string; fn: jsNativeFunction; AArgCount: LongInt); {$IFDEF SupportInline}inline;{$ENDIF}
    class procedure BindGetter(const AName: string; fn: jsNativeFunction); {$IFDEF SupportInline}inline;{$ENDIF}
    class procedure BindSetter(const AName: string; fn: jsNativeFunction); {$IFDEF SupportInline}inline;{$ENDIF}
    function ArgCount: Integer; {$IFDEF SupportInline}inline;{$ENDIF}
    function ArgType(argIdx: Integer): jsType; {$IFDEF SupportInline}inline;{$ENDIF}
    function Arg(argIdx: Integer): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function TypeOf(v: jsValue): jsType; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsNumber(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsString(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsBoolean(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsObject(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsFunction(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsUndefined(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsNull(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsArray(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsTrue(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    class function IsFalse(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToInt(v: jsValue): Integer; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToFloat(v: jsValue): Single; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToDouble(v: jsValue): Double; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToBoolean(v: jsValue): Boolean; {$IFDEF SupportInline}inline;{$ENDIF}
    function ToTempString(v: jsValue): string; {$IFDEF SupportInline}inline;{$ENDIF}
    class function Int(n: Integer): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function Float(f: Single): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function Double(d: Double): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function Boolean(b: Boolean): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function Undefined: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function Null: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function True_: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    class function False_: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function String_(const AStr: string): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function EmptyObject: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function EmptyArray: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Object_(obj: PjsData): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Function_(obj: PjsData): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function GetData(AObject: jsValue): pjsData; {$IFDEF SupportInline}inline;{$ENDIF}
    function Get(AObject: jsValue; const prop: string): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure Set_(AObject: jsValue; const prop: string; v: jsValue); {$IFDEF SupportInline}inline;{$ENDIF}
    function GetAt(AObject: jsValue; index: Integer): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure SetAt(AObject: jsValue; index: Integer; v: jsValue); {$IFDEF SupportInline}inline;{$ENDIF}
    function GetLength(AObject: jsValue): Integer; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure SetLength(AObject: jsValue; length: Integer); {$IFDEF SupportInline}inline;{$ENDIF}
    function GlobalObject: jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function GetWebView: wkeWebView; {$IFDEF SupportInline}inline;{$ENDIF}
    function Eval(const AStr: string): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function Call(func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function CallGlobal(func: jsValue; args: PjsValue; argCount: Integer): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    function GetGlobal(const prop: string): jsValue; {$IFDEF SupportInline}inline;{$ENDIF}
    procedure SetGlobal(const prop: string; v: jsValue); {$IFDEF SupportInline}inline;{$ENDIF}
    class procedure GC; {$IFDEF SupportInline}inline;{$ENDIF}
  end;

implementation
   uses Langji.Wke.lib;
{ wkeWebView }




class procedure wkeWebView.Initialize;
begin
  wkeInitialize;
end;

class procedure wkeWebView.InitializeEx(settings: PwkeSettings);
begin
  wkeInitializeEx(settings);
end;

class procedure wkeWebView.Configure(settings: PwkeSettings);
begin
  wkeConfigure(settings);
end;

class procedure wkeWebView.Finalize;
begin
  wkeFinalize;
end;

class procedure wkeWebView.Update;
begin
  wkeUpdate;
end;

class function wkeWebView.GetVersion: Integer;
begin
  Result := wkeGetVersion;
end;

class function wkeWebView.GetVersionString: string;
begin
  Result := string(AnsiString(wkeGetVersionString));
end;

class procedure wkeWebView.SetFileSystem(pfn_open: FILE_OPEN; pfn_close: FILE_CLOSE; pfn_size: FILE_SIZE; pfn_read: FILE_READ; pfn_seek: FILE_SEEK);
begin
  wkeSetFileSystem(pfn_open, pfn_close, pfn_size, pfn_read, pfn_seek);
end;

class function wkeWebView.CreateWebView: wkeWebView;
begin
  Result := wkeCreateWebView;
end;

procedure wkeWebView.DestroyWebView;
begin
  wkeDestroyWebView(Self);
end;

function wkeWebView.GetName: string;
begin
  Result := string(AnsiString(wkeGetName(Self)));
end;

procedure wkeWebView.SetName(const AName: string);
begin
  wkeSetName(Self, PAnsiChar(AnsiString(AName)));
end;

function wkeWebView.IsTransparent: Boolean;
begin
  Result := wkeIsTransparent(Self);
end;

procedure wkeWebView.SetTransparent(ATransparent: Boolean);
begin
  wkeSetTransparent(Self, ATransparent);
end;

procedure wkeWebView.SetUserAgent(const AUserAgent: string);
begin
{$IFDEF UNICODE}
   wkeSetUserAgentW(Self, PChar(AUserAgent));
{$ELSE}
   wkeSetUserAgent(Self, PChar({$IFDEF FPC}AUserAgent{$ELSE}AnsiToUtf8(AUserAgent){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.LoadURL(const AURL: string);
begin
{$IFDEF UNICODE}
  wkeLoadURLW(Self, PChar(AURL));
{$ELSE}
  wkeLoadURL(Self, PChar({$IFDEF FPC}AURL{$ELSE}AnsiToUtf8(AURL){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.PostURL(const AURL, APostData: string; PostLen: Integer);
begin
{$IFDEF UNICODE}
   wkePostURLW(Self, PChar(AURL), PAnsiChar(AnsiString(APostData)), PostLen);
{$ELSE}
   wkePostURL(Self, PChar({$IFDEF FPC}AURL{$ELSE}AnsiToUtf8(AURL){$ENDIF}),
     PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(APostData){$ELSE}APostData{$ENDIF})), PostLen);
{$ENDIF}
end;

procedure wkeWebView.LoadHTML(const AHTML: string);
begin
{$IFDEF UNICODE}
  wkeLoadHTMLW(Self, PChar(AHTML));
{$ELSE}
  wkeLoadHTML(Self, PChar({$IFDEF FPC}AHTML{$ELSE}AnsiToUtf8(AHTML){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.LoadFile(const AFileName: string);
begin
{$IFDEF UNICODE}
  wkeLoadFileW(Self, PChar(AFileName));
{$ELSE}
  wkeLoadFile(Self, PChar({$IFDEF FPC}AFileName{$ELSE}AnsiToUtf8(AFileName){$ENDIF}));
{$ENDIF}
end;

procedure wkeWebView.Load(const AStr: string);
begin
{$IFDEF UNICODE}
  wkeLoadW(Self, PChar(AStr))
{$ELSE}
  wkeLoad(Self, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUTf8(AStr){$ENDIF}))
{$ENDIF}
end;

//function wkeWebView.IsLoading: Boolean;
//begin
//  Result := wkeIsLoading(Self);
//end;

//function wkeWebView.IsLoadingSucceeded: Boolean;
//begin
//  Result := wkeIsLoadingSucceeded(Self);
//end;
//
//function wkeWebView.IsLoadingFailed: Boolean;
//begin
//  Result := wkeIsLoadingFailed(Self);
//end;
//
//function wkeWebView.IsLoadingCompleted: Boolean;
//begin
//  Result := wkeIsLoadingCompleted(Self);
//end;

function wkeWebView.IsDocumentReady: Boolean;
begin
  Result := wkeIsDocumentReady(Self);
end;

procedure wkeWebView.StopLoading;
begin
  wkeStopLoading(Self);
end;

procedure wkeWebView.Reload;
begin
  wkeReload(Self);
end;

function wkeWebView.GetTitle: string;
begin
{$IFDEF UNICODE}
  Result := wkeGetTitleW(Self);
{$ELSE}
  Result := {$IFDEF FPC}wkeGetTitle(Self){$ELSE}Utf8ToAnsi(wkeGetTitle(Self)){$ENDIF};
{$ENDIF}
end;

procedure wkeWebView.Resize(w: Integer; h: Integer);
begin
  wkeResize(Self, w, h);
end;

function wkeWebView.GetWidth: Integer;
begin
  Result := wkeGetWidth(Self);
end;

function wkeWebView.GetHeight: Integer;
begin
  Result := wkeGetHeight(Self);
end;

function wkeWebView.GetLocalUrl: string;
begin
  result :=wkeGetURL(Self);
end;

function wkeWebView.GetContentWidth: Integer;
begin
  Result := wkeGetContentWidth(Self);
end;

function wkeWebView.GetContentHeight: Integer;
begin
  Result := wkeGetContentHeight(Self);
end;

//procedure wkeWebView.SetDirty(dirty: Boolean);
//begin
//  wkeSetDirty(Self, dirty);
//end;
//
//function wkeWebView.IsDirty: Boolean;
//begin
//  Result := wkeIsDirty(Self);
//end;
//
//procedure wkeWebView.AddDirtyArea(x: Integer; y: Integer; w: Integer; h: Integer);
//begin
//  wkeAddDirtyArea(Self, x, y, w, h);
//end;
//
//procedure wkeWebView.LayoutIfNeeded;
//begin
//  wkeLayoutIfNeeded(Self);
//end;

procedure wkeWebView.Paint(bits: Pointer; bufWid: Integer; bufHei: Integer; xDst: Integer; yDst: Integer; w: Integer; h: Integer; xSrc: Integer; ySrc: Integer; bCopyAlpha: Boolean);
begin
  wkePaint(Self, bits, bufWid, bufHei, xDst, yDst, w, h, xSrc, ySrc, bCopyAlpha);
end;

procedure wkeWebView.Paint2(bits: Pointer; pitch: Integer);
begin
  wkePaint2(Self, bits, pitch);
end;

//procedure wkeWebView.RepaintIfNeeded;
//begin
//  wkeRepaintIfNeeded(Self);
//end;

function wkeWebView.GetViewDC: HDC;
begin
  Result := wkeGetViewDC(Self);
end;

function wkeWebView.CanGoBack: Boolean;
begin
  Result := wkeCanGoBack(Self);
end;

function wkeWebView.GoBack: Boolean;
begin
  Result := wkeGoBack(Self);
end;

function wkeWebView.CanGoForward: Boolean;
begin
  Result := wkeCanGoForward(Self);
end;

function wkeWebView.GoForward: Boolean;
begin
  Result := wkeGoForward(Self);
end;

procedure wkeWebView.EditorSelectAll;
begin
  wkeEditorSelectAll(Self);
end;

procedure wkeWebView.EditorCopy;
begin
  wkeEditorCopy(Self);
end;

procedure wkeWebView.EditorCut;
begin
  wkeEditorCut(Self);
end;

procedure wkeWebView.EditorPaste;
begin
  wkeEditorPaste(Self);
end;

procedure wkeWebView.EditorDelete;
begin
  wkeEditorDelete(Self);
end;

function wkeWebView.GetCookie: string;
begin
{$IFDEF UNICODE}
  Result := wkeGetCookieW(Self);
{$ELSE}
  Result := {$IFDEF FPC}wkeGetCookie(Self){$ELSE}Utf8ToAnsi(wkeGetCookie(Self)){$ENDIF};
{$ENDIF}
end;

procedure wkeWebView.SetCookie(const scookie: string);
begin
  if Assigned(wkeSetCookie) then
    wkeSetCookie(Self,PansiChar(AnsiToUtf8( GetLocalUrl)),PAnsiChar(AnsiToUtf8(scookie)));
end;

procedure wkeWebView.SetCookieEnabled(enable: Boolean);
begin

  if Assigned(wkeSetCookieEnabled) then
    wkeSetCookieEnabled(Self, enable);
end;

function wkeWebView.IsCookieEnabled: Boolean;
begin
  Result := wkeIsCookieEnabled(Self);
end;

procedure wkeWebView.SetMediaVolume(volume: Single);
begin
  wkeSetMediaVolume(Self, volume);
end;

function wkeWebView.GetMediaVolume: Single;
begin
  Result := wkeGetMediaVolume(Self);
end;

function wkeWebView.FireMouseEvent(AMessage: LongInt; x: Integer; y: Integer; flags: LongInt): Boolean;
begin
  Result := wkeFireMouseEvent(Self, AMessage, x, y, flags);
end;

function wkeWebView.FireContextMenuEvent(x: Integer; y: Integer; flags: LongInt): Boolean;
begin
  Result := wkeFireContextMenuEvent(Self, x, y, flags);
end;

function wkeWebView.FireMouseWheelEvent(x: Integer; y: Integer; delta: Integer; flags: LongInt): Boolean;
begin
  Result := wkeFireMouseWheelEvent(Self, x, y, delta, flags);
end;

function wkeWebView.FireKeyUpEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeFireKeyUpEvent(Self, virtualKeyCode, flags, systemKey);
end;

function wkeWebView.FireKeyDownEvent(virtualKeyCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeFireKeyDownEvent(Self, virtualKeyCode, flags, systemKey);
end;

function wkeWebView.FireKeyPressEvent(charCode: LongInt; flags: LongInt; systemKey: Boolean): Boolean;
begin
  Result := wkeFireKeyPressEvent(Self, charCode, flags, systemKey);
end;

procedure wkeWebView.SetFocus;
begin
  wkeSetFocus(Self);
end;

procedure wkeWebView.SetLocaStoragePath(const Value: string);
begin
{$IFDEF UNICODE}
  wkeSetLocalStorageFullPath(self,PChar(value));
{$ELSE}
   wkeSetLocalStorageFullPath(self,PwideChar(value));
{$ENDIF}
end;

procedure wkeWebView.KillFocus;
begin
  wkeKillFocus(Self);
end;

function wkeWebView.GetCaretRect: wkeRect;
begin
  Result := wkeGetCaretRect(Self);
end;

function wkeWebView.RunJS(const AScript: string): jsValue;
begin
{$IFDEF UNICODE}
  Result := wkeRunJSW(Self, PChar(AScript));
{$ELSE}
  Result := wkeRunJS(Self, PChar({$IFDEF FPC}AScript{$ELSE}AnsiToUtf8(AScript){$ENDIF}));
{$ENDIF}
end;

function wkeWebView.GlobalExec: jsExecState;
begin
  Result := wkeGlobalExec(Self);
end;

procedure wkeWebView.Sleep;
begin
  wkeSleep(Self);
end;

procedure wkeWebView.Wake;
begin
  wkeWake(Self);
end;

function wkeWebView.IsAwake: Boolean;
begin
  Result := wkeIsAwake(Self);
end;

procedure wkeWebView.SetZoomFactor(factor: Single);
begin
  wkeSetZoomFactor(Self, factor);
end;

function wkeWebView.GetZoomFactor: Single;
begin
  Result := wkeGetZoomFactor(Self);
end;

procedure wkeWebView.SetEditable(editable: Boolean);
begin
  wkeSetEditable(Self, editable);
end;

class function wkeWebView.GetString(AString: wkeString): string;
begin
{$IFDEF UNICODE}
  Result := wkeGetStringW(AString);
{$ELSE}
  Result := {$IFDEF FPC}wkeGetString(AString){$ELSE}Utf8ToAnsi(wkeGetString(AString)){$ENDIF};
{$ENDIF}
end;

class procedure wkeWebView.SetString(AString: wkeString; const AStr: string);
begin
{$IFDEF UNICODE}
  wkeSetStringW(AString, PChar(AStr), Length(AStr));
{$ELSE}
  wkeSetString(AString, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUtf8(AStr){$ENDIF}), Length(AStr));
{$ENDIF}
end;

procedure wkeWebView.SetOnTitleChanged(callback: wkeTitleChangedCallback; callbackParam: Pointer);
begin
  wkeOnTitleChanged(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnURLChanged(callback: wkeURLChangedCallback; callbackParam: Pointer);
begin
  wkeOnURLChanged(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnPaintUpdated(callback: wkePaintUpdatedCallback; callbackParam: Pointer);
begin
  wkeOnPaintUpdated(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnAlertBox(callback: wkeAlertBoxCallback; callbackParam: Pointer);
begin
  wkeOnAlertBox(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnConfirmBox(callback: wkeConfirmBoxCallback; callbackParam: Pointer);
begin
  wkeOnConfirmBox(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnConsoleMessage(callback: wkeConsoleMessageCallback;
  callbackParam: Pointer);
begin
  wkeOnConsoleMessage(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnPromptBox(callback: wkePromptBoxCallback; callbackParam: Pointer);
begin
  wkeOnPromptBox(Self, callback, callbackParam);
end;

procedure wkeWebView.SetOnNavigation(callback: wkeNavigationCallback; param: Pointer);
begin
  wkeOnNavigation(Self, callback, param);
end;

procedure wkeWebView.SetOnCreateView(callback: wkeCreateViewCallback; param: Pointer);
begin
  wkeOnCreateView(Self, callback, param);
end;

procedure wkeWebView.SetOnDocumentReady(callback: wkeDocumentReadyCallback; param: Pointer);
begin
  wkeOnDocumentReady(Self, callback, param);
end;

procedure wkeWebView.SetOnDownload(callback: wkeDownloadCallback;
  param: Pointer);
begin
  wkeOnDownload(self,callback,param);
end;

procedure wkeWebView.SetOnLoadingFinish(callback: wkeLoadingFinishCallback; param: Pointer);
begin
  wkeOnLoadingFinish(Self, callback, param);
end;

class function wkeWebView.CreateWebWindow(AType: wkeWindowType; parent: HWND; x: Integer; y: Integer; width: Integer; height: Integer): wkeWebView;
begin
  Result := wkeCreateWebWindow(AType, parent, x, y, width, height);
end;

procedure wkeWebView.DestroyWebWindow;
begin
  wkeDestroyWebWindow(Self);
end;



function wkeWebView.GetWindowHandle: HWND;
begin
  Result := wkeGetWindowHandle(Self);
end;

procedure wkeWebView.SetOnWindowClosing(callback: wkeWindowClosingCallback; param: Pointer);
begin
  wkeOnWindowClosing(Self, callback, param);
end;

procedure wkeWebView.SetOnWindowDestroy(callback: wkeWindowDestroyCallback; param: Pointer);
begin
  wkeOnWindowDestroy(Self, callback, param);
end;

procedure wkeWebView.ShowWindow(show: Boolean);
begin
  wkeShowWindow(Self, show);
end;

procedure wkeWebView.EnableWindow(enable: Boolean);
begin
  wkeEnableWindow(Self, enable);
end;

procedure wkeWebView.MoveWindow(x: Integer; y: Integer; width: Integer; height: Integer);
begin
  wkeMoveWindow(Self, x, y, width, height);
end;

procedure wkeWebView.MoveToCenter;
begin
  wkeMoveToCenter(Self);
end;

procedure wkeWebView.ResizeWindow(width: Integer; height: Integer);
begin
  wkeResizeWindow(Self, width, height);
end;

procedure wkeWebView.SetWindowTitle(const ATitle: string);
begin
{$IFDEF UNICODE}
  wkeSetWindowTitleW(Self, PChar(ATitle));
{$ELSE}
  wkeSetWindowTitle(Self, PChar({$IFDEF FPC}ATitle{$ELSE}AnsiToUtf8(ATitle){$ENDIF}));
{$ENDIF}
end;

{ JScript }

class procedure JScript.BindFunction(const AName: string; fn: jsNativeFunction; AArgCount: LongInt);
begin
  jsBindFunction(PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(AName){$ELSE}AName{$ENDIF})), fn, AArgCount);
end;

class procedure JScript.BindGetter(const AName: string; fn: jsNativeFunction);
begin
  jsBindGetter(PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(AName){$ELSE}AName{$ENDIF})), fn);
end;

class procedure JScript.BindSetter(const AName: string; fn: jsNativeFunction);
begin
  jsBindSetter(PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(AName){$ELSE}AName{$ENDIF})), fn);
end;

function JScript.ArgCount: Integer;
begin
  Result := jsArgCount(Self);
end;

function JScript.ArgType(argIdx: Integer): jsType;
begin
  Result := jsArgType(Self, argIdx);
end;

function JScript.Arg(argIdx: Integer): jsValue;
begin
  Result := jsArg(Self, argIdx);
end;

class function JScript.TypeOf(v: jsValue): jsType;
begin
  Result := jsTypeOf(v);
end;

class function JScript.IsNumber(v: jsValue): Boolean;
begin
  Result := jsIsNumber(v);
end;

class function JScript.IsString(v: jsValue): Boolean;
begin
  Result := jsIsString(v);
end;

class function JScript.IsBoolean(v: jsValue): Boolean;
begin
  Result := jsIsBoolean(v);
end;

class function JScript.IsObject(v: jsValue): Boolean;
begin
  Result := jsIsObject(v);
end;

class function JScript.IsFunction(v: jsValue): Boolean;
begin
  Result := jsIsFunction(v);
end;

class function JScript.IsUndefined(v: jsValue): Boolean;
begin
  Result := jsIsUndefined(v);
end;

class function JScript.IsNull(v: jsValue): Boolean;
begin
  Result := jsIsNull(v);
end;

class function JScript.IsArray(v: jsValue): Boolean;
begin
  Result := jsIsArray(v);
end;

class function JScript.IsTrue(v: jsValue): Boolean;
begin
  Result := jsIsTrue(v);
end;

class function JScript.IsFalse(v: jsValue): Boolean;
begin
  Result := jsIsFalse(v);
end;

function JScript.ToInt(v: jsValue): Integer;
begin
  Result := jsToInt(Self, v);
end;

function JScript.ToFloat(v: jsValue): Single;
begin
  Result := jsToFloat(Self, v);
end;

function JScript.ToDouble(v: jsValue): Double;
begin
  Result := jsToDouble(Self, v);
end;

function JScript.ToBoolean(v: jsValue): Boolean;
begin
  Result := jsToBoolean(Self, v);
end;

function JScript.ToTempString(v: jsValue): string;
begin
{$IFDEF UNICODE}
  Result := jsToTempStringW(Self, v);
{$ELSE}
  Result := {$IFDEF FPC}jsToTempString(Self, v){$ELSE}Utf8ToAnsi(jsToTempString(Self, v)){$ENDIF};
{$ENDIF}
end;

class function JScript.Int(n: Integer): jsValue;
begin
  Result := jsInt(n);
end;

class function JScript.Float(f: Single): jsValue;
begin
  Result := jsFloat(f);
end;

class function JScript.Double(d: Double): jsValue;
begin
  Result := jsDouble(d);
end;

class function JScript.Boolean(b: Boolean): jsValue;
begin
  Result := jsBoolean(b);
end;

class function JScript.Undefined: jsValue;
begin
  Result := jsUndefined;
end;

class function JScript.Null: jsValue;
begin
  Result := jsNull;
end;

class function JScript.True_: jsValue;
begin
  Result := jsTrue;
end;

class function JScript.False_: jsValue;
begin
  Result := jsFalse;
end;

function JScript.String_(const AStr: string): jsValue;
begin
{$IFDEF UNICODE}
  Result := jsStringW(Self, PChar(AStr));
{$ELSE}
  Result := jsString(Self, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUtf8(AStr){$ENDIF}));
{$ENDIF}
end;

function JScript.EmptyObject: jsValue;
begin
  Result := jsEmptyObject(Self);
end;

function JScript.EmptyArray: jsValue;
begin
  Result := jsEmptyArray(Self);
end;

function JScript.Object_(obj: PjsData): jsValue;
begin
  Result := jsObject(Self, obj);
end;

function JScript.Function_(obj: PjsData): jsValue;
begin
  Result := jsFunction(Self, obj);
end;

function JScript.GetData(AObject: jsValue): pjsData;
begin
  Result := jsGetData(Self, AObject);
end;

function JScript.Get(AObject: jsValue; const prop: string): jsValue;
begin
  Result := jsGet(Self, AObject, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})));
end;

procedure JScript.Set_(AObject: jsValue; const prop: string; v: jsValue);
begin
  jsSet(Self, AObject, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})), v);
end;

function JScript.GetAt(AObject: jsValue; index: Integer): jsValue;
begin
  Result := jsGetAt(Self, AObject, index);
end;

procedure JScript.SetAt(AObject: jsValue; index: Integer; v: jsValue);
begin
  jsSetAt(Self, AObject, index, v);
end;

function JScript.GetLength(AObject: jsValue): Integer;
begin
  Result := jsGetLength(Self, AObject);
end;

procedure JScript.SetLength(AObject: jsValue; length: Integer);
begin
  jsSetLength(Self, AObject, length);
end;

function JScript.GlobalObject: jsValue;
begin
  Result := jsGlobalObject(Self);
end;

function JScript.GetWebView: wkeWebView;
begin
  Result := jsGetWebView(Self);
end;

function JScript.Eval(const AStr: string): jsValue;
begin
{$IFDEF UNICODE}
  Result := jsEvalW(Self, PChar(AStr));
{$ELSE}
  Result := jsEval(Self, PChar({$IFDEF FPC}AStr{$ELSE}AnsiToUtf8(AStr){$ENDIF}));
{$ENDIF}
end;

function JScript.Call(func: jsValue; thisObject: jsValue; args: PjsValue; argCount: Integer): jsValue;
begin
  Result := jsCall(Self, func, thisObject, args, argCount);
end;

function JScript.CallGlobal(func: jsValue; args: PjsValue; argCount: Integer): jsValue;
begin
  Result := jsCallGlobal(Self, func, args, argCount);
end;

function JScript.GetGlobal(const prop: string): jsValue;
begin
  Result := jsGetGlobal(Self, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})));
end;

procedure JScript.SetGlobal(const prop: string; v: jsValue);
begin
  jsSetGlobal(Self, PAnsiChar(AnsiString({$IFDEF FPC}Utf8ToAnsi(prop){$ELSE}prop{$ENDIF})), v);
end;

class procedure JScript.GC;
begin
  jsGC;
end;


end.


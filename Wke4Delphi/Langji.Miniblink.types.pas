{*******************************************************}
{                                                       }
{       miniblink for delphi                            }
{                                                       }
{       版权所有 (C) 2018 langji                        }
{                                                       }
{*******************************************************}

unit Langji.Miniblink.types;

interface

uses
  Windows;

const
  mbdll = 'mb.dll';
  mbgetsourcemsg = $4001;

  //typedef enum {
//    MB_LBUTTON = 0x01,
//    MB_RBUTTON = 0x02,
//    MB_SHIFT = 0x04,
//    MB_CONTROL = 0x08,
//    MB_MBUTTON = 0x10,
//} mbMouseFlags;

  MB_LBUTTON = $01;
  MB_RBUTTON = $02;
  MB_SHIFT = $04;
  MB_CONTROL = $08;
  MB_MBUTTON = $10;


//typedef enum {
//    MB_EXTENDED = 0x0100,
//    MB_REPEAT = 0x4000,
//} mbKeyFlags;
  MB_EXTENDED = $0100;
  MB_REPEAT = $4000;


//typedef enum {
//    MB_MSG_MOUSEMOVE = 0x0200,
//    MB_MSG_LBUTTONDOWN = 0x0201,
//    MB_MSG_LBUTTONUP = 0x0202,
//    MB_MSG_LBUTTONDBLCLK = 0x0203,
//    MB_MSG_RBUTTONDOWN = 0x0204,
//    MB_MSG_RBUTTONUP = 0x0205,
//    MB_MSG_RBUTTONDBLCLK = 0x0206,
//    MB_MSG_MBUTTONDOWN = 0x0207,
//    MB_MSG_MBUTTONUP = 0x0208,
//    MB_MSG_MBUTTONDBLCLK = 0x0209,
//    MB_MSG_MOUSEWHEEL = 0x020A,
//} mbMouseMsg;

  MB_MSG_MOUSEMOVE = $0200;
  MB_MSG_LBUTTONDOWN = $0201;
  MB_MSG_LBUTTONUP = $0202;
  MB_MSG_LBUTTONDBLCLK = $0203;
  MB_MSG_RBUTTONDOWN = $0204;
  MB_MSG_RBUTTONUP = $0205;
  MB_MSG_RBUTTONDBLCLK = $0206;
  MB_MSG_MBUTTONDOWN = $0207;
  MB_MSG_MBUTTONUP = $0208;
  MB_MSG_MBUTTONDBLCLK = $0209;
  MB_MSG_MOUSEWHEEL = $020A;

//
//enum mbSettingMask {
//    MB_SETTING_PROXY = 1,
//    MB_SETTING_PAINTCALLBACK_IN_OTHER_THREAD = 1 << 2,
//};

  MB_SETTING_PROXY = 1;
  MB_SETTING_PAINTCALLBACK_IN_OTHER_THREAD = 4;       //????

//typedef enum {
//    mbWebDragOperationNone = 0,
//    mbWebDragOperationCopy = 1,
//    mbWebDragOperationLink = 2,
//    mbWebDragOperationGeneric = 4,
//    mbWebDragOperationPrivate = 8,
//    mbWebDragOperationMove = 16,
//    mbWebDragOperationDelete = 32,
//    mbWebDragOperationEvery = 0xffffffff
//} mbWebDragOperation;

  mbWebDragOperationNone = 0;
  mbWebDragOperationCopy = 1;
  mbWebDragOperationLink = 2;
  mbWebDragOperationGeneric = 4;
  mbWebDragOperationPrivate = 8;
  mbWebDragOperationMove = 16;
  mbWebDragOperationDelete = 32;
  mbWebDragOperationEvery = $ffffffff;


//typedef enum {
//    MB_RESOURCE_TYPE_MAIN_FRAME = 0,       // top level page
//    MB_RESOURCE_TYPE_SUB_FRAME = 1,        // frame or iframe
//    MB_RESOURCE_TYPE_STYLESHEET = 2,       // a CSS stylesheet
//    MB_RESOURCE_TYPE_SCRIPT = 3,           // an external script
//    MB_RESOURCE_TYPE_IMAGE = 4,            // an image (jpg/gif/png/etc)
//    MB_RESOURCE_TYPE_FONT_RESOURCE = 5,    // a font
//    MB_RESOURCE_TYPE_SUB_RESOURCE = 6,     // an "other" subresource.
//    MB_RESOURCE_TYPE_OBJECT = 7,           // an object (or embed) tag for a plugin,
//                                            // or a resource that a plugin requested.
//    MB_RESOURCE_TYPE_MEDIA = 8,            // a media resource.
//    MB_RESOURCE_TYPE_WORKER = 9,           // the main resource of a dedicated
//                                            // worker.
//    MB_RESOURCE_TYPE_SHARED_WORKER = 10,   // the main resource of a shared worker.
//    MB_RESOURCE_TYPE_PREFETCH = 11,        // an explicitly requested prefetch
//    MB_RESOURCE_TYPE_FAVICON = 12,         // a favicon
//    MB_RESOURCE_TYPE_XHR = 13,             // a XMLHttpRequest
//    MB_RESOURCE_TYPE_PING = 14,            // a ping request for <a ping>
//    MB_RESOURCE_TYPE_SERVICE_WORKER = 15,  // the main resource of a service worker.
//    MB_RESOURCE_TYPE_LAST_TYPE
//} mbResourceType;

  MB_RESOURCE_TYPE_MAIN_FRAME = 0;       // top level page
  MB_RESOURCE_TYPE_SUB_FRAME = 1;        // frame or iframe
  MB_RESOURCE_TYPE_STYLESHEET = 2;       // a CSS stylesheet
  MB_RESOURCE_TYPE_SCRIPT = 3;           // an external script
  MB_RESOURCE_TYPE_IMAGE = 4;            // an image (jpg/gif/png/etc)
  MB_RESOURCE_TYPE_FONT_RESOURCE = 5;    // a font
  MB_RESOURCE_TYPE_SUB_RESOURCE = 6;     // an "other" subresource.
  MB_RESOURCE_TYPE_OBJECT = 7;           // an object (or embed) tag for a plugin;
                                           // or a resource that a plugin requested.
  MB_RESOURCE_TYPE_MEDIA = 8;            // a media resource.
  MB_RESOURCE_TYPE_WORKER = 9;           // the main resource of a dedicated
                                           // worker.
  MB_RESOURCE_TYPE_SHARED_WORKER = 10;   // the main resource of a shared worker.
  MB_RESOURCE_TYPE_PREFETCH = 11;        // an explicitly requested prefetch
  MB_RESOURCE_TYPE_FAVICON = 12;         // a favicon
  MB_RESOURCE_TYPE_XHR = 13;             // a XMLHttpRequest
  MB_RESOURCE_TYPE_PING = 14;            // a ping request for <a ping>
  MB_RESOURCE_TYPE_SERVICE_WORKER = 15;  // the main resource of a service worker.
  MB_RESOURCE_TYPE_LAST_TYPE = 16;


//typedef enum {
//    kMbJsTypeNumber = 0,
//    kMbJsTypeString = 1,
//    kMbJsTypeBool = 2,
//    //kMbJsTypeObject = 3,
//    //kMbJsTypeFunction = 4,
//    kMbJsTypeUndefined  = 5,
//    //kMbJsTypeArray = 6,
//    kMbJsTypeNull = 7,
//} mbJsType;
  kMbJsTypeNumber = 0;
  kMbJsTypeString = 1;
  kMbJsTypeBool = 2;
   //kMbJsTypeObject = 3;
   //kMbJsTypeFunction = 4;
  kMbJsTypeUndefined = 5;
   //kMbJsTypeArray = 6;
  kMbJsTypeNull = 7;

//typedef enum {
//    mbLevelDebug = 4,
//    mbLevelLog = 1,
//    mbLevelInfo = 5,
//    mbLevelWarning = 2,
//    mbLevelError = 3,
//    mbLevelRevokedError = 6,
//    mbLevelLast = mbLevelInfo
//} mbConsoleLevel;

  mbLevelDebug = 4;
  mbLevelLog = 1;
  mbLevelInfo = 5;
  mbLevelWarning = 2;
  mbLevelError = 3;
  mbLevelRevokedError = 6;
  mbLevelLast = mbLevelInfo;

//enum MbAsynRequestState {
//    kMbAsynRequestStateOk = 0,
//    kMbAsynRequestStateFail = 1,
//};

  kMbAsynRequestStateOk = 0;
  kMbAsynRequestStateFail = 1;

type





//typedef struct {
//    int x;
//    int y;
//    int w;
//    int h;
//} mbRect;

  TmbRect = packed record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;

  PmbRect = ^TmbRect;

//typedef struct {
//    int x;
//    int y;
//} mbPoint;

  TmbPoint = packed record
    x: Integer;
    y: Integer;
  end;

  TmbConsoleLevel = Integer;

  TMbAsynRequestState = Integer;

//struct mbString;
//typedef mbString* mbStringPtr;

  TmbString = packed record
  end;

  TmbStringPtr = ^TmbString;

//  typedef unsigned short wchar_t;
//  typedef char utf8;
  utf8 = AnsiChar;

  wchat_t = WideChar;   //Word??

  Putf8 = PAnsiChar;

  Pwchar_t = PWideChar;


//typedef enum {
//    MB_PROXY_NONE,
//    MB_PROXY_HTTP,
//    MB_PROXY_SOCKS4,
//    MB_PROXY_SOCKS4A,
//    MB_PROXY_SOCKS5,
//    MB_PROXY_SOCKS5HOSTNAME
//} mbProxyType;

  TmbProxyType = (MB_PROXY_NONE, MB_PROXY_HTTP, MB_PROXY_SOCKS4, MB_PROXY_SOCKS4A, MB_PROXY_SOCKS5, MB_PROXY_SOCKS5HOSTNAME);


//
//typedef struct {
//    mbProxyType type;
//    char hostname[100];
//    unsigned short port;
//    char username[50];
//    char password[50];
//} mbProxy;

  TmbProxy = packed record
    mtype: TmbProxyType;
    hostname: array[0..99] of Ansichar;
    port: Word;
    username: array[0..49] of AnsiChar;
    password: array[0..49] of AnsiChar;
  end;

  PmbProxy = ^TmbProxy;

//typedef struct {
//    mbProxy proxy;
//    unsigned int mask;
//    mbOnBlinkThreadInitCallback blinkThreadInitCallback;
//    void* blinkThreadInitCallbackParam;
//} mbSettings;

  mbOnBlinkThreadInitCallback = procedure(param: Pointer);

  TmbSettings = packed record
    proxy: TmbProxy;
    mask: Cardinal;
    blinkThreadInitCallback: mbOnBlinkThreadInitCallback;
    blinkThreadInitCallbackParam: Pointer;
  end;

  PmbSettings = ^TmbSettings;


//typedef struct {
//    int size;
//    unsigned int bgColor;
//} mbViewSettings;
//

  TmbViewSettings = packed record
    size: Integer;
    bgColor: Cardinal
  end;


//typedef void* mbWebFrameHandle;
//typedef void* mbNetJob;
  TmbWebFrameHandle = Pointer;

  TmbNetJob = Pointer;

//#if defined(__cplusplus)
//namespace mb { class MbWebView; };
//typedef mb::MbWebView* mbWebView;
//#else
//struct _tagMbWebView;
//typedef struct _tagMbWebView* MBWebView;
//#endif

  TmbWebview = Pointer; //  class;

//
//typedef enum {
//    mbCookieCommandClearAllCookies,
//    mbCookieCommandClearSessionCookies,
//    mbCookieCommandFlushCookiesToFile,
//    mbCookieCommandReloadCookiesFromFile,
//} mbCookieCommand;
//

  TmbCookieCommand = (mbCookieCommandClearAllCookies, mbCookieCommandClearSessionCookies, mbCookieCommandFlushCookiesToFile, mbCookieCommandReloadCookiesFromFile);


//typedef enum {
//    MB_NAVIGATION_TYPE_LINKCLICK,
//    MB_NAVIGATION_TYPE_FORMSUBMITTE,
//    MB_NAVIGATION_TYPE_BACKFORWARD,
//    MB_NAVIGATION_TYPE_RELOAD,
//    MB_NAVIGATION_TYPE_FORMRESUBMITT,
//    MB_NAVIGATION_TYPE_OTHER
//} mbNavigationType;

  TmbNavigationType = (MB_NAVIGATION_TYPE_LINKCLICK, MB_NAVIGATION_TYPE_FORMSUBMITTE, MB_NAVIGATION_TYPE_BACKFORWARD, MB_NAVIGATION_TYPE_RELOAD, MB_NAVIGATION_TYPE_FORMRESUBMITT, MB_NAVIGATION_TYPE_OTHER);

//typedef enum {
//    kMbCursorInfoPointer,
//    kMbCursorInfoCross,
//    kMbCursorInfoHand,
//    kMbCursorInfoIBeam,
//    kMbCursorInfoWait,
//    kMbCursorInfoHelp,
//    kMbCursorInfoEastResize,
//    kMbCursorInfoNorthResize,
//    kMbCursorInfoNorthEastResize,
//    kMbCursorInfoNorthWestResize,
//    kMbCursorInfoSouthResize,
//    kMbCursorInfoSouthEastResize,
//    kMbCursorInfoSouthWestResize,
//    kMbCursorInfoWestResize,
//    kMbCursorInfoNorthSouthResize,
//    kMbCursorInfoEastWestResize,
//    kMbCursorInfoNorthEastSouthWestResize,
//    kMbCursorInfoNorthWestSouthEastResize,
//    kMbCursorInfoColumnResize,
//    kMbCursorInfoRowResize,
//    kMbCursorInfoMiddlePanning,
//    kMbCursorInfoEastPanning,
//    kMbCursorInfoNorthPanning,
//    kMbCursorInfoNorthEastPanning,
//    kMbCursorInfoNorthWestPanning,
//    kMbCursorInfoSouthPanning,
//    kMbCursorInfoSouthEastPanning,
//    kMbCursorInfoSouthWestPanning,
//    kMbCursorInfoWestPanning,
//    kMbCursorInfoMove,
//    kMbCursorInfoVerticalText,
//    kMbCursorInfoCell,
//    kMbCursorInfoContextMenu,
//    kMbCursorInfoAlias,
//    kMbCursorInfoProgress,
//    kMbCursorInfoNoDrop,
//    kMbCursorInfoCopy,
//    kMbCursorInfoNone,
//    kMbCursorInfoNotAllowed,
//    kMbCursorInfoZoomIn,
//    kMbCursorInfoZoomOut,
//    kMbCursorInfoGrab,
//    kMbCursorInfoGrabbing,
//    kMbCursorInfoCustom
//} mbCursorInfoType;

  TmbCursorInfoType = (kMbCursorInfoPointer, kMbCursorInfoCross, kMbCursorInfoHand, kMbCursorInfoIBeam, kMbCursorInfoWait, kMbCursorInfoHelp, kMbCursorInfoEastResize, kMbCursorInfoNorthResize, kMbCursorInfoNorthEastResize, kMbCursorInfoNorthWestResize, kMbCursorInfoSouthResize, kMbCursorInfoSouthEastResize, kMbCursorInfoSouthWestResize, kMbCursorInfoWestResize, kMbCursorInfoNorthSouthResize, kMbCursorInfoEastWestResize, kMbCursorInfoNorthEastSouthWestResize, kMbCursorInfoNorthWestSouthEastResize,
    kMbCursorInfoColumnResize, kMbCursorInfoRowResize, kMbCursorInfoMiddlePanning, kMbCursorInfoEastPanning, kMbCursorInfoNorthPanning, kMbCursorInfoNorthEastPanning, kMbCursorInfoNorthWestPanning, kMbCursorInfoSouthPanning, kMbCursorInfoSouthEastPanning, kMbCursorInfoSouthWestPanning, kMbCursorInfoWestPanning, kMbCursorInfoMove, kMbCursorInfoVerticalText, kMbCursorInfoCell, kMbCursorInfoContextMenu, kMbCursorInfoAlias, kMbCursorInfoProgress, kMbCursorInfoNoDrop, kMbCursorInfoCopy, kMbCursorInfoNone, kMbCursorInfoNotAllowed, kMbCursorInfoZoomIn, kMbCursorInfoZoomOut, kMbCursorInfoGrab, kMbCursorInfoGrabbing, kMbCursorInfoCustom);


//typedef struct {
//    int x;
//    int y;
//    int width;
//    int height;
//
//    bool menuBarVisible;
//    bool statusBarVisible;
//    bool toolBarVisible;
//    bool locationBarVisible;
//    bool scrollbarsVisible;
//    bool resizable;
//    bool fullscreen;
//} mbWindowFeatures;

  TmbWindowFeatures = packed record
    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
    menuBarVisible: Boolean;
    stausBarVisible: Boolean;
    toolBarVisible: Boolean;
    locationBarVisible: boolean;
    resizable: boolean;
    fullscreen: boolean;
  end;

  PmbWindowFeatures = ^TmbWindowFeatures;

//typedef struct {
//    int size;
//    void* data;
//    size_t length;
//} mbMemBuf;

  TmbMemBuf = packed record
    size: Integer;
    data: Pointer;
    length: Cardinal;
  end;

  PmbMemBuf = ^TmbMemBuf;

//typedef struct {
//    struct Item {
//        enum mbStorageType {
//            // String data with an associated MIME type. Depending on the MIME type, there may be
//            // optional metadata attributes as well.
//            StorageTypeString,
//            // Stores the name of one file being dragged into the renderer.
//            StorageTypeFilename,
//            // An image being dragged out of the renderer. Contains a buffer holding the image data
//            // as well as the suggested name for saving the image to.
//            StorageTypeBinaryData,
//            // Stores the filesystem URL of one file being dragged into the renderer.
//            StorageTypeFileSystemFile,
//        } storageType;
//
//        // Only valid when storageType == StorageTypeString.
//        mbMemBuf* stringType;
//        mbMemBuf* stringData;
//
//        // Only valid when storageType == StorageTypeFilename.
//        mbMemBuf* filenameData;
//        mbMemBuf* displayNameData;
//
//        // Only valid when storageType == StorageTypeBinaryData.
//        mbMemBuf* binaryData;
//
//        // Title associated with a link when stringType == "text/uri-list".
//        // Filename when storageType == StorageTypeBinaryData.
//        mbMemBuf* title;
//
//        // Only valid when storageType == StorageTypeFileSystemFile.
//        mbMemBuf* fileSystemURL;
//        long long fileSystemFileSize;
//
//        // Only valid when stringType == "text/html".
//        mbMemBuf* baseURL;
//    };
//
//    struct Item* m_itemList;
//    int m_itemListLength;
//
//    int m_modifierKeyState; // State of Shift/Ctrl/Alt/Meta keys.
//    mbMemBuf* m_filesystemId;
//} mbWebDragData;

{ TODO : 这里还没翻译 }





//typedef mbWebDragOperation mbWebDragOperationsMask;

 // mbWebDragOperationsMask=TmbWebDragOperation ;


//typedef int64_t mbJsValue;
//typedef void* mbJsExecState;

  TmbJsValue = Int64;

  TmbJsExecState = Pointer;

//typedef enum {
//    MB_LOADING_SUCCEEDED,
//    MB_LOADING_FAILED,
//    MB_LOADING_CANCELED
//} mbLoadingResult;

  TmbLoadingResult = (MB_LOADING_SUCCEEDED, MB_LOADING_FAILED, MB_LOADING_CANCELED);

//typedef enum {
//    MB_WINDOW_TYPE_POPUP,
//    MB_WINDOW_TYPE_TRANSPARENT,
//    MB_WINDOW_TYPE_CONTROL
//} mbWindowType;

  TmbWindowType = (MB_WINDOW_TYPE_POPUP, MB_WINDOW_TYPE_TRANSPARENT, MB_WINDOW_TYPE_CONTROL);

//typedef struct {
//    RECT bounds;
//    bool draggable;
//} mbDraggableRegion;

  TmbDraggableRegion = packed record
    Bounds: TRect;
    draggable: Boolean;
  end;

  PmbDraggableRegion = ^TmbDraggableRegion;




//typedef mbDownloadOpt(MB_CALL_TYPE*mbDownloadInBlinkThreadCallback)(
//    mbWebView webView,
//    void* param,
//    size_t expectedContentLength,
//    const char* url,
//    const char* mime,
//    const char* disposition,
//    mbNetJob job,
//    mbNetJobDataBind* dataBind
//    );
//


//typedef struct _mbPdfDatas {
//    int count;
//    size_t* sizes;
//    const void** datas;
//} mbPdfDatas;

//typedef struct _mbNetJobDataBind {
//    void* ptr;
//    mbNetJobDataRecvCallback recvCallback;
//    mbNetJobDataFinishCallback finishCallback;
//} mbNetJobDataBind;

//typedef void(MB_CALL_TYPE*mbNetJobDataRecvCallback)(void* ptr, mbNetJob job, const char* data, int length);
//typedef void(MB_CALL_TYPE*mbNetJobDataFinishCallback)(void* ptr, mbNetJob job, mbLoadingResult result);

  mbNetJobDataRecvCallback = procedure(ptr: Pointer; job: TmbNetJob; const data: PChar; len: Integer); stdcall;

  mbNetJobDataFinishCallback = procedure(ptr: Pointer; job: TmbNetJob; res: TmbLoadingResult); stdcall;

  TmbNetJobDataBind = packed record
    ptr: Pointer;
    recvcallback: mbNetJobDataRecvCallback;
    finishCallback: mbNetJobDataFinishCallback;
  end;

  PmbNetJobDataBind = ^TmbNetJobDataBind;

  TmbpdfDatas = packed record
    count: Integer;
    sizes: ^DWORD;
    datas: Pointer;
  end;

  PmbpdfDatas = ^TmbpdfDatas;

  TmbDownloadOpt = (kMbDownloadOptCancel, kMbDownloadOptCacheData);

  TmbScreenshotSettings = packed record
    structSize: Integer;
    width: Integer;
    height: Integer;
  end;

  TmbPrintintStep = (kPrintintStepStart, kPrintintStepPreview, kPrintintStepPrinting);

  TmbPrintintSettings = packed record
    dpi: Integer;
    width: Integer;
    height: Integer;
    scale: Real;
  end;


//  typedef struct _mbPrintSettings {
//    int structSize;
//    int dpi;
//    int width;
//    int height;
//    int marginTop;
//    int marginBottom;
//    int marginLeft;
//    int marginRight;
//    BOOL isPrintPageHeadAndFooter;
//    BOOL isPrintBackgroud;
//} mbPrintSettings;

  TmbPrintSettings = packed record
    structSize: integer;
    dpi: integer;
    width: integer;
    height: integer;
    marginTop: integer;
    marginBottom: integer;
    marginLeft: integer;
    marginRight: integer;
    isPrintPageHeadAndFooter: boolean;
    isPrintBackgroud: boolean;
  end;

  PmbprintSettings = ^TmbprintSettings;


//
//typedef void(MB_CALL_TYPE* mbPrintPdfDataCallback)(mbWebView webview, void* param, const mbPdfDatas* datas);
//
//typedef struct _mbScreenshotSettings {
//    int structSize;
//    int width;
//    int height;
//} mbScreenshotSettings;
//
//typedef void(MB_CALL_TYPE* mbPrintBitmapCallback)(mbWebView webview, void* param, const char* data, size_t size);
//

//typedef enum _mbPrintintStep {
//    kPrintintStepStart,
//    kPrintintStepPreview,
//    kPrintintStepPrinting,
//} mbPrintintStep;
//
//typedef struct _mbPrintintSettings {
//    int dpi;
//    int width;
//    int height;
//    float scale;
//} mbPrintintSettings;
//
//typedef BOOL(MB_CALL_TYPE *mbPrintingCallback)(mbWebView webview, void* param, mbPrintintStep step, HDC hDC, const mbPrintintSettings* settings, int pageCount);



//typedef bool(*mbCookieVisitor)(
//    void* params,
//    const char* name,
//    const char* value,
//    const char* domain,
//    const char* path, // If |path| is non-empty only URLs at or below the path will get the cookie value.
//    int secure, // If |secure| is true the cookie will only be sent for HTTPS requests.
//    int httpOnly, // If |httponly| is true the cookie will only be sent for HTTP requests.
//    int* expires // The cookie expiration date is only valid if |has_expires| is true.
//    );

//typedef void(MB_CALL_TYPE *mbNetGetFaviconCallback)(mbWebView webView, void* param, const utf8* url, mbMemBuf* buf);
//typedef BOOL(MB_CALL_TYPE *mbDestroyCallback)(mbWebView webView, void* param, void* unuse);
//typedef BOOL(MB_CALL_TYPE *mbCloseCallback)(mbWebView webView, void* param, void* unuse);

  mbDestroyCallback = function(webView: TmbWebView; param: Pointer; unuse: Pointer): boolean; stdcall;

  mbCloseCallback = mbDestroyCallback;

  mbNetGetFaviconCallback = procedure(webView: TmbWebView; param: Pointer; const url: PChar; buf: TmbMemBuf); stdcall;

  mbPrintPdfDataCallback = function(webView: TmbWebView; param: Pointer; datas: PmbpdfDatas): TmbDownloadOpt; stdcall;

  mbPrintBitmapCallback = procedure(webView: TmbWebView; param: Pointer; data: PChar; size: DWORD); stdcall;

  mbPrintingCallback = function(webView: TmbWebView; param: Pointer; step: TmbPrintintStep; hdc: HDC; const settings: TmbPrintintSettings; pagecount: Integer): Boolean; stdcall;

  mbDownloadInBlinkThreadCallback = procedure(webView: TmbWebView; param: Pointer; expectedContentLength: DWORD; const url, mime, disposition: PChar; job: Tmbnetjob; databind: PmbNetJobDataBind); stdcall;

  mbRunJsCallback = procedure(webView: TmbWebView; param: Pointer; es: TmbJsExecState; v: TmbJsValue); stdcall;

  mbJsQueryCallback = procedure(webView: TmbWebView; param: Pointer; es: TmbJsExecState; queryId: Int64; customMsg: Integer; const request: PAnsiChar); stdcall;

  mbTitleChangedCallback = procedure(webView: TmbWebView; param: Pointer; const title: PAnsiChar); stdcall;

  mbURLChangedCallback = procedure(webView: TmbWebView; param: Pointer; const url: PAnsiChar; bcanback, bcanforward: boolean); stdcall;

  mbURLChangedCallback2 = procedure(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle; const url: PAnsiChar); stdcall;

  mbPaintUpdatedCallback = procedure(webView: TmbWebView; param: Pointer; const hdc: HDC; x: integer; y: integer; cx: integer; cy: integer); stdcall;

  mbPaintBitUpdatedCallback = procedure(webView: TmbWebView; param: Pointer; const buffer: Pointer; const r: PmbRect; width: integer; height: Integer); stdcall;

  mbAlertBoxCallback = procedure(webView: TmbWebView; param: Pointer; const msg: PAnsiChar); stdcall;

  mbConfirmBoxCallback = function(webView: TmbWebView; param: Pointer; const msg: PAnsiChar): boolean; stdcall;

  mbPromptBoxCallback = function(webView: TmbWebView; param: Pointer; const msg: PAnsiChar; const defaultResult: PAnsiChar; sresult: PAnsiChar): boolean; stdcall;

  mbNavigationCallback = function(webView: TmbWebView; param: Pointer; navigationType: TmbNavigationType; const url: PAnsiChar): boolean; stdcall;

  mbCreateViewCallback = function(webView: TmbWebView; param: Pointer; navigationType: TmbNavigationType; const url: PAnsiChar; const windowFeatures: PmbWindowFeatures): TmbWebView; stdcall;

  mbDocumentReadyCallback = procedure(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle); stdcall;

  mbOnShowDevtoolsCallback = procedure(webView: TmbWebView; param: Pointer); stdcall;

  mbLoadingFinishCallback = procedure(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle; const url: PAnsiChar; lresult: TmbLoadingResult; const failedReason: PAnsiChar); stdcall;

  mbDownloadCallback = function(webView: TmbWebView; param: Pointer; const url: PAnsiChar): boolean; stdcall;

  mbConsoleCallback = procedure(webView: TmbWebView; param: Pointer; level: TmbConsoleLevel; const smessage: PAnsiChar; const sourceName: PAnsiChar; sourceLine: Cardinal; const stackTrace: PAnsiChar); stdcall;

  TmbOnCallUiThread = procedure(webView: TmbWebView; paramOnInThread: Pointer); stdcall;

  mbCallUiThread = procedure(webView: TmbWebView; func: TmbOnCallUiThread; param: Pointer); stdcall;


//mbNet--------------------------------------------------------------------------------------
  mbLoadUrlBeginCallback = function(webView: TmbWebView; param: Pointer; const url: PAnsiChar; job: Pointer): boolean; stdcall;

  mbLoadUrlEndCallback = procedure(webView: TmbWebView; param: Pointer; const url: PAnsiChar; job: Pointer; buf: Pointer; len: Integer); stdcall;

  mbDidCreateScriptContextCallback = procedure(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle; context: Pointer; extensionGroup: Integer; worldId: Integer); stdcall;

  mbWillReleaseScriptContextCallback = procedure(webView: TmbWebView; param: Pointer; frameId: TmbWebFrameHandle; context: Pointer; worldId: Integer); stdcall;

  mbNetResponseCallback = function(webView: TmbWebView; param: Pointer; const url: PAnsiChar; job: Pointer): boolean; stdcall;

  mbOnNetGetFaviconCallback = procedure(webView: TmbWebView; param: Pointer; const url: PAnsiChar; buf: PmbMemBuf); stdcall;

  mbCanGoBackForwardCallback = procedure(webView: TmbWebView; param: Pointer; state: TMbAsynRequestState; b: Boolean); stdcall;

  mbGetCookieCallback = procedure(webView: TmbWebView; param: Pointer; state: TMbAsynRequestState; const cookie: PAnsiChar); stdcall;

  mbGetMHTMLCallback = procedure(webView: TmbWebView; param: Pointer; const mhtml: PAnsiChar); stdcall;

  mbWindowClosingCallback = function(webWindow: TmbWebView; param: Pointer): boolean; stdcall;

  mbWindowDestroyCallback = procedure(webWindow: TmbWebView; param: Pointer); stdcall;

  mbDraggableRegionsChangedCallback = procedure(webWindow: TmbWebView; param: Pointer; const rects: PmbDraggableRegion; rectCount: Integer); stdcall;

//  ITERATOR1(const utf8*, mbGetTitle, mbWebView webView, "") \
//ITERATOR1(const utf8*, mbGetUrl, mbWebView webView, "") \

  

  //事件定义
  TOnTitleChangeEvent = procedure(Sender: TObject; sTitle: string) of object;

  TOnUrlChangeEvent = procedure(Sender: TObject; sUrl: string) of object;

  TOnLoadEndEvent = procedure(Sender: TObject; sUrl: string; loadresult: TmbLoadingResult) of object;

  TOnBeforeLoadEvent = procedure(Sender: TObject; sUrl: string; navigationType: TmbNavigationType; var Cancel: boolean) of object;

  TOnCreateViewEvent = procedure(Sender: TObject; sUrl: string; navigationType: TmbNavigationType; windowFeatures: PmbWindowFeatures; var wvw: TmbWebView) of object;

  TOnAlertBoxEvent = procedure(Sender: TObject; sMsg: string) of object;

  TOnConfirmBoxEvent = procedure(Sender: TObject; sMsg: string; var bresult: boolean) of object;

  TOnPromptBoxEvent = procedure(Sender: TObject; smsg, defaultres, Strres: string; var bresult: boolean) of object;

  TOnDownloadEvent = procedure(Sender: TObject; sUrl: string) of object;

  TOnConsoleMessgeEvent = procedure(Sender: TObject; const sMsg, source: string; const sline: integer) of object;

  TOnLoadUrlEndEvent = procedure(Sender: TObject; sUrl: string; buf: Pointer; len: Integer) of object;

  TOnLoadUrlBeginEvent = procedure(Sender: TObject; sUrl: string; out bHook, bHandled: boolean) of object;

  TOnLoadStateChangeEvent = procedure(Sender: TObject; const bBack, bForward: Boolean) of object;



//#define MB_DEFINE_ITERATOR0(returnVal, name, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR1(returnVal, name, p1, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR2(returnVal, name, p1, p2, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR3(returnVal, name, p1, p2, p3, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2, p3); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR4(returnVal, name, p1, p2, p3, p4, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2, p3, p4); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR5(returnVal, name, p1, p2, p3, p4, p5, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2, p3, p4, p5); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR6(returnVal, name, p1, p2, p3, p4, p5, p6, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2, p3, p4, p5, p6); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR7(returnVal, name, p1, p2, p3, p4, p5, p6, p7, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2, p3, p4, p5, p6, p7); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);
//
//#define MB_DEFINE_ITERATOR11(returnVal, name, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, description) \
//    typedef returnVal(MB_CALL_TYPE* FN_##name)(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11); \
//    __declspec(selectany) FN_##name name = ((FN_##name)0);

// ---

//#define MB_DECLARE_ITERATOR0(returnVal, name, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name();
//
//#define MB_DECLARE_ITERATOR1(returnVal, name, p1, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1);
//
//#define MB_DECLARE_ITERATOR2(returnVal, name, p1, p2, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2);
//
//#define MB_DECLARE_ITERATOR3(returnVal, name, p1, p2, p3, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2, p3);
//
//#define MB_DECLARE_ITERATOR4(returnVal, name, p1, p2, p3, p4, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2, p3, p4);
//
//#define MB_DECLARE_ITERATOR5(returnVal, name, p1, p2, p3, p4, p5, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2, p3, p4, p5);
//
//#define MB_DECLARE_ITERATOR6(returnVal, name, p1, p2, p3, p4, p5, p6, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2, p3, p4, p5, p6);
//
//#define MB_DECLARE_ITERATOR7(returnVal, name, p1, p2, p3, p4, p5, p6, p7, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2, p3, p4, p5, p6, p7);
//
//#define MB_DECLARE_ITERATOR11(returnVal, name, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, description) \
//    MB_EXTERN_C __declspec(dllexport) returnVal MB_CALL_TYPE name(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11);
//
//// ---
//
//#define MB_GET_PTR_ITERATOR(name) \
//    name = (FN_##name)GetProcAddress(hMod, #name); \
//    if (!name) \
//        MessageBoxA(((HWND)0), "mb api not found", #name, 0);
//
//#define MB_GET_PTR_ITERATOR0(returnVal, name, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR1(returnVal, name, p1, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR2(returnVal, name, p1, p2, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR3(returnVal, name, p1, p2, p3, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR4(returnVal, name, p1, p2, p3, p4, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR5(returnVal, name, p1, p2, p3, p4, p5, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR6(returnVal, name, p1, p2, p3, p4, p5, p6, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR7(returnVal, name, p1, p2, p3, p4, p5, p6, p7, description) \
//    MB_GET_PTR_ITERATOR(name);
//
//#define MB_GET_PTR_ITERATOR11(returnVal, name, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, description) \
//    MB_GET_PTR_ITERATOR(name);

implementation

end.


unit Langji.Wke.IWebBrowser;

interface

uses
  windows, Langji.Wke.types, Langji.Wke.lib;

type
  IWkeWebbrowser = interface
    procedure DoWebViewTitleChange(Sender: TObject; sTitle: string);
    procedure DoWebViewUrlChange(Sender: TObject; sUrl: string);
    procedure DoWebViewLoadStart(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean);
    procedure DoWebViewLoadEnd(Sender: TObject; sUrl: string; loadresult: wkeLoadingResult);
    procedure DoWebViewCreateView(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; windowFeatures: PwkeWindowFeatures; var wvw: wkeWebView);
    procedure DoWebViewAlertBox(Sender: TObject; smsg: string);
    function DoWebViewConfirmBox(Sender: TObject; smsg: string): boolean;
    function DoWebViewPromptBox(Sender: TObject; smsg, defaultres, Strres: string): boolean;
    procedure DoWebViewConsoleMessage(Sender: TObject; smsg: wkeConsoleMessage);
    procedure DoWebViewDocumentReady(Sender: TObject);
    procedure DoWebViewWindowClosing(Sender: TObject);
    procedure DoWebViewWindowDestroy(Sender: TObject);
    procedure GoBack;
    procedure GoForward;
    procedure Refresh;
    procedure Stop;
    procedure LoadUrl(const Aurl: string);
    procedure LoadHtml(const Astr: string);
    procedure LoadFile(const AFile: string);
    procedure ExecuteJavascript(const js: string);
  end;

implementation

end.


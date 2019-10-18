unit Langji.Wke.Reg;

interface
uses classes,Langji.Wke.Webbrowser,Langji.Wke.CustomPage   ;

procedure Register;

{$R wkelogo.res}

implementation

procedure Register;
begin
  RegisterComponents('Langji.Wke', [TWkeWebBrowser,TWkeApp,TWkeTransparentPage,TWkePopupPage ]);
end;

end.

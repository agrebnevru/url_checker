unit ThreadCheck;

interface

uses
  Classes, idHTTP, IdComponent, IdTCPConnection, IdTCPClient,
  IdBaseComponent;

type
  Check = class(TThread)
  private
    { Private declarations }
    FuncResult: boolean;
    SiteUrl: string;
    procedure ListBoxEditor;
    procedure Finish;
  protected
    procedure Execute; override;
  end;

implementation

uses UnitMain;

{ Check }

procedure Check.ListBoxEditor;
begin
  if FuncResult = true then
    FormMain.LBFound.Items.Add(SiteUrl)
  else
    FormMain.LBNotFound.Items.Add(SiteUrl);
end;

procedure Check.Finish;
begin
  FormMain.PageControl.TabIndex := 1;
end;

function CheckUrl(NeedUrl: string): boolean;
var
  http: TIdHTTP;
  HTML: string;
  Count, I: integer;
  res: boolean;
begin
  result := false;
  res := false;
  try
    http := TIdHTTP.Create();
    http.AllowCookies := true;
    http.HandleRedirects := true;
    HTML := http.Get(NeedUrl);
  finally
    http.Free;
  end;

  Count := FormMain.LBNeedStr.Items.Count;

  for I := 0 to Count - 1 do
  begin
    if (Pos(FormMain.LBNeedStr.Items[I], HTML) > 0) then
      res := true;
    if res = true then
      break;
  end;

  result := res;
end;

procedure Check.Execute;
var
  Count, I: integer;
begin
  { Place thread code here }
  Count := FormMain.CLBurl.Items.Count;
  FormMain.ProgressBar.Max := Count;

  for I := 0 to Count - 1 do
  begin
    if FormMain.CLBurl.Checked[I] then
    begin
      SiteUrl := FormMain.CLBurl.Items[I];
      FormMain.EditNeedUrl.text := SiteUrl;
      FuncResult := CheckUrl(SiteUrl);
      Synchronize(ListBoxEditor);
      FormMain.ProgressBar.Position := I + 1;
    end;
  end;

  Synchronize(Finish);
end;

end.

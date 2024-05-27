unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, ComCtrls, Menus, ToolWin, ImgList,
  Shellapi, CLIPBrd,
  ThreadCheck; // подключение потоков 

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    Main1: TMenuItem;
    Exot1: TMenuItem;
    N1: TMenuItem;
    Addfromfiletxt1: TMenuItem;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    LBNeedStr: TListBox;
    EditNeedUrl: TEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    LBFound: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    LBNotFound: TListBox;
    ProgressBar: TProgressBar;
    ILMenuIcons: TImageList;
    OpenDialog: TOpenDialog;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Label3: TLabel;
    CLBurl: TCheckListBox;
    Label4: TLabel;
    ToolBar1: TToolBar;
    TBStart: TToolButton;
    ToolButton1: TToolButton;
    Panel6: TPanel;
    PopupMenu: TPopupMenu;
    Copytoclipboard1: TMenuItem;
    Openinbrowser1: TMenuItem;
    CBAll: TCheckBox;
    procedure Exot1Click(Sender: TObject);
    procedure TBStartClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure Addfromfiletxt1Click(Sender: TObject);
    procedure Openinbrowser1Click(Sender: TObject);
    procedure Copytoclipboard1Click(Sender: TObject);
    procedure CBAllClick(Sender: TObject);
  private
    { Private declarations }
    co1: Check;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.Addfromfiletxt1Click(Sender: TObject);
var
  i: integer;
begin
  if OpenDialog.Execute then
    CLBurl.Items.LoadFromFile(OpenDialog.FileName);

    for i := 0 to CLBurl.Count - 1 do
      CLBurl.Checked[i] := true;
end;

procedure TFormMain.CBAllClick(Sender: TObject);
var
  i: integer;
begin
  if CBAll.Checked then
    for i := 0 to CLBurl.Count - 1 do
      CLBurl.Checked[i] := true;
  if not CBAll.Checked then
    for i := 0 to CLBurl.Count - 1 do
      CLBurl.Checked[i] := false;
end;

procedure TFormMain.Copytoclipboard1Click(Sender: TObject);
begin
  if LBFound.ItemIndex > 0 then
    Clipboard.AsText := LBFound.Items[LBFound.ItemIndex];
end;

procedure TFormMain.Exot1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.Openinbrowser1Click(Sender: TObject);
begin
  if LBFound.ItemIndex > 0 then
    ShellExecute(Handle, 'open', PChar(LBFound.Items[LBFound.ItemIndex]), nil,
      nil, SW_SHOW);
end;

procedure TFormMain.TBStartClick(Sender: TObject);
begin
  if (FormMain.CLBurl.Items.Count > 0) AND (FormMain.LBNeedStr.Items.Count > 0)
    then
  begin
    co1 := Check.Create(true);
    co1.FreeOnTerminate := true;
    co1.Priority := TpIdle;
    co1.Resume;

    ProgressBar.Position := 0;
    LBFound.Items.Clear;
    LBNotFound.Items.Clear;
  end
  else
    ShowMessage('Add more sites or seaching url');
end;

procedure TFormMain.ToolButton1Click(Sender: TObject);
var
  i: integer;
begin
  if OpenDialog.Execute then
    CLBurl.Items.LoadFromFile(OpenDialog.FileName);

    for i := 0 to CLBurl.Count - 1 do
      CLBurl.Checked[i] := true;
end;

procedure TFormMain.ToolButton2Click(Sender: TObject);
var
  SeachUrl: string;
begin
  SeachUrl := InputBox('Add searching url', 'Input url', 'http://');
  FormMain.LBNeedStr.Items.Add(SeachUrl);
end;

procedure TFormMain.ToolButton3Click(Sender: TObject);
begin
  FormMain.LBNeedStr.Items.Clear;
end;

end.

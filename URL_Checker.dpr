program URL_Checker;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  ThreadCheck in 'ThreadCheck.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

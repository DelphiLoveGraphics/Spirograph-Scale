program CircleOrbit;

uses
  Vcl.Forms,
  UntMain in 'UntMain.pas' {FrmMain},
  UntInCircle in 'UntInCircle.pas',
  UntAllFunctions in 'UntAllFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

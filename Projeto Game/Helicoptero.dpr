program Helicoptero;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {Frm_Principal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.Run;
end.

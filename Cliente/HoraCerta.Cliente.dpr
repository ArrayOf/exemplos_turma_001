program HoraCerta.Cliente;

uses
  Vcl.Forms,
  HoraCerta.View in 'HoraCerta.View.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

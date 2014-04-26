unit HoraCerta.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TForm2 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    Timer1: TTimer;
    Label1: TLabel;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Self.Button1.Enabled := False;

  Self.IdTCPClient1.Connect;
  Self.Timer1.Enabled := True;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
  sBuffer: string;
begin
  Self.Timer1.Enabled := False;

  Self.IdTCPClient1.IOHandler.Write('PEDE_HORA'#10);

  sBuffer := Self.IdTCPClient1.IOHandler.ReadLn(#10);

  Self.Label1.Caption := sBuffer;

  Application.ProcessMessages;

  Self.Timer1.Enabled := True;
end;

end.

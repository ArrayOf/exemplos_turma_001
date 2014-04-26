unit HoraCerta.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    Memo1: TMemo;
    Button1: TButton;
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.IdTCPServer1.Active := True;
end;

procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
var
  sBuffer: string;
begin
  sBuffer := AContext.Connection.IOHandler.ReadLn(#10);

  Self.Memo1.Lines.Insert(0, sBuffer);

  if (sBuffer = 'PEDE_HORA') then
  begin
    AContext.Connection.IOHandler.Write(TimeToStr(Time()) + #10);
  end;

end;

end.

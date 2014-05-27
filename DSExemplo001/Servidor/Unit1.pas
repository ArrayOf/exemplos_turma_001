unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerServer, Datasnap.DSCommonServer,
  Datasnap.DSServer, Datasnap.DSHTTP, System.JSON, Data.DBXCommon,
  Datasnap.DSHTTPCommon;

type

  {$METHODINFO ON}
  TContabilidade = class(TComponent)
  public
    function FecharMes(const AMes: Integer): string;
  end;
  {$METHODINFO OFF}

  TForm1 = class(TForm)
    DSServer1: TDSServer;
    DSHTTPService1: TDSHTTPService;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSHTTPService1HTTPTrace(Sender: TObject; AContext: TDSHTTPContext;
      ARequest: TDSHTTPRequest; AResponse: TDSHTTPResponse);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DSHTTPService1HTTPTrace(Sender: TObject;
  AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
  AResponse: TDSHTTPResponse);
var
  _hacker: TDSHTTPResponseIndy;
begin
  _hacker := TDSHTTPResponseIndy(AResponse);
  _hacker.ResponseInfo.CustomHeaders.Values['Content-Type'] := 'application/json';
  _hacker.ResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
end;

procedure TForm1.DSServerClass1GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
   PersistentClass := TContabilidade;
end;

{ TContabilidade }

function TContabilidade.FecharMes(const AMes: Integer): string;
begin
  // ...
  Result := Format('Fechou o mes %d com sucesso!',[AMes]);
end;

end.

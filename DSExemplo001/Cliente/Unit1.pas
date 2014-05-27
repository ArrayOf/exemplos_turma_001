unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Data.DB, Datasnap.DBClient,
  REST.Response.Adapter;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Button2: TButton;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    ClientDataSet1: TClientDataSet;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.JSON;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  conteudo: TJSONValue;
begin
  Self.RESTRequest1.Execute;

  Self.Memo1.Lines.Insert(0, Self.RESTResponse1.Content);

  ShowMessage(Self.RESTResponse1.ContentType);
  conteudo := Self.RESTResponse1.JSONValue;

  Self.Memo1.Lines.Insert(0,

  TJSONString(TJSONArray(TJSONObject(conteudo).GetValue('result')).Get(0)).Value);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
oResposta : TStringStream;
conteudo : TJSONValue;
begin
  oResposta := TStringStream.Create;

  IdHTTP1.Get('http://localhost:8080/morinfo/contabilidade/TContabilidade/FecharMes/12', oResposta);

  conteudo := TJSONObject.ParseJSONValue(oResposta.DataString);

  Memo1.Text := conteudo.ToString;

end;

end.

unit Facebook.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.DBCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Datasnap.DBClient,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ClientDataSet1: TClientDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBImage1: TDBImage;
    ClientDataSet1ID: TStringField;
    ClientDataSet1NOME: TStringField;
    ClientDataSet1FOTO: TGraphicField;
    ClientDataSet1DIA: TIntegerField;
    ClientDataSet1MES: TIntegerField;
    ClientDataSet1ANO: TIntegerField;
    Button1: TButton;
    Button2: TButton;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private const
    C_MEU_ID    = '1313066483';
    C_MEU_TOKEN =
      'CAACEdEose0cBAARg0mEniOxsyJ5lcDTrzlQNZC9RWAWBhpPfudSDRkNr9kvAh8zjwsJLQZBxYbqOUU4mtuF097CH3IkuM4EbiVTaWtiMD3ygjXQPt8mqvVmyUfzFACYF7xErQ2RaNJYklvOn3DZCHZCeBKxFYz9jr1yhNWfytTaMoMaurQWUHvSjigY9ZC5EZD';
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  jpeg,
  GIFImg,
  Data.DBXJSON;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const
  C_URL = 'https://graph.facebook.com.br/%s/friends?access_token=%s';
var
  sURL     : string;
  oResposta: TStringStream;

  oTodosDados   : TJSONValue; // Todo o conteúdo
  oTodosDadosObj: TJSONObject;

  oArrayAmigos: TJSONArray; // Listagem dos amigos
  oAmigo      : TJSONValue; // Um amigo em específico
  oAmigonObj  : TJSONObject;

begin
  // Screen.Cursor := crHourGlass;
  oResposta   := TStringStream.Create;
  oTodosDados := nil;
  try
    sURL := Format(C_URL, [Self.C_MEU_ID, Self.C_MEU_TOKEN]);
    Self.IdHTTP1.Get(sURL, oResposta);

    oTodosDados := TJSONObject.ParseJSONValue(oResposta.DataString);

    if oTodosDados is TJSONObject then
    begin
      oTodosDadosObj := TJSONObject(oTodosDados);
    end;

    if oTodosDadosObj.Get('data').JsonValue is TJSONArray then
    begin
      oArrayAmigos := TJSONArray(oTodosDadosObj.Get('data').JsonValue);
    end;

    Self.ClientDataSet1.EmptyDataSet;
    for oAmigo in oArrayAmigos do
    begin
      oAmigonObj := TJSONObject(oAmigo);

      Self.ClientDataSet1.Append;
      Self.ClientDataSet1NOME.AsString := TJSONString(oAmigonObj.Get('name').JsonValue).Value;
      Self.ClientDataSet1ID.AsString   := TJSONString(oAmigonObj.Get('id').JsonValue).Value;
      Self.ClientDataSet1.Post;
    end;

  finally
    oResposta.Free;
    if Assigned(oTodosDados) then
    begin
      oTodosDados.Free;
    end;
    ShowMessage('Finalizado!');
    // Self.Cursor := crDefault;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
const
  C_URL = 'https://graph.facebook.com.br/%s/friends?fields=birthday&access_token=%s';
var
  aBook    : TArray<Byte>;
  sURL     : string;
  oResposta: TStringStream;

  oTudo   : TJSONValue;
  oTudoObj: TJSONObject;

  oData    : TJSONArray;
  oAmigo   : TJSONValue;
  oAmigoObj: TJSONObject;
  bRet     : Boolean;
  sIDAmigo : string;

  oDataNascimento: TJSONPair;
  sDataNascimento: string;

  iDia, iMes, iAno: Integer;
begin
  Self.ClientDataSet1.DisableControls;
  oResposta := TStringStream.Create;
  try
    sURL := Format(C_URL, [Self.C_MEU_ID, Self.C_MEU_TOKEN]);
    Self.IdHTTP1.Get(sURL, oResposta);

    oTudo    := TJSONObject.ParseJSONValue(oResposta.DataString);
    oTudoObj := TJSONObject(oTudo);
    oData    := TJSONArray(oTudoObj.Get('data').JsonValue);

    aBook := Self.ClientDataSet1.GetBookmark;

    for oAmigo in oData do
    begin
      oAmigoObj := TJSONObject(oAmigo);
      sIDAmigo  := TJSONString(oAmigoObj.Get('id').JsonValue).Value;
      bRet      := Self.ClientDataSet1.Locate('ID', sIDAmigo, []);
      if bRet then
      begin
        oDataNascimento := oAmigoObj.Get('birthday');
        if Assigned(oDataNascimento) then
        begin
          sDataNascimento := TJSONString(oDataNascimento.JsonValue).Value;

          iDia := StrToIntDef(Copy(sDataNascimento, 4, 2), 0);
          iMes := StrToIntDef(Copy(sDataNascimento, 1, 2), 0);
          iAno := StrToIntDef(Copy(sDataNascimento, 7, 4), 0);

          Self.ClientDataSet1.Edit;
          Self.ClientDataSet1DIA.Value := iDia;
          Self.ClientDataSet1MES.Value := iMes;
          Self.ClientDataSet1ANO.Value := iAno;
          Self.ClientDataSet1.Post;
        end;
      end;
    end;

  finally
    Self.ClientDataSet1.GotoBookmark(aBook);
    oResposta.Free;
    Self.ClientDataSet1.EnableControls;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
const
  C_URL = 'https://graph.facebook.com.br/%s/picture?type=large';
var
  oJPG: TJPEGImage;
  oGIF: TGIFImage;
  oBMP: TBitmap;

  oResponse       : TStringStream;
  sURL            : string;
  sNovaLocalizacao: string;
begin
  oResponse := TStringStream.Create;
  oJPG := TJPEGImage.Create;
  oGIF := TGIFImage.Create;
  oBMP := TBitmap.Create;

  try
    sURL := Format(C_URL, [Self.ClientDataSet1ID.Value]);

    try
      Self.IdHTTP1.Get(sURL, oResponse);
    except
      on E: Exception do
      begin
        sNovaLocalizacao := Self.IdHTTP1.Response.Location;
      end;
    end;

    Self.IdHTTP1.Get(sNovaLocalizacao, oResponse);
    oResponse.Seek(0, 0);

    if Self.IdHTTP1.Response.ContentType = 'image/jpeg' then
    begin
      oJPG.LoadFromStream(oResponse);
      oBMP.Assign(oJPG);
    end;

    if Self.IdHTTP1.Response.ContentType = 'image/gif' then
    begin
      oGIF.LoadFromStream(oResponse);
      oBMP.Assign(oGIF);
    end;

    oResponse.Clear;
    oBMP.SaveToStream(oResponse);

    Self.ClientDataSet1.Edit;
    Self.ClientDataSet1FOTO.LoadFromStream(oResponse);
    Self.ClientDataSet1.Post;

  finally
    oResponse.Free;
    oJPG.Free;
    oGIF.Free;
    oBMP.Free;
  end;
end;

end.

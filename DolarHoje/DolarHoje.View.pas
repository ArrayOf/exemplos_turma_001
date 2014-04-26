unit DolarHoje.View;

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
  IdHTTP,
  Vcl.StdCtrls,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    IdTCPClient1: TIdTCPClient;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.RegularExpressions;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const
  C_TAMANHO = 'Content-Length: (?<TAM>\d+)$';
  C_DOLAR   = 'O (dolar|euro) (es)?tá (?<VALOR>[^!]+)!';
var
  sBuffer  : string;
  _tamanho : TMatch;
  _dolar   : TMatch;
  iTamanho : Integer;
  aConteudo: TArray<Byte>;
begin
  Screen.Cursor := crHourGlass;

  try
    Self.IdTCPClient1.Host := 'dolarhoje.com';
    Self.IdTCPClient1.Port := 80;
    Self.IdTCPClient1.Connect;

    Self.IdTCPClient1.IOHandler.WriteLn('GET / HTTP/1.1');
    Self.IdTCPClient1.IOHandler.WriteLn('Host: dolarhoje.com');
    Self.IdTCPClient1.IOHandler.WriteLn('User-agent: Aula da arrayOF');
    Self.IdTCPClient1.IOHandler.WriteLn('');

    sBuffer := Self.IdTCPClient1.IOHandler.ReadLn(#13#10#13#10);

    Self.Memo1.Text := sBuffer;

    _tamanho := TRegEx.Match(sBuffer, C_TAMANHO, [roMultiLine]);
    if _tamanho.Success then
    begin
      iTamanho := StrToIntDef(_tamanho.Groups['TAM'].Value, 0);
    end;

    Self.Memo1.Text := IntToStr(iTamanho);

    Self.IdTCPClient1.IOHandler.ReadBytes(aConteudo, iTamanho, False);

    sBuffer := TEncoding.UTF8.GetString(aConteudo);

    Self.Memo1.Text := sBuffer;

    _dolar := TRegEx.Match(sBuffer, C_DOLAR, []);
    if _dolar.Success then
    begin
      Self.Label1.Caption := _dolar.Groups['VALOR'].Value;
    end;

  finally
    Screen.Cursor := crDefault;
  end;

end;

end.

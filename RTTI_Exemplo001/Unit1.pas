unit Unit1;

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
  Vcl.StdCtrls;

type

  TNumeroLinha = class(TCustomAttribute)
  private
    FLinha: Integer;
  public
    constructor Create(const ALinha: Integer);
  published
    property Linha: Integer read FLinha;
  end;

  TTexto = class(TCustomAttribute)
  private
    FTamanho     : Integer;
    FTamanhoExato: Boolean;
  public
    constructor Create(const ATamanho: Integer; const ATamanhoExato: Boolean);
  published
    property Tamanho     : Integer read FTamanho;
    property TamanhoExato: Boolean read FTamanhoExato;
  end;

  /// <summary>
  /// Classe do framework
  /// </summary>
  TClasseNinja = class(TObject)
  public
    /// <summary>
    /// Gera uma linha
    /// </summary>
    /// <returns>
    /// Linha formatada de acordo com as RNs
    /// </returns>
    function GerarLinha: string;

    /// <summary>
    /// Gera uma linha a partir de um record
    /// </summary>
    /// <param name="ADados">
    /// Variavel do tipo generico
    /// </param>
    function GerarLinhaByRecord<T: record >(ADados: T): string;
  end;

  // DDD
  // Testes Unitários

  /// <summary>
  /// Informações do contador
  /// </summary>
  [TNumeroLinha(1)]
  TDadosContador = class(TClasseNinja)
  strict private
    FNomeContador: string;
    FCRC         : string;
    procedure SetNomeContador(const AValue: string);
  published
    /// <summary>
    /// Nome do contador
    /// </summary>
    [TTexto(50, False)]
    property NomeContador: string read FNomeContador write SetNomeContador;

    /// <summary>
    /// Código do contador
    /// </summary>
    [TTexto(10, True)]
    property CRC: string read FCRC write FCRC;
  end;

  [TNumeroLinha(999)]
  TFechaArquivo = class(TClasseNinja)
  strict private
    FResponsavel: string;
  published
    [TTexto(50, False)]
    property Responsavel: string read FResponsavel write FResponsavel;
  end;

  // ..

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Rtti,
  System.TypInfo;

{$R *.dfm}
{ TDadosContador }

procedure TDadosContador.SetNomeContador(const AValue: string);
begin
  if 1 = 2 then
  begin
    raise Exception.Create('Nome de contador inválido!');
  end;

  Self.FNomeContador := AValue;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oContador   : TDadosContador;
  oResponsavel: TFechaArquivo;
begin

  oContador := TDadosContador.Create;
  oResponsavel := TFechaArquivo.Create;
  try
    oContador.NomeContador := 'JOSÉ MARIO SILVA GUEDES';
    oContador.CRC := '1234567890';

    oResponsavel.Responsavel := StringOfChar('X', 100);

    Self.Memo1.Lines.Add(oContador.GerarLinha);
    Self.Memo1.Lines.Add(oResponsavel.GerarLinha);
  finally
    oContador.Free;
    oResponsavel.Free;
  end;
end;

{ TClasseNinja }

function TClasseNinja.GerarLinha: string;
const
  C_SEPARADOR = '|';
var
  _ctx   : TRttiContext;
  _typ   : TRttiType;
  _pro   : TRttiProperty;
  _atr   : TCustomAttribute;
  sBuffer: string;
  oTexto : TTexto;
begin
  _ctx := TRttiContext.Create;
  try
    _typ := _ctx.GetType(Self.ClassType);

    for _atr in _typ.GetAttributes do
    begin
      if (_atr is TNumeroLinha) then
      begin
        Result := Result + FormatFloat('000', TNumeroLinha(_atr).Linha) + C_SEPARADOR;
      end;
    end;

    for _pro in _typ.GetProperties do
    begin
      if not(_pro.Visibility = mvPublished) then
      begin
        Continue;
      end;

      for _atr in _pro.GetAttributes do
      begin
        case _pro.PropertyType.TypeKind of
          tkString, tkLString, tkWString, tkUString:
            begin
              if _atr is TTexto then
              begin
                oTexto := TTexto(_atr);
                sBuffer := Copy(_pro.GetValue(Self).AsString, 1, oTexto.Tamanho);

                if oTexto.TamanhoExato then
                begin
                  if Length(sBuffer) <> oTexto.Tamanho then
                  begin
                    raise Exception.CreateFmt('Tamanho errado! Verifique. [%d]', [oTexto.Tamanho]);
                  end;
                end;

                Result := Result + sBuffer + C_SEPARADOR;
              end;
            end;
        else
          raise Exception.Create('Tipo não previsto pelo nosso framework');
        end;
      end;
    end;
  finally
    _ctx.Free;
  end;
end;

function TClasseNinja.GerarLinhaByRecord<T>(ADados: T): string;
var
  _ctx: TRttiContext;
  _typ: TRttiType;
  _fie: TRttiField;
  _atr: TCustomAttribute;
begin
  _ctx := TRttiContext.Create;
  try
    _typ := _ctx.GetType(TypeInfo(T));

    for _fie in _typ.GetFields do
    begin
      Result := Result + _fie.Name + ': ' + _fie.GetValue(@ADados).AsString + #13#10;

      //Aqui vai todo o código "ninja"
    end;
  finally
    _ctx.Free;
  end;
end;

{ TTexto }

constructor TTexto.Create(const ATamanho: Integer; const ATamanhoExato: Boolean);
begin
  inherited Create;
  Self.FTamanho := ATamanho;
  Self.FTamanhoExato := ATamanhoExato;
end;

{ TNumeroLinha }

constructor TNumeroLinha.Create(const ALinha: Integer);
begin
  Self.FLinha := ALinha;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  _ctx: TRttiContext;
  _typ: TRttiType;
  _met: TRttiMethod;
  _par: TRttiParameter;
begin
  _ctx := TRttiContext.Create;
  try
    _typ := _ctx.GetType(TMemo);

    _met := _typ.GetMethod('Clear');

    if Assigned(_met) then
    begin
      // Varredura dos Parametros
      // for _par in _met.GetParameters do
      // begin
      //
      // end;

      _met.Invoke(Self.Memo1, []);
    end;

  finally
    _ctx.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
type

  [TNumeroLinha(1)]
  TLinha001 = record [TTexto(50, False)]
    NomeContador: string;
    [TTexto(10, True)]
    CRC: string;
  end;

  [TNumeroLinha(999)]
  TLinha999 = record [TTexto(50, False)][TTexto(50, False)]
    Responsavel: string;
  end;

var
  oNinja      : TClasseNinja;
  _contador   : TLinha001;
  _responsavel: TLinha999;
begin
  oNinja := TClasseNinja.Create;
  try
    _contador.NomeContador := 'ALEX';
    _contador.CRC := '1111111111';

    Self.Memo1.Lines.Add(oNinja.GerarLinhaByRecord<TLinha001>(_contador));

    _responsavel.Responsavel := 'MARIO GUEDES';
    Self.Memo1.Lines.Add(oNinja.GerarLinhaByRecord<TLinha999>(_responsavel));
  finally
    oNinja.Free;
  end;
end;

end.

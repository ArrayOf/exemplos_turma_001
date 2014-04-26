unit Unt_Principal;

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

  // REGRAS DE NEGÓCIOS ===========================
  TMinhaRegraNegocio = class(TObject)
  public
    function VarrerArquivo(AArquivo: string): Integer;
  end;

  EArquivoMailing = class(Exception);
  // ==============================================

  TVarreThread = class(TThread)
  private
    FQuantidadeLinha: Integer;
    FTempo          : Integer;
    FNomeArquivo    : string;
  public
    constructor Create(const ANomeArquivo: string); reintroduce;
    procedure Execute; override;
    property QuantidadeLinha: Integer read FQuantidadeLinha;
    property Tempo: Integer read FTempo;
  end;

  TGerente = class(TThread)
  private
    FQuantidadeLinha: Integer;
    FTempo          : Integer;
  public
    procedure Execute; override;
    property QuantidadeLinha: Integer read FQuantidadeLinha;
    property Tempo: Integer read FTempo;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure QuandoTerminar(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Diagnostics;

{$R *.dfm}
{ TMinhaRegraNegocio }

function TMinhaRegraNegocio.VarrerArquivo(AArquivo: string): Integer;
var
  _arq    : TextFile;
  slCampos: TStringList;
  sLinha  : string;
  i       : Integer;
begin
  slCampos := TStringList.Create;

  if not FileExists(AArquivo) then
  begin
    raise EArquivoMailing.Create('O arquivo não existe');
  end;

  Result := 0;
  AssignFile(_arq, AArquivo);
  Reset(_arq);
  while not Eof(_arq) do
  begin
    Readln(_arq, sLinha);
    slCampos.CommaText := sLinha;
    for i := 0 to Pred(slCampos.Count) do
    begin
      slCampos[i] := 'xxxxxxxxx';
    end;
    Inc(Result);
  end;
  CloseFile(_arq);
  slCampos.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oThread: TVarreThread;
begin
  Self.Button1.Enabled := False;

  oThread := TVarreThread.Create('.\arquivo.csv');
  oThread.OnTerminate := Self.QuandoTerminar;
  oThread.Start;
end;

{ TVarreThread }

constructor TVarreThread.Create(const ANomeArquivo: string);
begin
  inherited Create(True);
  Self.FNomeArquivo := ANomeArquivo;
end;

procedure TVarreThread.Execute;
var
  oRN   : TMinhaRegraNegocio;
  _crono: TStopwatch;
begin
  inherited;
  _crono := TStopwatch.StartNew;

  oRN := TMinhaRegraNegocio.Create;
  try
    Self.FQuantidadeLinha := oRN.VarrerArquivo(Self.FNomeArquivo);
  finally
    _crono.Stop;

    Self.FTempo := _crono.ElapsedMilliseconds div 1000;

    oRN.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oGerente: TGerente;
begin
  Self.Button2.Enabled := False;
  oGerente := TGerente.Create(True);
  oGerente.OnTerminate := Self.QuandoTerminar;
  oGerente.Start;
end;

procedure TForm1.QuandoTerminar(Sender: TObject);
begin
  if Sender is TVarreThread then
  begin
    Self.Label1.Caption := IntToStr(TVarreThread(Sender).QuantidadeLinha);
    Self.Edit1.Text := IntToStr(TVarreThread(Sender).Tempo);
    Self.Button1.Enabled := True;
  end
  else if Sender is TGerente then
  begin
    Self.Label1.Caption := IntToStr(TGerente(Sender).QuantidadeLinha);
    Self.Edit1.Text := IntToStr(TGerente(Sender).Tempo);
    Self.Button2.Enabled := True;
  end;
end;

{ TGerente }

procedure TGerente.Execute;
var
  iQuantidadeNucleo: Integer;
  aThreads         : array of TVarreThread;
  aManipuladores   : array[0..4] of THandle;
  ANomeArquivo     : array of string;
  i                : Integer;
  _arq             : TextFile;
  _destino         : TextFile;
  iLinha           : Integer;
  sLinha           : string;
  _crono           : TStopwatch;
begin
  inherited;
  _crono := TStopwatch.StartNew;

  iQuantidadeNucleo := TThread.ProcessorCount;
  SetLength(aThreads, iQuantidadeNucleo);
  SetLength(ANomeArquivo, iQuantidadeNucleo);
  //SetLength(aManipuladores, iQuantidadeNucleo);

  //AssignFile(_arq, '.\arquivo.csv');
  //Reset(_arq);

  for i := 0 to Pred(iQuantidadeNucleo) do
  begin
    aNomeArquivo[i] := Format('.\arquivo_%d.csv', [i]);
    //AssignFile(_destino, aNomeArquivo[i]);
    //Rewrite(_destino);
//    for iLinha := 1 to 3750000 do
//    begin
//      Readln(_arq, sLinha);
//      Writeln(_destino, sLinha);
//    end;
//    CloseFile(_destino);
  end;
//  CloseFile(_arq);

  for i := Low(aThreads) to High(aThreads) do
  begin
    aThreads[i] := TVarreThread.Create(ANomeArquivo[i]);
    aThreads[i].Start;

    aManipuladores[i] := aThreads[i].Handle;
  end;

  WaitForMultipleObjects(iQuantidadeNucleo, @aManipuladores, True, INFINITE);

  for i := 0 to Pred(iQuantidadeNucleo) do
  begin
    Self.FQuantidadeLinha := Self.FQuantidadeLinha + aThreads[i].QuantidadeLinha;
  end;

  _crono.Stop;
  Self.FTempo := _crono.ElapsedMilliseconds div 1000;
end;

end.

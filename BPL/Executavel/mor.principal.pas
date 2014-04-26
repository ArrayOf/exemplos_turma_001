unit mor.principal;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FlowPanel1: TFlowPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
type
  TProcedimento = procedure;

var
  _controle   : NativeInt;
  procedimento: TProcedimento;
begin
  _controle := LoadPackage('.\mor.cnab.bpl');

  procedimento := GetProcAddress(_controle, 'ExecutarTarefa');
  if Assigned(procedimento) then
  begin
    procedimento;
  end;

  UnloadPackage(_controle);
end;

procedure TForm1.FormCreate(Sender: TObject);
type
  TFormularios = function: TArray<TButton>;

var
  _controle   : NativeInt;
  procedimento: TFormularios;
  botoes      : TArray<TButton>;
  botao       : TButton;
begin
  _controle := LoadPackage('.\mor.cnab.bpl');

  procedimento := GetProcAddress(_controle, 'CarregarFormularios');

  if Assigned(procedimento) then
  begin
    botoes := procedimento;

    for botao in botoes do
    begin
      botao.Parent := Self.FlowPanel1;
    end;
  end;

  // UnloadPackage(_controle);
end;

end.

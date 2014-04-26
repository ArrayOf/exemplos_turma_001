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
  Data.DB,
  Datasnap.DBClient,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls;

type

  TPosicionaUF = class(TThread)
  public
    procedure Execute; override;
  end;

  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1UF: TStringField;
    ClientDataSet1NOME: TStringField;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FThread1: TPosicionaUF;
    FThread2: TPosicionaUF;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.FThread1 := TPosicionaUF.Create(True);
  Self.FThread1.Start;

  Self.Button1.Enabled := False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Self.FThread2 := TPosicionaUF.Create(True);
  Self.FThread2.Start;

  Self.Button2.Enabled := False;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  oThread: TThread;
begin
  Application.ProcessMessages;


  oThread := TThread.CreateAnonymousThread(
    procedure
    var
      sUF: string;
    begin
      sUF := InputBox('Digite', 'Busca UF', 'RJ');

      System.TMonitor.Enter(Self.ClientDataSet1);
      try
        if Self.ClientDataSet1.FindKey([sUF]) then
        begin
          ShowMessage(Self.ClientDataSet1.FieldByName('NOME').AsString);
        end;
      finally
        System.TMonitor.Exit(Self.ClientDataSet1);
      end;
    end);

  oThread.Start;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Self.FThread1) then
  begin
    if not Self.FThread1.Finished then
    begin
      Self.FThread1.Terminate;
      Self.FThread1.WaitFor;
      Self.FThread1.Free;
      Self.FThread1 := nil;
    end;
  end;

  if Assigned(Self.FThread2) then
  begin
    if not Self.FThread2.Finished then
    begin
      Self.FThread2.Terminate;
      Self.FThread2.WaitFor;
      Self.FThread2.Free;
      Self.FThread2 := nil;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.ClientDataSet1.Open;
  with Self.ClientDataSet1 do
  begin
    AppendRecord(['SP', 'SÃO PAULO']);
    AppendRecord(['BA', 'BAHIA']);
    AppendRecord(['MG', 'MINAS GERAIS']);
    AppendRecord(['RJ', 'RIO DE JANEIRO']);
    AppendRecord(['ES', 'ESPIRITO SANTO']);
    AppendRecord(['PA', 'PARA']);
    AppendRecord(['PR', 'PARANA']);
    AppendRecord(['AM', 'AMAZONAS']);
    AppendRecord(['AC', 'ACRE']);
  end;

  Self.ClientDataSet1.DisableControls;
end;

{ TPosicionaUF }

procedure TPosicionaUF.Execute;
const
  C_UF: array [0 .. 2] of string = ('SP', 'RJ', 'AC');
var
  iPos: Integer;
begin
  inherited;
  while not Self.Terminated do
  begin
    Sleep(1);

    iPos := Random(3);

    System.TMonitor.Enter(Form1.ClientDataSet1);
    try
      Form1.ClientDataSet1.First;
      if Form1.ClientDataSet1.FindKey([C_UF[iPos]]) then
      begin
        Sleep(100);

        if (Form1.ClientDataSet1.FieldByName('UF').AsString <> C_UF[iPos]) then
        begin
          ShowMessage('Deu erro!!!');
        end;
      end;
    finally
      System.TMonitor.Exit(Form1.ClientDataSet1);
    end;

  end;
end;

end.

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
  System.Generics.Collections,
  Vcl.StdCtrls,
  Vcl.Samples.Spin,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  System.SyncObjs;

type

  // TMinhaRN = class(TObject)
  //
  // end;

  TMinhaThread = class(TThread)
  private
    FEvento      : TEvent;
    FPilhaEntrada: TObjectQueue<TObject>;
  protected
     procedure TerminatedSet; override;
  public
    procedure AlimentarProgresso;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure Execute; override; // Rotina que será executada de forma paralela
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    FLixeira: TMinhaThread;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ TMinhaThread }

procedure TMinhaThread.AfterConstruction;
begin
  inherited;
  Self.FEvento := TEvent.Create(nil, False, True, '_nome_unico');
  Self.FPilhaEntrada := TObjectQueue<TObject>.Create(False);
end;

procedure TMinhaThread.AlimentarProgresso;
begin
  Form1.ProgressBar1.Position := Form1.ProgressBar1.Position - 1;
end;

procedure TMinhaThread.BeforeDestruction;
begin
  inherited;
  Self.FPilhaEntrada.Free;
  Self.FEvento.Free;
end;

procedure TMinhaThread.Execute;
var
  oObjeto: TObject;
  eWait  : TWaitResult;
begin
  inherited;
  while not(Self.Terminated) do
  begin
    // Sleep(1);

    eWait := Self.FEvento.WaitFor(INFINITE);

    case eWait of
      wrSignaled:
        begin
          while (Self.FPilhaEntrada.Count > 0) do
          begin
            if (Self.Terminated) then
            begin
              Abort;
            end;

            Sleep(100);
            oObjeto := Self.FPilhaEntrada.Extract;
            oObjeto.Free;

            // Self.Synchronize(Self.AlimentarProgresso);
            Self.Queue(Self.AlimentarProgresso);
          end;
        end;
      wrTimeout:
        begin
          Sleep(1)
        end;
    else
      Sleep(1);
    end;
  end;
end;

procedure TMinhaThread.TerminatedSet;
begin
  inherited;
  Self.FEvento.SetEvent;
end;

procedure TForm1.AfterConstruction;
begin
  inherited;
  Self.FLixeira := TMinhaThread.Create(True);
  // Self.FLixeira.FreeOnTerminate := True;
  Self.FLixeira.Start;

  Self.Label1.Caption := IntToStr(Self.FLixeira.ThreadID);

  Self.Timer1.Enabled := True;
end;

procedure TForm1.BeforeDestruction;
begin
  inherited;
  Self.FLixeira.Terminate;
  Self.FLixeira.WaitFor;
  Self.FLixeira.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  slListagem: TStringList;
  i         : Integer;
begin

  for i := 1 to Self.SpinEdit1.Value do
  begin
    slListagem := TStringList.Create;
    slListagem.Add('Olá Mundo!');
    slListagem.Add('Olá Mundo!');

    Self.FLixeira.FPilhaEntrada.Enqueue(slListagem);
  end;

  Self.ProgressBar1.Max := Self.ProgressBar1.Max + Self.SpinEdit1.Value;
  Self.ProgressBar1.Position := Self.ProgressBar1.Max;

  Self.FLixeira.FEvento.SetEvent;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.ProgressBar1.Max := 0;
  Self.ProgressBar1.Position := 0;
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Self.Label2.Caption := IntToStr(Self.FLixeira.FPilhaEntrada.Count);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Self.Timer2.Enabled := False;
  Sleep(5000); // <== processamento longo
  Self.Timer2.Enabled := True;
end;

end.

unit mor.cnab.export;

interface

uses
  Vcl.StdCtrls;

procedure ExecutarTarefa;
function CarregarFormularios: TArray<TButton>;

exports ExecutarTarefa;
exports CarregarFormularios;

implementation

uses
  mor.cnab.classeninja,
  Vcl.Dialogs,
  mor.cnab.bradesco,
  mor.cnab.itau;

procedure ExecutarTarefa;
var
  oOlaMundo: TOlaMundo;
  antes    : TRegraEspecifica;
  depois   : TRegraEspecifica;
begin
  oOlaMundo := TOlaMundo.Create;
  try

    // Procurar BPL de extensão e lá dentro os métodos anonimos se exisitir;

    depois := procedure
      begin
        ShowMessage('DEPOIS');
      end;;

    ShowMessage(oOlaMundo.OlaMundo(
      procedure
      begin
        ShowMessage('ANTES')
      end, depois));
  finally
    oOlaMundo.Free;
  end;
end;

function CarregarFormularios: TArray<TButton>;
begin
  SetLength(Result, 2);
  Result[0] := TButton.Create(nil);
  Result[0].Caption := 'BRADESCO';
  Result[0].OnClick := TForm2.ChamarForm;

  Result[1] := TButton.Create(nil);
  Result[1].Caption := 'ITAÚ';
  Result[1].OnClick := TForm3.ChamarForm;

end;

end.

unit mor.cnab.classeninja;

interface

type

  TRegraEspecifica = reference to procedure;

  TOlaMundo = class
  public
    function OlaMundo(AAntes: TRegraEspecifica = nil; ADepois: TRegraEspecifica = nil): string;
  end;

implementation

{ TOlaMundo }

function TOlaMundo.OlaMundo(AAntes: TRegraEspecifica = nil; ADepois: TRegraEspecifica = nil): string;
begin
  if Assigned(AAntes) then
  begin
    AAntes;
  end;

  Result := 'Olá Mundo!';

  if Assigned(ADepois) then
  begin
    ADepois;
  end;
end;

end.

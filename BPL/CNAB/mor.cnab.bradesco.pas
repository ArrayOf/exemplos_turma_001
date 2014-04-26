unit mor.cnab.bradesco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
  private
    { Private declarations }
  public
    class procedure ChamarForm(Sender: TObject);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

{ TForm2 }

class procedure TForm2.ChamarForm(Sender: TObject);
begin
  Form2 := TForm2.Create(nil);
  Form2.ShowModal;
end;

end.

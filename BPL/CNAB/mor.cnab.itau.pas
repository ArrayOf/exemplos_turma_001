unit mor.cnab.itau;

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
  TForm3 = class(TForm)
    Label1: TLabel;
  private
    { Private declarations }
  public
    class procedure ChamarForm(Sender: TObject);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
{ TForm3 }

class procedure TForm3.ChamarForm(Sender: TObject);
begin
  Form3 := TForm3.Create(nil);
  Form3.ShowModal;
end;

end.

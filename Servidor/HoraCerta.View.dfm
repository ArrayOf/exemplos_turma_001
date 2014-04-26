object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Servidor'
  ClientHeight = 226
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 80
    Width = 249
    Height = 137
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 8080
    OnExecute = IdTCPServer1Execute
    Left = 64
    Top = 32
  end
end

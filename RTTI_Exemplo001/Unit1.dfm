object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 254
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'RTTI - Classes'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 96
    Width = 593
    Height = 153
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    WordWrap = False
  end
  object Button2: TButton
    Left = 176
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Invoke'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'RTTI - Record'
    TabOrder = 3
    OnClick = Button3Click
  end
end

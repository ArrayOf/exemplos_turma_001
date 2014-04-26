object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Conflito de Threads'
  ClientHeight = 367
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 57
    Width = 448
    Height = 291
    Align = alClient
    DataSource = DataSource1
    DrawingStyle = gdsClassic
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 448
    Height = 57
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 352
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 184
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 348
    Width = 448
    Height = 19
    Panels = <>
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'UF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NOME'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'ClientDataSet1Index1'
        Fields = 'UF'
      end>
    IndexName = 'ClientDataSet1Index1'
    Params = <>
    StoreDefs = True
    Left = 248
    Top = 136
    Data = {
      4A0000009619E0BD0100000018000000020000000000030000004A0002554601
      00490000000100055749445448020002000200044E4F4D450100490000000100
      0557494454480200020014000000}
    object ClientDataSet1UF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object ClientDataSet1NOME: TStringField
      FieldName = 'NOME'
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = ClientDataSet1
    Left = 120
    Top = 192
  end
end

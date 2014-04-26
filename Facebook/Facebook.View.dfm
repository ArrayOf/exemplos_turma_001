object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Meus amigos do Face :D'
  ClientHeight = 422
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 726
    Height = 131
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = -6
    object DBImage1: TDBImage
      Left = 8
      Top = 16
      Width = 105
      Height = 105
      DataField = 'FOTO'
      DataSource = DataSource1
      TabOrder = 0
    end
    object Button1: TButton
      Left = 119
      Top = 16
      Width = 242
      Height = 25
      Caption = 'Amigos'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 119
      Top = 47
      Width = 242
      Height = 25
      Caption = 'Anivers'#225'rios'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 119
      Top = 78
      Width = 242
      Height = 25
      Caption = 'Foto'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 403
    Width = 726
    Height = 19
    Panels = <>
    ExplicitLeft = 352
    ExplicitTop = 224
    ExplicitWidth = 0
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 131
    Width = 726
    Height = 272
    Align = alClient
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    FileName = '.\dados.cds'
    Params = <>
    Left = 64
    Top = 168
    Data = {
      920000009619E0BD010000001800000006000000000003000000920002494401
      00490000000100055749445448020002006400044E4F4D450100490000000100
      05574944544802000200640004464F544F04004B000000010007535542545950
      45020049000900477261706869637300034449410400010000000000034D4553
      040001000000000003414E4F04000100000000000000}
    object ClientDataSet1ID: TStringField
      DisplayWidth = 30
      FieldName = 'ID'
      Size = 100
    end
    object ClientDataSet1NOME: TStringField
      DisplayWidth = 50
      FieldName = 'NOME'
      Size = 100
    end
    object ClientDataSet1FOTO: TGraphicField
      FieldName = 'FOTO'
      Visible = False
      BlobType = ftGraphic
    end
    object ClientDataSet1DIA: TIntegerField
      FieldName = 'DIA'
    end
    object ClientDataSet1MES: TIntegerField
      FieldName = 'MES'
    end
    object ClientDataSet1ANO: TIntegerField
      FieldName = 'ANO'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 152
    Top = 168
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 224
    Top = 168
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'graph.facebook.com.br:80'
    Host = 'graph.facebook.com.br'
    MaxLineAction = maException
    Port = 80
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 224
    Top = 240
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SERVIDOR'
  ClientHeight = 226
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DSServer1: TDSServer
    Left = 104
    Top = 24
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8080
    DSContext = 'morinfo/'
    RESTContext = 'contabilidade/'
    OnHTTPTrace = DSHTTPService1HTTPTrace
    Server = DSServer1
    Filters = <>
    SessionTimeout = 60000
    Left = 104
    Top = 120
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 224
    Top = 80
  end
end

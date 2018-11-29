object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 619
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 655
    Top = 21
    Width = 29
    Height = 13
    Caption = 'Wynik'
  end
  object Label2: TLabel
    Left = 655
    Top = 93
    Width = 29
    Height = 13
    Caption = 'Wynik'
  end
  object Button1: TButton
    Left = 40
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Pobierz'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 152
    Width = 703
    Height = 459
    TabOrder = 1
  end
  object Button2: TButton
    Left = 40
    Top = 47
    Width = 113
    Height = 25
    Caption = 'Testowo pobierz A'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 40
    Top = 78
    Width = 161
    Height = 25
    Caption = 'Pobierz list'#281' podstron od A'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 152
    Top = 16
    Width = 75
    Height = 25
    Caption = 'test memo'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 40
    Top = 109
    Width = 161
    Height = 25
    Caption = 'Pobierz list'#281' podstron od O'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 304
    Top = 16
    Width = 161
    Height = 25
    Caption = 'Wczytaj symbole - dom element'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 304
    Top = 47
    Width = 161
    Height = 25
    Caption = 'Wczytaj symbole - ansiPos'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 488
    Top = 16
    Width = 161
    Height = 25
    Caption = 'Po'#322#261'cz z baz'#261' lokaln'#261
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 488
    Top = 47
    Width = 161
    Height = 25
    Caption = 'Wprowadz do bazy lokalnej'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 488
    Top = 88
    Width = 161
    Height = 25
    Caption = 'Po'#322#261'cz z baz'#261' serwera'
    TabOrder = 10
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 488
    Top = 121
    Width = 161
    Height = 25
    Caption = 'Wprowadz do bazy serwera'
    TabOrder = 11
    OnClick = Button11Click
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 88
    Top = 448
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 288
    Top = 392
  end
  object FDConnection1: TFDConnection
    Left = 360
    Top = 368
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 384
    Top = 416
  end
  object FDConnection2: TFDConnection
    Left = 504
    Top = 368
  end
end

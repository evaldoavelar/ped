inherited FrmInformaSerial: TFrmInformaSerial
  BorderStyle = bsDialog
  Caption = 'Serial'
  ClientHeight = 110
  ClientWidth = 331
  ExplicitWidth = 337
  ExplicitHeight = 138
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 331
    Height = 110
    Align = alClient
    Picture.Data = {
      0A544A504547496D6167650F020000FFD8FFE000104A46494600010101004800
      480000FFDB0043000302020302020303030304030304050805050404050A0707
      06080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F17
      1816141812141514FFDB00430103040405040509050509140D0B0D1414141414
      1414141414141414141414141414141414141414141414141414141414141414
      14141414141414141414141414FFC20011080013001903011100021101031101
      FFC4001500010100000000000000000000000000000008FFC400140101000000
      00000000000000000000000000FFDA000C03010002100310000001A540000000
      07FFC40014100100000000000000000000000000000030FFDA00080101000105
      024FFFC40014110100000000000000000000000000000030FFDA000801030101
      3F014FFFC40014110100000000000000000000000000000030FFDA0008010201
      013F014FFFC40014100100000000000000000000000000000030FFDA00080101
      00063F024FFFC40014100100000000000000000000000000000030FFDA000801
      0100013F214FFFDA000C03010002000300000010924924924FFFC40014110100
      000000000000000000000000000030FFDA0008010301013F104FFFC400141101
      00000000000000000000000000000030FFDA0008010201013F104FFFC4001410
      0100000000000000000000000000000030FFDA0008010100013F104FFFD9}
    Stretch = True
    ExplicitLeft = -8
    ExplicitTop = -8
  end
  object Label1: TLabel
    Left = 111
    Top = 37
    Width = 4
    Height = 13
    Anchors = []
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5259564
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 207
    Top = 37
    Width = 4
    Height = 13
    Anchors = []
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5259564
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblPedidos: TLabel
    Left = 20
    Top = 10
    Width = 144
    Height = 13
    Anchors = []
    Caption = 'Digite abaixo o Serial recebido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5259564
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
    ExplicitTop = 8
  end
  object edtSerial1: TEdit
    Left = 20
    Top = 33
    Width = 78
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 0
    OnKeyUp = edtSerial1KeyUp
  end
  object edtSerial2: TEdit
    Left = 122
    Top = 32
    Width = 78
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 1
    OnKeyUp = edtSerial1KeyUp
  end
  object edtSerial3: TEdit
    Left = 225
    Top = 32
    Width = 78
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 2
    OnKeyUp = edtSerial1KeyUp
  end
  object btn1: TBitBtn
    Left = 156
    Top = 77
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Enviar'
    ModalResult = 1
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 248
    Top = 77
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Sair'
    ModalResult = 2
    TabOrder = 4
  end
end

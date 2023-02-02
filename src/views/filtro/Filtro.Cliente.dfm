inherited frmFiltroCliente: TfrmFiltroCliente
  BorderStyle = bsDialog
  Caption = 'Cliente'
  ClientHeight = 161
  ClientWidth = 385
  OnDestroy = FormDestroy
  ExplicitWidth = 391
  ExplicitHeight = 190
  PixelsPerInch = 96
  TextHeight = 13
  object pnl2: TPanel
    Left = 0
    Top = 121
    Width = 385
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      385
      40)
    object btnOk: TBitBtn
      Left = 210
      Top = 6
      Width = 75
      Height = 25
      Action = actOk
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnCancelar: TBitBtn
      Left = 303
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 121
    Align = alClient
    TabOrder = 0
    object img2: TImage
      Left = 1
      Top = 1
      Width = 383
      Height = 119
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
      ExplicitLeft = 0
      ExplicitTop = 2
    end
    object lbl1: TLabel
      Left = 16
      Top = 21
      Width = 39
      Height = 13
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnConsultaProduto: TSpeedButton
      Left = 349
      Top = 39
      Width = 23
      Height = 22
      Action = actPesquisaCliente
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbbCliente: TComboBox
      Left = 16
      Top = 40
      Width = 327
      Height = 21
      AutoDropDown = True
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnKeyPress = cbbClienteKeyPress
      OnKeyUp = cbbClienteKeyUp
    end
  end
  object act1: TActionList
    Left = 168
    Top = 88
    object actPesquisaCliente: TAction
      Caption = '...'
      ShortCut = 116
      OnExecute = actPesquisaClienteExecute
    end
    object actOk: TAction
      Caption = 'Ok'
      OnExecute = actOkExecute
    end
  end
end

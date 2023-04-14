object FrmCancelarItem: TFrmCancelarItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cancelar Item'
  ClientHeight = 180
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image2: TImage
    Left = 0
    Top = 43
    Width = 240
    Height = 93
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
    ExplicitLeft = -4
    ExplicitTop = 0
    ExplicitHeight = 180
  end
  object Label1: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 10
    Width = 222
    Height = 30
    Margins.Left = 15
    Margins.Top = 10
    Align = alTop
    Caption = 'N'#218'MERO DO ITEM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10639360
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 179
  end
  object Panel1: TPanel
    Left = 16
    Top = 64
    Width = 217
    Height = 49
    BevelOuter = bvNone
    Color = 15524818
    ParentBackground = False
    TabOrder = 0
    object edtItem: TEdit
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 204
      Height = 29
      Margins.Left = 10
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 15524818
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '0'
      OnEnter = edtItemEnter
      OnKeyPress = edtItemKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 136
    Width = 240
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    Color = 16119285
    ParentBackground = False
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 62
      Top = 11
      Width = 75
      Height = 25
      Action = actOk
      Caption = '&Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 158
      Top = 11
      Width = 75
      Height = 25
      Action = actCancelar
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object ActionList1: TActionList
    Left = 128
    Top = 48
    object actOk: TAction
      Caption = '&Ok'
      OnExecute = actOkExecute
    end
    object actCancelar: TAction
      Caption = '&Cancelar'
      OnExecute = actCancelarExecute
    end
  end
end

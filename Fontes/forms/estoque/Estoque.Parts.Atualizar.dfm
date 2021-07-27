object FrameEstoquePartsAtualizar: TFrameEstoquePartsAtualizar
  Left = 0
  Top = 0
  Width = 764
  Height = 47
  TabOrder = 0
  object pnl2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 758
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlNumero: TPanel
      Left = 0
      Top = 0
      Width = 40
      Height = 41
      Align = alLeft
      BevelOuter = bvNone
      Caption = '1'
      Color = 14211288
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnlCodigoPrd: TPanel
      AlignWithMargins = True
      Left = 43
      Top = 0
      Width = 87
      Height = 41
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      Caption = '1234567891234'
      Color = 16119285
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object ViewPartVendaItens: TPanel
      Left = 133
      Top = 0
      Width = 574
      Height = 41
      Margins.Left = 0
      Margins.Right = 0
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object lblDescricao: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 3
        Width = 566
        Height = 16
        Margins.Left = 5
        Margins.Bottom = 0
        Align = alTop
        AutoSize = False
        Caption = 'OL'#201'O MOTOR 5W30 SINT'#201'TICO SELENIA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitLeft = 8
        ExplicitTop = 10
        ExplicitWidth = 365
      end
      object pnlPreco: TPanel
        Left = 0
        Top = 19
        Width = 574
        Height = 22
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblPreco: TLabel
          AlignWithMargins = True
          Left = 30
          Top = 0
          Width = 131
          Height = 19
          Margins.Left = 30
          Margins.Top = 0
          Align = alLeft
          AutoSize = False
          Caption = '1,00  UNIDADE(S)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          ExplicitHeight = 12
        end
      end
    end
    object pnlCancelar: TPanel
      Left = 707
      Top = 0
      Width = 51
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 5
      Padding.Right = 5
      ParentBackground = False
      TabOrder = 3
      object img1: TImage
        Left = 5
        Top = 0
        Width = 41
        Height = 41
        Align = alClient
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
          00200806000000737A7AF4000000097048597300000EC400000EC401952B0E1B
          000001DA4944415478DAEDD5314FC2401400E0DE5D29841603C10809AC1A0766
          E2803191C9C5FFE0A271D138187F82A3D1490713F537986862D0C1C9C4C120A3
          617400020468D1EBB5F561C010BC06F03438F4920E3D5EEF7D69DF7B2069C20B
          79000FE001FE3DA01D8D269546E354B2ED8C84509E05831BFE4623CF8BD563B1
          697FADB68F2C2BED60FC48C3E1BD60B95C1102309F2F474C73B977EF2054659A
          96559ACDA7FEB8663C3E03C972D8B252BD3DCBE7BB954D332B04B008B1E050DC
          BF3788E025FF8C830B0FC9311C20CBCF98B1D4E07E0FF1AEAAAFBCE49D65635C
          27B61D1102504D5B9075FD46721CEDFBD3A80ADFBA04DF7C9EF72CD4CB9A6218
          674280CE325535430CE38A8B70594C5537155D3F1E1637721BBA21060F70C648
          3E16A01F815CDEC4B8C9C70674ABFD1E0A6E8E0B40A80585B938D8A2BF02706B
          350E823B278400A326FF096228A0335E0395CA1D724B8ED01B146680B35F3543
          A12518DB0521005394134CE93AF737283838A0E0D6A28E2C5F13C65684003009
          1F1063695EF25EB5BBB528005E00302BFA060E09A55B5F874AFC56EB47A06E9C
          AD284732A5DB4280562231152895CEE1FF6015C66EDDF2FB7760BC5EF0626928
          9426EDF60120920E2197CD647237522C1A4280BF5E1EC003788089033E00C7CF
          FC219818FEDD0000000049454E44AE426082}
        ExplicitLeft = -24
        ExplicitTop = -32
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
      object btnCancelar: TSpeedButton
        Left = 5
        Top = 0
        Width = 41
        Height = 41
        Hint = 'CANCELAR O PRODUTO'
        Align = alClient
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = btnCancelarClick
        ExplicitLeft = 10
        ExplicitHeight = 36
      end
    end
  end
end

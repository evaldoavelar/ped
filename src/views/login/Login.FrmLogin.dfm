inherited frmLogin: TfrmLogin
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'frmLogin'
  ClientHeight = 424
  ClientWidth = 766
  Color = 10574592
  Position = poScreenCenter
  OnShow = FormShow
  ExplicitWidth = 768
  ExplicitHeight = 426
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 424
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl1'
    Color = 15854571
    Padding.Left = 20
    Padding.Top = 20
    Padding.Right = 30
    Padding.Bottom = 20
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object Label2: TLabel
      AlignWithMargins = True
      Left = 22
      Top = 55
      Width = 317
      Height = 346
      Margins.Top = 35
      Margins.Right = 10
      Align = alRight
      Caption = 'BEM VINDO!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10574592
      Font.Height = -53
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 62
    end
    object Panel7: TPanel
      Left = 349
      Top = 20
      Width = 387
      Height = 384
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel7'
      TabOrder = 0
      object Label3: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 10
        Width = 381
        Height = 33
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alTop
        Caption = 'LOGIN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10574592
        Font.Height = -29
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 90
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 66
        Width = 381
        Height = 311
        Margins.Top = 10
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        Color = clWhite
        Padding.Left = 10
        Padding.Right = 10
        ParentBackground = False
        ShowCaption = False
        TabOrder = 1
        object Label4: TLabel
          AlignWithMargins = True
          Left = 13
          Top = 20
          Width = 355
          Height = 16
          Margins.Top = 20
          Margins.Bottom = 0
          Align = alTop
          Caption = 'C'#211'DIGO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10574592
          Font.Height = -13
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 51
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 13
          Top = 107
          Width = 355
          Height = 16
          Margins.Top = 20
          Margins.Bottom = 0
          Align = alTop
          Caption = 'SENHA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10574592
          Font.Height = -13
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 45
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 13
          Top = 126
          Width = 355
          Height = 45
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel4'
          Color = 15524818
          Padding.Right = 10
          ParentBackground = False
          ShowCaption = False
          TabOrder = 1
          object edtSenha: TEdit
            AlignWithMargins = True
            Left = 15
            Top = 3
            Width = 327
            Height = 39
            Margins.Left = 15
            Align = alClient
            BiDiMode = bdLeftToRight
            BorderStyle = bsNone
            Color = 15524818
            Font.Charset = ANSI_CHARSET
            Font.Color = 10574592
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentBiDiMode = False
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 0
            OnKeyPress = edtSenhaKeyPress
          end
        end
        object Panel5: TPanel
          AlignWithMargins = True
          Left = 13
          Top = 39
          Width = 355
          Height = 45
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel4'
          Color = 15524818
          Padding.Right = 10
          ParentBackground = False
          ShowCaption = False
          TabOrder = 0
          object edtCodigo: TEdit
            AlignWithMargins = True
            Left = 15
            Top = 3
            Width = 327
            Height = 39
            Margins.Left = 15
            Align = alClient
            BiDiMode = bdLeftToRight
            BorderStyle = bsNone
            Color = 15524818
            Font.Charset = ANSI_CHARSET
            Font.Color = 10574592
            Font.Height = -29
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 5
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            OnExit = edtCodigoExit
            OnKeyPress = edtCodigoKeyPress
          end
        end
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 13
          Top = 211
          Width = 355
          Height = 41
          Margins.Bottom = 5
          Align = alBottom
          BevelOuter = bvNone
          Color = 10574592
          ParentBackground = False
          TabOrder = 2
          object btnEntrar: TSpeedButton
            Left = 0
            Top = 0
            Width = 355
            Height = 41
            Action = actLogin
            Align = alClient
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Arial Narrow'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 2
            ExplicitWidth = 439
          end
        end
        object Panel8: TPanel
          AlignWithMargins = True
          Left = 10
          Top = 267
          Width = 361
          Height = 41
          Margins.Left = 0
          Margins.Top = 10
          Margins.Right = 0
          Align = alBottom
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 3
          object Panel6: TPanel
            AlignWithMargins = True
            Left = 316
            Top = 3
            Width = 42
            Height = 33
            Margins.Left = 400
            Margins.Bottom = 5
            Align = alRight
            BevelOuter = bvNone
            Color = clWhite
            ParentBackground = False
            TabOrder = 1
            object btnSair: TSpeedButton
              Left = 0
              Top = 0
              Width = 42
              Height = 33
              Action = actSair
              Align = alClient
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -16
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              ExplicitLeft = 32
              ExplicitWidth = 60
              ExplicitHeight = 32
            end
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 41
            Height = 41
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'Panel9'
            ShowCaption = False
            TabOrder = 0
            object Image1: TImage
              Left = 0
              Top = 0
              Width = 41
              Height = 41
              Align = alClient
              Center = True
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
                00180806000000E0773DF8000000097048597300000EC400000EC401952B0E1B
                000001854944415478DA6364A031601CB5806C0BD81396CDFEF9FB4F0A132323
                C3BFFFFFF01AC1CECABCEEE782E860922C608B5FB2F3DF7F46160D3961FFEB0F
                5F5FFEFBEF9F022EB5AC2CCCA77E2F8C3127C902D6B825DBFFFEFB6FC4C2CC34
                E3F7DFBF15404FB0E1B680E9D4EF45245AC09DBCDCEDEFDF7F9EC484331333D3
                C16F73233790640167D2F2B07F7FFF0612650113D3EEEFF3A3E6916401280E7E
                FDFEE7468C05ACAC4CA4C701CD2DE0485CD6FDF3F7DF38622C606361DEF47341
                542A491648E7AF1700A622354286830C606464BCF76C52E01B922C608D5FB2F6
                F79FBF414405110BF33E601039936401CDE30098D1B60233981798F31F4D351A
                9F9599F91830A3599364017FFA6A8DAF3F7E9BA02AFE67FCEFDF7F3B4626E67E
                64712E76962B9F66855D20C9026C80337149C0EF3FFFE3FF2C8E252A03926C01
                47E2D29C3F7FFE255BE92A181F2AB3FD478C1EBC160867AE29FAF3F7AF2688CD
                C2CC7CFFF3B79FA27FFEFE4B9014E609FDF2FD5738481C584C3C7C3F23B4852A
                3E20078C5A401000008958A01983CC144A0000000049454E44AE426082}
              ExplicitLeft = -16
              ExplicitTop = -32
              ExplicitWidth = 105
              ExplicitHeight = 105
            end
            object btnBancoDeDados: TSpeedButton
              Left = 0
              Top = 0
              Width = 41
              Height = 41
              Align = alClient
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -16
              Font.Name = 'Arial Narrow'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btnBancoDeDadosClick
              ExplicitLeft = 32
              ExplicitWidth = 60
              ExplicitHeight = 32
            end
          end
        end
      end
      object Panel21: TPanel
        Left = 0
        Top = 53
        Width = 387
        Height = 3
        Margins.Top = 0
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel9'
        Color = 500714
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
      end
    end
  end
  object act1: TActionList
    Left = 216
    Top = 104
    object actLogin: TAction
      Caption = 'LOGIN'
      OnExecute = actLoginExecute
    end
    object actSair: TAction
      Caption = 'SAIR'
      ShortCut = 27
      OnExecute = actSairExecute
    end
  end
end

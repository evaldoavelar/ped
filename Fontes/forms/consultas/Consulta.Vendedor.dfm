inherited frmConsultaVendedor: TfrmConsultaVendedor
  Caption = 'Consulta Vendedor'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGridResultado: TJvDBUltimGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 900
        Visible = True
      end>
  end
  inherited jvPnl1: TPanel
    inherited cbbPesquisa: TComboBox
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        '')
    end
  end
end

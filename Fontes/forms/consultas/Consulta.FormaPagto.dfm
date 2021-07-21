inherited frmConsultaFormaPagto: TfrmConsultaFormaPagto
  Caption = 'Consulta Forma Pagamento'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGridResultado: TJvDBUltimGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 450
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTASVEZES'
        Title.Caption = 'Quantas Vezes'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JUROS'
        Title.Caption = 'Juros'
        Width = 110
        Visible = True
      end>
  end
  inherited jvPnl1: TPanel
    inherited cbbPesquisa: TComboBox
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
    end
  end
end

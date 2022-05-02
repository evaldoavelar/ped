inherited FrmConsultaFormaPagtoParceiro: TFrmConsultaFormaPagtoParceiro
  Caption = 'Forma de Pagamento'
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
        FieldName = 'COMISSAOPERCENTUAL'
        Title.Caption = 'Comiss'#227'o'
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

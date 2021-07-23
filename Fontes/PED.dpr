program PED;

{$R *.dres}


uses
  Windows,
  Vcl.Forms,
  untFrmPrincipal in 'forms\untFrmPrincipal.pas' {FrmPrincipal},
  untFrmBase in 'forms\untFrmBase.pas' {frmBase},
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Dialogs,
  FMX.Platform.Win,
  Pedido.Venda in 'forms\pedido\Pedido.Venda.pas' {FrmPedidoVenda},
  Pedido.Parcelamento in 'forms\pedido\Pedido.Parcelamento.pas' {FrmParcelamento},
  Pedido.SelecionaCliente in 'forms\pedido\Pedido.SelecionaCliente.pas' {FrmInfoCliente},
  Consulta.Base in 'forms\consultas\Consulta.Base.pas' {frmConsultaBase},
  Consulta.Cliente in 'forms\consultas\Consulta.Cliente.pas' {frmConsultaCliente},
  Consulta.Produto in 'forms\consultas\Consulta.Produto.pas' {FrmConsultaProdutos},
  Pedido.CancelarItem in 'forms\pedido\Pedido.CancelarItem.pas' {FrmCancelarItem},
  Filtro.Pedidos in 'forms\filtro\Filtro.Pedidos.pas' {frmFiltroPedidos},
  Recebimento.DetalhesPedido in 'forms\recebimento\Recebimento.DetalhesPedido.pas' {frmDetalhesPedido},
  Recebimento.Recebe in 'forms\recebimento\Recebimento.Recebe.pas' {frmRecebimento},
  Helper.TBindGrid in 'units\helper\Helper.TBindGrid.pas',
  Recebimento.ConfirmaBaixa in 'forms\recebimento\Recebimento.ConfirmaBaixa.pas' {frmConfirmaBaixa},
  Pedido.Observacao in 'forms\pedido\Pedido.Observacao.pas' {frmObservacao},
  Cadastros.Cliente in 'forms\cadastros\Cadastros.Cliente.pas' {frmCadastroCliente},
  Cadastros.FormaPagto in 'forms\cadastros\Cadastros.FormaPagto.pas' {frmCadastroFormaPagto},
  Consulta.FormaPagto in 'forms\consultas\Consulta.FormaPagto.pas' {frmConsultaFormaPagto},
  Consulta.Vendedor in 'forms\consultas\Consulta.Vendedor.pas' {frmConsultaVendedor},
  Cadastros.Base in 'forms\cadastros\Cadastros.Base.pas' {frmCadastroBase},
  Cadastros.Vendedor in 'forms\cadastros\Cadastros.Vendedor.pas' {frmCadastroVendedor},
  Cadastros.Produto in 'forms\cadastros\Cadastros.Produto.pas' {frmCadastroProduto},
  Cadastros.Fornecedor in 'forms\cadastros\Cadastros.Fornecedor.pas' {frmCadastroFornecedor},
  Consulta.Fornecedor in 'forms\consultas\Consulta.Fornecedor.pas' {frmConsultaFornecedor},
  Helper.TParcelasCliente in 'units\helper\Helper.TParcelasCliente.pas',
  Configuracoes.Parametros in 'forms\configuracoes\Configuracoes.Parametros.pas' {FrmConfiguracoes},
  Splash.Form in 'forms\splash\Splash.Form.pas' {frmSplash},
  Recebimento.ListaParcelas in 'forms\recebimento\Recebimento.ListaParcelas.pas' {frmParcelasVencendo},
  Sistema.TParametros in 'units\Sistema\Sistema.TParametros.pas',
  Login.FrmLogin in 'forms\login\Login.FrmLogin.pas' {frmLogin},
  Relatorio.TRPedido in 'units\relatorio\Relatorio.TRPedido.pas',
  Relatorio.TRBase in 'units\relatorio\Relatorio.TRBase.pas',
  Relatorio.TRParcelas in 'units\relatorio\Relatorio.TRParcelas.pas',
  Filtro.Vencimento in 'forms\filtro\Filtro.Vencimento.pas' {frmFiltroVencimento},
  Util.Backup in 'units\Util\Util.Backup.pas',
  Dao.IDAOCliente in 'units\Dao\Abstract\Dao.IDAOCliente.pas',
  Dao.TDaoCliente in 'units\Dao\Concret\Dao.TDaoCliente.pas',
  Dao.TDaoEmitente in 'units\Dao\Concret\Dao.TDaoEmitente.pas',
  Dao.TDaoFormaPagto in 'units\Dao\Concret\Dao.TDaoFormaPagto.pas',
  Dao.TDaoFornecedor in 'units\Dao\Concret\Dao.TDaoFornecedor.pas',
  Dao.TDaoItemPedido in 'units\Dao\Concret\Dao.TDaoItemPedido.pas',
  Dao.TDaoParametros in 'units\Dao\Concret\Dao.TDaoParametros.pas',
  Dao.TDaoParcelas in 'units\Dao\Concret\Dao.TDaoParcelas.pas',
  Dao.TDaoPedido in 'units\Dao\Concret\Dao.TDaoPedido.pas',
  Dao.TDaoProdutos in 'units\Dao\Concret\Dao.TDaoProdutos.pas',
  Dao.TDaoVendedor in 'units\Dao\Concret\Dao.TDaoVendedor.pas',
  Dao.IDaoEmitente in 'units\Dao\Abstract\Dao.IDaoEmitente.pas',
  Dao.IDaoFormaPagto in 'units\Dao\Abstract\Dao.IDaoFormaPagto.pas',
  Dao.IDaoFornecedor in 'units\Dao\Abstract\Dao.IDaoFornecedor.pas',
  Dao.IDaoParametros in 'units\Dao\Abstract\Dao.IDaoParametros.pas',
  Dao.IDaoParcelas in 'units\Dao\Abstract\Dao.IDaoParcelas.pas',
  Dao.IDaoPedido in 'units\Dao\Abstract\Dao.IDaoPedido.pas',
  Dao.IDaoProdutos in 'units\Dao\Abstract\Dao.IDaoProdutos.pas',
  Dao.IDaoVendedor in 'units\Dao\Abstract\Dao.IDaoVendedor.pas',
  Impressao.TParametrosImpressora in 'units\Impressao\Impressao.TParametrosImpressora.pas',
  Database.IDataseMigration in 'units\Database\Abstract\Database.IDataseMigration.pas',
  Database.TTabelaBDFB in 'units\Database\Concret\Database.TTabelaBDFB.pas',
  Dominio.Mapeamento.Atributos in 'units\Dominio\Mapeamento\Dominio.Mapeamento.Atributos.pas',
  Dominio.Entidades.TCliente in 'units\Dominio\Entidades\Dominio.Entidades.TCliente.pas',
  Dominio.Entidades.TEmitente in 'units\Dominio\Entidades\Dominio.Entidades.TEmitente.pas',
  Dominio.Entidades.TFactory in 'units\Dominio\Entidades\Dominio.Entidades.TFactory.pas',
  Dominio.Entidades.TFormaPagto in 'units\Dominio\Entidades\Dominio.Entidades.TFormaPagto.pas',
  Dominio.Entidades.TFornecedor in 'units\Dominio\Entidades\Dominio.Entidades.TFornecedor.pas',
  Dominio.Entidades.TItemPedido in 'units\Dominio\Entidades\Dominio.Entidades.TItemPedido.pas',
  Dominio.Entidades.TParcelas in 'units\Dominio\Entidades\Dominio.Entidades.TParcelas.pas',
  Dominio.Entidades.TPedido in 'units\Dominio\Entidades\Dominio.Entidades.TPedido.pas',
  Dominio.Entidades.TProduto in 'units\Dominio\Entidades\Dominio.Entidades.TProduto.pas',
  Dominio.Entidades.TVendedor in 'units\Dominio\Entidades\Dominio.Entidades.TVendedor.pas',
  Dominio.Mapeamento.Tipos in 'units\Dominio\Mapeamento\Dominio.Mapeamento.Tipos.pas',
  Database.TTabelaBD in 'units\Database\Abstract\Database.TTabelaBD.pas',
  Database.TDataseMigrationBase in 'units\Database\Concret\Database.TDataseMigrationBase.pas',
  Filtro.Parcelas in 'forms\filtro\Filtro.Parcelas.pas' {frmFiltroParcelas},
  Filtro.Datas in 'forms\filtro\Filtro.Datas.pas' {frmFiltroDatas},
  Filtro.Base in 'forms\filtro\Filtro.Base.pas' {frmFiltroBase},
  Grafico.Pedidos in 'forms\graficos\Grafico.Pedidos.pas' {frmGraficoPedidos},
  Helper.TPedidoPeriodo in 'units\helper\Helper.TPedidoPeriodo.pas',
  Dao.IDAOPedidoPeriodo in 'units\Dao\Abstract\Dao.IDAOPedidoPeriodo.pas',
  Dao.TDaoPedidoPeriodo in 'units\Dao\Concret\Dao.TDaoPedidoPeriodo.pas',
  Sistema.TLicenca in 'units\Sistema\Sistema.TLicenca.pas',
  DCPbase64 in 'units\Cript\DCPbase64.pas',
  DCPconst in 'units\Cript\DCPconst.pas',
  DCPcrypt2 in 'units\Cript\DCPcrypt2.pas',
  DCPrc4 in 'units\Cript\DCPrc4.pas',
  DCPripemd160 in 'units\Cript\DCPripemd160.pas',
  DCPsha1 in 'units\Cript\DCPsha1.pas',
  Licenca.InformaSerial in 'forms\licenca\Licenca.InformaSerial.pas' {FrmInformaSerial},
  Util.VclFuncoes in 'units\Util\Util.VclFuncoes.pas',
  Util.TCript in 'units\Util\Util.TCript.pas',
  Dao.TDaoBase in '..\Repositorio\DAO\Dao.TDaoBase.pas',
  Dominio.Entidades.TEntity in '..\Repositorio\Dominio\Dominio.Entidades.TEntity.pas',
  Util.Exceptions in '..\Repositorio\Util\Util.Exceptions.pas',
  Util.Funcoes in '..\Repositorio\Util\Util.Funcoes.pas',
  Util.TSerial in '..\Repositorio\Util\Util.TSerial.pas',
  Dominio.Entidades.TOrcamento in 'units\Dominio\Entidades\Dominio.Entidades.TOrcamento.pas',
  Dominio.Entidades.TItemOrcamento in 'units\Dominio\Entidades\Dominio.Entidades.TItemOrcamento.pas',
  Dao.TDaoOrcamento in 'units\Dao\Concret\Dao.TDaoOrcamento.pas',
  Dao.IDaoOrcamento in 'units\Dao\Abstract\Dao.IDaoOrcamento.pas',
  Dao.TDaoItemOrcamento in 'units\Dao\Concret\Dao.TDaoItemOrcamento.pas',
  Helper.TLiveBindingFormatCurr in 'units\helper\Helper.TLiveBindingFormatCurr.pas',
  Helper.TLiveBindingMethodUtils in 'units\helper\Helper.TLiveBindingMethodUtils.pas',
  Relatorio.TROrcamento in 'units\relatorio\Relatorio.TROrcamento.pas',
  Helper.TItemOrcamento in 'units\helper\Helper.TItemOrcamento.pas',
  Filtro.Orcamentos in 'forms\filtro\Filtro.Orcamentos.pas' {frmFiltroOrcamentos},
  Relatorio.TRVendasDoDia in 'units\relatorio\Relatorio.TRVendasDoDia.pas',
  Filtro.DatasVendedor in 'forms\filtro\Filtro.DatasVendedor.pas' {frmFiltroDataVendedor},
  Dominio.Entidades.TAUTOINC in 'units\Dominio\Entidades\Dominio.Entidades.TAUTOINC.pas',
  Orcamento.Criar in 'forms\orcamento\Orcamento.Criar.pas' {FrmCadastroOrcamento},
  Sistema.TFormaPesquisa in 'units\Sistema\Sistema.TFormaPesquisa.pas',
  Relatorio.TRParcelasCliente in 'units\relatorio\Relatorio.TRParcelasCliente.pas',
  Filtro.Cliente in 'forms\filtro\Filtro.Cliente.pas' {frmFiltroCliente},
  Helper.TProdutoVenda in 'units\helper\Helper.TProdutoVenda.pas',
  Relatorio.TRProdutosVendidos in 'units\relatorio\Relatorio.TRProdutosVendidos.pas',
  Dominio.Entidades.TParceiroVenda in 'units\Dominio\Entidades\Dominio.Entidades.TParceiroVenda.pas',
  Dominio.Entidades.TParceiro in 'units\Dominio\Entidades\Dominio.Entidades.TParceiro.pas',
  parceiro.InformaPagto in 'forms\parceiro\parceiro.InformaPagto.pas' {FrmParceiroInfoPagto},
  Dominio.Entidades.TParceiroVenda.Pagamentos in 'units\Dominio\Entidades\Dominio.Entidades.TParceiroVenda.Pagamentos.pas',
  Cadastros.Parceiro in 'forms\cadastros\Cadastros.Parceiro.pas' {frmCadastroParceiro},
  Dao.IDaoParceiro in 'units\Dao\Abstract\Dao.IDaoParceiro.pas',
  Dao.TDaoParceiro in 'units\Dao\Concret\Dao.TDaoParceiro.pas',
  Consulta.Parceiro in 'forms\consultas\Consulta.Parceiro.pas' {frmConsultaParceiro},
  Dominio.Entidades.TParceiro.FormaPagto in 'units\Dominio\Entidades\Dominio.Entidades.TParceiro.FormaPagto.pas',
  Dao.IDaoParceiro.FormaPagto in 'units\Dao\Abstract\Dao.IDaoParceiro.FormaPagto.pas',
  Dao.TDaoParceiro.FormaPagto in 'units\Dao\Concret\Dao.TDaoParceiro.FormaPagto.pas',
  Cadastros.Parceiro.FormaPagto in 'forms\cadastros\Cadastros.Parceiro.FormaPagto.pas' {FrmCadastroFormaPagtoParceiro},
  Consulta.Parceiro.FormaPagto in 'forms\consultas\Consulta.Parceiro.FormaPagto.pas' {FrmConsultaFormaPagtoParceiro},
  parceiro.FramePagamento in 'forms\parceiro\parceiro.FramePagamento.pas' {FramePagamento: TFrame},
  Dao.IDaoParceiroVenda in 'units\Dao\Abstract\Dao.IDaoParceiroVenda.pas',
  Dao.TDaoParceiroVenda in 'units\Dao\Concret\Dao.TDaoParceiroVenda.pas',
  Dao.IDoParceiroVenda.Pagamentos in 'units\Dao\Abstract\Dao.IDoParceiroVenda.Pagamentos.pas',
  Dao.TDaoParceiroVenda.Pagamentos in 'units\Dao\Concret\Dao.TDaoParceiroVenda.Pagamentos.pas',
  pedido.InformaParceiro in 'forms\pedido\pedido.InformaParceiro.pas' {FrmPedidoInformaParceiroVenda},
  Filtro.VendasParceiro in 'forms\filtro\Filtro.VendasParceiro.pas' {frmFiltroVendasParceiro},
  parceiro.PagtoDetalhes in 'forms\parceiro\parceiro.PagtoDetalhes.pas' {FrmPagtoDetalhes},
  Relatorio.TRVendasPorParceiro in 'units\relatorio\Relatorio.TRVendasPorParceiro.pas',
  Pedido.Venda.IPart in 'forms\pedido\Pedido.Venda.IPart.pas',
  Pedido.Venda.Part.Produto in 'forms\pedido\Pedido.Venda.Part.Produto.pas' {PedidoPartFrameProduto: TFrame},
  Pedido.Venda.Part.Item in 'forms\pedido\Pedido.Venda.Part.Item.pas' {PedidoVendaFramePartItem: TFrame},
  Pedido.Venda.Part.ItemCancelamento in 'forms\pedido\Pedido.Venda.Part.ItemCancelamento.pas' {PedidoVendaPartItemCancelamento: TFrame},
  Pedido.Venda.Part.LogoItens in 'forms\pedido\Pedido.Venda.Part.LogoItens.pas' {PedidoVendaPartLogoItens: TFrame},
  Vcl.AutoComplete in '..\AutoComplete\Vcl.AutoComplete.pas',
  Dominio.Entidades.TFormaPagto.Tipo in 'units\Dominio\Entidades\Dominio.Entidades.TFormaPagto.Tipo.pas',
  Utils.Rtti in 'units\Util\Utils.Rtti.pas',
  Pedido.Pagamento in 'forms\pedido\Pedido.Pagamento.pas' {FrmPagamento},
  Dominio.Entidades.CondicaoPagto in 'units\Dominio\Entidades\Dominio.Entidades.CondicaoPagto.pas',
  Helper.Currency in 'units\helper\Helper.Currency.pas',
  Pedido.Venda.Part.CondicaoPagamento in 'forms\pedido\Pedido.Venda.Part.CondicaoPagamento.pas' {ViewPartVendaFormaPagto: TFrame},
  Dao.IDaoCondicaoPagto in 'units\Dao\Abstract\Dao.IDaoCondicaoPagto.pas',
  Dao.TDaoCondicaoPagto in 'units\Dao\Concret\Dao.TDaoCondicaoPagto.pas',
  Dominio.Entidades.Pedido.Pagamentos in 'units\Dominio\Entidades\Dominio.Entidades.Pedido.Pagamentos.pas',
  Dao.IDAOPedidoPagamento in 'units\Dao\Abstract\Dao.IDAOPedidoPagamento.pas',
  Dao.TDAOPedidoPagamento in 'units\Dao\Concret\Dao.TDAOPedidoPagamento.pas',
  Dominio.Entidades.Pedido.Pagamentos.Pagamento in 'units\Dominio\Entidades\Dominio.Entidades.Pedido.Pagamentos.Pagamento.pas',
  Helpers.HelperString in 'units\helper\Helpers.HelperString.pas',
  Pedido.Venda.Part.Pagamento in 'forms\pedido\Pedido.Venda.Part.Pagamento.pas' {FramePedidoVendaPagamento: TFrame},
  Pedido.Pagamento.Imagem in 'forms\pedido\Pedido.Pagamento.Imagem.pas' {FramePedidoPagamentoImagem: TFrame},
  Dominio.Entidades.Observable in 'units\Dominio\Entidades\Dominio.Entidades.Observable.pas',
  Dominio.Entidades.Observe in 'units\Dominio\Entidades\Dominio.Entidades.Observe.pas',
  Dominio.IEntidade in 'units\Dominio\Entidades\Dominio.IEntidade.pas';

{$R *.res}


var
  Mutex: THandle;

begin

  Mutex := CreateMutex(nil, True, 'PED');
  if (Mutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
    MessageDlg('Voc� n�o pode executar outra c�pia do aplicativo', mtInformation, [mbOK], 0);
  end
  else
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := 'PED';
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
  end;

end.

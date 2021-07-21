unit pedido.InformaParceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  System.Generics.Collections, Dominio.Entidades.TParceiro,
  Dominio.Entidades.TFactory, Vcl.Imaging.pngimage;

type
  TFrmPedidoInformaParceiroVenda = class(TfrmBase)
    Panel1: TPanel;
    cbbParceiroVenda: TComboBox;
    Panel2: TPanel;
    btnOk: TBitBtn;
    ActionList1: TActionList;
    actOk: TAction;
    lblParceiro: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure cbbParceiroVendaKeyPress(Sender: TObject; var Key: Char);
    procedure actOkExecute(Sender: TObject);
  private
    { Private declarations }
  private
    FParceiroVenda: TParceiro;
    procedure PopulaLista;
    procedure SetParceiroVenda;
    { Private declarations }
  public
    { Public declarations }
    property ParceiroVenda: TParceiro read FParceiroVenda write FParceiroVenda;
  end;

var
  FrmPedidoInformaParceiroVenda: TFrmPedidoInformaParceiroVenda;

implementation

{$R *.dfm}


procedure TFrmPedidoInformaParceiroVenda.actOkExecute(Sender: TObject);
begin
  inherited;
  SetParceiroVenda();
  Close;
end;

procedure TFrmPedidoInformaParceiroVenda.cbbParceiroVendaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnOk.SetFocus;
end;

procedure TFrmPedidoInformaParceiroVenda.FormShow(Sender: TObject);
begin
  inherited;
  PopulaLista;

  try
    cbbParceiroVenda.SetFocus;
  except
  end;
end;

procedure TFrmPedidoInformaParceiroVenda.PopulaLista;
var
  Parceiros: TObjectList<TParceiro>;
  Parceiro: TParceiro;
  i: Integer;
begin

  try
    Parceiros := TFactory.DaoParceiro.ListarAtivos();

    cbbParceiroVenda.Clear;
    for Parceiro in Parceiros do
    begin
      cbbParceiroVenda.Items.AddObject(Parceiro.NOME, Parceiro);
      // deixar o comboposicionado
      if Assigned(FParceiroVenda) then
        if FParceiroVenda.CODIGO = Parceiro.CODIGO then
          cbbParceiroVenda.ItemIndex := cbbParceiroVenda.Items.Count - 1;
    end;

  except
    on E: Exception do
      raise Exception.Create('Falha ao popular lista: ' + E.Message);
  end;

end;

procedure TFrmPedidoInformaParceiroVenda.SetParceiroVenda();
var
  parceiroSelecionado: TParceiro;
begin
  if cbbParceiroVenda.ItemIndex >= 0 then
  begin

    if Assigned(FParceiroVenda) = false then
      ParceiroVenda := TParceiro.Create;

    // ParceiroVenda.Vendedor := TFactory.DaoVendedor.GetVendedor(TFactory.VendedorLogado.CODIGO);
    // ParceiroVenda.DATA := Now;

    parceiroSelecionado := TParceiro(
      cbbParceiroVenda
      .Items
      .Objects[cbbParceiroVenda.ItemIndex]
      );

    FParceiroVenda := (TFactory
      .DaoParceiro
      .GetParceiro(parceiroSelecionado.CODIGO));

  end;
end;

end.

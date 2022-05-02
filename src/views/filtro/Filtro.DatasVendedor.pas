unit Filtro.DatasVendedor;

interface

uses
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Filtro.Datas, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Dominio.Entidades.TVendedor, Dominio.Entidades.TFactory, Util.Exceptions;

type
  TfrmFiltroDataVendedor = class(TfrmFiltroDatas)
    cbbVendedor: TComboBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure cbbVendedorSelect(Sender: TObject);
  private
    FVendedor: TVendedor;
    procedure SetVendedor(const Value: TVendedor);
    { Private declarations }
  public
    { Public declarations }
    property Vendedor:TVendedor read FVendedor write SetVendedor;
  end;

var
  frmFiltroDataVendedor: TfrmFiltroDataVendedor;

implementation

{$R *.dfm}


procedure TfrmFiltroDataVendedor.btnImprimirClick(Sender: TObject);
begin
  try
    if cbbVendedor.ItemIndex = -1 then
    begin
      cbbVendedor.SetFocus;
      raise TValidacaoException.Create('Selecione um vendedor');
    end;
    inherited;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroDataVendedor.cbbVendedorSelect(Sender: TObject);
var
  Produto: TVendedor;
begin
  inherited;
  if cbbVendedor.ItemIndex > -1 then
  begin
    if cbbVendedor.Items.Objects[cbbVendedor.ItemIndex] <> nil then
    begin
      try
        FVendedor := cbbVendedor.Items.Objects[cbbVendedor.ItemIndex] as TVendedor;
      except
      end;
    end;
  end;

end;

procedure TfrmFiltroDataVendedor.FormCreate(Sender: TObject);
var
  vendedores: TObjectList<TVendedor>;
  item: TVendedor;
begin
  inherited;
  cbbVendedor.Items.Clear;

  vendedores := TFactory.DaoVendedor.Listar();

  for item in vendedores do
  begin
    cbbVendedor.AddItem(item.CODIGO + ' ' + item.NOME, item);
  end;

end;

procedure TfrmFiltroDataVendedor.SetVendedor(const Value: TVendedor);
begin
  FVendedor := Value;
end;

end.

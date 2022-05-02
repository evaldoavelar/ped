unit Pedido.Observacao;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Dominio.Entidades.TPedido, Util.VclFuncoes, Vcl.Imaging.pngimage;

type
  TfrmObservacao = class(TfrmBase)
    Panel1: TPanel;
    mmoObservacoes: TMemo;
    ActionList1: TActionList;
    actOk: TAction;
    actEditar: TAction;
    lblParceiro: TLabel;
    Panel2: TPanel;
    btnOk: TBitBtn;
    lbl1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure mmoObservacoesChange(Sender: TObject);
  private
    FPedido: TPedido;
    { Private declarations }
  public
    { Public declarations }
    property Pedido: TPedido read FPedido write FPedido;
    procedure Bind;
  end;

var
  frmObservacao: TfrmObservacao;

implementation

{$R *.dfm}


uses Util.Funcoes;

procedure TfrmObservacao.actEditarExecute(Sender: TObject);
begin
  inherited;
  mmoObservacoes.SetFocus;
end;

procedure TfrmObservacao.actOkExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmObservacao.Bind;
begin
  FPedido.ClearBindings;
  FPedido.Bind('OBSERVACAO', mmoObservacoes, 'Text');
end;

procedure TfrmObservacao.FormShow(Sender: TObject);
begin
  inherited;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(self, 'TMemo');
  Bind;
  btnOk.SetFocus;
end;

procedure TfrmObservacao.mmoObservacoesChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

end.

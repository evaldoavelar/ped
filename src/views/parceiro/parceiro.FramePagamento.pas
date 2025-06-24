unit parceiro.FramePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Dominio.Entidades.TParceiroVenda.Pagamentos;

type
  TFramePagamento = class(TFrame)
    Panel11: TPanel;
    Panel12: TPanel;
    lblValor: TLabel;
    Panel13: TPanel;
    lblForma: TLabel;
    lblCondicao: TLabel;
    lblComissao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setPagamento(pagto: TParceiroVendaPagto);
  end;

implementation

{$R *.dfm}

{ TFramePagamento }

procedure TFramePagamento.setPagamento(pagto: TParceiroVendaPagto);
begin
  Self.lblValor.Caption := 'R$ ' + FloatToStrF(pagto.VALORPAGAMENTO, ffNumber, 9, 2);
  Self.lblValor.Font.Size := 12;
  Self.lblForma.Caption := pagto.DESCRICAO;
  Self.lblComissao.Caption := 'Comissão: ' + FloatToStrF(pagto.COMISSAOVALOR, ffNumber, 9, 2);
  Self.lblCondicao.Caption := CurrToStr(pagto.COMISSAOPERCENTUAL) + '% ';
end;

end.

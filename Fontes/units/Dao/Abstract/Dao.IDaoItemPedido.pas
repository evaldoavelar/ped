unit Dao.IDaoItemPedido;

interface

uses
  Dao.TDaoBase,
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Dominio.Entidades.TItemPedido;
type

  IDaoItemPedido = interface
    procedure IncluiItemPedido(ItemPedido: TItemPedido);
    procedure ExcluiItemPedido(SEQ, IDPEDIDO: Integer);
    procedure AtualizaItemPedido(ItemPedido: TItemPedido);
    function GeTItemPedido(SEQ, IDPEDIDO: Integer): TItemPedido;
    function GeTItemsPedido(IDPEDIDO: Integer): TObjectList<TItemPedido>;
    function GeraID: Integer;
  end;

implementation

end.

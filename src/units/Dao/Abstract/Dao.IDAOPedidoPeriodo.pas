unit Dao.IDAOPedidoPeriodo;

interface

uses Helper.TPedidoPeriodo;

 type

   IDAOPedidoPeriodo = interface
     ['{CA44ED92-4461-46EC-9EFB-1E013E041F62}']

     function GetTotaisBrutoPedido(DataInicio: TDate; DataFim: TDate): TListaPeriodoPedido;
    function GetTotaisParcelado(DataInicio: TDate; DataFim: TDate): TListaPeriodoPedido;
   end;

implementation

end.

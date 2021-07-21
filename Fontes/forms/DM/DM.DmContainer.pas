unit DM.DmContainer;

interface

uses
  System.SysUtils, System.Classes;

type
  TDmContainer = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmContainer: TDmContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

unit Database.IDataseMigration;

interface
 uses System.Generics.Collections;

type
  IDataseMigration = interface
    ['{CCC63C2A-B643-4424-9FB7-7F01439232FD}']

    procedure Migrate();
    function GetErros: TDictionary<TClass, string>;
  end;

  implementation

end.

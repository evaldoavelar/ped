unit untTFaker;

interface

uses System.Generics.Collections, System.Math, classes, System.DateUtils, System.SysUtils;

type

  TFaker = class

  public
    class function Name: string;
    class function Code: string;
    class function Comment(MaxLenght: integer): string;
  end;

implementation

{ TFaker }

class function TFaker.Code: string;
begin
  Result := Format('%.6d', [Random(10000)]);
end;

class function TFaker.Name: string;
var
  Names: TStringList;
  index: integer;
begin
  Names := TStringList.Create;
  Names.Add('Sabine Stinchcomb');
  Names.Add('Petrina Latch');
  Names.Add('An Shock');
  Names.Add('Charmain Frenkel');
  Names.Add('Anissa Rowlands');
  Names.Add('Anisa Vossen');
  Names.Add('Pablo Westbrooks');
  Names.Add('Temple Critchfield');
  Names.Add('Katrice Keefe');
  Names.Add('Macie Mcewan');
  Names.Add('Tarah Sorber');
  Names.Add('Claudia Mustafa');
  Names.Add('Lewis Tharrington');
  Names.Add('Hien Meritt');
  Names.Add('Robt Howle');
  Names.Add('Maren Walker');
  Names.Add('Lory Cousino');
  Names.Add('Roseann Hales');
  Names.Add('Merle Strum');
  Names.Add('Dorie Dy');

  index := Random(Names.Count);

  Result := Names[index];

end;

class function TFaker.Comment(MaxLenght: integer): string;
var
  Comments: TStringList;
  index: integer;
begin

  Comments := TStringList.Create;
  Comments.Add(
    'Mussum Ipsum, cacilds vidis litro abertis. A ordem dos tratores n�o altera o p�o duris Pra l� , depois divoltis porris, paradis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. undefined');

  Comments.Add(
    'Suco de cevadiss, � um leite divinis, ec orci ornare consequat. Praesent lacinia ultrices consectetur. Sed non ipsum felis. Ta deprimidis, eu conhe�o uma cachacis que pode alegrar sua vidis.�');

  Comments.Add(
    'in elementis m� pra quem � amistosis quis leo. Todo mundo v� os porris que eu tomo, mas ningu�m v� os tombis que eu levo! na minha terra sou Euzis!');

  Comments.Add(
    'Manduma pindureta quium dia nois paga. Sapien in monti palavris qui num significa nadis i pareci latim. Quem num gosta di m�,  ante blandit hendrerit. Aenean sit amet nisi.');

  Comments.Add(
    'Mais vale um bebadis conhecidiss, que um alcoolatra anonimiss. Cevadis im ampola pa arma uma pindureta. Delegadis gente finis, bibendum Mauris aliquet nunc non turpis scelerisque, eget.');

  Comments.Add(
    'Casamentiss faiz malandris se pirulit�. Si u mundo t� muito paradis? Toma um m� que o mundo vai girarzis! Leite de capivaris, sem cochilar e fazendo pose.');

  Comments.Add(
    'Copo furadis � disculpa de bebadis, arcu quam euismod magna. Interagi no m�, cursus quis, vehicula ac nisi. M� faiz elementum girarzis, nisi eros vermeio. .');

  Comments.Add(
    'Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis. Per aumento de cachacis, eu reclamis. N�o sou faixa preta cumpadi,si, ');

  Comments.Add(
    'Detraxit consequat et quo num tendi nada. Si num tem leite ent�o bota uma pinga a� cumpadi! Suco de cevadiss deixa as pessoas mais interessantiss. Atirei o pau no gatis, per gatis num morreus.');

  Comments.Add(
    'Paisis, filhis, espiritis santis. Viva Forevis aptent taciti sociosqu ad litora torquent Nullam volutpat risus nec leo commodo, ut interdum diam laoreet. Sed non consequat odio. Admodum accumsan disputationi eu sit. Vide electram sadipscing et per.');

  Comments.Add(
    'Per aumento de cachacis, eu reclamis. Leite de capivaris, leite de mula manquis. Suco de cevadiss, � um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Todo mundo v� os porris que eu tomo, mas ningu�m v� os tombis que eu levo!');

  Comments.Add(
    'Si num tem leite ent�o bota uma pinga a� cumpadi! Pra l� , depois divoltis porris, paradis. Quem num gosta di m�, boa gente num �. Quem num gosti di mum que vai ca�� sua turmis!');

  Comments.Add(
    'Interagi no m�, cursus quis, vehicula ac nisi. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. A ordem dos tratores n�o altera o p�o duris M� faiz elementum girarzis, nisi eros vermeio.');

  Comments.Add(
    'Atirei o pau no gatis, per gatis num morreus. Quem manda na minha terra sou Euzis! Nec orci ornare consequat. Praesent lacinia ultrices consectetur. Sed non ipsum felis. Copo furadis � disculpa de bebadis, arcu quam euismod magna.');

  Comments.Add(
    'Casamentiss faiz malandris se pirulit�. Sapien in monti palavris qui num significa nadis i pareci latim. Diuretics paradis num copo � motivis de denguis. Mais vale um bebadis conhecidiss, que um alcoolatra anonimiss.');

  index := Random(Comments.Count);

  Result := Copy( Comments[index],0,MaxLenght);

end;

end.

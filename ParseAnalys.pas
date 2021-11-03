unit ParseAnalys;



interface
  uses
    customTypes, Math;

  procedure countLex( var ABSDIFF, RELDIFF, HEIGHT: integer; var LEXEMS: TArray);

implementation

  function detType(const LEX: integer): tLexType;
    begin

          //TODO:определить какая лексема текущая - возможное использование пробегания вперёд
    end;

  function isOperator(const LEX: integer): boolean;
    begin

          //TODO:определить какая лексема текущая - возможное использование пробегания вперёд
    end;

  function findEnding(const LEX: integer; const LEXTYPE: tLexType): integer;
    begin
    //TODO:находится конец блока
    end;

  procedure countLex( var ABSDIFF, RELDIFF, HEIGHT: integer; var LEXEMS: TArray);
    var
      cur, ending, curHeight: integer;
      curType: tLexType;
    begin
      cur:=0;
      HEIGHT:=0;
      curHeight:=0;
      ending:=length(LEXEMS)-1;
      while cur<=length(LEXEMS)-1 do
        begin

          if isOperator(cur) then
            begin
             inc(RELDIFF);
             curType:=detType(cur);
             if curType<>lNone then
              begin
                inc(ABSDIFF);
                //TODO:увеличение текущей высоты с учётом свитча и прочего
                if curHeight>HEIGHT then HEIGHT:=curHeight;
                push(ending);
                ending:=findEnding(cur, curType);     //конец блока, в котором могут быть вложенные условия
                                                      //для контроля вложенности
              end;

            end;
                      //мне начинает казаться, что кроме этих двух TODO добавлять нечего
          inc(cur);
          if cur=ending then
            begin
              //TODO:уменьшение текущей высоты с учётом свитча
              ending:=pop;
            end;
        end;

      RELDIFF:=ABSDIFF*100 div RELDIFF;

    end;

end.

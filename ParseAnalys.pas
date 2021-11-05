unit ParseAnalys;



interface
  uses
    customTypes, Math;

  procedure countLex( var ABSDIFF, RELDIFF, HEIGHT: integer; var LEXEMS: TArray; nLexems: integer);

implementation

procedure countLex( var ABSDIFF, RELDIFF, HEIGHT: integer; var LEXEMS: TArray; nLexems: integer);

function detType(const LEX: integer): tLexType;
    var tmp : string;
    begin
        tmp := ' ' + lexems[LEX] + ' ';
        if      tmp = STR_lIf     then result:= lIf
        else if tmp = STR_lSwitch then result:= lSwitch
        else if tmp = STR_lFor    then result:= lFor
        else if tmp = STR_lWhile  then result:= lWhile
        else if tmp = STR_lRepeat then result:= lRepeat
        else if tmp = STR_lConv   then result:= lConv
        else if tmp = STR_lCase   then result:= lCase
        else if tmp = STR_lDeflt  then result:= lCase
        else                           result:= lNone;

        //определить какая лексема текущая - возможное использование пробегания вперёд
    end;

function isOperator(const LEX: integer): boolean;
    begin
        //определить какая лексема текущая - возможное использование пробегания вперёд
        result := pos(' ' + lexems[LEX] + ' ', STR_OPERATORS) <> 0;
    end;

function findEnding(const LEX: integer; const LEXTYPE: tLexType): integer;
    begin
        //TODO:находится конец блока
    end;

    var
      cur, ending, curHeight: integer;
      curType: tLexType;
    begin
        cur := 0;       // cur lex num
        HEIGHT := 0;    // cur max height
        curHeight := 0; // cur block height
        ending:= nLexems; // lexems bound

        while cur <= nLexems do
        begin
            if isOperator(cur) then
            begin
                inc(RELDIFF);  // count sum of operators
                writeln(' + operator ', lexems[cur], ' (' , RELDIFF, ')');
                curType := detType(cur);
                if curType <> lNone then
                begin
                    inc(ABSDIFF);  // if cur operator is vlozhennniy
                    writeln(' + vlozhenn ', lexems[cur], ' (' , ABSDIFF, ')');
                    //TODO:увеличение текущей высоты с учётом свитча и прочего
                    // check if max height reached
                    if curHeight > HEIGHT then HEIGHT := curHeight;
                    push(ending);
                    ending := findEnding(cur, curType);     //конец блока, в котором могут быть вложенные условия
                                                         //для контроля вложенности
                end;
            end;
                    //мне начинает казаться, что кроме этих двух TODO добавлять нечего
            inc(cur);
            if cur = ending then
            begin
                //TODO:уменьшение текущей высоты с учётом свитча
                ending := pop;
            end;
        end;

        RELDIFF := ABSDIFF * 100 div RELDIFF;

    end;

end.

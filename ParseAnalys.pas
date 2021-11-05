unit ParseAnalys;



interface
  uses
    customTypes, Math;

  procedure countLex( var ABSDIFF, RELDIFF, HEIGHT: integer; var LEXEMS: TArray; const NLEX: integer);

implementation


  procedure countLex( var ABSDIFF, RELDIFF, HEIGHT: integer; var LEXEMS: TArray; const NLEX: integer);
    var
      cur, ending, curHeight: integer;
      curType: tLexType;


    function detType(const LEX: integer): tLexType;
      begin

            //TODO:определить какая лексема текущая - возможное использование пробегания вперёд
      end;

    function isOperator(const LEX: integer): boolean;
      begin

            //TODO:определить какая лексема текущая - возможное использование пробегания вперёд
      end;

    function findEnding(const LEX: integer; const LEXTYPE: tLexType): integer;
      var
        str: String;
        counter, count2, cur: integer;
      begin
        counter:=1;
        cur:=LEX+1;
        str:=LEXEMS[LEX];
        if (LEXTYPE=lIf) then
            begin
              while counter<>0 do
                begin
                  inc(cur);
                  if LEXEMS[cur]='(' then inc(counter)
                    else if LEXEMS[cur]=')' then dec(counter);
                end;

              inc(cur);
              if LEXEMS[cur]='{' then
                  begin
                    counter:=1;
                    while counter<>0 do
                      begin
                        inc(cur);
                        if LEXEMS[cur]='{' then inc(counter)
                          else if LEXEMS[cur]='}' then dec(counter);
                      end;
                  end
                else
                  while LEXEMS[cur]<>';' do
                    inc(cur);

            end
          else if (LEXTYPE=lCase) then
              begin
                while counter<>0 do
                  begin
                    inc(cur);
                    if LEXEMS[cur]='{' then inc(counter)
                      else if LEXEMS[cur]='}' then dec(counter);
                  end;
              end

        {    else if (str='do') then
                begin

                end  }

              else if (LEXTYPE=lRepeat) then
                  begin
                    while counter<>0 do
                      begin
                        inc(cur);
                        if LEXEMS[cur]='do' then inc(counter)
                          else if LEXEMS[cur]='while' then
                              begin
                                count2:=1;
                                inc(cur);
                                while count2<>0 do
                                  begin
                                    inc(cur);
                                    if LEXEMS[cur]='(' then inc(count2)
                                        else if LEXEMS[cur]=')' then dec(count2);
                                  end;
                                inc(cur);
                                if LEXEMS[cur]=';' then dec(counter);

                              end;

                      end;
                  end
                else if (LEXTYPE=lWhile) then
                    begin
                        while counter<>0 do
                          begin
                            inc(cur);
                            if LEXEMS[cur]='(' then inc(counter)
                              else if LEXEMS[cur]=')' then dec(counter);
                          end;

                        inc(cur);
                        if LEXEMS[cur]='{' then
                            begin
                              counter:=1;
                              while counter<>0 do
                                begin
                                  inc(cur);
                                  if LEXEMS[cur]='{' then inc(counter)
                                    else if LEXEMS[cur]='}' then dec(counter);
                                end;
                            end
                          else
                            while LEXEMS[cur]<>';' do
                              inc(cur);
                    end
                  else if (LEXTYPE=lFor) then
                      begin
                        while counter<>0 do
                          begin
                            inc(cur);
                            if LEXEMS[cur]='(' then inc(counter)
                              else if LEXEMS[cur]=')' then dec(counter);
                          end;

                        inc(cur);
                        if LEXEMS[cur]='{' then
                            begin
                              counter:=1;
                              while counter<>0 do
                                begin
                                  inc(cur);
                                  if LEXEMS[cur]='{' then inc(counter)
                                    else if LEXEMS[cur]='}' then dec(counter);
                                end;
                            end
                          else
                            while LEXEMS[cur]<>';' do
                              inc(cur);
                      end
                    else if (LEXTYPE=lConv) then
                        begin
                          while LEXEMS[cur]<>';' do
                            inc(cur);
                        end
                      else RESULT:=LEX;

        RESULT:=cur;
      end;

    begin
      cur:=0;
      HEIGHT:=0;
      curHeight:=0;
      ending:=NLEX;
      while cur<=NLEX do
        begin

          if isOperator(cur) then
            begin
             inc(RELDIFF);
             curType:=detType(cur);
             if curType=lSwitch then
                inc(ABSDIFF);
             if (curType<>lNone)and(curType<>lSwitch) then
              begin
                if curType<>lCase then inc(ABSDIFF);


                if curHeight>HEIGHT then HEIGHT:=curHeight;

                if LEXEMS[cur]<>'default' then
                  begin

                    push(ending);
                    ending:=findEnding(cur, curType);     //конец блока, в котором могут быть вложенные условия
                                                      //для контроля вложенности
                  end;


                  //TODO:увеличение текущей высоты с учётом свитча и прочего
                curHeight:=getLen;
                  //DONE

              end;

            end;
                      //мне начинает казаться, что кроме этих двух TODO добавлять нечего
          inc(cur);
          if cur=ending then
            begin
              ending:=pop;

                //TODO:уменьшение текущей высоты с учётом свитча и прочего
              curHeight:=getLen;
                //DONE

            end;
        end;

      dec(HEIGHT);
      RELDIFF:=ABSDIFF*100 div RELDIFF;

    end;

end.

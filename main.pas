PROGRAM FormatString(INPUT, OUTPUT);
VAR
  C1, C2, C3, C4, C5, C6: CHAR;
  Flag, NewLineFlag, IndentCount: CHAR;
BEGIN
  C1 := ' ';
  C2 := ' ';
  C3 := ' ';
  C4 := ' ';
  C5 := ' ';
  Flag := '0';
  NewLineFlag := '0';
  IndentCount := '0';
  
  WHILE NOT EOLN
  DO
    BEGIN
      C1 := C2;
      C2 := C3;
      C3 := C4;
      C4 := C5;
      READ(C5);
      
      {Является ли символ маркером?}
      IF (Flag = '0')
      THEN
      BEGIN
        IF (C5 = 'B') AND (C4 = ' ')
        THEN {Возможно BEGIN}
          Flag := C5;
        IF (C5 = 'E') AND ((C4 = ' ') OR (C4 = ')') OR (C4 = ';'))
        THEN {Возможно END}
          Flag := C5;
      END;

      {Вывод идентификаторов}
      IF (Flag = '0') AND (C5 <> ' ')
      THEN
        BEGIN
          IF NewLineFlag = '1' {Если новая строка}
          THEN
            BEGIN
              NewLineFlag := '0';
              WRITELN;
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          IF C5 = ':' {Если двоеточие, ...}
          THEN {...перед двоеточием нужен пробел}
            WRITE(' ');
          {Печатаем текущий символ}
          WRITE(C5);
          IF (C5 = ',') OR (C5 = '=') {Если запятая или знак равенства, ...}
          THEN {...после нужен пробел}
            WRITE(' ');
          IF (C5 = ';'){Если точка с запятой, ...}
          THEN {...перевод строки}
            NewLineFlag := '1'; 
        END;
          
     {Поиск ключевого слова BEGIN}
      IF (Flag = 'B') AND (C4 = 'B') AND (C5 <> 'E')
      THEN {BEGIN не будет}
        BEGIN
          IF NewLineFlag = '1' {Если новая строка}
          THEN
            BEGIN
              NewLineFlag := '0';
              WRITELN;
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          WRITE(C4);
          IF C5 = ':' {Если двоеточие, ...}
          THEN {...перед двоеточием нужен пробел}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {Сбрасываем маркер}
        END;
      IF (Flag = 'B') AND (C3 = 'B') AND (C4 = 'E') AND (C5 <> 'G')
      THEN {BEGIN не будет}
        BEGIN
          IF (NewLineFlag = '1')
          THEN
            BEGIN
              WRITELN;
              NewLineFlag := '0';
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          WRITE(C3, C4);
          IF C5 = ':' {Если двоеточие, ...}
          THEN {...перед двоеточием нужен пробел}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {Сбрасываем маркер}
        END;
      IF (Flag = 'B') AND (C2 = 'B') AND (C3 = 'E') AND (C4 = 'G') AND (C5 <> 'I')
      THEN {BEGIN не будет}
        BEGIN
          IF (NewLineFlag = '1')
          THEN
            BEGIN
              NewLineFlag := '0';
              WRITELN;
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          WRITE(C2, C3, C4);
          IF C5 = ':' {Если двоеточие, ...}
          THEN {...перед двоеточием нужен пробел}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {Сбрасываем маркер}
        END;
      IF (Flag = 'B') AND (C1 = 'B') AND (C2 = 'E') AND (C3 = 'G') AND (C4 = 'I') AND (C5 <> 'N')
      THEN {BEGIN не будет}
        BEGIN
          IF (NewLineFlag = '1')
          THEN
            BEGIN
              NewLineFlag := '0';
              WRITELN;
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          WRITE(C1, C2, C3, C4);
          IF C5 = ':' {Если двоеточие, ...}
          THEN {...перед двоеточием нужен пробел}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {Сбрасываем маркер}
        END;
        
      {Найдено ключевое слово BEGIN}
      IF (Flag = 'B') AND (C1 = 'B') AND (C2 = 'E') AND (C3 = 'G') AND (C4 = 'I') AND (C5 = 'N')
      THEN
        BEGIN
          {Проверяем следующий за BEGIN символ Должен быть ' '}
          IF NOT EOLN
          THEN
            BEGIN
              READ(C6);
              {Если действительно BEGIN}
              IF (C6 = ' ') OR (C6 = ';')
              THEN
                BEGIN
                  WRITE('BEGIN'); {Печатаем BEGIN}
                  IndentCount := '1'; {Увеличиваем отступ}
                  NewLineFlag := '1';
                  C1 := C2;
                  C2 := C3;
                  C3 := C4;
                  C4 := C5;
                  C5 := C6; {Передвигаем окно, включая C6}
                  Flag := '0'; {Сбрасываем маркер}
                  
                  IF C6 = ';' {Если за BEGIN сразу пустой оператор без пробела}
                  THEN
                    BEGIN
                      WRITELN;
                      IF (IndentCount = '1')
                      THEN
                        WRITE('  ');
                      WRITE(C6);
                      NewLineFlag := '0'
                    END;
                END
              {Если что-то другое}
              ELSE
                BEGIN
                  IF (NewLineFlag = '1')
                  THEN
                    BEGIN
                      NewLineFlag := '0';
                      WRITELN;
                      IF (IndentCount = '1')
                      THEN
                        WRITE('  ')
                    END;
  		            WRITE('BEGIN', C6); {Печатаем что-то другое}
                  C1 := C2;
                  C2 := C3;
                  C3 := C4;
                  C4 := C5;
                  C5 := C6; {Передвигаем окно, включая C6}
                  Flag := '0' {Сбрасываем маркер}
                END;
            END;
        END;
       {Поиск ключевого слова END}
       IF (Flag = 'E') AND (C4 = 'E') AND (C5 <> 'N')
       THEN {END не будет}
         BEGIN
           IF (NewLineFlag = '1')
           THEN
             BEGIN
               NewLineFlag := '0';
               WRITELN;
               IF (IndentCount = '1')
               THEN
                 WRITE('  ')
             END;
           WRITE(C4);
           IF C5 = ':' {Если двоеточие, ...}
           THEN {...перед двоеточием нужен пробел}
             WRITE(' ');
           WRITE(C5);
           Flag := '0' {Сбрасываем маркер}
         END;
       IF (Flag = 'E') AND (C3 = 'E') AND (C4 = 'N') AND (C5 <> 'D')
       THEN {END не будет}
         BEGIN
           IF (NewLineFlag = '1')
           THEN
             BEGIN
               NewLineFlag := '0';
               WRITELN;
               IF (IndentCount = '1')
               THEN
                 WRITE('  ')
             END;
           WRITE(C3, C4);
           IF C5 = ':' {Если двоеточие, ...}
           THEN {...перед двоеточием нужен пробел}
             WRITE(' ');
           WRITE(C5);
           Flag := '0' {Сбрасываем маркер}
         END;
       {Если найдено ключевое слово END}
       IF (Flag = 'E') AND (C3 = 'E') AND (C4 = 'N') AND (C5 = 'D')
       THEN
         BEGIN
           IF EOLN {Если конец строки}
           THEN
             BEGIN
               WRITELN;
               WRITE('END')
             END
           ELSE {Если не конец строки}
             BEGIN
               READ(C6);
               IF (C6 = ' ') OR (C6 = '.') OR (C6 = ';')
               THEN {Действительно END}
                 BEGIN
                   WRITELN;
                   NewLineFlag := '0';
                   IndentCount := '0';
                   WRITE('END');
                   IF (C6 = '.') OR (C6 = ';')
                   THEN
                     WRITE(C6);
                   C1 := C2;
                   C2 := C3;
                   C3 := C4;
                   C4 := C5;
                   C5 := C6; {Передвигаем окно, включая C6}
                   Flag := '0' {Сбрасываем маркер}
                 END
               ELSE {Что-то другое, но не END}
                 BEGIN
                   IF (NewLineFlag = '1')
                   THEN
                     BEGIN
                       NewLineFlag := '0';
                       WRITELN;
                       IF (IndentCount = '1')
                       THEN
                         WRITE('  ')
                     END;
                   WRITE('END', C6); {Печатаем что-то другое}
                   C1 := C2;
                   C2 := C3;
                   C3 := C4;
                   C4 := C5;
                   C5 := C6; {Передвигаем окно, включая C6}
                   Flag := '0' {Сбрасываем маркер}
                 END;
             END;
         END;  
    END;  
END. 
PROGRAM FormatString(INPUT, OUTPUT);
VAR
  C1, C2, C3, C4, C5, C6: CHAR;
  Flag, NewLineFlag, IndentCount, Bracket: CHAR;
BEGIN
  C1 := ' ';
  C2 := ' ';
  C3 := ' ';
  C4 := ' ';
  C5 := ' ';
  Flag := '0';
  NewLineFlag := '0';
  IndentCount := '0';
  Bracket := '0';
  
  WHILE NOT EOLN
  DO
    BEGIN
      C1 := C2;
      C2 := C3;
      C3 := C4;
      C4 := C5;
      READ(C5);
      
      IF (Flag = ';')
      THEN
      BEGIN
        Flag := '0';
        IF (C5 <> ';')
        THEN
          NewLineFlag := '1';
      END;
      
      {�������� �� ������ ��������?}
      IF (Flag = '0') AND (Bracket = '0')
      THEN
        BEGIN
          IF (C5 = 'B') AND (C4 = ' ')
          THEN {�������� BEGIN}
            Flag := C5;
          IF (C5 = 'E') AND ((C4 = ' ') OR (C4 = ')') OR (C4 = ';') OR (C4 = '}'))
          THEN {�������� END}
            Flag := C5;
          END;
          
      {��������� ������ ������������ ��� ��������� (����������) ���������}
      IF (Bracket = '0') AND ((C5 = '''') OR (C5 = '{'))
      THEN
        BEGIN
          Bracket := C5;
          IF (C5 = '{')
          THEN
            BEGIN
              IF NewLineFlag = '1' {���� ����� ������}
              THEN
                BEGIN
                  NewLineFlag := '0';
                  WRITELN;
                  IF (IndentCount = '1')
                  THEN
                    WRITE('  ')
                END
              ELSE              
               {������ ����� ������� ������������}
                WRITE(' ');
            END;
          WRITE(C5);
          READ(C6);
          C1 := C2;
          C2 := C3;
          C3 := C4;
          C4 := C5;
          C5 := C6; {����������� ����, ������� C6}
        END;
        
      {����� ���������������}
      IF (Flag = '0') AND (C5 <> ' ') AND (Bracket = '0')
      THEN
        BEGIN
          IF NewLineFlag = '1' {���� ����� ������}
          THEN
            BEGIN
              NewLineFlag := '0';
              WRITELN;
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          IF C5 = ':' {���� ���������, ...}
          THEN {...����� ���������� ����� ������}
            WRITE(' ');
          {�������� ������� ������}
          WRITE(C5);
          IF (C5 = ',') OR (C5 = '=') {���� ������� ��� ���� ���������, ...}
          THEN {...����� ����� ������}
            WRITE(' ');
          IF (C5 = ';'){���� ����� � �������, ...}
          THEN {...������� ������}
            Flag := ';'
        END;
     {����� ��������� ��� ���������� ���������}
     IF (Flag = '0') AND (Bracket = '''')
      THEN
        BEGIN
          WRITE(C5);
          IF (C5 = '''') {���� ����� ��������� ��� ���������� ���������}
          THEN
            BEGIN
              Bracket := '0'
            END;
        END;
        
     {����� ������������}
     IF (Flag = '0') AND (Bracket = '{')
      THEN
        BEGIN
          WRITE(C5);
          IF (C5 = '}') {���� ����� ������������}
          THEN
            BEGIN
              Bracket := '0';
              NewLineFlag := '1'
            END;
        END;
     {����� ��������� ����� BEGIN}
      IF (Flag = 'B') AND (C4 = 'B') AND (C5 <> 'E')
      THEN {BEGIN �� �����}
        BEGIN
          IF NewLineFlag = '1' {���� ����� ������}
          THEN
            BEGIN
              NewLineFlag := '0';
              WRITELN;
              IF (IndentCount = '1')
              THEN
                WRITE('  ')
            END;
          WRITE(C4);
          IF C5 = ':' {���� ���������, ...}
          THEN {...����� ���������� ����� ������}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {���������� ������}
        END;
      IF (Flag = 'B') AND (C3 = 'B') AND (C4 = 'E') AND (C5 <> 'G')
      THEN {BEGIN �� �����}
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
          IF C5 = ':' {���� ���������, ...}
          THEN {...����� ���������� ����� ������}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {���������� ������}
        END;
      IF (Flag = 'B') AND (C2 = 'B') AND (C3 = 'E') AND (C4 = 'G') AND (C5 <> 'I')
      THEN {BEGIN �� �����}
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
          IF C5 = ':' {���� ���������, ...}
          THEN {...����� ���������� ����� ������}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {���������� ������}
        END;
      IF (Flag = 'B') AND (C1 = 'B') AND (C2 = 'E') AND (C3 = 'G') AND (C4 = 'I') AND (C5 <> 'N')
      THEN {BEGIN �� �����}
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
          IF C5 = ':' {���� ���������, ...}
          THEN {...����� ���������� ����� ������}
            WRITE(' ');
          WRITE(C5);
          Flag := '0' {���������� ������}
        END;
        
      {������� �������� ����� BEGIN}
      IF (Flag = 'B') AND (C1 = 'B') AND (C2 = 'E') AND (C3 = 'G') AND (C4 = 'I') AND (C5 = 'N')
      THEN
        BEGIN
          {��������� ��������� �� BEGIN ������ ������ ���� ' '}
          IF NOT EOLN
          THEN
            BEGIN
              READ(C6);
              {���� ������������� BEGIN}
              IF (C6 = ' ') OR (C6 = ';')
              THEN
                BEGIN
                  WRITE('BEGIN'); {�������� BEGIN}
                  IndentCount := '1'; {����������� ������}
                  NewLineFlag := '1';
                  C1 := C2;
                  C2 := C3;
                  C3 := C4;
                  C4 := C5;
                  C5 := C6; {����������� ����, ������� C6}
                  Flag := '0'; {���������� ������}
                  
                  IF C6 = ';' {���� �� BEGIN ����� ������ �������� ��� �������}
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
              {���� ���-�� ������}
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
  		            WRITE('BEGIN', C6); {�������� ���-�� ������}
                  C1 := C2;
                  C2 := C3;
                  C3 := C4;
                  C4 := C5;
                  C5 := C6; {����������� ����, ������� C6}
                  Flag := '0' {���������� ������}
                END;
            END;
        END;
       {����� ��������� ����� END}
       IF (Flag = 'E') AND (C4 = 'E') AND (C5 <> 'N')
       THEN {END �� �����}
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
           IF C5 = ':' {���� ���������, ...}
           THEN {...����� ���������� ����� ������}
             WRITE(' ');
           WRITE(C5);
           Flag := '0' {���������� ������}
         END;
       IF (Flag = 'E') AND (C3 = 'E') AND (C4 = 'N') AND (C5 <> 'D')
       THEN {END �� �����}
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
           IF C5 = ':' {���� ���������, ...}
           THEN {...����� ���������� ����� ������}
             WRITE(' ');
           WRITE(C5);
           Flag := '0' {���������� ������}
         END;
       {���� ������� �������� ����� END}
       IF (Flag = 'E') AND (C3 = 'E') AND (C4 = 'N') AND (C5 = 'D')
       THEN
         BEGIN
           IF EOLN {���� ����� ������}
           THEN
             BEGIN
               WRITELN;
               WRITE('END')
             END
           ELSE {���� �� ����� ������}
             BEGIN
               READ(C6);
               IF (C6 = ' ') OR (C6 = '.') OR (C6 = ';')
               THEN {������������� END}
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
                   C5 := C6; {����������� ����, ������� C6}
                   Flag := '0' {���������� ������}
                 END
               ELSE {���-�� ������, �� �� END}
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
                   WRITE('END', C6); {�������� ���-�� ������}
                   C1 := C2;
                   C2 := C3;
                   C3 := C4;
                   C4 := C5;
                   C5 := C6; {����������� ����, ������� C6}
                   Flag := '0' {���������� ������}
                 END;
             END;
         END;  
    END;  
END. 

# DATABASE - 250123

## 1. Procedure의 정의
- MySQL에서 프로시저(Procedure)는 저장 프로시저(Stored Procedure)라고도 하며, 데이터베이스 내에 저장된 SQL 명령어의 집합이다.

- 프로시저는 반복적으로 수행해야 하는 복잡한 작업을 자동화하고, SQL 명령어를 코드로 캡슐화하여 실행할 수 있도록 설계되어있다.

  1. 저장 프로시저의 장점
      - 재사용성 : 한 번 작성한 프로시저를 여러 곳에서 반복적으로 사용할 수 있어 생산성이 향상된다.
      - 복잡한 작업 단순화 : 여러 SQL 명령어를 하나로 묶어 실행하므로 복잡한 작업을 단순화한다.
      - 성능 향상 : 저장 프로시저는 서버에서 미리 컴파일되므로 실행 속도가 빠르다.
      - 보안성 : 사용자가 직접 SQL 쿼리를 작성하지 않아도 되므로, 데이터베이스에 대한 직접 접근을 제한하고 보안을 강화할 수 있다.
  
  2. 저장 프로시저의 주요 사용 사례
      - 반복적으로 실행되는 쿼리 자동화
      - 데이터 처리 및 변환 작업
      - 대규모 배치 작업 수행
      - 데이터 유효성 검사 및 트랜잭션 처리
  
- 저장 프로시저는 데이터베이스 중심의 비즈니스 로직을 중앙화하여 관리할 수 있어서 효율적으로 관리할 수 있으며, 복잡한 로직을 캡슐화하여 SQL 코드가 간결하고 가독성이 좋아진다.

- 따라서, 저장 프로시저는 데이터 베이스 중심의 작업을 자동화하고 최적화하기 위해 꼭 필요한 도구이다.

## 2. Procedure 실습

```SQL
  -- 저장 프로시저 작성
  DELIMITER // -- 저장 프로시저 안에서는 새로운 구분자 // 를 실정하여 명령어 블록을 처리한다.

  CREATE PROCEDURE UpdateUserGrade()
  BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE userId INT;
    DECLARE userPoints INT;
    DECLARE userOldGrade VARCHAR(10);
    DECLARE cur CURSOR FOR
    SELECT id, points, grade
        FROM Users
        WHERE points >= 1000 AND grade != 'VIP';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      
      -- 커서를 열어 데이터를 반복적으로 처리
      OPEN cur;
      
      loop_process: LOOP
      FETCH cur INTO userId, userPoints, userOldGrade;
          
          -- 더 이상 처리할 데이터가 없으면 루프 종료
          IF done = 1 THEN
        LEAVE loop_process;
      END IF;
          
          -- 사용자 등급 업데이트
          UPDATE Users
          SET grade = 'VIP'
          WHERE id = userId;
          
          -- 변경사항을 로그 테이블에 기록
          INSERT INTO LogTable (user_id, old_grade, new_grade)
          VALUES (userId, userOldGrade, 'VIP');
    END LOOP;
      
      CLOSE cur;

  END //

  DELIMITER ;

```

1. 프로시저 구분자 명령어   
  - MySQL 클라이언트에서만 사용하는 설정 명령어   
  - 저장 프로시저, 트리거, 함수처럼 SQL 블록 안에서 여러 명령어를 사용할 경우, ; 를 중간 명령어의 끝으로 해석하지 않도록 구분자를 임시로 변경해야 한다.
    ```SQL
      DELIMITER //
        CREATE ...;
        DELETE ...;
      DELIMITER ;
    ```
    

2. 프로시저 생성 명령어
  - 'CREATE PROCEDURE' 명령어로 새로운 저장 프로시저를 정의한다.
  - 괄호 안에는 저장 프로시저가 매개변수를 받을 경우 여기에 정의한다.
    ```SQL
      CREATE PROCEDURE procdure_name()
    ```

3. 프로시저 시작, 끝
  - BEGIN : 저장 프로시저의 시작을 나타낸다.
  - END : 저장 프로시저의 끝을 나타낸다.
  - 프로시저 안에서 실행할 모든 명령어는 BEGIN과 END 사이에 작성된다.

4. 변수 처리 플래그
  - DECLARE : 저장 프로시저 안에서 변수를 선언할 때 사용된다.
  - DEFAULT : 변수의 초기값을 설정한다.

5. 커서
  - 쿼리 결과 집합을 한 행씩 처리할 수 있도록 지원하는 메커니즘
  - 커서를 사용하면 결과 집합을 순차적으로 탐색하며 필요한 작업을 수행할 수 있음
  - cursor 사용 순서
    1. DECLARE ... CURSOR 을 사용해 선언 후 사용한다.
    2. OPEN cusor_name을 사용해 결과 집합을 메모리에 로드한다.
    3. FETCH 명령어를 사용해 데이터를 한 행씩 가져와 변수에 저장한다.
    4. 작업이 끝나면 CLOSE cursor_name; 으로 커서를 닫아 메모리를 해제한다.
    ```SQL
      DECLARE cursor_name CURSOR FOR SELECT_statement;
      OPEN cursor_name;

      FETCH cursor_name INTO varialbe_list;

      CLOSE cursor_name;
    ```

5. 루프 반복문 시작
  - 'loop_process : LOOP' : 반복문의 시작을 나타낸다.
    - loop_process는 사용자가 임의로 붙인 이름 (제거해서 사용도 가능)
    - LOOP 는 고유 명령어
    - 특정 조건에서 'LEAVE loop_process;' 로 루프를 종료할 수 있음
  - 커서를 사용하여 데이터를 하나씩 처리할 때 사용된다.

6. 프로시저 호출
  - CALL 명령어를 사용해 정의한 프로시저를 호출한다.
    ```SQL
      CALL procedure_name;
    ```
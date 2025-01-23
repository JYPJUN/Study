CREATE database Stored_Procedure;

use Stored_Procedure;

-- 기본 테이블 구성
CREATE TABLE Users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    points INT,
    grade VARCHAR(10) DEFAULT 'NORMAL'
);

CREATE TABLE LogTable (
	log_id INT auto_increment PRIMARY KEY,
    user_id INT,
    old_grade VARCHAR(10),
    new_grade VARCHAR(10),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 저장 프로시저 작성
DELIMITER //

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
        
        -- 사용자 등급 ㅂ업데이트
        UPDATE Users
        SET grade = 'VIP'
        WHERE id = userId;
        
        -- 변경사항을 로그 테이블에 기록
        INSERT INTO LogTable (user_id, old_grade, new_grade)
        VALUES (userId, userOldGrade, 'VIP');
	END LOOP;
    
    CLOSE cur;

END //
    









































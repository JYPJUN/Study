-- 코드를 입력하세요
SELECT FACTORY_ID, FACTORY_NAME, ADDRESS
FROM FOOD_FACTORY
HAVING ADDRESS LIKE '강원도%'
ORDER BY FACTORY_ID;
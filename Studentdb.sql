 ﻿-- 1. List all the student details studying in fourth semester ‘C’ section. 
  
 SELECT S.*, SS.SSID FROM STUDENT S, 
     SEMSEC SS, CLASS C 
     WHERE S.USN = C.USN AND C.SSID = SS.SSID 
     AND SS.SEM = 4 AND SS.SEC = 'C'; 
  
  
 -- 2. Compute the total number of male and female students 
 -- in each semester and in each section. 
  
 SELECT SS.SEM, SS.SEC, S.GENDER, COUNT(S.GENDER) AS COUNT 
     FROM STUDENT S, SEMSEC SS, CLASS C 
     WHERE S.USN = C.USN AND C.SSID = SS.SSID 
     GROUP BY SEM, SEC, GENDER 
     ORDER BY SEM, SEC, GENDER; 
  
  
 -- 3. Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects. 
  
 CREATE VIEW REPORT_CARD AS 
     SELECT TEST1, SUBCODE 
     FROM IAMARKS 
     WHERE USN = '1RN13CS091'; 
 SELECT * FROM REPORT_CARD; 
  
  
 -- 4. Calculate the FinalIA (average of best two test marks) 
 -- and update the corresponding table for all students. 
  
 CREATE OR REPLACE PROCEDURE AVGMARKS IS 
     CURSOR C_IAMARKS IS 
     SELECT GREATEST(TEST1, TEST2) AS A, 
     GREATEST(TEST2, TEST3) AS B, 
     GREATEST(TEST3, TEST1) AS C 
     FROM IAMARKS WHERE FINALIA IS NULL 
     FOR UPDATE; 
     C_A NUMBER; 
     C_B NUMBER; 
     C_C NUMBER; 
     C_SUM NUMBER; 
     C_AVG NUMBER; 
     BEGIN 
     OPEN C_IAMARKS; 
     LOOP 
     FETCH C_IAMARKS INTO C_A, C_B, C_C; 
     EXIT WHEN C_IAMARKS%NOTFOUND; 
     IF (C_A != C_B) THEN 
     C_SUM := C_A + C_B; 
     ELSE 
     C_SUM := C_A + C_C; 
     END IF; 
     C_AVG := C_SUM / 2; 
     UPDATE IAMARKS SET FINALIA = C_AVG WHERE CURRENT OF C_IAMARKS; 
     END LOOP; 
     CLOSE C_IAMARKS; 
     END; 
     / 
  
     BEGIN 
     AVGMARKS; 
     END; 
     / 
  
  
 -- 5. Categorize students based on the following criterion: 
 -- If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
 -- If FinalIA = 12 to 16 then CAT = ‘Average’ 
 -- If FinalIA< 12 then CAT = ‘Weak’ 
 -- Give these details only for 8th semester A, B, and C section students. 
  
 SELECT S.*, (CASE 
     WHEN IA.FINALIA BETWEEN 17 AND 20 THEN 'OUTSTANDING' 
     WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE' 
     ELSE 'WEAK' 
     END) AS CAT 
     FROM STUDENT S, IAMARKS IA, SEMSEC SS 
     WHERE IA.USN = S.USN AND 
     IA.SSID = SS.SSID AND 
     SS.SEM = 8; 

 ﻿-- 1. Retrieve details of all books in the library – id, title, name of publisher, 
 -- authors, number of copies in each branch, etc. 
  
 SELECT B.BOOK_ID, TITLE, PUBLISHER_NAME, AUTHOR_NAME, NO_OF_COPIES, LB.BRANCH_ID 
     FROM BOOK B, BOOK_AUTHORS BA, BOOK_COPIES BC, LIBRARY_BRANCH LB 
     WHERE B.BOOK_ID = BA.BOOK_ID AND 
     B.BOOK_ID = BC.BOOK_ID AND 
     BC.BRANCH_ID = LB.BRANCH_ID; 
  
  
 -- 2. Get the particulars of borrowers who have borrowed more than 3 books, 
 -- but from Jan 2017 to Jun 2017. 
  
 SELECT CARD_NO FROM BOOK_LENDING 
     WHERE DATE_OUT BETWEEN '01-JAN-2017' AND '01-JUL-2017' 
     GROUP BY CARD_NO 
     HAVING COUNT(*) > 3; 
  
  
 -- 3. Delete a book in BOOK table. Update the contents of other tables 
 -- to reflect this data manipulation operation. 
  
 DELETE FROM BOOK WHERE BOOK_ID = 3; 
  
  
 -- 4. Partition the BOOK table based on year of publication. 
 -- Demonstrate its working with a simple query. 
  
 CREATE VIEW V_PUB AS SELECT PUB_YEAR FROM BOOK ORDER BY PUB_YEAR; 
 SELECT * FROM V_PUB; 
  
  
 -- 5. Create a view of all books and its number of copies 
 -- that are currently available in the Library. 
  
 CREATE VIEW CUR_BOOKS AS 
     SELECT B.BOOK_ID, TITLE, NO_OF_COPIES 
     FROM BOOK B, BOOK_COPIES BC 
     WHERE B.BOOK_ID = BC.BOOK_ID; 
 SELECT * FROM CUR_BOOKS; 

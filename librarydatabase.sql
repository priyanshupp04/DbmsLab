create table publisher(
	name varchar(30) primary key,
	adddress varchar(100),
	phone int
);

create table book(
	book_id int primary key,
	title varchar(30),
	publisher_name varchar(30) references publisher(name) on delete cascade,
	pub_year date
);



create table BOOK_AUTHOR (
	book_id int,
	author_name varchar(30),
	Foreign key (book_id) references book(book_id) on delete cascade,
	primary key(book_id, author_name)
);

create table LIB_BRANCH(
	branch_id int primary key,
	branch_name varchar(20),
	address varchar(100)
)

create table CARD(
	card_no int primary key
)

create table BOOK_COPIES (
	book_id int,
	branch_id int,
	no_of_copies int,
	primary key(book_id, branch_id),
	foreign key (book_id) references book(book_id) on delete cascade,
	foreign key (branch_id) references LIB_BRANCH(branch_id) on delete cascade
)


create table BOOK_LENDING (
	book_id int,
	branch_id int,
	card_no int,
	date_out date,
	due_date date,
	foreign key (book_id) references book(book_id) on delete cascade,
	foreign key (branch_id) references LIB_BRANCH(branch_id) on delete cascade,
	foreign key (card_no) references CARD(card_no) on delete cascade
);
	

--values:

--LIB_BRANCH

insert into LIB_BRANCH
	values ('1', 'ECE', 'ECE Department');
insert into LIB_BRANCH
	values ('2', 'CSE', 'CSE Department');
insert into LIB_BRANCH
	values ('3', 'EIE', 'EIE Department');


--CARD_NO

insert into CARD values('101');
insert into CARD values('456');
insert into CARD values('001');
insert into CARD values('096');

--PUBLISHER

insert into PUBLISHER values('SChand','Delhi','8349841278');
insert into PUBLISHER values('Arihant','Mumbai','9319848346');
insert into PUBLISHER values('Ncert','Delhi','8349841278');
insert into PUBLISHER values('Gulmohar','Lucknow','8349841278');

--BOOK

insert into BOOK values('01','Fun with Science','SChand','10-MAR-2004');
insert into BOOK values('03','Grammar Tree','Gulmohar','20-JUN-2010');
insert into BOOK values('04','Beakers and Burners','SChand','15-AUG-2003');
insert into BOOK values('02','Chhitiz','Ncert','20-NOV-2004');
insert into BOOK values('05','10 years papers (Physics)','Arihant','15-MAY-2004');
	
--BOOK_AUTHOR

insert into BOOK_AUTHOR values('01','Martha Jacobs');
insert into BOOK_AUTHOR values('02','Jack Snyder');
insert into BOOK_AUTHOR values('03','M. Prasad');
insert into BOOK_AUTHOR values('04','Walter White');
insert into BOOK_AUTHOR values('05','S. Lakshmi');

--BOOK_COPIES

insert into BOOK_COPIES values('01','1','25');
insert into BOOK_COPIES values('03','2','10');
insert into BOOK_COPIES values('05','1','40');
insert into BOOK_COPIES values('02','3','45');
insert into BOOK_COPIES values('04','2','15');

--BOOK_LENDING

insert into BOOK_LENDING values('01','1','456','10-JAN-2017','10-FEB-2017');
insert into BOOK_LENDING values('03','2','456','12-FEB-2017','12-MAR-2017');
insert into BOOK_LENDING values('05','1','096','15-MAR-2017','15-APR-2017');
insert into BOOK_LENDING values('04','2','001','20-AUG-2017','20-SEP-2017');
insert into BOOK_LENDING values('02','3','101','25-OCT-2017','25-NOV-2017');




select C.branch_id,B.book_id,B.title,B.publisher_name,A.author_name,C.no_of_copies
from BOOK B, BOOK_AUTHOR A, BOOK_COPIES C
where B.book_id= A.book_id and B.book_id = C.book_id;

select L.card_no
from BOOK_LENDING L, BOOK_COPIES C
where L.date_out between '01-JAN-2017' AND '01-JUN-2017'
group by L.card_no
having count(*)>3;

delete from BOOK
WHERE book_id = 5;

CREATE VIEW V_BOOKS AS
SELECT B.book_id, B.title, C.no_of_copies
FROM BOOK B, BOOK_COPIES C;

CREATE VIEW v_PUB AS
SELECT pub_year
FROM BOOK;

create table salesman
(
	salesman_id int primary key,
	name varchar(30) not null,
	city varchar(30) not null,
	commision float
);

create table customer
(
	customer_id int primary key,
	cust_name varchar(30) not null,
	city varchar(30) not null,
	grade int,
	salesman_id int references salesman(salesman_id) 
);

create table orders
(
	ord_no int primary key,
	purchase_amt float,
	ord_date date not null,
	customer_id int references customer(customer_id) on delete cascade,
	salesman_id int references salesman(salesman_id) on delete cascade
);

insert into salesman
values ('1','vijay','Bangalore','250');
insert into salesman
values ('2','sharma','Mumbai','300');
insert into salesman
values ('3','kumar','Bangalore','200');
insert into salesman
values ('4','ranjith','Chennai','400');
insert into salesman
values ('5','hussain','Bangalore','300');

insert into customer
values ('101','aishwarya','Bangalore','9','3');
insert into customer
values ('102','naksh','Delhi','6','4');
insert into customer
values ('103','shakib','Kolkata','7','5');
insert into customer
values ('104','arya','Bangalore','8','1');
insert into customer
values ('105','aman','Bangalore','7','1');
insert into customer
values ('106','divyanshu','Patna','6','2');
insert into customer
values ('107','aditi','Mumbai','7','4');
insert into customer
values ('108','mahesh','Bangalore','6','3');


insert into orders
values ('1001','324','10-JAN-2021','105','3');
insert into orders
values ('1002','2345','24-MAR-2021','101','2');
insert into orders
values ('1003','999','15-JUN-2021','102','5');
insert into orders
values ('1004','512','21-AUG-2021','107','4');
insert into orders
values ('1005','666','23-SEP-2021','104','1');
insert into orders
values ('1006','777','12-OCT-2021','106','4');
insert into orders
values ('1007','45743','23-SEP-2021','103','2');
insert into orders
values ('1008','342','23-JUL-2021','108','5');

select count(*) 
from customer
where grade > (select avg(grade)
				from customer
				where city ='Bangalore');
				
select S.salesman_id, S.name
from salesman S
where 1 < ( select count(*)
			from Customer C
			where S.salesman_id = C.salesman_id);
			
select S.salesman_id, S.name, C.cust_name, S.city
from salesman S, customer C
where S.city = C.city
UNION
select S.salesman_id,S.name, 'No-MAtch', S.city
from Salesman S, customer C
where S.city not in (select city from Customer);


CREATE view big_orders as
select B.ord_date, A.salesman_id, A.name
from salesman A, orders B
where A.salesman_id = B.salesman_id and B.purchase_amt in
							(select max(purchase_amt)
							from orders
							group by ord_date);

delete from salesman 
where salesman_id = 1;

update orders
set ord_date = '23-SEP-2021'
where ord_no = '1005';

create table t(
	age int
	);
	
alter table t
modify age float;

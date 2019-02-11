-- book_ex
DROP SCHEMA IF EXISTS book_ex;

-- book_ex
CREATE SCHEMA book_ex;

use book_ex;

-- 190211 AOP
create table tbl_user(
	uid varchar(50) not null,
	upw varchar(50) not null,
	uname varchar(100) not null,
	upoint int not null default 0,
	primary key(uid)
);

create table tbl_message(
	mid int not null auto_increment,
	targetid varchar(50) not null,
	sender varchar(50) not null,
	message text not null,
	opendate timestamp,
	senddate timestamp not null default now(),
	primary key(mid)
);

alter table tbl_message add constraint fk_usertarget
foreign key (targetid) references tbl_user(uid);

alter table tbl_message add constraint fk_usersender
foreign key (sender) references tbl_user(uid);

insert into tbl_user(uid, upw, uname) values
('user00', 'user00', 'IRON MAN'), ('user01', 'user01', 'CAPTAIN'),
('user02', 'user02', 'HULK'), ('user03', 'user03', 'Thor'),
('user10', 'user10', 'Doctor Strange');
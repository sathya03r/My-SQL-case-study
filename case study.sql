create database casestudy;
use casestudy;

-- creating the table--

create table anime( anime_id int primary key ,
 anime_name varchar(50) ,
 genres varchar(50) , 
 released_year int );

-- inserting values in the created table--

insert into anime values(01 , 'OnePiece' , 'adventure' , 1997),
						(02 , 'Naruto' , 'action' , 2002),
                        (03 , 'Attack_on_titan' , 'War' , 2013),
                        (04 , 'Bleach' , 'soulriper' , 2004),
                        (05 , 'Boruto' , 'ninja' , 2023),
                        (06 , 'Blackclover' , 'Magic' , 2018);
select * from anime;


-- creating another table --
                   
create table author( author_id int primary key , author_name varchar(50), anime_id int , anime_status varchar(50) );
select * from author;

insert into author values(1 , 'elichiro oda',1,'ongoing'),
						 (2 , 'Masashi Kishimoto',2,'completed'),
						 (3 , 'Hajime Isayama ',3,'completed'),
                         (4 , 'Tite Kubo',4,'completed'),
                         (5 , 'Masahi kishimoto',5,'ongoing'),
                         (6 , 'Yuki tabata',6,'ongoing');
-- update the valaues in tables --

update author set author_name='masashi kishimoto' where author_id=5;


-- creating another table  using auto increment --
create table platform( anime_id int, platform_id int primary key auto_increment, ottname varchar(55), rating float(2));
insert into platform (anime_id , ottname  ,rating )
					values(01,'Netflix',10),
                       (02,'Crunchyroll',9.8),
                           (03,'Amazonprime',9.7),
                           (04,'Aniwatch',9.6),
                           (05,'Crunchyroll',9.5),
                           (06,'Sony yay',9.4);
		
select * from platform;
						
        -- table 4 --       
     create table anime_char (anime_id int , main_char varchar(50), gender varchar(50));
     insert into anime_char values(01,'monkey.D.luffy','male'),
                       (02,'Uzumaki naruto','male'),
                           (03,'mikasa eren','female'),
                           (04,'Ichigo kurasaki','male'),
                           (05,'sarada uchiha','female'),
                           (06,'Asta','male');
                           select* from anime_char;
                           
    -- table 5--
    create table ott_subscription(platform_id int , ott_name varchar(50),price int);
    insert into ott_subscription values(01,'Netflix',649),
                       (02,'Crunchyroll',999),
                           (03,'Amazonprime',1200),
                           (04,'Aniwatch',750),
                           (05,'Crunchyroll',999),
                           (06,'Sony yay',899);
                           select * from ott_subscription;
                           
    -- altering/adding anime_name  in the anime_char --
update anime_char set main_char='boruto' where anime_id=5 ;
update anime_char set gender='male' where anime_id=5 ;


-- TCL:commit and rollback in ott_subscription --
set autocommit=off;
delete from ott_subscription where platform_id=6;
rollback;
select * from ott_subs;


-- alter table --
alter table ott_subscription rename ott_subs; 
select * from ott_subs;

-- aggeregate function avg, sum, count the no.of rows in each coulmn --
select  platform_id,sum(price) from ott_subs group by platform_id order by  1;


select  count(platform_id),
		count(ott_name),
		count(price)
	from ott_subs;
 
-- list of author with name is kishimoto--

select * from author where author_name like 'Masashi kishimoto';

-- anime released in year between 1997 to 2013 --

select * from anime;

select anime_name,released_year from anime
 where released_year <=2013 
 order by released_year ;

-- find price of ott subscription for all anime--

select a.anime_id ,a.anime_name,p.platform_id,o.price from anime a
 join platform p on(a.anime_id=p.platform_id)
 join ott_subs o on(p.platform_id=o.platform_id);
 
 -- find price for subscribing aniwatch--
select*from platform;
 select ott_name,price from ott_subs where platform_id=4 order by price ;


-- least and expensive of price for each ott_name--
select* from ott_subs;
select ott_name,  min(price) over (order by platform_id) as minimum ,max(price) over(order by platform_id)as maximum from ott_subs;

-- identify author name whose anime has high rating --
select author_id,author_name from author where anime_id in (select anime_id from platform where rating>9.9);

-- anime name having ranking above 9.8--
select * from platform;
select anime_id,anime_name from anime where anime_id in (select anime_id from platform where rating>9.5);


-- show the main charcters of their respective anime  --
select a.anime_name,ac.main_char from anime a
join anime_char ac on a.anime_id=ac.anime_id; 

-- show the list of anime char who are female with their anime name  --
select a.anime_name,ac.main_char,ac.gender from anime a
join anime_char ac on a.anime_id=ac.anime_id
where ac.gender='female';

-- list of all anime name with main_char name who are males --
 select a.anime_name,ac.main_char,ac.gender from anime a
join anime_char ac on a.anime_id=ac.anime_id 
 where  ac.gender='male';
 
 
 -- show main char name  who have more rating--
 select main_char from anime_char where anime_id in(select anime_id from platform where rating>9.8);
 
 --  show ratings for completed anime with their names--
 select au.author_name,a.anime_name,au.anime_status,p.rating from anime a
 join platform p on a.anime_id=p.anime_id
 join author au on au.anime_id=a.anime_id where au.anime_status like'completed';
 
 
 
 
 
 show tables;
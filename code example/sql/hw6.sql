Use CS122A;
/* LastName: Liu	FirstName: Yating	student ID: 10588498 */

select P.userid, P.publisherid, count(D.userid)
from Users U left outer join Degree D on U.userid=D.userid, Poster P
where P.userid=U.userid
group by P.userid
order by count(D.userid) desc/* Q1 */;

select D.userid, U.account, count(H.userid), min(H.like_score)
from (Detector D join Users U on D.userid=U.userid) 
left outer join (Has_read H join Article A on A.userid=H.article_userid and A.articleid=H.article_articleid)
on D.userid=H.userid
group by D.userid
order by D.userid asc/* Q2 */;

select A.userid, A.articleid, A.quality, count(distinct H.userid), avg(H.like_score), count(distinct R.userid)
from (Article A left join Has_read H on A.userid=H.article_userid and A.articleid=H.article_articleid)
left join Reports R on A.userid=R.article_userid and A.articleid=R.article_articleid
group by A.userid, A.articleid /* Q3 */;

drop procedure if exists NewArticle;
delimiter //
create procedure NewArticle( /*Q4.a */
	id integer,
    title varchar(100),
    content varchar(1000))
begin
	declare new_articleid integer;
    set new_articleid = (select count(A.articleid) from Article A where A.userid=id)+1;
    insert into Article (userid, articleid, title, content, posting_datetime, popularity, quality) 
    values (id, new_articleid, title, content, now(), 'Regular', 'Clean');
end; //
delimiter ;
CALL NewArticle(2, 'WannaCry ransomware attack', 'The WannaCry ransomware attack is an ongoing cyberattack of the WannaCry ransomware cryptoworm, targeting the Microsoft Windows operating system, encrypting data and demanding ransom payments in the cryptocurrency bitcoin.');
SELECT userid, articleid, posting_datetime, popularity, quality, title
FROM Article WHERE userid = 2  /* Q4.b */;

alter table Poster
drop foreign key poster_ibfk_2;
alter table Poster
add constraint poster_ibfk_2 
foreign key(publisherid) references Publisher(publisherid) on delete cascade  /* Q5 */;

drop view if exists PublisherView;
CREATE VIEW PublisherView(publisherid, name, website, num_articles) as
select R.publisherid, R.name, R.website, count(*)
from Publisher R join (Poster P join Article A on P.userid=A.userid) 
on R.publisherid=P.publisherid
group by R.publisherid  /* Q6.a */;

select V.name, V.website
from PublisherView V
where V.num_articles=(select max(num_articles) from PublisherView)  /* Q6.b */;

drop trigger if exists update_quality;
delimiter //
create trigger update_quality  /* Q7.a */
after insert on Reports
for each row
begin
declare num_report integer;
set num_report = (select count(*) from Reports R where R.article_userid=new.article_userid
and R.article_articleid=new.article_articleid);
if (num_report>5 and num_report<10) then
update Article A set A.quality='Suspicious' where A.userid=new.article_userid
and A.articleid=new.article_articleid;
elseif (num_report>=10) then
update Article A set A.quality='Junk' where A.userid=new.article_userid
and A.articleid=new.article_articleid;
end if;
end;//
delimiter ;

INSERT INTO Reports VALUES(21,3,2,'Kinda incorrect'), (10,4,1,'Team is not correct');
SELECT userid, articleid, quality FROM Article /* Q7.b */;

drop trigger if exists update_quality2;
delimiter //
create trigger update_quality2  /* Q8.a */
after delete on Reports
for each row
begin
declare num_report integer;
set num_report = (select count(*) from Reports R where R.article_userid=old.article_userid
and R.article_articleid=old.article_articleid);
if (num_report<=5) then
update Article A set A.quality='Clean' where A.userid=old.article_userid
and A.articleid=old.article_articleid;
elseif (num_report>5 and num_report<10) then
update Article A set A.quality='Suspicious' where A.userid=old.article_userid
and A.articleid=old.article_articleid;
else
update Article A set A.quality='Junk' where A.userid=old.article_userid
and A.articleid=old.article_articleid;
end if;
end;//
delimiter ;

DELETE FROM Reports WHERE Reports.userid=21 and Reports.article_userid=3 and Reports.article_articleid=2;
DELETE FROM Reports WHERE Reports.userid=10 and Reports.article_userid=4 and Reports.article_articleid=1;
SELECT userid, articleid, quality FROM Article /* Q8.b */;



Use cs122a;
SELECT "LastName: Liu   FirstName: Yating   student ID: 10588498";

SELECT D.userid,D.detector_since, U.email 
FROM Detector D, Users U
WHERE U.name_first='Ellen' and U.userid=D.userid /* Q1 */;

SELECT DISTINCT A.userid, A.articleid, A.posting_datetime
FROM Article A, Has_read H
WHERE A.userid=H.article_userid and A.articleid=H.article_articleid and H.like_score=0/* Q2 */;

SELECT A.title, A.quality
FROM Article A, Topic T, Has_read H
WHERE T.userid=A.userid and T.articleid=A.articleid and A.userid=H.article_userid and
A.articleid=H.article_articleid and T.topic='Politics' 
ORDER BY H.like_score DESC
LIMIT 1/* Q3 */;

SELECT R.name, A.userid, A.articleid 
FROM Publisher R, Article A, Poster P
WHERE P.publisherid=R.publisherid and P.userid=A.userid and R.addr_city='San Francisco'
UNION
SELECT R.name, A.userid, A.articleid 
FROM Publisher R, Article A, Poster P
WHERE P.publisherid=R.publisherid and P.userid=A.userid and R.addr_city='Irvine'/* Q4 */;

SELECT DISTINCT R.publisherid, R.name, R.website
FROM Publisher R, Poster P, Degree D
WHERE R.publisherid=P.publisherid and P.userid=D.userid and D.school='Harvard University' and R.publisherid in
(SELECT R2.publisherid
FROM Publisher R2, Poster P2, Degree D2
WHERE R2.publisherid=P2.publisherid and P2.userid=D2.userid and D2.school='University of California, Irvine')/* Q5 */;

SELECT P.userid, U.name_first, U.name_last, U.jobtitle
FROM Poster P, Users U, Recommendation R
WHERE P.userid=U.userid and P.userid=R.from_userid and P.userid not in 
(SELECT P2.userid
FROM Poster P2, Has_read H
WHERE P2.userid=H.userid and H.article_userid=R.article_userid and H.article_articleid=R.article_articleid)/* Q6 */;

SELECT DISTINCT U.userid, count(*)
FROM Users U, Article A, Has_read H
WHERE U.userid=H.userid and H.article_userid=A.userid and H.article_articleid=A.articleid
GROUP BY U.userid
ORDER BY count(*) DESC
LIMIT 3/* Q7 */;

SELECT DISTINCT A.userid, A.articleid, A.title
FROM Article A
WHERE A.quality='Clean' and 5<(SELECT count(*) FROM Reports R WHERE R.article_userid=A.userid and R.article_articleid=A.articleid)/* Q8 */;

SELECT U.userid, U.account
FROM Poster P, Users U, Article A
WHERE P.userid=U.userid and A.userid=P.userid
ORDER BY timediff(A.posting_datetime, U.user_since) ASC
LIMIT 1/* Q9 */;

SELECT A.userid, A.articleid, A.title
FROM Article A
WHERE NOT EXISTS (SELECT D.userid FROM Detector D WHERE NOT EXISTS (SELECT R.userid FROM Reports R WHERE R.userid=D.userid and R.article_userid=A.userid and R.article_articleid=A.articleid))/* Q10 */;


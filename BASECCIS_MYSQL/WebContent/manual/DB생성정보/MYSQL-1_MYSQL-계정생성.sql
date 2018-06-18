--계정생성
CREATE USER '[계정]'@'%' IDENTIFIED BY '[패스워드]'; -- 계정/패스워드
	
--데이터베이스 생성
create database [DB명];

--아이디권환
grant all privileges on [DB명].* to '[계정]'@'%';
    

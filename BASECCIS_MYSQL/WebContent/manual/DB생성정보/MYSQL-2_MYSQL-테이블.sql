###################################################
#  DDL for Table T_USER
###################################################

  CREATE TABLE T_USER 
   (	
   	USERID VARCHAR(64) NOT NULL 			COMMENT '회원아이디', 
	PASSWORD TEXT(255) NOT NULL 			COMMENT '비밀번호', 
	CERTIFICATION VARCHAR(8) DEFAULT '-' 	COMMENT '인증구분', 
	KEY1 VARCHAR(32) DEFAULT '-' 		 	COMMENT '인증키1', 
	KEY2 VARCHAR(32) DEFAULT '-' 			COMMENT '인증키2', 
	KEY3 VARCHAR(32) DEFAULT '-' 			COMMENT '인증키3', 
	DKEY VARCHAR(255) DEFAULT '-' 			COMMENT '고유키', 
	KNAME VARCHAR(96) NOT NULL 				COMMENT '한글명', 
	KIND VARCHAR(8) NOT NULL 				COMMENT '회원구분', 
	PASSWORDTIME DATETIME 					COMMENT '비밀번호변경시각', 
	WITHDRAWTIME DATETIME 					COMMENT '회원탈퇴갱신시각', 
	JOINSITEID VARCHAR(32) 					COMMENT '가입사이트ID', 
	JOINDATE VARCHAR(8) 					COMMENT '가입일', 
	OUTDATE VARCHAR(8) 						COMMENT '탈퇴일', 
	MAILCERTIYN VARCHAR(8) NOT NULL DEFAULT 'N' COMMENT '메일인증유무', 
	SENDYN VARCHAR(3) 						COMMENT '발송유무', 
	LOGINFAILCOUNT INT DEFAULT 0 			COMMENT '로그인실패카운트',
	STATE VARCHAR(8) NOT NULL 				COMMENT '상태관리', 
	INSUSERID VARCHAR(64) NOT NULL			COMMENT '생성자ID', 
	INSIP VARCHAR(64) NOT NULL 				COMMENT '생성자IP', 
	INSTIME DATETIME NOT NULL 				COMMENT '생성시각', 
	DMLUSERID VARCHAR(64) NOT NULL 			COMMENT '처리자ID', 
	DMLIP VARCHAR(64) NOT NULL 				COMMENT '처리자IP', 
	DMLTIME DATETIME NOT NULL 				COMMENT '처리시각', 
	DMLLOG VARCHAR(255) 					COMMENT '처리로그',
    CONSTRAINT PKT_USER PRIMARY KEY (USERID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_USER COMMENT = '회원기본정보';
   
   CREATE INDEX INDEXT_USER ON T_USER (USERID);   
  
###################################################
#  DDL for Table T_PERSONUSER
###################################################

  CREATE TABLE T_PERSONUSER 
   (	
   	USERID VARCHAR(64) NOT NULL          COMMENT '회원ID',   
	MAILING VARCHAR(8) NOT NULL          COMMENT '메일수신구분',    
	CELLPHONE VARCHAR(16)                COMMENT '휴대폰번호',  
	HOMEPHONE VARCHAR(16)                COMMENT '전화번호',   
	BIRTHDATE VARCHAR(8)                 COMMENT '생년월일',   
	SOLARYN VARCHAR(8)                   COMMENT '양력유무',   
	GENDER VARCHAR(8)                    COMMENT '성별',     
	HOMEZIPCODE VARCHAR(8)               COMMENT '우편번호',   
	HOMEADDRESS1 VARCHAR(96)             COMMENT '기본주소',   
	HOMEADDRESS2 VARCHAR(192)            COMMENT '상세주소',   
	STATE VARCHAR(8) NOT NULL            COMMENT '상태관리',   
	INSUSERID VARCHAR(64) NOT NULL       COMMENT '생성자ID',  
	INSIP VARCHAR(64) NOT NULL           COMMENT '생성자IP',  
	INSTIME DATETIME  NOT NULL           COMMENT '생성시각',   
	DMLUSERID VARCHAR(64) NOT NULL       COMMENT '처리자ID',  
	DMLIP VARCHAR(64) NOT NULL           COMMENT '처리자IP',  
	DMLTIME DATETIME NOT NULL            COMMENT '처리시각',   
	DMLLOG VARCHAR(255) DEFAULT '-'		 COMMENT '처리로그',
	CONSTRAINT PKT_PERSONUSER PRIMARY KEY (USERID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_PERSONUSER COMMENT = '개인회원';
   
   CREATE INDEX INDEXT_PERSONUSER ON T_PERSONUSER (USERID);
   
   ALTER TABLE T_PERSONUSER ADD CONSTRAINT FKT_PERSONUSER_T_USER FOREIGN KEY (USERID)
   REFERENCES T_USER (USERID);

###################################################
#  DDL for Table T_COMPANYUSER
###################################################

  CREATE TABLE T_COMPANYUSER 
   (	
    USERID VARCHAR(64) NOT NULL              COMMENT  '회원ID',       
	CORPREGNO VARCHAR(16) NOT NULL           COMMENT  '사업자등록번호',   
	CORPTYPE VARCHAR(8)                      COMMENT  '사업자유형',      
	CEONAME VARCHAR(64) NOT NULL             COMMENT  '대표자성명',       
	BUSINESS VARCHAR(64)                     COMMENT  '업종',         
	BUSINESSDESC TEXT                		 COMMENT  '주요사업내용',      
	CHARGENAME VARCHAR(64)                   COMMENT  '담당자성명',     
	CHARGEEMAIL VARCHAR(64)                  COMMENT  '담당자Email',  
	CHARGEPHONE VARCHAR(16)                  COMMENT  '담당자전화번호',   
	CHARGECELLPHONE VARCHAR(16)              COMMENT  '담당자휴대폰번호',  
	CHARGEDEPTNAME VARCHAR(64)               COMMENT  '담당자부서명',    
	MAILING VARCHAR(8) NOT NULL              COMMENT  '메일링',        
	MAILRECEIVE VARCHAR(16) NOT NULL         COMMENT  '메일수신구분',    
	INTEREST VARCHAR(64) NOT NULL            COMMENT  '관심분야',       
	CORPPHONE VARCHAR(16)                    COMMENT  '기업전화번호',    
	CORPFAX VARCHAR(16)                      COMMENT  '기업팩스번호',     
	HOMEPAGE VARCHAR(128)                    COMMENT  '기업홈페이지',     
	CORPZIPCODE VARCHAR(8)                   COMMENT  '기업우편번호',    
	CORPADDRESS1 VARCHAR(96)                 COMMENT  '기업기본주소',    
	CORPADDRESS2 VARCHAR(192)                COMMENT  '기업상세주소',    
	STATE VARCHAR(8) NOT NULL                COMMENT  '상태관리',        
	INSUSERID VARCHAR(64) NOT NULL           COMMENT  '생성자ID',     
	INSIP VARCHAR(64) NOT NULL               COMMENT  '생성자IP',       
	INSTIME DATETIME NOT NULL                COMMENT  '생성시각',       
	DMLUSERID VARCHAR(64) NOT NULL           COMMENT  '처리자ID',     
	DMLIP VARCHAR(64) NOT NULL               COMMENT  '처리자IP',       
	DMLTIME DATETIME NOT NULL                COMMENT  '처리시각',       
	DMLLOG VARCHAR(255) DEFAULT '-'		 	 COMMENT  '처리로그',     
	CONSTRAINT PKT_COMPANYUSER PRIMARY KEY (USERID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_COMPANYUSER  COMMENT = '기업회원';
   ALTER TABLE T_COMPANYUSER ADD CONSTRAINT FKT_COMPANYUSER_T_USER FOREIGN KEY (USERID) REFERENCES T_USER (USERID);
	  
###################################################
#  DDL for Table T_SITE
###################################################

  CREATE TABLE T_SITE 
   (	
   	SITEID VARCHAR(32) NOT NULL      	COMMENT  '사이트ID',
	KNAME VARCHAR(96) NOT NULL          COMMENT  '한글명',
	KDESC TEXT NOT NULL                 COMMENT  '한글내용',
	URL TEXT NOT NULL                   COMMENT  '사이트URL',
	IP VARCHAR(64) NOT NULL             COMMENT  '사이트IP',
	SOURCEPATH VARCHAR(128) NOT NULL    COMMENT  '소스경로',
	SITETYPE VARCHAR(8) NOT NULL        COMMENT  '사이트유형',
	SITELANGUAGE VARCHAR(8) NOT NULL    COMMENT  '사이트언어',
	SITEKEY VARCHAR(16) DEFAULT '-'     COMMENT  '사이트구분값',
	STARTTIME DATETIME NOT NULL         COMMENT  '유효시작시각',
	ENDTIME DATETIME NOT NULL           COMMENT  '유효종료시각',
	STATE VARCHAR(8) NOT NULL           COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL      COMMENT  '생성자ID',
	INSIP VARCHAR(64) NOT NULL          COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL           COMMENT  '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL      COMMENT  '처리자ID',
	DMLIP VARCHAR(64) NOT NULL          COMMENT  '처리자IP',
	DMLTIME DATETIME NOT NULL           COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'		COMMENT  '처리로그',
	CONSTRAINT PKT_SITE PRIMARY KEY (SITEID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_SITE COMMENT = '사이트';

###################################################
#  DDL for Table T_MENU
###################################################

  CREATE TABLE T_MENU 
   (	
   	MENUID VARCHAR(32) NOT NULL              	COMMENT  '메뉴ID',
	SITEID VARCHAR(32) NOT NULL                 COMMENT  '사이트ID',
	KNAME VARCHAR(96) NOT NULL                  COMMENT  '한글명',
	KDESC TEXT                                  COMMENT  '한글내용',
	DEPTH INT (8) NOT NULL                      COMMENT  '단계',
	SORT INT (8) NOT NULL                       COMMENT  '순서',
	HIGHERID VARCHAR(32) NOT NULL               COMMENT  '상위ID',
	IMAGEPATH VARCHAR(128) DEFAULT '-'          COMMENT  '그림파일경로',
	IMAGEFILE VARCHAR(96) DEFAULT '-'           COMMENT  '그림파일명',
	PROGRAMURL VARCHAR(255) DEFAULT '-'         COMMENT  '프로그램URL',
	CHARGEUSERID VARCHAR(64) NOT NULL           COMMENT  '담당자ID',
	TABYN VARCHAR(8) NOT NULL                   COMMENT  '탭여부',
	USERGRADEYN VARCHAR(8) NOT NULL             COMMENT  '고객만족도여부',
	DISPLAYYN VARCHAR(8) DEFAULT 'Y' NOT NULL   COMMENT  '메뉴표출여부', 
	MENUTYPE VARCHAR(8) NOT NULL                COMMENT  '메뉴유형',
	IMGKIND VARCHAR(64) 						COMMENT  '메뉴아이콘명',
	MENUKIND VARCHAR(32)						COMMENT  '메뉴구분',
	NEWMENUYN VARCHAR(8)						COMMENT  '신규메뉴표시여부',
	STARTTIME DATETIME NOT NULL                 COMMENT  '유효시작시각',
	ENDTIME DATETIME NOT NULL                   COMMENT  '유효종료시각',
	STATE VARCHAR(8) NOT NULL                   COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL              COMMENT  '생성자ID',
	INSIP VARCHAR(64) NOT NULL                  COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL                   COMMENT  '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL              COMMENT  '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                  COMMENT  '처리자IP',
	DMLTIME DATETIME NOT NULL                   COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'             COMMENT  '처리로그',
	CONSTRAINT PKT_MENU PRIMARY KEY (MENUID)
   )ENGINE=InnoDB;

   ALTER TABLE T_MENU COMMENT = '사이트메뉴';
   
   ALTER TABLE T_MENU ADD CONSTRAINT FKT_MENU_T_SITE FOREIGN KEY (SITEID)
   REFERENCES T_SITE (SITEID);
 
###################################################
#  DDL for Table T_CODE
###################################################

  CREATE TABLE T_CODE 
   (	
   	CODE VARCHAR(32)                NOT NULL   COMMENT   '코드',
	CODE2 VARCHAR(32)                 		   COMMENT   '코드2',
	HIGHERCODE VARCHAR(32)          NOT NULL   COMMENT   '상위코드',
	SITEID VARCHAR(32)              NOT NULL   COMMENT   '사이트ID',
	KNAME VARCHAR(96)               NOT NULL   COMMENT   '한글명',
	ENAME VARCHAR(128)              NOT NULL   COMMENT   '영문명',
	DEPTH INT                    	NOT NULL   COMMENT   '단계',
	SORT INT                    	NOT NULL   COMMENT   '순서',
	STATE VARCHAR(8)                NOT NULL   COMMENT   '상태관리',
	INSUSERID VARCHAR(64)           NOT NULL   COMMENT   '생성자ID',
	INSIP VARCHAR(64)               NOT NULL   COMMENT   '생성자IP',
	INSTIME DATETIME                NOT NULL   COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)           NOT NULL   COMMENT   '처리자ID',
	DMLIP VARCHAR(64)               NOT NULL   COMMENT   '처리자IP',
	DMLTIME DATETIME                NOT NULL   COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'   COMMENT   '처리로그', 
	CONSTRAINT PKT_CODE PRIMARY KEY (CODE, HIGHERCODE, SITEID)
   )ENGINE=InnoDB; 
   
   ALTER TABLE T_CODE COMMENT = '코드';


###################################################
#  DDL for Table T_ROLE
###################################################

  CREATE TABLE T_ROLE 
   (
   	ROLEID INT NOT NULL           	 COMMENT   '권한ID', 
	MENUID VARCHAR(32) NOT NULL      COMMENT   '메뉴ID', 
	KNAME VARCHAR(96) NOT NULL       COMMENT   '한글명',   
	ROLETYPE VARCHAR(32) NOT NULL    COMMENT   '기능유형', 
	STATE VARCHAR(8) NOT NULL        COMMENT   '상태관리',  
	INSUSERID VARCHAR(64) NOT NULL   COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL       COMMENT   '생성자IP', 
	INSTIME DATETIME NOT NULL        COMMENT   '생성시각', 
	DMLUSERID VARCHAR(64) NOT NULL   COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL       COMMENT   '처리자IP', 
	DMLTIME DATETIME NOT NULL        COMMENT   '처리시각', 
	DMLLOG VARCHAR(255) DEFAULT '-'  COMMENT   '처리로그', 
	CONSTRAINT PKT_ROLE PRIMARY KEY (ROLEID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_ROLE COMMENT = '권한정의';
     ALTER TABLE T_ROLE ADD CONSTRAINT FKT_ROLE_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;

###################################################
#  DDL for Table T_GROUP
###################################################

  CREATE TABLE T_GROUP 
   (	
   	GROUPID VARCHAR(32) NOT NULL           COMMENT  '그룹ID',  
	KNAME VARCHAR(96) NOT NULL             COMMENT  '한글명',   
	KDESC TEXT                             COMMENT  '한글내용',  
	GROUPTYPE VARCHAR(32) NOT NULL         COMMENT  '그룹유형', 
	DEPTH INT NOT NULL                     COMMENT  '단계',    
	HIGHERID VARCHAR(32) NOT NULL          COMMENT  '상위ID', 
	SORT INT NOT NULL                      COMMENT  '순서',     
	STATE VARCHAR(8) NOT NULL              COMMENT  '상태관리',  
	INSUSERID VARCHAR(64) NOT NULL         COMMENT  '생성자ID',
	INSIP VARCHAR(64) NOT NULL             COMMENT  '생성자IP', 
	INSTIME DATETIME NOT NULL              COMMENT  '생성시각',  
	DMLUSERID VARCHAR(64) NOT NULL         COMMENT  '처리자ID',
	DMLIP VARCHAR(64) NOT NULL             COMMENT  '처리자IP', 
	DMLTIME DATETIME NOT NULL              COMMENT  '처리시각',  
	DMLLOG VARCHAR(255) DEFAULT '-'        COMMENT  '처리로그',
	CONSTRAINT PKT_GROUP PRIMARY KEY (GROUPID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_GROUP COMMENT = '그룹정의';

###################################################
#  DDL for Table T_GROUPROLE
###################################################

  CREATE TABLE T_GROUPROLE 
   (	
   	GROUPID VARCHAR(32)    NOT NULL            COMMENT  '그룹ID',
	ROLEID INT       NOT NULL                  COMMENT  '권한ID',
	STATE VARCHAR(8)        NOT NULL           COMMENT  '상태관리',
	INSUSERID VARCHAR(64)  NOT NULL            COMMENT  '생성자ID',
	INSIP VARCHAR(64)      NOT NULL            COMMENT  '생성자IP',
	INSTIME DATETIME             NOT NULL      COMMENT  '생성시각',
	DMLUSERID VARCHAR(64)      NOT NULL        COMMENT  '처리자ID',
	DMLIP VARCHAR(64)         NOT NULL         COMMENT  '처리자IP',
	DMLTIME DATETIME          NOT NULL         COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'   		   COMMENT  '처리로그',
	CONSTRAINT PKT_GROUPROLE PRIMARY KEY (GROUPID, ROLEID)
   )ENGINE=InnoDB;
 
	ALTER TABLE T_GROUPROLE COMMENT = '그룹권한';
	
	ALTER TABLE T_GROUPROLE ADD CONSTRAINT FKT_GROUPROLE_T_GROUP FOREIGN KEY (GROUPID)
	  REFERENCES T_GROUP (GROUPID);
 
  	ALTER TABLE T_GROUPROLE ADD CONSTRAINT FKT_GROUPROLE_T_ROLE FOREIGN KEY (ROLEID)
	  REFERENCES T_ROLE (ROLEID);

###################################################
#  DDL for Table T_USERGROUP
###################################################

  CREATE TABLE T_USERGROUP 
   (	
   	USERID VARCHAR(64)          NOT NULL 	COMMENT '회원ID', 
	GROUPID VARCHAR(32)         NOT NULL    COMMENT '그룹ID', 
	STATE VARCHAR(8)            NOT NULL 	COMMENT '상태관리',  
	INSUSERID VARCHAR(64)       NOT NULL    COMMENT '생성자ID',
	INSIP VARCHAR(64)           NOT NULL    COMMENT '생성자IP', 
	INSTIME DATETIME            NOT NULL    COMMENT '생성시각', 
	DMLUSERID VARCHAR(64)       NOT NULL    COMMENT '처리자ID',
	DMLIP VARCHAR(64)           NOT NULL    COMMENT '처리자IP', 
	DMLTIME DATETIME            NOT NULL    COMMENT '처리시각',  
	DMLLOG VARCHAR(255) DEFAULT '-'			COMMENT '처리로그',
	CONSTRAINT PKT_USERGROUP PRIMARY KEY (USERID, GROUPID)
   )ENGINE=InnoDB;
 	
   ALTER TABLE T_USERGROUP COMMENT = '회원그룹정보';

  ALTER TABLE T_USERGROUP ADD CONSTRAINT FKT_USERGROUP_T_GROUP FOREIGN KEY (GROUPID)
	  REFERENCES T_GROUP (GROUPID) ;
 
  ALTER TABLE T_USERGROUP ADD CONSTRAINT FKT_USERGROUP_T_USER FOREIGN KEY (USERID)
	  REFERENCES T_USER (USERID) ;

###################################################
#  DDL for Table T_LOG
###################################################

  CREATE TABLE T_LOG 
   (	
   	NO INT NOT NULL                        COMMENT   '로그번호',
	DBNAME VARCHAR(32)                     COMMENT   'DB명',
	CURRENTSCHEMA VARCHAR(32)              COMMENT   'DB접속계정',
	SESSIONID VARCHAR(32)                  COMMENT   '세션ID',
	OBJECTTYPE VARCHAR(32)                 COMMENT   '객체형태',
	OBJECTNAME VARCHAR(128) NOT NULL       COMMENT   '객체이름',
	OBJECTCOMMENT VARCHAR(128)             COMMENT   '객체설명',
	VERSION INT                            COMMENT   '버젼',
	COMPILETIME DATETIME                   COMMENT   '컴파일시각',
	STARTTIME DATETIME                     COMMENT   '유효시작시각',
	ENDTIME DATETIME                       COMMENT   '유효종료시각',
	SQLCODE INT                            COMMENT   'SQL코드',
	SQLERRM VARCHAR(255)                   COMMENT   'SQL에러메세지',
	RESULT VARCHAR(16)                     COMMENT   '성공유무',
	ROWCOUNT INT                           COMMENT   '실행횟수',
	EXECMENUID VARCHAR(32)                 COMMENT   '실행메뉴ID',
	BEFOREDATA TEXT                        COMMENT   '처리전데이터',
	AFTERDATA TEXT                         COMMENT   '처리후데이터',
	NOTICE VARCHAR(255)                    COMMENT   '결과상세내용',
	TERMINAL VARCHAR(32)                   COMMENT   '접속터미널명',
	OSUSER VARCHAR(32)                     COMMENT   '터미널유저',
	MODULE VARCHAR(32)                     COMMENT   '접속모듈',
	DMLUSERID VARCHAR(64) NOT NULL         COMMENT   '처리자ID',
	DMLIP VARCHAR(16) NOT NULL             COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL              COMMENT   '처리시각',
	CONSTRAINT PKT_LOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_LOG COMMENT = '로그관리';

   
###################################################
#  DDL for Table T_CHANGELOG
###################################################

  CREATE TABLE T_CHANGELOG 
   (	
   	NO INT NOT NULL                  COMMENT   '로그번호',
	DBNAME VARCHAR(32)               COMMENT   'DB명',
	CURRENTSCHEMA VARCHAR(32)        COMMENT   'DB접속계정',
	SESSIONID VARCHAR(32)            COMMENT   '세션ID',
	OBJECTTYPE VARCHAR(32)           COMMENT   '객체형태',
	OBJECTNAME VARCHAR(128)          COMMENT   '객체이름',
	OBJECTCOMMENT VARCHAR(128)       COMMENT   '객체설명',
	STARTTIME DATETIME               COMMENT   '유효시작시각',
	ENDTIME DATETIME                 COMMENT   '유효종료시각',
	EXECMENUID VARCHAR(32)           COMMENT   '실행메뉴ID',
	DMLTYPE VARCHAR(8)               COMMENT   'DML유형',
	BEFOREDATA TEXT                  COMMENT   '처리전데이터',
	AFTERDATA TEXT                   COMMENT   '처리후데이터',
	NOTICE VARCHAR(255)              COMMENT   '결과상세내용',
	DMLUSERID VARCHAR(64) NOT NULL   COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL       COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL        COMMENT   '처리시각',
	CONSTRAINT PKT_CHANGELOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;
 
	ALTER TABLE T_CHANGELOG COMMENT = '변경로그관리';
   

###################################################
#  DDL for Table T_CONNECTLOG
###################################################

  CREATE TABLE T_CONNECTLOG 
   (
   	NO INT              NOT NULL    COMMENT '로그번호',
	USERID VARCHAR(64)     			COMMENT '회원ID',
	SITEID VARCHAR(32)      		COMMENT '사이트ID',
	MENUID VARCHAR(32)       		COMMENT '메뉴ID',
	CONNECTTIME DATETIME    		COMMENT '접속시간',
	MODULE VARCHAR(255)    			COMMENT '접속기기',
	TERMINAL VARCHAR(32)   			COMMENT '접속OS',
	DMLUSERID VARCHAR(64)  NOT NULL COMMENT '수정자ID',
	DMLIP VARCHAR(64)      NOT NULL COMMENT '수정자IP',
	DMLTIME DATETIME       NOT NULL COMMENT '수정시간',
	CONSTRAINT PKT_CONNECTLOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;

   ALTER TABLE T_CONNECTLOG COMMENT = '접속기록로그';

###################################################
#  DDL for Table T_SITEMENUHITLOG
###################################################

  CREATE TABLE T_SITEMENUHITLOG 
   (	
   	NO INT NOT NULL                   COMMENT   '로그번호',
	HITDATE VARCHAR(8)                COMMENT   '게시물조회일',
	SITEID VARCHAR(32)                COMMENT   'SITEID',
	MENUID VARCHAR(32)                COMMENT   'MENUID',
	HITCOUNT INT                      COMMENT   '조회수',
	DMLUSERID VARCHAR(64) NOT NULL    COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL        COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL         COMMENT   '처리시각',
	CONSTRAINT PKT_SITEMENUHITLOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;
	
   ALTER TABLE T_SITEMENUHITLOG COMMENT = '일별게시물조회수관리';

   ###################################################
#  DDL for Table T_USERLOGINOUTLOG
###################################################

  CREATE TABLE T_USERLOGINOUTLOG 
   (	
   	NO INT NOT NULL                  COMMENT   '로그번호',
	USERID VARCHAR(64)               COMMENT   '사용자 ID',
	LOGINTIME DATETIME               COMMENT   '로그인 시간',
	LOGOUTTIME DATETIME              COMMENT   '로그아웃시간',
	GUBUN VARCHAR(8)                 COMMENT   '모듈 구분',
	BROWSER VARCHAR(8)               COMMENT   '브라우저 구분',
	STATE VARCHAR(1) NOT NULL        COMMENT   '로그인 상태',
	USUALYN VARCHAR(1)               COMMENT   '로그아웃 정상여부',
	REASON TEXT                      COMMENT   '비정상로그아웃 사유',
	DMLUSERID VARCHAR(64) NOT NULL   COMMENT   '처리자ID',  
	DMLIP VARCHAR(64) NOT NULL       COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL        COMMENT   '처리시각',
	CONSTRAINT PKT_USERLOGINOUTLOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;
   
	ALTER TABLE T_USERLOGINOUTLOG COMMENT = '로그인로그아웃관리';

###################################################
#  DDL for Table T_TRANS
###################################################

  CREATE TABLE T_TRANS 
   (	
   	TRANSID INT NOT NULL                          COMMENT '이관ID',
	MENUID VARCHAR(32) NOT NULL                   COMMENT  '메뉴ID',
	TARGETMENUID VARCHAR(32) NOT NULL             COMMENT   '타겟메뉴ID',
	STATE VARCHAR(8) NOT NULL                     COMMENT '상태관리',
	INSUSERID VARCHAR(64) NOT NULL                COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL                    COMMENT '생성자IP',
	INSTIME DATETIME NOT NULL                     COMMENT  '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL                COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                    COMMENT '처리자IP',
	DMLTIME DATETIME NOT NULL                     COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'               COMMENT  '처리로그',
	CONSTRAINT PKT_TRANS PRIMARY KEY (TRANSID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_USERLOGINOUTLOG COMMENT = '메뉴이관';
   
   ALTER TABLE T_TRANS ADD CONSTRAINT FKT_TRANS_T_MENU FOREIGN KEY (MENUID)
   REFERENCES T_MENU (MENUID);

###################################################
#  DDL for Table T_BOARD
###################################################

  CREATE TABLE T_BOARD 
   (	
   	BOARDID VARCHAR(32) NOT NULL           COMMENT  '게시판관리ID',         
	MENUID VARCHAR(32) NOT NULL            COMMENT  '메뉴ID',            
	KNAME VARCHAR(96) NOT NULL             COMMENT  '한글명',              
	KDESC TEXT                             COMMENT  '한글내용',             
	BOARDKIND VARCHAR(16) NOT NULL         COMMENT  '게시판유형',          
	PAGECOUNT INT                          COMMENT  '페이지당게시글목록수',     
	COMMENTYN VARCHAR(8) NOT NULL          COMMENT  '댓글허용유무',         
	NOTICEYN VARCHAR(8) NOT NULL           COMMENT  '공지글허용유무',         
	SECRETYN VARCHAR(8) NOT NULL           COMMENT  '비밀글허용여부',         
	CATEGORYYN VARCHAR(8) NOT NULL         COMMENT  '카테코리허용여부',       
	EVENTYN VARCHAR(8)                     COMMENT  '이벤트혀용여부',         
	IMAGEYN VARCHAR(8)                     COMMENT  '이미지표출여부_공지형',     
	FILEMAXCOUNT INT NOT NULL              COMMENT  '첨부파일최대갯수',       
	FILEMAXSIZE INT NOT NULL               COMMENT  '첨부파일최대사이즈',      
	STARTTIME DATETIME NOT NULL            COMMENT  '유효시작시각',         
	ENDTIME DATETIME NOT NULL              COMMENT  '유효종료시각',          
	ADDFIELD1 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명1',         
	ADDFIELD2 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명2',         
	ADDFIELD3 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명3',         
	ADDFIELD4 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명4',         
	ADDFIELD5 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명5',         
	ADDFIELD6 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명6',         
	ADDFIELD7 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명6',         
	ADDFIELD8 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명6',         
	ADDFIELD9 VARCHAR(32) DEFAULT '-'      COMMENT  '추가필드명6',         
	ADDFIELD10 VARCHAR(32) DEFAULT '-'     COMMENT  '추가필드명6',  
	ADDFIELDKHTML1 VARCHAR(32) DEFAULT '-' COMMENT  '추가내용필드명1', 
	ADDFIELDKHTML2 VARCHAR(32) DEFAULT '-' COMMENT  '추가내용필드명2',
	RSSYN VARCHAR(8)                       COMMENT  'RSS허용유무',          
	BOARDLISTKIND VARCHAR(16)              COMMENT  '게시판리스트유형',       
	COUNTRYYN VARCHAR(8)                   COMMENT  '국가허용여부',         
	SNSYN VARCHAR(8)                       COMMENT  'SNS허용여부',          
	NEWYN VARCHAR(8)                       COMMENT  'NET허용여부',          
	BOARDHEADERKHTML TEXT                  COMMENT  '컨텐츠HEAD',        
	BOARDFOOTERKHTML TEXT                  COMMENT  '컨텐츠FOOTER',
	APPYN VARCHAR(8)                       COMMENT  '승인허용유무', 
	CUSTOMIZINGYN VARCHAR(8)               COMMENT  '게시판목록동적생성', 
	STATE VARCHAR(8) NOT NULL              COMMENT  '상태관리',             
	INSUSERID VARCHAR(64) NOT NULL         COMMENT  '생성자ID',          
	INSIP VARCHAR(64) NOT NULL             COMMENT  '생성자IP',            
	INSTIME DATETIME NOT NULL              COMMENT  '생성시각',            
	DMLUSERID VARCHAR(64) NOT NULL         COMMENT  '처리자ID',          
	DMLIP VARCHAR(64) NOT NULL             COMMENT  '처리자IP',            
	DMLTIME DATETIME NOT NULL              COMMENT  '처리시각',            
	DMLLOG VARCHAR(255) DEFAULT '-'        COMMENT  '처리로그',            
	CONSTRAINT PKT_BOARD PRIMARY KEY (BOARDID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_BOARD COMMENT = '게시판관리';
 
  ALTER TABLE T_BOARD ADD CONSTRAINT FKT_BOARD_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;

###################################################
#  DDL for Table T_BOARDREFERENCE
###################################################

  CREATE TABLE T_BOARDREFERENCE 
   (	
   	BOARDID VARCHAR(32) NOT NULL        COMMENT  '게시판ID',
	MENUID VARCHAR(32) NOT NULL         COMMENT  '메뉴ID',
	SEARCHCODE1 VARCHAR(32) NOT NULL    COMMENT  '검색체계코드1',
	SEARCHCODE2 VARCHAR(32) NOT NULL    COMMENT  '검색체계코드2',
	STATE VARCHAR(8) NOT NULL           COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL      COMMENT  '생성자ID',
	INSIP VARCHAR(64) NOT NULL          COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL           COMMENT  '생성시각',
	DMLUSERID VARCHAR(64)NOT NULL       COMMENT  '처리자ID',
	DMLIP VARCHAR(64) NOT NULL          COMMENT  '처리자IP',
	DMLTIME DATETIME NOT NULL           COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'     COMMENT  '처리로그',
	CONSTRAINT PKT_BOARDREFERENCE PRIMARY KEY (BOARDID, MENUID, SEARCHCODE1, SEARCHCODE2)
   )ENGINE=InnoDB;

     ALTER TABLE T_BOARDREFERENCE COMMENT = '참조형게시판정보';
     
       ALTER TABLE T_BOARDREFERENCE ADD CONSTRAINT FKT_BOARDREFERENCE_T_BOARD FOREIGN KEY (BOARDID)
	  REFERENCES T_BOARD (BOARDID) ;
	  
  ALTER TABLE T_BOARDREFERENCE ADD CONSTRAINT FKT_BOARDREFERENCE_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;
	  
###################################################
#  DDL for Table T_DBOARDLIST
###################################################

  CREATE TABLE T_DBOARDLIST 
   (	
   	BOARDID VARCHAR(32) NOT NULL,
	INFO VARCHAR(512) NOT NULL,
	SORT VARCHAR(32) NOT NULL
   )ENGINE=InnoDB;

     ALTER TABLE T_DBOARDLIST COMMENT = '게시판목록형태항목목록';

###################################################
#  DDL for Table T_CATEGORY
###################################################

  CREATE TABLE T_CATEGORY 
   (	
   	BOARDID VARCHAR(32)  NOT NULL     	 COMMENT   '게시판관리ID',
	CATEGORYID VARCHAR(8) NOT NULL       COMMENT   '카테고리ID',
	CATEGORYNAME VARCHAR(64) NOT NULL    COMMENT   '카테고리명',
	STATE VARCHAR(8) NOT NULL            COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL       COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL           COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL       COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL           COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL            COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'      COMMENT   '처리로그',
	CONSTRAINT PKT_CATEGORY PRIMARY KEY (BOARDID, CATEGORYID)
   )ENGINE=InnoDB;

   ALTER TABLE T_CATEGORY COMMENT = '카테고리관리';
   
     ALTER TABLE T_CATEGORY ADD CONSTRAINT FKT_CATEGORY_T_BOARD FOREIGN KEY (BOARDID)
	  REFERENCES T_BOARD (BOARDID);


###################################################
#  DDL for Table T_TITLE
###################################################

  CREATE TABLE T_TITLE 
   (	
   TITLEID INT                          NOT NULL     COMMENT   '게시물ID',
	MENUID VARCHAR(32)                  NOT NULL     COMMENT   '메뉴ID',
	BOARDID VARCHAR(32)               	NOT NULL     COMMENT   '게시판관리ID',
	KNAME TEXT                          NOT NULL     COMMENT   '한글명',
	USERID VARCHAR(64)           		NOT NULL     COMMENT   '회원ID',
	USERNAME VARCHAR(64) DEFAULT '-'        		 COMMENT   '회원성명',
	HITCOUNT INT                      NOT NULL       COMMENT   '조회수',
	UPCOUNT INT                       NOT NULL       COMMENT   '추천수',
	OPENYN VARCHAR(8)                 NOT NULL       COMMENT   '게시물공개여부',
	PROCESS VARCHAR(8)                NOT NULL       COMMENT   '처리상황',
	NOTICETITLEYN VARCHAR(8)         NOT NULL        COMMENT   '공지글유무',
	SECRETTITLEYN VARCHAR(8)   NOT NULL DEFAULT 'N'  COMMENT   '비밀글유무',
	CREATETIME DATETIME              NOT NULL     	 COMMENT   '최초작성시각',
	STARTTIME DATETIME               NOT NULL        COMMENT   '유효시작시각',
	ENDTIME DATETIME                      NOT NULL   COMMENT   '유효종료시각',
	KEYWORD1 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드1',
	KEYWORD2 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드2',
	KEYWORD3 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드3',
	KEYWORD4 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드4',
	KEYWORD5 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드5',
	KEYWORD6 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드6',
	KEYWORD7 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드7',
	KEYWORD8 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드8',
	KEYWORD9 VARCHAR(128) DEFAULT '-'                COMMENT   '키워드9',
	KEYWORD10 VARCHAR(128) DEFAULT '-'               COMMENT   '키워드10',
	CONTENTS1 TEXT                                   COMMENT   '추가콘텐츠1',
	CONTENTS2 TEXT                                   COMMENT   '추가콘텐츠2',
	CONTENTS3 TEXT                                   COMMENT   '추가콘텐츠3',
	CONTENTS4 DATETIME                               COMMENT   '추가콘텐츠4',
	CONTENTS5 DATETIME                               COMMENT   '추가콘텐츠5',
	CONTENTS6 DATETIME                               COMMENT   '추가콘텐츠6',
	CONTENTS7 TEXT                                   COMMENT   '추가콘텐츠7',
	CONTENTS8 TEXT                                   COMMENT   '추가콘텐츠8',
	CONTENTS9 TEXT                                   COMMENT   '추가콘텐츠9',
	CONTENTS10 TEXT                                  COMMENT   '추가콘텐츠10',
	LINKURL TEXT                					 COMMENT   '링크URL',
	CATEGORYID VARCHAR(8) DEFAULT '-'      			 COMMENT   '카테고리ID',
	ORIGIN VARCHAR(255)                       		 COMMENT   '출처',
	REPORTTIME DATETIME                       		 COMMENT   '보도일',
	CONTINENT VARCHAR(32) 							 COMMENT   '대륙',
	COUNTRY VARCHAR(32) 							 COMMENT   '국가',
	NOTICESTARTTIME DATETIME 						 COMMENT   '공지시작일',
	NOTICEENDTIME DATETIME 							 COMMENT   '공지종료일',
	STATEYN VARCHAR(8)                  NOT NULL     COMMENT   '승인관리',
	STATE VARCHAR(8)                    NOT NULL     COMMENT   '상태관리',
	INSUSERID VARCHAR(64)               NOT NULL     COMMENT   '생성자ID',
	INSIP VARCHAR(64)                   NOT NULL     COMMENT   '생성자IP',
	INSTIME DATETIME                    NOT NULL     COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)               NOT NULL     COMMENT   '처리자ID',
	DMLIP VARCHAR(64)                   NOT NULL     COMMENT   '처리자IP',
	DMLTIME DATETIME                    NOT NULL     COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'         		 COMMENT   '처리로그',
	CONSTRAINT PKT_TITLE PRIMARY KEY (TITLEID)
   )ENGINE=InnoDB;

   ALTER TABLE T_TITLE COMMENT = '게시물';

  ALTER TABLE T_TITLE ADD CONSTRAINT FKT_TITLE_T_BOARD FOREIGN KEY (BOARDID)
	  REFERENCES T_BOARD (BOARDID);
 
  ALTER TABLE T_TITLE ADD CONSTRAINT FKT_TITLE_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID);

###################################################
#  DDL for Table T_LINK
###################################################

  CREATE TABLE T_LINK 
   (	
   	LINKID INT NOT NULL              COMMENT  '링크ID',   
	TITLEID INT NOT NULL             COMMENT  '게시물ID',  
	MENUID VARCHAR(32) NOT NULL      COMMENT  '메뉴ID',   
	DEPTH INT NOT NULL               COMMENT  '단계',      
	HIGHERID INT NOT NULL            COMMENT  '상위ID',   
	PARENTLINKID INT NOT NULL        COMMENT  '원글링크ID',
	REPLYNO INT NOT NULL             COMMENT  '답글순서',   
	CATEGORYID VARCHAR(8) DEFAULT '-' COMMENT '카테고리아이디',
	STATE VARCHAR(8) NOT NULL        COMMENT  '상태관리',    
	INSUSERID VARCHAR(64) NOT NULL   COMMENT  '생성자ID', 
	INSIP VARCHAR(64) NOT NULL       COMMENT  '생성자IP',   
	INSTIME DATETIME NOT NULL        COMMENT  '생성시각',   
	DMLUSERID VARCHAR(64)NOT NULL    COMMENT  '처리자ID', 
	DMLIP VARCHAR(64) NOT NULL       COMMENT  '처리자IP',   
	DMLTIME DATETIME NOT NULL        COMMENT  '처리시각',   
	DMLLOG VARCHAR(255) DEFAULT '-'  COMMENT  '처리로그',   
	CONSTRAINT PKT_LINK PRIMARY KEY (LINKID)
   )ENGINE=InnoDB;
 
 ALTER TABLE T_LINK COMMENT = '게시물링크';

  ALTER TABLE T_LINK ADD CONSTRAINT FKT_LINK_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;
 
  ALTER TABLE T_LINK ADD CONSTRAINT FKT_LINK_T_TITLE FOREIGN KEY (TITLEID)
	  REFERENCES T_TITLE (TITLEID) ;

###################################################
#  DDL for Table T_CONTENTS
###################################################

  CREATE TABLE T_CONTENTS 
   (	
   TITLEID INT NOT NULL                          COMMENT  '게시물ID',        
	CONTENTSID INT NOT NULL                      COMMENT  '본문ID',        
	KTEXT TEXT NOT NULL                          COMMENT  '한글설명',          
	KHTML TEXT                                   COMMENT  '한글본문HTML',      
	KHTML2 TEXT                                  COMMENT  '추가내용2',      
	KHTML3 TEXT                                  COMMENT  '추가내용3',      
	IMAGEFILENAME VARCHAR(255) DEFAULT '-'       COMMENT  '이미지파일명',      
	IMAGESFILENAME VARCHAR(255) DEFAULT '-'      COMMENT  '이미지시스템파일명',   
	FILEPATH TEXT                                COMMENT  '파일경로',         
	ALTINFO VARCHAR(255)                         COMMENT  '알트정보',         
	STATE VARCHAR(8) NOT NULL                    COMMENT  '상태관리',          
	INSUSERID VARCHAR(64) NOT NULL               COMMENT  '생성자ID',       
	INSIP VARCHAR(64) NOT NULL                   COMMENT  '생성자IP',         
	INSTIME DATETIME NOT NULL                    COMMENT  '생성시각',         
	DMLUSERID VARCHAR(64) NOT NULL               COMMENT  '처리자ID',       
	DMLIP VARCHAR(64) NOT NULL                   COMMENT  '처리자IP',         
	DMLTIME DATETIME NOT NULL                    COMMENT  '처리시각',         
	DMLLOG VARCHAR(255) DEFAULT '-'              COMMENT  '처리로그',         
	CONSTRAINT PKT_CONTENTS PRIMARY KEY (TITLEID, CONTENTSID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_CONTENTS COMMENT = '게시물본문';

  ALTER TABLE T_CONTENTS ADD CONSTRAINT FKT_CONTENTS_T_TITLE FOREIGN KEY (TITLEID)
	  REFERENCES T_TITLE (TITLEID) ;

###################################################
#  DDL for Table T_FILES
###################################################

  CREATE TABLE T_FILES 
   (	
   TITLEID INT              NOT NULL    COMMENT    '게시물ID',  
	FILEID INT          NOT NULL        COMMENT   '첨부파일ID',  
	USERFILENAME VARCHAR(255) NOT NULL  COMMENT    '사용자파일명', 
	SYSTEMFILENAME VARCHAR(255) NOT NULL COMMENT    '시스템파일명', 
	FILEPATH TEXT          NOT NULL     COMMENT    '파일경로',   
	FILEEXTENSION VARCHAR(16) NOT NULL  COMMENT    '파일확장자',  
	FILESIZE INT              NOT NULL  COMMENT    '파일크기',   
	ALTINFO VARCHAR(255)        COMMENT    '알트정보',   
	STATE VARCHAR(8)         NOT NULL   COMMENT  '상태관리',     
	INSUSERID VARCHAR(64)  NOT NULL     COMMENT    '생성자ID',  
	INSIP VARCHAR(64)      NOT NULL     COMMENT  '생성자IP',    
	INSTIME DATETIME       NOT NULL    COMMENT    '생성시각',   
	DMLUSERID VARCHAR(64)  NOT NULL     COMMENT    '처리자ID',  
	DMLIP VARCHAR(64)     NOT NULL      COMMENT  '처리자IP',    
	DMLTIME DATETIME       NOT NULL     COMMENT    '처리시각',   
	DMLLOG VARCHAR(255) DEFAULT '-' COMMENT   '처리로그',
	CONSTRAINT PKT_FILES PRIMARY KEY (TITLEID, FILEID)
   )ENGINE=InnoDB;
   
  ALTER TABLE T_FILES COMMENT = '게시물첨부파일';

  ALTER TABLE T_FILES ADD CONSTRAINT FKT_FILES_T_TITLE FOREIGN KEY (TITLEID)
	  REFERENCES T_TITLE (TITLEID) ;	  
	  
###################################################
#  DDL for Table T_VISIT
###################################################

  CREATE TABLE T_VISIT 
   (	
   	SITEID VARCHAR(32) NOT NULL      COMMENT  '사이트ID',
	CDATE VARCHAR(8) NOT NULL        COMMENT '방문일',   
	TOTAL INT NOT NULL               COMMENT '전체방문수', 
	TODAY INT NOT NULL               COMMENT '금일방문수', 
	STATE VARCHAR(8) NOT NULL        COMMENT '상태관리',  
	INSUSERID VARCHAR(64) NOT NULL   COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL       COMMENT '생성자IP', 
	INSTIME DATETIME NOT NULL        COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL   COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL       COMMENT '처리자IP', 
	DMLTIME DATETIME NOT NULL        COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'  COMMENT  '처리로그', 
	CONSTRAINT PKT_VISIT PRIMARY KEY (SITEID, CDATE)
   )ENGINE=InnoDB;
 	
	ALTER TABLE T_VISIT COMMENT = '방문객수';

	ALTER TABLE T_VISIT ADD CONSTRAINT FKT_VISIT_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;
	  
###################################################
#  DDL for Table T_DEPARTMENT
###################################################

  CREATE TABLE T_DEPARTMENT 
   (	
   	DEPTID VARCHAR(32)     NOT NULL            COMMENT   '부서ID',
	DEPTSEQ INT          NOT NULL                 COMMENT    '부서SEQ',
	KNAME VARCHAR(96)     NOT NULL                COMMENT  '한글명',
	HIGHERID VARCHAR(32)     NOT NULL             COMMENT    '상위ID',
	DEPTH INT              NOT NULL               COMMENT  '단계',
	SORT INT              NOT NULL                COMMENT  '순서',
	STATE VARCHAR(8)     NOT NULL                 COMMENT  '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL             COMMENT    '생성자ID',
	INSIP VARCHAR(64)       NOT NULL              COMMENT  '생성자IP',
	INSTIME DATETIME            NOT NULL             COMMENT    '생성시각',
	DMLUSERID VARCHAR(64)    NOT NULL             COMMENT    '처리자ID',
	DMLIP VARCHAR(64)          NOT NULL           COMMENT  '처리자IP',
	DMLTIME DATETIME               NOT NULL           COMMENT    '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'       COMMENT   '처리로그',
	CONSTRAINT PKT_DEPARTMENT PRIMARY KEY (DEPTID, DEPTSEQ)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_DEPARTMENT COMMENT = '부서정의';

###################################################
#  DDL for Table T_DUTY
###################################################

  CREATE TABLE T_DUTY 
   (	
   	DUTYID VARCHAR(32) NOT NULL       COMMENT   '직위ID',
	KNAME VARCHAR(96) NOT NULL          COMMENT  '한글명',
	SORT INT NOT NULL                   COMMENT  '순서',
	STATE VARCHAR(8) NOT NULL           COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL      COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL          COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL           COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL      COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL          COMMENT  '처리자IP',
	DMLTIME DATETIME                    COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'     COMMENT   '처리로그',
	CONSTRAINT PKT_DUTY PRIMARY KEY (DUTYID)
   )ENGINE=InnoDB;
   
ALTER TABLE T_DUTY COMMENT = '직위정의';

###################################################
#  DDL for Table T_POSITION
###################################################

  CREATE TABLE T_POSITION 
   (	
   	POSITIONID VARCHAR(32) NOT NULL               COMMENT    '직급ID',
	KNAME VARCHAR(96) NOT NULL                    COMMENT   '한글명',
	SORT INT NOT NULL                             COMMENT  '순서',
	STATE VARCHAR(8) NOT NULL                     COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL                COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL                    COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL                     COMMENT    '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL                COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                    COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                     COMMENT    '처리시각',
	DMLLOG VARCHAR(255) NOT NULL DEFAULT '-'       COMMENT   '처리로그',
	CONSTRAINT PKT_POSITION PRIMARY KEY (POSITIONID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_POSITION COMMENT = '직급정의';

###################################################
#  DDL for Table T_TEAM
###################################################

  CREATE TABLE T_TEAM 
   (	
   	USERID VARCHAR(64) NOT NULL      COMMENT   '회원ID',
	DEPTID VARCHAR(32) NOT NULL         COMMENT   '부서ID',
	DEPTSEQ INT NOT NULL                COMMENT    '부서SEQ',
	DUTYID VARCHAR(32) NOT NULL         COMMENT   '직위ID',
	POSITIONID VARCHAR(32) NOT NULL     COMMENT    '직급ID',
	PHONE VARCHAR(16) DEFAULT '-'       COMMENT   '전화번호',
	FAX VARCHAR(16) DEFAULT '-'         COMMENT  '팩스번호',
	CHARGEWORK TEXT                     COMMENT    '담당업무',
	SORT INT NOT NULL                   COMMENT   '순서',
	STATE VARCHAR(8) NOT NULL           COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL      COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL          COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL           COMMENT    '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL      COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL          COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL           COMMENT    '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'     COMMENT   '처리로그',
	CONSTRAINT PKT_TEAM PRIMARY KEY (USERID, DEPTID, DEPTSEQ)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_TEAM COMMENT = '조직정보';

  ALTER TABLE T_TEAM ADD CONSTRAINT FKT_TEAM_T_DEPARTMENT FOREIGN KEY (DEPTID, DEPTSEQ)
	  REFERENCES T_DEPARTMENT (DEPTID, DEPTSEQ) ;
 
  ALTER TABLE T_TEAM ADD CONSTRAINT FKT_TEAM_T_DUTY FOREIGN KEY (DUTYID)
	  REFERENCES T_DUTY (DUTYID) ;
 
  ALTER TABLE T_TEAM ADD CONSTRAINT FKT_TEAM_T_POSITION FOREIGN KEY (POSITIONID)
	  REFERENCES T_POSITION (POSITIONID) ;
 
  ALTER TABLE T_TEAM ADD CONSTRAINT FKT_TEAM_T_USER FOREIGN KEY (USERID)
	  REFERENCES T_USER (USERID) ;

###################################################
#  DDL for Table T_BANNER
###################################################

  CREATE TABLE T_BANNER 
   (	
   	BANNERID INT NOT NULL                   COMMENT    '배너ID',
	SITEID VARCHAR(32) NOT NULL                COMMENT   '사이트ID',
	KNAME VARCHAR(128) NOT NULL                COMMENT   '한글명',
	KDESC TEXT NOT NULL                        COMMENT   '한글내용',
	IMAGEFILENAME VARCHAR(128) NOT NULL        COMMENT    '이미지파일명',
	IMAGESFILENAME VARCHAR(128) NOT NULL       COMMENT    '이미지시스템파일명',
	FILEPATH TEXT NOT NULL                     COMMENT    '파일경로',
	LINKURL VARCHAR(255) NOT NULL              COMMENT   '링크URL',
	SORT INT NOT NULL                          COMMENT  '순서',
	STARTTIME DATETIME NOT NULL                COMMENT    '유효시작시각',
	ENDTIME DATETIME NOT NULL                  COMMENT   '유효종료시각',
	NEWWINDOWYN VARCHAR(8) NOT NULL            COMMENT    '새창유무',
	STATE VARCHAR(8) NOT NULL                  COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL             COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL                 COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL                  COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL             COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                 COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                  COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'            COMMENT   '처리로그',
	CONSTRAINT PKT_BANNER PRIMARY KEY (BANNERID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_BANNER COMMENT = '배너관리';

  ALTER TABLE T_BANNER ADD CONSTRAINT FKT_BANNER_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;
	  
###################################################
#  DDL for Table T_BOOKMARK
###################################################

  CREATE TABLE T_BOOKMARK 
   (	
   	USERID VARCHAR(64) NOT NULL        	  COMMENT  '회원ID',
	MENUID VARCHAR(32) NOT NULL           COMMENT  '메뉴ID',
	LINKID INT DEFAULT '-1' NOT NULL      COMMENT  '링크ID',
	URL VARCHAR(255) DEFAULT '-'          COMMENT '비통합플랫폼메뉴URL',
	STATE VARCHAR(8) NOT NULL             COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL        COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL            COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL             COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL        COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL            COMMENT '처리자IP',
	DMLTIME DATETIME NOT NULL             COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'       COMMENT  '처리로그',
	CONSTRAINT PKT_BOOKMARK PRIMARY KEY (USERID, MENUID, LINKID, URL)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_BOOKMARK COMMENT = '북마크';

  ALTER TABLE T_BOOKMARK ADD CONSTRAINT FKT_BOOKMARK_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;
 
  ALTER TABLE T_BOOKMARK ADD CONSTRAINT FKT_BOOKMARK_T_USER FOREIGN KEY (USERID)
	  REFERENCES T_USER (USERID) ;

###################################################
#  DDL for Table T_IMAGEPOOL
###################################################

  CREATE TABLE T_IMAGEPOOL 
   (	
   	IMAGEPOOLID INT NOT NULL              COMMENT    '이미지POOLID',
	KNAME VARCHAR(128) NOT NULL             COMMENT  '한글명',
	KDESC TEXT NOT NULL                     COMMENT  '한글내용',
	IMAGEFILENAME VARCHAR(255) NOT NULL     COMMENT    '사용자파일명',
	IMAGESFILENAME VARCHAR(255) NOT NULL    COMMENT    '시스템파일명',
	FILEPATH TEXT NOT NULL                  COMMENT   '파일경로',
	KEYWORD1 VARCHAR(128) DEFAULT '-'       COMMENT   '키워드1',
	KEYWORD2 VARCHAR(128) DEFAULT '-'       COMMENT   '키워드2',
	KEYWORD3 VARCHAR(1024) DEFAULT '-'      COMMENT   '키워드3',
	KEYWORD4 VARCHAR(128) DEFAULT '-'       COMMENT   '키워드4',
	KEYWORD5 VARCHAR(128) DEFAULT '-'       COMMENT   '키워드5',
	STATE VARCHAR(8) NOT NULL               COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL          COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL              COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL               COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL          COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL              COMMENT  '처리자IP',
	DMLTIME DATETIME NOT NULL               COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'         COMMENT   '처리로그',
	CONSTRAINT PKT_IMAGEPOOL PRIMARY KEY (IMAGEPOOLID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_IMAGEPOOL COMMENT = '이미지POOL정보';

###################################################
#  DDL for Table T_POPUP
###################################################

  CREATE TABLE T_POPUP 
   (	
   	POPUPID INT         NOT NULL               COMMENT    '팝업ID',
	SITEID VARCHAR(32)   NOT NULL              COMMENT    '사이트ID',
	KNAME VARCHAR(128)   NOT NULL              COMMENT    '한글명',
	KDESC TEXT           NOT NULL              COMMENT    '한글내용',
	IMAGEFILENAME VARCHAR(128)  NOT NULL       COMMENT    '이미지파일명',
	IMAGESFILENAME VARCHAR(128)  NOT NULL      COMMENT    '이미지시스템파일명',
	FILEPATH TEXT            NOT NULL          COMMENT    '파일경로',
	LINKURL VARCHAR(255)    NOT NULL           COMMENT    '링크URL',
	SORT INT               NOT NULL            COMMENT    '순서',
	POSITIONX INT        NOT NULL              COMMENT    '팝업위치X',
	POSITIONY INT          NOT NULL            COMMENT    '팝업위치Y',
	POPUPWIDTH INT        NOT NULL             COMMENT    '팝업세로크기',
	POPUPHEIGHT INT       NOT NULL             COMMENT    '팝업가로크기',
	STARTTIME DATETIME       NOT NULL          COMMENT    '유효시작시각',
	ENDTIME DATETIME        NOT NULL           COMMENT    '유효종료시각',
	NEWWINDOWYN VARCHAR(8)    NOT NULL         COMMENT    '새창유무',
	STATE VARCHAR(8)                   		   COMMENT    '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL          COMMENT    '생성자ID',
	INSIP VARCHAR(64)        NOT NULL          COMMENT    '생성자IP',
	INSTIME DATETIME        NOT NULL           COMMENT    '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL           COMMENT    '처리자ID',
	DMLIP VARCHAR(64)   NOT NULL               COMMENT    '처리자IP',
	DMLTIME DATETIME NOT NULL                  COMMENT    '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'    	 	   COMMENT    '처리로그',
	CONSTRAINT PKT_POPUP PRIMARY KEY (POPUPID)
	)ENGINE=InnoDB;
   
   ALTER TABLE T_POPUP COMMENT = '팝업관리';

  ALTER TABLE T_POPUP ADD CONSTRAINT FKT_POPUP_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;

###################################################
#  DDL for Table T_POPUPZONE
###################################################

  CREATE TABLE T_POPUPZONE 
   (	
   	POPUPZONEID INT         NOT NULL           COMMENT   '팝업존ID',
	SITEID VARCHAR(32)     NOT NULL            COMMENT   '사이트ID',
	KNAME VARCHAR(128)     NOT NULL            COMMENT   '한글명',
	KDESC TEXT               NOT NULL          COMMENT   '한글내용',
	IMAGEFILENAME VARCHAR(128)   NOT NULL      COMMENT   '이미지파일명',
	IMAGESFILENAME VARCHAR(128)  NOT NULL      COMMENT   '이미지시스템파일명',
	FILEPATH TEXT           NOT NULL           COMMENT   '파일경로',
	LINKURL VARCHAR(255)     NOT NULL          COMMENT   '링크URL',
	SORT INT                NOT NULL           COMMENT   '순서',
	STARTTIME DATETIME    NOT NULL             COMMENT   '유효시작시각',
	ENDTIME DATETIME          NOT NULL         COMMENT   '유효종료시각',
	NEWWINDOWYN VARCHAR(8)    NOT NULL         COMMENT   '새창유무',
	STATE VARCHAR(8)        NOT NULL           COMMENT   '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL          COMMENT   '생성자ID',
	INSIP VARCHAR(64)    NOT NULL              COMMENT   '생성자IP',
	INSTIME DATETIME       NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL           COMMENT   '처리자ID',
	DMLIP VARCHAR(64)    NOT NULL              COMMENT   '처리자IP',
	DMLTIME DATETIME           NOT NULL        COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'    		   COMMENT   '처리로그',
	CONSTRAINT PKT_POPUPZONE PRIMARY KEY (POPUPZONEID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_POPUPZONE COMMENT = '팝업존관리';

  ALTER TABLE T_POPUPZONE ADD CONSTRAINT FKT_POPUPZONE_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;
	  
###################################################
#  DDL for Table T_SITELINK
###################################################

  CREATE TABLE T_SITELINK 
   (	
   	SITELINKID INT NOT NULL                              COMMENT   '추천사이트ID',
	SITEID VARCHAR(32) NOT NULL                          COMMENT   '사이트ID',
	KNAME VARCHAR(96) NOT NULL                           COMMENT   '한글명',
	KDESC TEXT NOT NULL                                  COMMENT   '한글내용',
	LINKURL VARCHAR(255) NOT NULL                        COMMENT   '링크URL',
	SORT INT NOT NULL                                    COMMENT   '순서',
	NEWWINDOWYN VARCHAR(8) NOT NULL                      COMMENT   '새창유무',
	STATE VARCHAR(8) NOT NULL                            COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL                       COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL                           COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL                            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL                       COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                           COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                            COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'                      COMMENT   '처리로그',
	CONSTRAINT PKT_SITELINK PRIMARY KEY (SITELINKID)
   )ENGINE=InnoDB;
 
      ALTER TABLE T_SITELINK COMMENT = '추천사이트관리';

  ALTER TABLE T_SITELINK ADD CONSTRAINT FKT_SITELINK_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;

	  
###################################################
#  DDL for Table T_VISUALZONE
###################################################

  CREATE TABLE T_VISUALZONE 
   (	
    VISUALZONEID INT NOT NULL                 COMMENT  '비쥬얼존ID',
	SITEID VARCHAR(32) NOT NULL               COMMENT  '사이트ID',
	KNAME VARCHAR(128) NOT NULL               COMMENT  '한글명',
	KDESC TEXT NOT NULL                       COMMENT  '한글내용',
	IMAGEFILENAME VARCHAR(128) NOT NULL       COMMENT  '이미지파일명',
	IMAGESFILENAME VARCHAR(128) NOT NULL      COMMENT  '이미지시스템파일명',
	FILEPATH TEXT NOT NULL                    COMMENT  '파일경로',
	LINKURL VARCHAR(255) NOT NULL             COMMENT  '링크URL',
	SORT INT NOT NULL                         COMMENT  '순서',
	STARTTIME DATETIME NOT NULL               COMMENT  '유효시작시각',
	ENDTIME DATETIME NOT NULL                 COMMENT  '유효종료시각',
	NEWWINDOWYN VARCHAR(8) NOT NULL           COMMENT  '새창유무',
	STATE VARCHAR(8) NOT NULL                 COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL            COMMENT  '생성자ID',
	INSIP VARCHAR(64) NOT NULL                COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL                 COMMENT  '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL            COMMENT  '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                COMMENT  '처리자IP',
	DMLTIME DATETIME NOT NULL                 COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'           COMMENT  '처리로그',
	CONSTRAINT PKT_VISUALZONE PRIMARY KEY (VISUALZONEID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_VISUALZONE COMMENT = '비쥬얼존관리';


  ALTER TABLE T_VISUALZONE ADD CONSTRAINT FKT_VISUALZONE_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;

	  
###################################################
#  DDL for Table T_TABOOWORD
###################################################

  CREATE TABLE T_TABOOWORD 
   (	
   	SEQ INT NOT NULL                  COMMENT   'SEQ',
	KNAME VARCHAR(255) NOT NULL       COMMENT   'KNAME',
	STATE VARCHAR(8) NOT NULL         COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL    COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL        COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL         COMMENT   '생성시각',
	CONSTRAINT PKT_T_TABOOWORD PRIMARY KEY (SEQ)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_TABOOWORD COMMENT = '유해어관리';
	  

###################################################
#  DDL for Table T_REPLY
###################################################

  CREATE TABLE T_REPLY 
   (	
   	REPLYID INT NOT NULL               COMMENT '댓글ID',
	LINKID INT NOT NULL                COMMENT '링크ID',
	REPLYDESC TEXT NOT NULL            COMMENT '댓글내용',
	STATE VARCHAR(8) NOT NULL          COMMENT '상태관리',
	INSUSERID VARCHAR(64) NOT NULL     COMMENT '생성자ID',
	INSIP VARCHAR(64) NOT NULL         COMMENT '생성자IP',
	INSTIME DATETIME NOT NULL          COMMENT '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL     COMMENT '처리자ID',
	DMLIP VARCHAR(64) NOT NULL         COMMENT '처리자IP',
	DMLTIME DATETIME NOT NULL          COMMENT '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'    COMMENT '처리로그',
	CONSTRAINT PKT_REPLY PRIMARY KEY (REPLYID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_REPLY COMMENT = '댓글';

  ALTER TABLE T_REPLY ADD CONSTRAINT FKT_REPLY_T_LINK FOREIGN KEY (LINKID)
	  REFERENCES T_LINK (LINKID) ;
	  
###################################################
#  DDL for Table T_HISTORY
###################################################

  CREATE TABLE T_HISTORY 
   (	
   	NO INT NOT NULL                            COMMENT   '로그번호',
	TITLEID INT NOT NULL                       COMMENT   '게시물ID',
	CONTENTSID INT NOT NULL                    COMMENT   '본문ID',
	KTEXT TEXT NOT NULL                        COMMENT   '한글설명',
	KHTML TEXT                                 COMMENT   '한글본문HTML',
	IMAGEFILENAME VARCHAR(128) DEFAULT '-'     COMMENT   '이미지파일명',
	IMAGESFILENAME VARCHAR(128) DEFAULT '-'    COMMENT   '이미지시스템파일명',
	FILEPATH TEXT                   		   COMMENT   '파일경로',
	STATE VARCHAR(8) NOT NULL                  COMMENT   '상태관리',
	DMLUSERID VARCHAR(64) NOT NULL             COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                 COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                  COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'            COMMENT   '처리로그',
	CONSTRAINT PKT_HISTORY PRIMARY KEY (NO)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_HISTORY COMMENT = '콘텐츠변경이력';

  ALTER TABLE T_HISTORY ADD CONSTRAINT FKT_HISTORY_T_CONTENTS FOREIGN KEY (TITLEID, CONTENTSID)
	  REFERENCES T_CONTENTS (TITLEID, CONTENTSID) ;
	  
  
###################################################
#  DDL for Table T_MANAGEUSER
###################################################

  CREATE TABLE T_MANAGEUSER 
   (	
    BOARDID VARCHAR(32)    NOT NULL            COMMENT   '게시판관리ID', 
	USERID VARCHAR(64)     NOT NULL            COMMENT   '회원ID', 
	MANAGETYPE VARCHAR(64) NOT NULL            COMMENT   '담당형태', 
	SORT INT               NOT NULL            COMMENT   '순서', 
	STATE VARCHAR(8) NOT NULL                  COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL     		   COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL                 COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL                  COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL             COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                 COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                  COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'            COMMENT   '처리로그',
	CONSTRAINT PKT_MANAGEUSER PRIMARY KEY (BOARDID, USERID, MANAGETYPE)
   )ENGINE=InnoDB;
	  
   ALTER TABLE T_MANAGEUSER COMMENT = '경영공시담당자';
   
   ALTER TABLE T_MANAGEUSER ADD CONSTRAINT FKT_MANAGEUSER_T_BOARD FOREIGN KEY (BOARDID)
	  REFERENCES T_BOARD (BOARDID) ;

###################################################
#  DDL for Table T_MANAGEUSERLOG
###################################################

  CREATE TABLE T_MANAGEUSERLOG 
   (	
    BOARDID VARCHAR(32)    NOT NULL            COMMENT   '게시판관리ID', 
	USERID VARCHAR(64)     NOT NULL            COMMENT   '회원ID', 
	MANAGETYPE VARCHAR(64) NOT NULL            COMMENT   '담당형태', 
	TITLEID INT            NOT NULL            COMMENT   '게시판ID', 
	STATE VARCHAR(8) NOT NULL                  COMMENT   '상태관리',
	LOGTIME DATETIME NOT NULL                  COMMENT   'LOG시각',
	CONSTRAINT PKT_MANAGEUSERLOG PRIMARY KEY (BOARDID, USERID, MANAGETYPE, TITLEID)
   )ENGINE=InnoDB;
	  
   ALTER TABLE T_MANAGEUSERLOG COMMENT = '경영공시담당자';
   
   ALTER TABLE T_MANAGEUSERLOG ADD CONSTRAINT FKT_MANAGEUSERLOG_T_BOARD FOREIGN KEY (BOARDID)
	  REFERENCES T_BOARD (BOARDID) ;

	ALTER TABLE T_MANAGEUSERLOG ADD CONSTRAINT FKT_MANAGEUSERLOG_T_TITLE FOREIGN KEY (TITLEID)
	  REFERENCES T_TITLE (TITLEID) ;

	  
###################################################
#  DDL for Table T_GUESTINFO
###################################################

  CREATE TABLE T_GUESTINFO 
   (	
   	TITLEID INT NOT NULL                COMMENT   '게시물ID',
	GUESTNAME VARCHAR(32) NOT NULL      COMMENT    '비회원성명',
	KEY1 VARCHAR(32) NOT NULL           COMMENT  '인증키1',
	KEY2 VARCHAR(32) NOT NULL           COMMENT  '인증키2',
	KEY3 VARCHAR(32) NOT NULL           COMMENT  '인증키3',
	DKEY VARCHAR(64) NOT NULL           COMMENT  '고유키',
	STATE VARCHAR(8) NOT NULL           COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL      COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL          COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL           COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL      COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL          COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL           COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'     COMMENT   '처리로그',
	CONSTRAINT PKT_GUESTINFO PRIMARY KEY (TITLEID)
   )ENGINE=InnoDB;
 
	ALTER TABLE T_GUESTINFO COMMENT = '비회원게시물정보';

  ALTER TABLE T_GUESTINFO ADD CONSTRAINT FKT_GUESTINFO_T_TITLE FOREIGN KEY (TITLEID)
	  REFERENCES T_TITLE (TITLEID) ;

###################################################
#  DDL for Table T_APPEALUSER
###################################################

  CREATE TABLE T_APPEALUSER 
   (	
   	TITLEID INT  NOT NULL            COMMENT  '게시물ID',
	USERID VARCHAR(64)  NOT NULL       COMMENT  '회원ID',
	STATE VARCHAR(8)  NOT NULL         COMMENT '상태관리',
	INSUSERID VARCHAR(64)  NOT NULL    COMMENT   '생성자ID',
	INSIP VARCHAR(64)  NOT NULL        COMMENT '생성자IP',
	INSTIME DATETIME  NOT NULL         COMMENT  '생성시각',
	DMLUSERID VARCHAR(64)  NOT NULL    COMMENT   '처리자ID',
	DMLIP VARCHAR(64)  NOT NULL        COMMENT '처리자IP',
	DMLTIME DATETIME  NOT NULL         COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'    COMMENT  '처리로그',
	CONSTRAINT PKT_APPEALUSER PRIMARY KEY (TITLEID, USERID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_APPEALUSER COMMENT = '민원처리자';
  
###################################################
#  DDL for Table T_FILESHITLOG
###################################################

  CREATE TABLE T_FILESHITLOG 
   (	
   	NO INT               NOT NULL      COMMENT    '시퀀스',
	HITDATE VARCHAR(8)                 COMMENT    '조회일',
	TITLEID INT                        COMMENT    '게시물아이디',
	FILEID INT                         COMMENT    '파일아이디',
	USERFILENAME VARCHAR(255)          COMMENT    '유저파일명',
	SYSTEMFILENAME VARCHAR(255)        COMMENT    '시스템파일명',
	FILEGUBUN VARCHAR(64) 			   COMMENT    '파일구분',
	MENUID VARCHAR(64) 				   COMMENT    '메뉴ID',
	EXECMENUID VARCHAR(32)			   COMMENT    '메뉴ID',
	HITCOUNT INT                       COMMENT    '조회수',
	DMLUSERID VARCHAR(64) 	NOT NULL	COMMENT   '작성자ID',
	DMLIP VARCHAR(64) 		NOT NULL	COMMENT   '작성자IP',
	DMLTIME DATETIME 		NOT NULL	COMMENT   '작성시간',
	CONSTRAINT PKT_FILESHITLOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_FILESHITLOG COMMENT = '파일조회로그';

   ###################################################
#  DDL for Table T_TITLEHITLOG
###################################################

  CREATE TABLE T_TITLEHITLOG 
   (	
   	NO INT NOT NULL                    COMMENT   '로그번호',
	HITDATE VARCHAR(8)                 COMMENT   '게시물조회일',
	LINKID INT                         COMMENT   '링크ID',
	HITCOUNT INT                       COMMENT   '조회수',
	STARTDISPLAY VARCHAR(64)           COMMENT   '첫시작점',
	DMLUSERID VARCHAR(64) NOT NULL     COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL         COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL          COMMENT   '처리시각',
	CONSTRAINT PKT_TITLEHITLOG PRIMARY KEY (HITDATE, LINKID, DMLUSERID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_TITLEHITLOG COMMENT = '일별게시물조회수관리';

###################################################
#  DDL for Table T_USERGRADE
###################################################

  CREATE TABLE T_USERGRADE 
   (	
   	USERGRADEID INT NOT NULL          COMMENT    '고객만족도ID',
	MENUID VARCHAR(32) NOT NULL          COMMENT   '메뉴ID',
	LINKID INT DEFAULT NULL              COMMENT   '링크ID',
	GRADE INT DEFAULT 0                COMMENT  '점수',
	KTEXT TEXT                           COMMENT  '한글설명',
	STATE VARCHAR(8) NOT NULL            COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL       COMMENT    '생성자ID',
	INSIP VARCHAR(64) NOT NULL           COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL       COMMENT    '처리자ID',
	DMLIP VARCHAR(64) NOT NULL           COMMENT  '처리자IP',
	DMLTIME DATETIME NOT NULL            COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'      COMMENT   '처리로그',
	CONSTRAINT PKT_USERGRADE PRIMARY KEY (USERGRADEID)
   )ENGINE=InnoDB;
 
	ALTER TABLE T_USERGRADE COMMENT = '고객만족도';

  ALTER TABLE T_USERGRADE ADD CONSTRAINT FKT_USERGRADE_T_LINK FOREIGN KEY (LINKID)
	  REFERENCES T_LINK (LINKID);
 
  ALTER TABLE T_USERGRADE ADD CONSTRAINT FKT_USERGRADE_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;


###################################################
#  DDL for Table T_CONNECTLOG_DAY
###################################################
CREATE
    TABLE T_CONNECTLOG_DAY
    (
        SITEID VARCHAR(32) NOT NULL     	COMMENT  '사이트ID',
        CONNECTTIME DATETIME NOT NULL   	COMMENT  '접속시각',
        MODULE VARCHAR(255) NOT NULL    	COMMENT  '접속모듈',
        CONNUSER VARCHAR(32) NOT NULL   	COMMENT  '접속자구분',
        TOTAL INT                       	COMMENT  '일자별접속합계',
        CONSTRAINT PKT_CONNECTLOG_DAY PRIMARY KEY (SITEID, CONNECTTIME, MODULE, CONNUSER)
    )ENGINE=InnoDB;
    
    ALTER TABLE T_CONNECTLOG_DAY COMMENT = '일자별접속로그';
    
###################################################
#  DDL for Table T_CONNECTLOG_TIME
###################################################
	    
CREATE TABLE T_CONNECTLOG_TIME
    (
        TIME DATE NOT NULL                  	COMMENT  '수집일',
        SITEID VARCHAR(32) NOT NULL         	COMMENT  '사이트ID',
        CONNECTTIME VARCHAR(32) NOT NULL    	COMMENT  '시간',
        CONNUSER VARCHAR(32) NOT NULL       	COMMENT  '접속자구분',
        TOTAL INT                        		COMMENT  '일자별접속합계',
        CONSTRAINT PKT_CONNECTLOG_TIME PRIMARY KEY (TIME, SITEID, CONNECTTIME, CONNUSER)
    )ENGINE=InnoDB;
    
    ALTER TABLE T_CONNECTLOG_TIME COMMENT = '시간별접속로그';

###################################################
#  DDL for Table T_CONNECTLOG_MENU
###################################################
CREATE
    TABLE T_CONNECTLOG_MENU
    (
        TIME DATE NOT NULL                  	COMMENT  '수집일',
        SITEID VARCHAR(32) NOT NULL         	COMMENT  '사이트ID',
        MENUID VARCHAR(32) NOT NULL    			COMMENT  '메뉴ID',
        CONNUSER VARCHAR(32) NOT NULL       	COMMENT  '접속자구분',
        CONSTRAINT PKT_CONNECTLOG_MENU PRIMARY KEY (TIME, SITEID, MENUID)
    )ENGINE=InnoDB;
    
    ALTER TABLE T_CONNECTLOG_MENU COMMENT = '메뉴별접속로그';
    
###################################################
#  DDL for Table T_FILESHITLOG_BOARD
###################################################
CREATE
    TABLE T_FILESHITLOG_BOARD
    (
         HITDATE VARCHAR(8) NOT NULL           	COMMENT '게시물조회일',
        USERFILENAME VARCHAR(255) NOT NULL  	COMMENT '유저파일명',   
        SYSTEMFILENAME VARCHAR(255) NOT NULL    COMMENT '시스템파일명',   	 
        HITCOUNT INT 							COMMENT '조회수',
        EXECMENUID VARCHAR(32) NOT NULL   		COMMENT '메뉴ID',
        CONSTRAINT PKT_FILESHITLOG_BOARD PRIMARY KEY (HITDATE, USERFILENAME, EXECMENUID)
    )ENGINE=InnoDB;
    
    ALTER TABLE T_FILESHITLOG_BOARD COMMENT = '게시판형일별게시물조회수';
	
###################################################
#  DDL for Table T_FILESHITLOG_PROGRAM
###################################################
CREATE
    TABLE T_FILESHITLOG_PROGRAM
    (
        HITDATE VARCHAR(8) NOT NULL 		 COMMENT '게시물조회일',
        USERFILENAME VARCHAR(255) NOT NULL   COMMENT '유저파일명',   
        SYSTEMFILENAME VARCHAR(255) NOT NULL COMMENT '시스템파일명', 
        HITCOUNT INT COMMENT  '조회수',
        EXECMENUID VARCHAR(32) NOT NULL COMMENT '메뉴ID',
        CONSTRAINT PKT_FILESHITLOG_PROGRAM PRIMARY KEY (HITDATE, USERFILENAME, EXECMENUID)
    )ENGINE=InnoDB;
    
    ALTER TABLE T_FILESHITLOG_PROGRAM COMMENT = '프로그램형일별게시물조회수';
    
###################################################
#  DDL for Table T_TITLEHITLOG_WEEK
###################################################
CREATE
    TABLE T_TITLEHITLOG_WEEK
    (
        HITDATE VARCHAR(8) NOT NULL  	  COMMENT   '주간생성일',
        LINKID INT NOT NULL         	  COMMENT   '링크ID',
        HITCOUNT INT                	  COMMENT   '조회수',
        CONSTRAINT PKT_TITLEHITLOG_WEEK PRIMARY KEY (HITDATE, LINKID)
    )ENGINE=InnoDB;
    
    ALTER TABLE T_TITLEHITLOG_WEEK COMMENT = '주간게시물조회수관리';
    
###################################################
#  DDL for Table T_SURVEY
###################################################

  CREATE TABLE T_SURVEY 
   (	
   	SURVEYID INT             NOT NULL   COMMENT  '설문조사ID',      
	SITEID VARCHAR(32)      NOT NULL    COMMENT  '사이트ID',       
	KNAME VARCHAR(255)      NOT NULL    COMMENT  '설문한글명',        
	KHTML TEXT       					COMMENT  '설문개요',         
	OPENYN VARCHAR(8)       NOT NULL    COMMENT  '공개여부',        
	SURVEYSTARTTIME VARCHAR(16) NOT NULL COMMENT '설문조사시작시각',   
	SURVEYENDTIME VARCHAR(16) NOT NULL  COMMENT  '살문조사종료시각',   
	SURVEYTARGET VARCHAR(8)  NOT NULL   COMMENT  '설문대상',       
	RESULTOPENFORM VARCHAR(8) NOT NULL  COMMENT  '결과통보형태',     
	STATE VARCHAR(8)       NOT NULL     COMMENT  '상태관리',         
	INSUSERID VARCHAR(64)  NOT NULL     COMMENT  '생성자ID',      
	INSIP VARCHAR(64)      NOT NULL     COMMENT  '생성자IP',        
	INSTIME DATETIME       NOT NULL     COMMENT  '생성시각',        
	DMLUSERID VARCHAR(64)  NOT NULL     COMMENT  '처리자ID',      
	DMLIP VARCHAR(64)    NOT NULL       COMMENT  '처리자IP',        
	DMLTIME DATETIME       NOT NULL     COMMENT  '처리시각',        
	DMLLOG VARCHAR(255) DEFAULT '-' 	COMMENT  '처리로그',        
	CONSTRAINT PKT_SURVEY PRIMARY KEY (SURVEYID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_SURVEY COMMENT = '설문조사정보';

  ALTER TABLE T_SURVEY ADD CONSTRAINT FKT_SURVEY_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;


###################################################
#  DDL for Table T_SURVEYQUESTION
###################################################

  CREATE TABLE T_SURVEYQUESTION 
   (	
   	SURVEYID INT NOT NULL                       COMMENT   '설문조사ID',
	QUESTIONID INT NOT NULL                     COMMENT   '설문문항ID',
	KNAME VARCHAR(255) NOT NULL                 COMMENT   '한글명',
	ANSWERTYPE VARCHAR(8) NOT NULL              COMMENT   '답변유형',
	MULTIPLECHOICETYPE VARCHAR(8) NOT NULL      COMMENT   '객관식유형',
	STATE VARCHAR(8) NOT NULL                   COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL              COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL                  COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL                   COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL              COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                  COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                   COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'             COMMENT   '처리로그',
	CONSTRAINT PKT_SURVEYQUESTION PRIMARY KEY (SURVEYID, QUESTIONID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_SURVEYQUESTION COMMENT = '설문조사문항정보';

  ALTER TABLE T_SURVEYQUESTION ADD CONSTRAINT FKT_SURVEYQUESTION_T_SURVEY FOREIGN KEY (SURVEYID)
	  REFERENCES T_SURVEY (SURVEYID) ;
	  
###################################################
#  DDL for Table T_SURVEYANSWER
###################################################

  CREATE TABLE T_SURVEYANSWER 
   (	
   	SURVEYID INT NOT NULL                 COMMENT   '설문조사ID',
	QUESTIONID INT NOT NULL               COMMENT   '설문문항ID',
	ANSWERID INT NOT NULL                 COMMENT   '설문답변ID',
	KNAME VARCHAR(255)                    COMMENT   '한글명',
	IMAGEFILENAME VARCHAR(128)            COMMENT   '이미지파일명',
	IMAGESFILENAME VARCHAR(128)           COMMENT   '이미지시스템파일명',
	FILEPATH TEXT                         COMMENT   '파일경로',
	STATE VARCHAR(8) NOT NULL             COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL        COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL            COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL             COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL        COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL            COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL             COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'       COMMENT   '처리로그',
	CONSTRAINT PKT_SURVEYANSWER PRIMARY KEY (SURVEYID, QUESTIONID, ANSWERID)
   )ENGINE=InnoDB;
 
	ALTER TABLE T_SURVEYANSWER COMMENT = '설문조사답변정보';

  ALTER TABLE T_SURVEYANSWER ADD CONSTRAINT FKT_SURVEYANSWER_T_SURVEYQUEST FOREIGN KEY (SURVEYID, QUESTIONID)
	  REFERENCES T_SURVEYQUESTION (SURVEYID, QUESTIONID) ;

###################################################
#  DDL for Table T_SURVEYPARTICIPATION
###################################################

  CREATE TABLE T_SURVEYPARTICIPATION 
   (	
   	PARTICIPATIONID INT NOT NULL        COMMENT   '설문조사참여ID',
	SURVEYID INT NOT NULL               COMMENT   '설문조사ID',
	USERID VARCHAR(64) NOT NULL         COMMENT   '설문조사참여자ID',
	USERNAME VARCHAR(96) NOT NULL       COMMENT   '한글명',
	DKEY VARCHAR(64) DEFAULT '-'        COMMENT   '고유키',
	STATUS VARCHAR(8) NOT NULL          COMMENT   '설문조사참여상태',
	STATE VARCHAR(8) NOT NULL           COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL      COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL          COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL           COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL      COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL          COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL           COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'     COMMENT   '처리로그',
	CONSTRAINT PKT_SURVEYPARTICIPATION PRIMARY KEY (PARTICIPATIONID)
   )ENGINE=InnoDB; 
 
 	ALTER TABLE T_SURVEYPARTICIPATION COMMENT = '설문조사참여정보';

  ALTER TABLE T_SURVEYPARTICIPATION ADD CONSTRAINT FKT_SURVEYPARTICIPATION_T_SURV FOREIGN KEY (SURVEYID)
	  REFERENCES T_SURVEY (SURVEYID) ;


###################################################
#  DDL for Table T_SURVEYPARTICIPATIONREPLY
###################################################

  CREATE TABLE T_SURVEYPARTICIPATIONREPLY 
   (	
   	PARTICIPATIONID INT NOT NULL       COMMENT   '설문조사참여ID',
	QUESTIONID INT NOT NULL            COMMENT   '설문조사문항ID',
	ANSWER TEXT NOT NULL               COMMENT   '설문조사참여답안',
	INSUSERID VARCHAR(64) NOT NULL     COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL         COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL          COMMENT   '생성시각',
	CONSTRAINT PKT_SURVEYPARTICIPATIONREPLY PRIMARY KEY (PARTICIPATIONID, QUESTIONID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_SURVEYPARTICIPATIONREPLY COMMENT = '설문조사참여답안정보';


  ALTER TABLE T_SURVEYPARTICIPATIONREPLY ADD CONSTRAINT FKT_SURVEYPARTICIPATIONREPLY_T FOREIGN KEY (PARTICIPATIONID)
	  REFERENCES T_SURVEYPARTICIPATION (PARTICIPATIONID) ;

###################################################
#  DDL for Table T_NEWSLETTER
###################################################

  CREATE TABLE T_NEWSLETTER 
   (	
   	NEWSLETTERID INT NOT NULL             COMMENT   '뉴스레터ID',
	SITEID VARCHAR(32) NOT NULL           COMMENT   '사이트ID',
	KNAME VARCHAR(600) NOT NULL           COMMENT   '한글명',
	OPENYN VARCHAR(8) NOT NULL            COMMENT   '공개여부',
	SENDDUEDATE DATETIME NOT NULL         COMMENT   '발송예정일',
	TEMPLATE VARCHAR(8) NOT NULL          COMMENT   '템플릿',
	UPIMAGE VARCHAR(8) NOT NULL           COMMENT   '상단이미지',
	PUBNO VARCHAR(16) DEFAULT '-'         COMMENT   '발행호수',
	PUBDATE VARCHAR(32) DEFAULT '-'       COMMENT   '발행일',
	PUBTIME DATETIME                      COMMENT   '발행시각',
	UPIMAGEFILENAME VARCHAR(128),
    UPIMAGESFILENAME VARCHAR(128),
    UPIMAGEFILEPATH VARCHAR(512),
    UPIMAGEHTML TEXT,
    PREVIEWHTML TEXT,
	STATE VARCHAR(8) NOT NULL             COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL        COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL            COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL             COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL        COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL            COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL             COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'       COMMENT   '처리로그',
	CONSTRAINT PKT_NEWSLETTER PRIMARY KEY (NEWSLETTERID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_NEWSLETTER COMMENT = '뉴스레터관리';
   
     ALTER TABLE T_NEWSLETTER ADD CONSTRAINT FKT_NEWSLETTER_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;
	  

###################################################
#  DDL for Table T_IPMANAGEMENT
###################################################

  CREATE TABLE T_IPMANAGEMENT 
   (	
   	SEQ INT NOT NULL                   COMMENT  'SEQ',
	IP_1 VARCHAR(32) NOT NULL          COMMENT  'IP_1',
	IP_2 VARCHAR(32) NOT NULL          COMMENT  'IP_2',
	IP_3 VARCHAR(32) NOT NULL          COMMENT  'IP_3',
	IP_4 VARCHAR(32) NOT NULL          COMMENT  'IP_4',
	ALLWYN VARCHAR(32) DEFAULT 'Y'     COMMENT  '허용여부',
	REMK VARCHAR(32) NOT NULL          COMMENT  '비고',
	STATE VARCHAR(8) NOT NULL          COMMENT  '상태관리',
	INSUSERID VARCHAR(64) NOT NULL     COMMENT  '생성자ID',
	INSIP VARCHAR(64) NOT NULL         COMMENT  '생성자IP',
	INSTIME DATETIME NOT NULL          COMMENT  '생성시각',
	CONSTRAINT PKT_IPMANAGEMENT PRIMARY KEY (SEQ)
   )ENGINE=InnoDB;

   ALTER TABLE T_IPMANAGEMENT COMMENT = 'IP관리';

###################################################
#  DDL for Table T_BOARDREFERENCEMENU
###################################################

  CREATE TABLE T_BOARDREFERENCEMENU 
   (	
   	BOARDID VARCHAR(32)   NOT NULL      COMMENT '게시판ID',
	MENUID VARCHAR(32)   NOT NULL       COMMENT '메뉴ID',
	STATE VARCHAR(8)       NOT NULL     COMMENT '상태관리',
	INSUSERID VARCHAR(64)   NOT NULL    COMMENT '생성자ID',
	INSIP VARCHAR(64)      NOT NULL     COMMENT '생성자IP',
	INSTIME DATETIME      NOT NULL      COMMENT '생성시각',
	CONSTRAINT PKT_BOARDREFERENCEMENU PRIMARY KEY (BOARDID, MENUID)
   )ENGINE=InnoDB;

   ALTER TABLE T_BOARDREFERENCEMENU  COMMENT = '참조형게시판정보';
   
  ALTER TABLE T_BOARDREFERENCEMENU ADD CONSTRAINT FKT_BOARDREFERENCEMENU_T_BOARD FOREIGN KEY (BOARDID)
	  REFERENCES T_BOARD (BOARDID) ;
 
  ALTER TABLE T_BOARDREFERENCEMENU ADD CONSTRAINT FKT_BOARDREFERENCEMENU_T_MENU FOREIGN KEY (MENUID)
	  REFERENCES T_MENU (MENUID) ;
	
     
###################################################
#  DDL for Table T_NEWSLETTER_PORTLET
###################################################

  CREATE TABLE T_NEWSLETTER_PORTLET 
   (	
   	NEWSLETTERID INT NOT NULL            COMMENT   '뉴스레터ID',
	DIVID VARCHAR(32) NOT NULL           COMMENT   'DIV레이어ID',
	PORTLETTYPE VARCHAR(4) NOT NULL      COMMENT   '포틀릿타입',
	STATE VARCHAR(8) NOT NULL            COMMENT   '상태관리',
	INSUSERID VARCHAR(64) NOT NULL       COMMENT   '생성자ID',
	INSIP VARCHAR(64) NOT NULL           COMMENT   '생성자IP',
	INSTIME DATETIME NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64) NOT NULL       COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL           COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL            COMMENT   '처리시각',
	CONTENTS_TITLE VARCHAR(255) 		 COMMENT   '콘텐츠제목',
	CONTENTS_TITLE_USE VARCHAR(1)		 COMMENT   '콘텐츠사용',
	CONSTRAINT PKT_NEWSLETTER_PORTLET PRIMARY KEY (NEWSLETTERID, DIVID)
   )ENGINE=InnoDB; 
   
   ALTER TABLE T_NEWSLETTER_PORTLET  COMMENT = '뉴스레터 포틀릿';
  
###################################################
#  DDL for Table T_NEWSLETTER_PORTLET_CONT
###################################################

  CREATE TABLE T_NEWSLETTER_PORTLET_CONT 
   (	
   	NEWSLETTERID INT         NOT NULL             COMMENT '뉴스레터ID',
	DIVID VARCHAR(32)        NOT NULL             COMMENT '뉴스레터포틀릿DIVID',
	SEQ INT                  NOT NULL             COMMENT '순번',
	LINK VARCHAR(1024)                  COMMENT   '링크',
	USERIMGFILENAME VARCHAR(255)        COMMENT   '사용자이미지파일명',
	SYSTEMIMGFILENAME VARCHAR(255)      COMMENT   '시스템이미지파일명',
	IMGFILEPATH TEXT                    COMMENT   '이미지파일경로',
	IMGDESC TEXT                        COMMENT   '이미지설명',
	CONTENTS TEXT                       COMMENT   '콘텐츠',
	HTML TEXT                           COMMENT   'HTML',
	STATE VARCHAR(8)           NOT NULL          COMMENT  '상태관리',
	INSUSERID VARCHAR(64)      NOT NULL          COMMENT  '생성자ID',
	INSIP VARCHAR(64)          NOT NULL          COMMENT  '생성자IP',
	INSTIME DATETIME            NOT NULL         COMMENT  '생성시각',
	DMLUSERID VARCHAR(64)       NOT NULL         COMMENT  '처리자ID',
	DMLIP VARCHAR(64)            NOT NULL        COMMENT  '처리자IP',
	DMLTIME DATETIME             NOT NULL        COMMENT  '처리시각',
	SUBJECT VARCHAR(255)		 NOT NULL		 COMMENT  '제목',
	CONSTRAINT PKT_N_NEWSLETTER_PORTLET_CONT PRIMARY KEY (NEWSLETTERID, DIVID, SEQ)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_NEWSLETTER_PORTLET_CONT  COMMENT = '뉴스레터포틀릿콘텐츠';

###################################################
#  DDL for Table T_NEWSLETTERAPP
###################################################

  CREATE TABLE T_NEWSLETTERAPP 
   (	
   	SITEID VARCHAR(32)     NOT NULL         COMMENT  '사이트ID',
	APPEMAIL VARCHAR(64)  NOT NULL            COMMENT  '한글명',
	APPTIME DATETIME      NOT NULL            COMMENT  '공개여부',
	STATE VARCHAR(8)      NOT NULL            COMMENT '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL         COMMENT   '생성자ID',
	INSIP VARCHAR(64)      NOT NULL           COMMENT '생성자IP',
	INSTIME DATETIME       NOT NULL           COMMENT  '생성시각',
	DMLUSERID VARCHAR(64)  NOT NULL           COMMENT   '처리자ID',
	DMLIP VARCHAR(64)       NOT NULL          COMMENT '처리자IP',
	DMLTIME DATETIME       NOT NULL           COMMENT  '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'   COMMENT  '처리로그', 
	RCV_YN VARCHAR(1) DEFAULT 'Y' COMMENT  '수신여부',
	CONSTRAINT PKT_NEWSLETTERAPP PRIMARY KEY (SITEID, APPEMAIL)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_NEWSLETTERAPP  COMMENT = '뉴스레터신청정보';

  ALTER TABLE T_NEWSLETTERAPP ADD CONSTRAINT FKT_NEWSLETTERAPP_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;
	  
   
###################################################
#  DDL for Table T_TEMPSEQUENCE
###################################################

  CREATE TABLE T_TEMPSEQUENCE 
   (	
   	MENUID VARCHAR(32) NOT NULL    COMMENT '메뉴ID',
	YYYY VARCHAR(4) NOT NULL       COMMENT '년',
	MM VARCHAR(2) NOT NULL         COMMENT '월',
	DD VARCHAR(2) NOT NULL         COMMENT '일',
	SEQ VARCHAR(10) NOT NULL       COMMENT '순번',
	CONSTRAINT PKT_TEMPSEQUENCE PRIMARY KEY (MENUID, YYYY, MM, DD)
   )ENGINE=InnoDB;

   ALTER TABLE T_TEMPSEQUENCE  COMMENT = '년월일-순번 생성 테이블';

###################################################
#  DDL for Table T_TITLEHITLOG_MONTH
###################################################

  CREATE TABLE T_TITLEHITLOG_MONTH 
   (	
   	NO INT NOT NULL,
	HITDATE VARCHAR(8), 
	LINKID INT ,
	HITCOUNT INT, 
	DMLUSERID VARCHAR(64) NOT NULL,
	DMLIP VARCHAR(64) NOT NULL,
	DMLTIME DATETIME NOT NULL,
	CONSTRAINT PKT_TITLEHITLOG_MONTH PRIMARY KEY (NO, HITDATE, LINKID, DMLUSERID)
   )ENGINE=InnoDB;

   
###################################################
#  DDL for Table T_USERINFOLOG
###################################################

  CREATE TABLE T_USERINFOLOG 
   (	
   	NO INT NOT NULL                        	  COMMENT   '로그번호',
	INQUSERID VARCHAR(64)                     COMMENT   '조회자ID',
	RECUSERID VARCHAR(128)                    COMMENT   '조회대상자ID',
	MENUID VARCHAR(32)                        COMMENT   '메뉴ID',
	INQTIME DATETIME                          COMMENT   '조회시각',
	RECDESC TEXT                              COMMENT   '조회내용',
	DMLUSERID VARCHAR(64) NOT NULL            COMMENT   '처리자ID',
	DMLIP VARCHAR(64) NOT NULL                COMMENT   '처리자IP',
	DMLTIME DATETIME NOT NULL                 COMMENT   '처리시각',
	GUBUN VARCHAR(1) DEFAULT 'R' NOT NULL 	  COMMENT   '구분',
	REASON VARCHAR(1024) COMMENT   '사유',
	GROUPID VARCHAR(32) COMMENT   '그룹ID',
	FILEGUBUN VARCHAR(5) COMMENT   '파일구분',
	FILESIZE VARCHAR(10) COMMENT   '파일크기',
	CONSTRAINT PKT_USERINFOLOG PRIMARY KEY (NO)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_USERINFOLOG  COMMENT = '개인정보조회관리';
	
###################################################
#  DDL for Table T_DOODLES
###################################################

  CREATE TABLE T_DOODLES 
   (	
   	DOODLESID INT         NOT NULL             COMMENT   '두들ID',
	SITEID VARCHAR(32)     NOT NULL            COMMENT   '사이트ID',
	KNAME VARCHAR(128)     NOT NULL            COMMENT   '한글명',
	KDESC TEXT               NOT NULL          COMMENT   '한글내용',
	IMAGEFILENAME VARCHAR(128)   NOT NULL      COMMENT   '이미지파일명',
	IMAGESFILENAME VARCHAR(128)  NOT NULL      COMMENT   '이미지시스템파일명',
	FILEPATH TEXT           NOT NULL           COMMENT   '파일경로',
	LINKURL VARCHAR(255)     NOT NULL          COMMENT   '링크URL',
	SORT INT                NOT NULL           COMMENT   '순서',
	STARTTIME DATETIME    NOT NULL             COMMENT   '유효시작시각',
	ENDTIME DATETIME          NOT NULL         COMMENT   '유효종료시각',
	NEWWINDOWYN VARCHAR(8)    NOT NULL         COMMENT   '새창유무',
	STATE VARCHAR(8)        NOT NULL           COMMENT   '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL          COMMENT   '생성자ID',
	INSIP VARCHAR(64)    NOT NULL              COMMENT   '생성자IP',
	INSTIME DATETIME       NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL           COMMENT   '처리자ID',
	DMLIP VARCHAR(64)    NOT NULL              COMMENT   '처리자IP',
	DMLTIME DATETIME           NOT NULL        COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'    COMMENT   '처리로그',
	CONSTRAINT PKT_DOODLES PRIMARY KEY (DOODLESID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_DOODLES COMMENT = '두들관리';

  ALTER TABLE T_DOODLES ADD CONSTRAINT FKT_DOODLES_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;	
	  
###################################################
#  DDL for Table T_PERSONALINFO
###################################################

  CREATE TABLE T_PERSONALINFO
   (	
   	PERSONALINFOID INT     NOT NULL            COMMENT   '개인정보처리방침ID',
	KNAME VARCHAR(128)     NOT NULL            COMMENT   '한글명',
	KDESC TEXT               NOT NULL          COMMENT   '한글내용',
	INSUSERID VARCHAR(64)    NOT NULL          COMMENT   '생성자ID',
	INSIP VARCHAR(64)    NOT NULL              COMMENT   '생성자IP',
	INSTIME DATETIME       NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL           COMMENT   '처리자ID',
	DMLIP VARCHAR(64)    NOT NULL              COMMENT   '처리자IP',
	DMLTIME DATETIME           NOT NULL        COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'            COMMENT   '처리로그',
	CONSTRAINT PKT_PERSONALINFO PRIMARY KEY (PERSONALINFOID)
   )ENGINE=InnoDB;
 
   ALTER TABLE T_PERSONALINFO COMMENT = '개인정보처리방침관리';
	
   
###################################################
#  DDL for Table T_NEWSTICKER
###################################################
CREATE TABLE T_NEWSTICKER
   (	
   	NEWSTICKERID INT         NOT NULL          COMMENT   '뉴스티커ID',
	SITEID VARCHAR(32)   NOT NULL              COMMENT   '사이트ID',
	KNAME VARCHAR(128)   NOT NULL              COMMENT   '한글명',
	LINKURL VARCHAR(255)    NOT NULL           COMMENT   '링크URL',
	STARTTIME DATETIME       NOT NULL          COMMENT   '유효시작시각',
	ENDTIME DATETIME        NOT NULL           COMMENT   '유효종료시각',
	NEWWINDOWYN VARCHAR(8)    NOT NULL         COMMENT   '새창유무',
	STATE VARCHAR(8)                   		   COMMENT   '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL          COMMENT   '생성자ID',
	INSIP VARCHAR(64)    NOT NULL              COMMENT   '생성자IP',
	INSTIME DATETIME       NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL           COMMENT   '처리자ID',
	DMLIP VARCHAR(64)    NOT NULL              COMMENT   '처리자IP',
	DMLTIME DATETIME           NOT NULL        COMMENT   '처리시각',
	CONSTRAINT PKT_NEWSTICKER PRIMARY KEY (NEWSTICKERID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_NEWSTICKER COMMENT = '뉴스티커관리';
   
   ALTER TABLE T_NEWSTICKER ADD CONSTRAINT FKT_NEWSTICKER_T_SITE FOREIGN KEY (SITEID)
	  REFERENCES T_SITE (SITEID) ;	
	  

###################################################
#  DDL for Table T_ATTACHFILE
###################################################
CREATE TABLE T_ATTACHFILE
   (	
   	ATTACHFILEID INT         	               COMMENT   '첨부파일관리ID', 
	USERID VARCHAR(64)         	               COMMENT   '등록자ID', 
	USERNAME VARCHAR(64)                       COMMENT   '등록자이름', 
	KNAME VARCHAR(128)                         COMMENT   '첨부파일제목', 
	KHTML TEXT 				                   COMMENT   '첨부파일내용',
	STATE VARCHAR(8)                   		   COMMENT   '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL          COMMENT   '생성자ID',
	INSIP VARCHAR(64)    NOT NULL              COMMENT   '생성자IP',
	INSTIME DATETIME       NOT NULL            COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL           COMMENT   '처리자ID',
	DMLIP VARCHAR(64)    NOT NULL              COMMENT   '처리자IP',
	DMLTIME DATETIME           NOT NULL        COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'            COMMENT   '처리로그',
	CONSTRAINT PKT_ATTACHFILE PRIMARY KEY (ATTACHFILEID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_ATTACHFILE COMMENT = '첨부파일관리';
   

###################################################
#  DDL for Table T_ATTACHFILEFILES
###################################################
CREATE TABLE T_ATTACHFILEFILES
   (	
   	ATTACHFILEID INT         	                COMMENT   '첨부파일관리ID',
   	FILEID INT          NOT NULL        		COMMENT   '첨부파일ID',  
	USERFILENAME VARCHAR(255) NOT NULL  		COMMENT   '사용자파일명', 
	SYSTEMFILENAME VARCHAR(255) NOT NULL 		COMMENT   '시스템파일명', 
	FILEPATH TEXT          NOT NULL     		COMMENT   '파일경로',   
	FILEEXTENSION VARCHAR(16) NOT NULL  		COMMENT   '파일확장자',  
	FILESIZE INT              NOT NULL  		COMMENT   '파일크기', 
	STATE VARCHAR(8)                   		    COMMENT   '상태관리',
	INSUSERID VARCHAR(64)    NOT NULL           COMMENT   '생성자ID',
	INSIP VARCHAR(64)    NOT NULL               COMMENT   '생성자IP',
	INSTIME DATETIME       NOT NULL             COMMENT   '생성시각',
	DMLUSERID VARCHAR(64)   NOT NULL            COMMENT   '처리자ID',
	DMLIP VARCHAR(64)    NOT NULL               COMMENT   '처리자IP',
	DMLTIME DATETIME           NOT NULL         COMMENT   '처리시각',
	DMLLOG VARCHAR(255) DEFAULT '-'             COMMENT   '처리로그',
	CONSTRAINT PKT_ATTACHFILEFILES PRIMARY KEY (ATTACHFILEID, FILEID)
   )ENGINE=InnoDB;
   
   ALTER TABLE T_ATTACHFILE COMMENT = '첨부파일관리파일';
   
   
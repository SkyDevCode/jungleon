-- =============================  t_code : 기본코드
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('board','게시판 카테고리','0',1,1,'99','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sysCd','시스템코드','0',1,2,'99','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('programcd','프로그램코드','0',1,3,'90','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('common','공통코드','0',1,4,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sysmenu','시스템메뉴','sysCd',2,1,'99','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sitemenu','사이트메뉴','sysCd',2,2,'80','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mngrAuth','관리자등급','sysCd',2,3,'99','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드 > 시스템 메뉴
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SYSTEM','시스템관리','sysmenu',3,1,'90','Y',null,'fa-gear','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SYSTEMCONFIG','환경설정','sysmenu',3,2,'80','Y',null,'fa-check-circle','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MENU','메뉴관리','sysmenu',3,3,'80','Y',null,'fa-list','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('AUTHORITY','권한관리','sysmenu',3,4,'80','Y',null,'fa-lock','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MANAGER','관리자관리','sysmenu',3,5,'80','Y',null,'fa-user-secret','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MEMBERM','회원관리','sysmenu',3,6,'80','Y',null,'fa-user','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('BOARDCONFIG','게시판관리','sysmenu',3,7,'80','Y',null,'fa-list-alt','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS','통계관리','sysmenu',3,9,'80','Y',null,'fa-bar-chart-o','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('LOG','로그관리','sysmenu',3,10,'80','N',null,'fa-file-text-o','itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드 > 사이트 메뉴
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sitemng','사이트관리','sitemenu',3,1,'80','N',null,'fa-gear','itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드 > 관리자 등급
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mngrAuth80','일반관리자','mngrAuth',3,1,'99','Y','80',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mngrAuth90','사이트관리자','mngrAuth',3,2,'99','Y','90',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mngrAuth99','총괄관리자','mngrAuth',3,3,'99','Y','99',null,'itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드 > 시스템 메뉴 > 시스템관리, 환경설정, 메뉴관리, 권한관리, 관리자관리, 회원관리, 게시판관리, 설문조사, 통계관리, 로그관리
---> 시스템관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SITE','사이트 관리','SYSTEM',4,1,'90','Y','site/sitemng_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('PROGRAM','프로그램 관리','SYSTEM',4,2,'90','Y','program/prog_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('CODE','코드 관리','SYSTEM',4,3,'90','Y','code/code_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('TEMP','템플릿관리','SYSTEM',4,4,'90','Y','templeteconfig/templete_list',null,'itgood','N');
---> 환경설정
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('DEFAULT','시스템설정','SYSTEMCONFIG',4,1,'90','Y','systemconfig/basic_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SITECONFIG','사이트설정','SYSTEMCONFIG',4,2,'80','Y','systemconfig/site_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SOCIALKEY','소셜미디어 키 관리','SYSTEMCONFIG',4,3,'90','Y','socialKey/socialKey_edit',null,'itgood','N');
---> 메뉴관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MENU_SUB','메뉴 관리','MENU',4,1,'80','Y','menu/menu_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MENU_SATIS','메뉴 만족도','MENU',4,2,'80','Y','menu/satisfaction_list',null,'itgood','N');
---> 권한관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MENU_AUTH','메뉴그룹권한관리','AUTHORITY',4,1,'80','Y','menuauth/mnauthgroup_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MENU_AUTH_INDIVIDUAL','개별권한관리','AUTHORITY',4,2,'80','Y','menuauth/mnauthindividual_list',null,'itgood','N');
---> 관리자관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MEMBER_MANAGER','관리자관리','MANAGER',4,1,'80','Y','manager/manager_list',null,'itgood','N');
---> 회원관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MEMBER_USER','일반회원관리','MEMBERM',4,1,'80','Y','member/member_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MEMBERM_COM','기업회원관리','MEMBERM',4,2,'00','Y','comember/comember_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('IP_MANAGE','사용자 IP 관리','MEMBERM',4,3,'80','Y','memIP/ip_edit',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('CONTRACT','약관 관리','MEMBERM',4,4,'80','Y','contract/contract_list',null,'itgood','N');
---> 게시판관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('BOARDCONFIG_M','게시판관리','BOARDCONFIG',4,1,'80','Y','boardconfig/boardconfig_list','fa-list-alt','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('PROHIBIT_WORD','금지어관리','BOARDCONFIG',4,2,'80','Y','prohibitword/prohibitWord_edit','fa-list-alt','itgood','N');
---> 통계관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_DATE','날짜별 접속통계','STATS',4,1,'80','Y','stats/statsDate_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_TERM','기간별 접속통계','STATS',4,2,'80','Y','stats/statsTerm_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_OPTION','옵션별 접속통계','STATS',4,3,'80','Y','stats/statsOpt_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_MENU','메뉴별 접속통계','STATS',4,4,'80','Y','stats/statsMenu_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_BOARD','게시판 통계','STATS',4,5,'80','Y','stats/statsBbs_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_SNS','SNS 통계','STATS',4,6,'80','Y','stats/statsSocial_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('STATS_POPUP','팝업 통계','STATS',4,7,'80','Y','stats/statsPopup_view',null,'itgood','N');
---> 로그관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('PERSN_INFO_LOG','개인정보 조회 로그','LOG',4,1,'80','Y','persnInfoLog/persnInfoLog_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MEMBER_MANAGER_LOG','관리자 작업 로그','LOG',4,2,'80','Y','managerlog/manager_list_log',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('MEMBER_LOGIN_LOG','회원 로그인 로그','LOG',4,3,'80','Y','manager/loginLog_list',null,'itgood','N');

--- =============================  t_code : 기본코드 > 시스템 코드 > 사이트 메뉴 > 사이트관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SITE_MNG','사이트관리','sitemng',4,1,'80','Y',null,'fa-gear','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('POPUP','팝업관리','sitemng',4,2,'80','Y',null,'fa-desktop','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('filemanage','파일관리','sitemng',4,3,'80','Y',null,'fa-desktop','itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SURVEY','설문조사','sitemng',4,4,'80','Y',null,'fa-pencil-square-o','itgood','N');

--- =============================  t_code : 기본코드 > 시스템 코드 > 사이트 메뉴 > 사이트관리 > 팝업관리, 사이트관리, 파일관리, 설문조사
--- > 팝업관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('POPUP_1','팝업존','POPUP',5,1,'80','Y','popup/popup1_comm',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('POPUP_2','팝업창','POPUP',5,2,'80','Y','popup/popup2_comm',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('POPUP_3','배너','POPUP',5,3,'80','Y','popup/popup3_comm',null,'itgood','N');

--- > 사이트관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SITE_CONFIG','사이트설정','SITE_MNG',5,1,'80','N','systemconfig/site_view',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('SLIDE','슬라이드셋관리','SITE_MNG',5,2,'80','Y','slides/slides_list',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('BOARDREACTION','답글 관리','SITE_MNG',5,3,'80','Y','boardReaction/reply_list',null,'itgood','N');

--- > 설문조사
INSERT into T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,ETC1,ETC2,REGMEMID,DELYN) values ('SURVEYREG','설문생성','SURVEY',5,1,'80','survey/mngrSurvey_regist',null,'itgood','N');
INSERT into T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,ETC1,ETC2,REGMEMID,DELYN) values ('SURVEYLIST','설문관리','SURVEY',5,2,'80','survey/mngrSurveyManage_list',null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램 코드
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('managercd','관리자관리','programcd',2,1,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('membercd','회원관리','programcd',2,2,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('survey_cd','설문조사','programcd',2,3,'00','N',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 관리자관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('group','부서','managercd',3,1,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('position','직위','managercd',3,2,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 회원관리
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('nomemcd','일반회원','membercd',3,2,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('comemcd','기업회원','membercd',3,2,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 회원관리 > 일반회원
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('memstatuscd','회원상태','nomemcd',4,1,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 회원관리 > 일반회원 > 회원상태
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mem_normal','승인','memstatuscd',5,1,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mem_cutoff','차단','memstatuscd',5,2,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mem_del','탈퇴','memstatuscd',5,3,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mem_wait','대기','memstatuscd',5,4,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('mem_unreceived','미승인','memstatuscd',5,5,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 회원관리 > 기업회원
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('comem_status','기업회원상태','comemcd',4,1,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 회원관리 > 기업회원 > 기업회원상태
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('com_status_0','미승인대기','comem_status',5,1,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('com_status_1','가입완료','comem_status',5,2,'00','Y',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('com_status_2','회원탈퇴','comem_status',5,3,'00','Y',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 설문조사
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('survey_qu_op','설문문항구분','survey_cd',3,1,'00','N',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) values ('svstatuscd','설문조사진행상태','survey_cd',3,2,'00','N',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 설문조사 > 설문문항구분
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('op_editable_radio','객관식(단일 선택)','survey_qu_op',4,1,'00','N',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('op_editable_checkbox','객관식(복수 선택)','survey_qu_op',4,2,'00','N',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('op_object','만족도평가형','survey_qu_op',4,3,'00','N',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('op_score','점수형','survey_qu_op',4,4,'00','N',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('op_descriptive','서술형','survey_qu_op',4,5,'00','N',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 프로그램코드 > 설문조사 > 설문문항구분 > 만족도 평가형, 점수형
---> 만족도 평가형
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_ass','매우그렇다 ~ 매우그렇지않다','op_object',5,1,'00','N',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_sat','매우만족~매우불만족','op_object',5,2,'00','N',null,null,'itgood','N');
---> 만족도 평가형 > 매우그렇다 ~ 매우그렇지않다
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_ass5','매우 그렇다','ob_ass',6,1,'00','N','5',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_ass4','그렇다','ob_ass',6,2,'00','N','4',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_ass3','보통이다','ob_ass',6,3,'00','N','3',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_ass2','그렇지 않다','ob_ass',6,4,'00','N','2',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_ass1','매우 그렇지 않다','ob_ass',6,5,'00','N','1',null,'itgood','N');
---> 만족도 평가형 > 매우만족~매우불만족
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_sat5','매우 만족','ob_sat',6,1,'00','N','5',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_sat4','만족','ob_sat',6,2,'00','N','4',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_sa3','보통이다','ob_sat',6,3,'00','N','3',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_sat2','불만족','ob_sat',6,4,'00','N','2',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('ob_sat1','매우 불만족','ob_sat',6,5,'00','N','1',null,'itgood','N');

---> 점수형
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sc_num','5~1점','op_score',5,1,'00','N',null,null,'itgood','N');
---> 점수형 > 5~1점
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sc_num5','5점','sc_num',6,1,'00','N','5',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sc_num4','4점','sc_num',6,2,'00','N','4',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sc_num3','3점','sc_num',6,3,'00','N','3',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sc_num2','2점','sc_num',6,4,'00','N','2',null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,DEFAULTYN,ETC1,ETC2,REGMEMID,DELYN) VALUES ('sc_num1','1점','sc_num',6,5,'00','N','1',null,'itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드 > 프로그램코드 > 설문조사 > 설문조사진행상태
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,ETC1,ETC2,REGMEMID,DELYN) values ('svstatus01','종료','svstatuscd',4,1,'00',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,ETC1,ETC2,REGMEMID,DELYN) values ('svstatus02','미사용','svstatuscd',4,2,'00',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,ETC1,ETC2,REGMEMID,DELYN) values ('svstatus03','대기','svstatuscd',4,3,'00',null,null,'itgood','N');
INSERT INTO T_CODE (C_CODE,C_NAME,C_PCODE,C_DEPTH,C_ORDER,C_AUTH,ETC1,ETC2,REGMEMID,DELYN) values ('svstatus04','진행중','svstatuscd',4,4,'00',null,null,'itgood','N');

-- =============================  t_code : 기본코드 > 시스템 코드 > 프로그램코드 > 게시판관리
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('boardconfigcd', '게시판관리', 'programcd', '0>programcd', 2, 1, '00', 'N', '', '', '', 'itgood', 'N');
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('custom', '커스텀게시판', 'boardconfigcd', '0>programcd>boardconfigcd', 3, 1, '00', 'N', '', '', '', 'itgood', 'N');
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('columnType', '컬럼타입', 'custom', '0>programcd>boardconfigcd>custom', 4, 1, '00', 'N', '', '', '', 'itgood', 'N');
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('columnType01', '텍스트', 'columnType', '0>programcd>boardconfigcd>custom>columnType', 5, 1, '00', 'N', '', 'text', '', 'itgood', 'N');
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('columnType02', '텍스트영역', 'columnType', '0>programcd>boardconfigcd>custom>columnType', 5, 1, '00', 'N', '', 'textarea', '', 'itgood', 'N');
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('columnType03', '에디터', 'columnType', '0>programcd>boardconfigcd>custom>columnType', 5, 1, '00', 'N', '', 'editor', '', 'itgood', 'N');
INSERT INTO T_CODE (C_CODE, C_NAME, C_PCODE, C_PFULLCODE, C_DEPTH, C_ORDER, C_AUTH, DEFAULTYN, EXP1, ETC1, ETC2, REGMEMID, DELYN) VALUES ('columnType04', '숫자', 'columnType', '0>programcd>boardconfigcd>custom>columnType', 5, 1, '00', 'N', '', 'number', '', 'itgood', 'N');



-- =============================  t_manager
-- 관리자 추가
-- itgood/sitegood 통합관리자
INSERT INTO T_MANAGER (MNG_ID,MNG_NAME,MNG_PASS,MNG_PHONE,MNG_MOBILE,MNG_EMAIL,MNG_FAX,MNG_IPYN,MNG_AUTH,REGMEMID,DELYN)
values ('itgood','총괄관리','65dafd6f6c7140835ce029512e65b42a35a6665fdf018a8fcea140177a741434','031-386-0651','d582738cb43a1c344fce260486c2e8e5','9a04978675da809b036b1b9e225cc3c910bfbf015218d7d1de836d900a77a3c9','031-375-3322','N','99','itgood','N');


-- ============================= t_board_config
INSERT INTO T_BOARD_CONFIG (BC_ID,BC_NAME,BC_SKIN,BC_VIEWCOUNT,BC_DEFAULTPAGE,BC_LIST,BC_VIEW,BC_REGIST,BC_UPDATE,BC_REPLY,BC_MNGR_LIST,BC_MNGR_VIEW,BC_MNGR_REGIST,BC_MNGR_UPDATE,BC_MNGR_REPLY,BC_REPLYYN,BC_SECRETYN,BC_NOTICEYN,BC_EDITORYN,BC_PREVNEXTYN,BC_COMMENT,BC_RSS,BC_GROUPYN,BC_GROUPCODE,BC_FILEYN,BC_FILECOUNT,BC_FILESIZE,BC_FILETYPEDESC,BC_THUMBYN,BC_THUMBCOUNT,BC_THUMBWIDTH,BC_THUMBHEIGHT,BC_THUMBRATIOYN,REGMEMID,DELYN)
values ('default','일반게시판','default',10,'list','100','100','900','900','900','200','200','200','200','200','N','N','Y','Y','Y',0,'N','N','_default','Y',5,1000,'all','N',1,100,100,'N','itgood','N');
-- 기본 일반게시판에서 사용 할 코드
INSERT INTO t_code (c_code, c_name, c_pcode, c_depth, c_order, regmemid, delyn) VALUES ('_default', '일반게시판', 'board', 2, 1, 'itgood', 'N');


-- ============================= t_site
-- 기본 사이트 추가

INSERT INTO t_site
  (site_code, site_name)
VALUES
  ('web', 'CUBECMS');

INSERT INTO t_menu
  (menu_idx ,menu_code, menu_name, menu_type, menu_url, menu_navi, menu_depth, menu_pcode, menu_order, menu_memo, menu_useyn, menu_showtype, menu_mngurl, menu_chargeuseyn, mng_id, menu_researchuseyn, menu_pfullname, menu_pfullcode, menu_usetype, menu_qruseyn, menu_contents, regmemid, delyn, menu_sitecode, menu_fullorder)
VALUES
  (T_MENU_SEQ.nextval ,'web',  'CUBECMS', '5', '', '', 1, '0', 1, '', 'Y', '0', '', 'N', '', '', '>CUBECMS', '>web', '0', 'Y', '', 'itgood','N', 'web','001');


-- 기본 프로그램 : CMS 메뉴관리에서 아래 메뉴를  해당하는 코드로 생성해야함(소스에 하드코딩 되어 있음)
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '사이트맵','sitemap','view_mngrSitemap');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '로그인','userlogin','view_loginConfig');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '회원가입','memberRegist','view_joinFormConf');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '통합검색','totalSearch','view_totalSearch');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '소셜미디어','socialhub','view_snsConfig');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '약관정책','contract','view_contract');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '비밀번호 변경','passChange','view_mngrPassChange');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '아이디/비밀번호 찾기','findMyInfo','view_mngrFindIdPwd');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '설문조사','userSurveyList','-');
INSERT INTO T_PROGRAM (PROG_IDX,PROG_NAME,PROG_USERURL,PROG_MNGRURL) VALUES (t_program_seq.nextval, '회원정보수정','memberEdit','-');


-- 사이트(web) 기본메뉴  / 공통프로그램, 통합검색, 소셜미디어
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'web','common','공동프로그램','0',null,null,null,'web',2,1,'011001','>web>common','>CUBE CMS>공동프로그램',0,'0','0','0','N','Y','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'web','search','통합검색','0',null,null,null,'web',2,2,'011001005','>web>search','>CUBE CMS>통합검색',0,'0','1','0','N','Y','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'web','social','소셜','0',null,null,null,'web',2,3,'011008','>web>social','>CUBE CMS>소셜',0,'0','0','0','N','N','Y','N','N','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'common','policyPersonal','이용약관','2',null,'contract','view_contract','web',3,1,'011001001','>web>common>policyPersonal','>CUBE CMS>공동프로그램>이용약관',0,'0','0','0','N','Y','N','Y','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'common','login','로그인','2',null,'userlogin','view_loginConfig','web',3,2,'011001002','>web>common>webLogin','>CUBE CMS>공동프로그램>로그인',0,'0','0','0','N','N','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'common','sitemap','사이트맵','2',null,'sitemap','view_mngrSitemap','web',3,3,'011001003','>web>common>webSitemap','>CUBE CMS>공동프로그램>사이트맴',0,'0','0','0','N','Y','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'common','join','회원가입','2',null,'memberRegist','view_joinFormConf','web',3,4,'011001008','>web>common>menutest1','>CUBE CMS>공동프로그램>회원가입',0,'0','0','0','N','N','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'common','find','아이디/비밀번호찾기','2',null,'findMyInfo','view_mngrFindIdPwd','web',3,5,'011001007','>web>common>find','>CUBE CMS>공동프로그램>아이디/비밀번호찾기',0,'0','0','0','N','Y','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'common','passChange','비밀번호변경','2',null,'passChange','view_mngrPassChange','web',3,9,'011001009','>web>common>passChange','>CUBE CMS>공동프로그램>비밀번호변경',0,'0','0','0','N','N','Y','Y','N','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'search','webSearch','통합검색','2',null,'totalSearch','view_totalSearch','web',3,1,'011001005001','>web>search>webSearch','>CUBE CMS>통합검색>통합검색',0,'0','0','0','N','Y','Y','N','Y','Y','itgood','N');
INSERT INTO T_MENU (MENU_IDX,MENU_PCODE,MENU_CODE,MENU_NAME,MENU_TYPE,MENU_CATEGORY,MENU_URL,MENU_MNGURL,MENU_SITECODE,MENU_DEPTH,MENU_ORDER,MENU_FULLORDER,MENU_PFULLCODE,MENU_PFULLNAME,MENU_MAINPAGE,MENU_SHOWTYPE,MENU_USETYPE,MENU_USEFIXWIDTH,MENU_CHARGEUSEYN,MENU_RESEARCHUSEYN,MENU_LNBUSEYN,MENU_QRUSEYN,MENU_SNSSHAREYN,MENU_USEYN,REGMEMID,DELYN)
values (T_MENU_SEQ.nextval,'social','social1','소셜','2',null,'socialhub','view_snsConfig','web',3,1,'011008001','>web>social>social1','>CUBE CMS>소셜>소셜',0,'0','0','0','N','N','Y','Y','N','Y','itgood','N');


-- 기본 템플릿 : CMS 메뉴관리에서 아래 메뉴를  해당하는 코드로 생성해야함(소스에 하드코딩 되어 있음)
INSERT INTO t_templete (temp_idx , temp_code, temp_name, recent_bd_cnt, regmemid,sitecode) 	VALUES (T_TEMPLETE_SEQ.nextval, 'cms1', 'CUBE_TEMPLETE1', '1', 'itgood','web');
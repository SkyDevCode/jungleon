-- =============================  t_code : 기본코드
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('common', '공통코드', '0', 1, 1, '00', 'itgood', 'Y', 'N');

INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('board', '게시판 카테고리', '0', 1, 2, '00','itgood', 'Y', 'N');

INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('member', '회원관리', '0', 1, 3, '00','itgood', 'Y', 'N');

INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('group', '부서명', 'member', 2, 1, '00','itgood', 'Y', 'N');

INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('position', '직위', 'member', 2, 2, '00','itgood', 'Y', 'N');

INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('sysCd', '시스템코드', '0', 1, 6, '99', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('sysmenu', '시스템메뉴', 'sysCd', 2, 1, '99', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('mngrAuth','관리자등급','sysCd',3,1,'99','itgood','Y','N');

insert into `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
values ('programcd','프로그램코드','0',1,7,'00','','','itgood','Y','N');

-- =============================  t_code : 관리자메뉴
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('AUTHORITY', '권한관리', 'sysmenu', 3, 5, '80', '', 'fa-lock', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('AUTH_POWER', '관리자 권한 관리', 'AUTHORITY', 4, 4, '99', 'authority/mngrAuthorityPowerMain', '', 'itgood','Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('AUTH_ROLE', '컨텐츠 권한 관리', 'AUTHORITY', 4, 1, '80', 'authority/mngrAuthorityMain', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('BOARDCONFIG', '게시판관리', 'sysmenu', 3, 8, '80', '', 'fa-list-alt', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('BOARDCONFIG_M', '게시판관리', 'BOARDCONFIG', 4, 1, '80', 'boardconfig/mngrBoardconfigList', 'fa-list-alt', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('PROHIBIT_WORD', '금지어관리', 'BOARDCONFIG', 4, 2, '80', 'prohibitword/mngrProhibitWordMain', 'fa-list-alt', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('CODE', '코드 관리', 'SYSTEM', 4, 4, '90', 'code/mngrCodeMain', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('CONTENTS', '컨텐츠관리', 'sysmenu', 3, 4, '80', '', 'fa-newspaper-o', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('CONTENTS_MAIN', '컨텐츠 관리', 'CONTENTS', 4, 1, '80', 'mngrContents/_mngrContentsMain', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('SLIDE', '메인슬라이드 관리', 'CONTENTS', 4, 2, '80', 'slides/mngrSlidesList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('CONTRACT', '약관 관리', 'CONTENTS', 4, 3, '80', 'contract/mngrContractMain', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('BOARDREACTION', '답글 관리', 'CONTENTS', 4, 4, '80', 'boardReaction/replyList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('DEFAULT', '기본설정', 'SYSTEMCONFIG', 4, 3, '90', 'systemconfig', '', 'itgood', 'Y', 'N');
-- INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
-- VALUES ('GROUPM', '부서관리', 'MEMBERM', 4, 5, '80', 'group/mngrGroupList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('IP_MANAGE', '사용자 IP 관리', 'MEMBERM', 4, 6, '80', 'memIP/ipManageMain', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MEMBERM', '회원관리', 'sysmenu', 3, 6, '80', '', 'fa-user', 'itgood', 'Y', 'N');
-- insert into `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
-- values ('MEMBERM_COM','기업회원관리','MEMBERM',4,7,'80','module/mngrComemberList','','itgood','Y','N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MEMBER_LOGIN_LOG', '회원 로그인 로그', 'MEMBERM', 4, 3, '80', 'manager/mngrManagerLoginLogList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MEMBER_MANAGER', '관리자관리', 'MEMBERM', 4, 1, '80', 'manager/mngrManagerList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MEMBER_MANAGER_LOG', '관리자 로그', 'MEMBERM', 4, 4, '80', 'managerlog/mngrManagerLogList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MEMBER_USER', '일반회원관리', 'MEMBERM', 4, 2, '80', 'member/mngrMemberList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MENU', '메뉴관리', 'sysmenu', 3, 3, '80', '', 'fa-list', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MENU_SATIS', '메뉴 만족도', 'MENU', 4, 2, '80', 'menu/mngrMenuSatisfaction', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('MENU_SUB', '메뉴 관리', 'MENU', 4, 1, '80', 'menu/mngrMenuMain', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('POPUP', '팝업관리', 'sysmenu', 3, 7, '80', 'popup/mngrPopup', 'fa-desktop', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('PROGRAM', '프로그램 관리', 'SYSTEM', 4, 3, '90', 'program/mngrProgramList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('SITE', '사이트 관리', 'SYSTEM', 4, 2, '90', 'site/mngrSiteList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('SITECONFIG', '사이트설정', 'SYSTEMCONFIG', 4, 4, '80', 'systemconfigSite', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('STATS', '통계관리', 'sysmenu', 3, 9, '80', '', 'fa-bar-chart-o', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('STATS_BOARD', '게시판 통계', 'STATS', 4, 5, '80', 'stats/mngrStatsBoardView', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('STATS_DATE', '날짜별 접속통계', 'STATS', 4, 1, '80', 'stats/mngrStatsDateView', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('STATS_MENU', '메뉴별 접속통계', 'STATS', 4, 4, '80', 'stats/mngrStatsMenuView', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('STATS_OPTION', '옵션별 접속통계', 'STATS', 4, 3, '80', 'stats/mngrStatsOptView', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('STATS_TERM', '기간별 접속통계', 'STATS', 4, 2, '80', 'stats/mngrStatsTermView', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('SYSTEM', '시스템관리', 'sysmenu', 3, 2, '90', '', 'fa-gear', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('SYSTEMCONFIG', '환경설정', 'sysmenu', 3, 1, '80', 'systemconfig', 'fa-check-circle', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('TEMP', '템플릿관리', 'SYSTEM', 4, 5, '90', 'templeteconfig/templeteconfigList', '', 'itgood', 'Y', 'N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('SOCIALKEY', '소셜미디어 키 관리', 'SYSTEMCONFIG', 4, 5, '90', 'socialKey/socialMediaKeyList', '', 'itgood', 'Y', 'N');


-- INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
-- VALUES ('mngrAuth10','일반 관리자','mngrAuth',3,1,'99','10','','itgood','Y','N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('mngrAuth80','사이트 관리자','mngrAuth',3,2,'99','80','','itgood','Y','N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('mngrAuth90','통합 관리자','mngrAuth',3,3,'99','90','','itgood','Y','N');
INSERT INTO t_code (`c_code`, `c_name`, `c_pcode`, `c_depth`, `c_order`, `c_auth`, `etc1`, `etc2`, `regmemid`, `defaultyn`, `delyn`)
VALUES ('mngrAuth99','최고 관리자','mngrAuth',3,4,'99','99','','itgood','Y','N');


-- 프로그램 코드
-- 일반회원관리
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('membercd', '일반회원관리', 'programcd', '2', '6', '00', '', '', NOW(), NULL, NULL, 'itgood', NULL, NULL, 'y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('memstatuscd', '회원상태코드', 'membercd', '2', '3', '00', '', '', NOW(), NULL, NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('mem_cutoff', '차단', 'memstatuscd', '3', '2', '00', '', '', NOW(), NULL, NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('mem_del', '탈퇴', 'memstatuscd', '3', '3', '00', '', '', NOW(), NULL, NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('mem_normal', '승인', 'memstatuscd', '3', '1', '00', '', '', NOW(),  NULL, NULL, 'itgood', 'itgood', NULL, 'Y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('mem_unreceived', '미승인', 'memstatuscd', '3', '5', '00', '', '', NOW(), NULL, NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('mem_wait', '대기', 'memstatuscd', '3', '4', '00', '', '', NOW(), NULL, NULL, 'itgood', NULL, NULL, 'Y', 'N');

INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('career1', '경력직종코드', 'membercd', '3', '4', '00', '', '', '2017-07-12 13:33:21', '2017-07-12 13:33:21', NULL, 'itgood', NULL, NULL, 'N', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('ET', '기타', 'career1', '4', '5', '00', '', '', '2017-07-12 13:35:57', '2017-07-12 13:35:57', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('OJ', '사무직', 'career1', '4', '4', '00', '', '', '2017-07-12 13:35:42', '2017-07-12 13:35:42', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('PE', '생산직', 'career1', '4', '2', '00', '', '', '2017-07-12 13:34:56', '2017-07-12 13:34:56', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('RS', '연구직', 'career1', '4', '1', '00', '', '', '2017-07-12 13:34:34', '2017-07-12 13:34:34', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('SM', '영업직', 'career1', '4', '3', '00', '', '', '2017-07-12 13:35:24', '2017-07-12 13:35:24', NULL, 'itgood', NULL, NULL, 'Y', 'N');

INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('career2', '경력코드', 'membercd', '3', '5', '00', '', '', '2017-07-12 13:33:50', '2017-07-12 13:33:50', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('Y1', '1~3년', 'career2', '4', '1', '00', '', '', '2017-07-12 13:36:31', '2017-07-12 13:36:31', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('Y2', '4~6년', 'career2', '4', '2', '00', '', '', '2017-07-12 13:37:05', '2017-07-12 13:37:05', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('Y3', '7~10년', 'career2', '4', '3', '00', '', '', '2017-07-12 13:37:19', '2017-07-12 13:37:19', NULL, 'itgood', NULL, NULL, 'Y', 'N');
INSERT INTO `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regdt`,`upddt`,`deldt`,`regmemid`,`updmemid`,`delmemid`,`defaultyn`,`delyn`)
VALUES ('Y4', '10년 이상', 'career2', '4', '4', '00', '', '', '2017-07-12 13:37:38', '2017-07-12 13:37:38', NULL, 'itgood', NULL, NULL, 'Y', 'N');

-- 기업회원코드
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
VALUES ('comemcd', '기업회원코드', 'programcd', '2', '2', '00', '', '','itgood','Y', 'N');
INSERT INTO `t_code` (`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
VALUES ('comem_status', '기업회원상태', 'comemcd', '3', '1', '00', '', '','itgood','Y', 'N');
insert into `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
values ('com_status_0','미승인대기','comem_status',4,1,'00','','','itgood','Y','N');
insert into `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
values ('com_status_1','가입완료','comem_status',4,2,'00','','','itgood','Y','N');
insert into `t_code`(`c_code`,`c_name`,`c_pcode`,`c_depth`,`c_order`,`c_auth`,`etc1`,`etc2`,`regmemid`,`defaultyn`,`delyn`)
values ('com_status_2','회원탈퇴','comem_status',4,3,'00','','','itgood','Y','N');



-- =============================  t_power, t_power_authority
-- 관리자 권한추가
-- poContents 컨텐츠관리
-- aaaa/aaaa 총관리자
-- zzzz/zzzz 일반관리자

INSERT INTO t_power( power_name , power_code , regmemid , delyn ) VALUES ( '전체관리' , 'poTotal' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'SYSTEMCONFIG' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'DEFAULT' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'SITECONFIG' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'SYSTEM' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'PROGRAM' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'CODE' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'TEMP' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MENU' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MENU_SUB' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MENU_SATIS' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'CONTENTS' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'CONTENTS_MAIN' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'SLIDE' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'CONTRACT' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'AUTHORITY' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'AUTH_ROLE' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'AUTH_POWER' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MEMBERM' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MEMBER_MANAGER' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MEMBER_USER' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MEMBER_LOGIN_LOG' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'MEMBER_MANAGER_LOG' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'GROUPM' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'IP_MANAGE' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'POPUP' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'BOARDCONFIG' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'STATS' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'STATS_DATE' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'STATS_TERM' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'STATS_OPTION' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'STATS_MENU' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '1' , '1' , 'STATS_BOARD' , 'itgood' , 'N' );

INSERT INTO t_power( power_name , power_code , regmemid , delyn ) VALUES ( '컨텐츠관리' , 'poContents' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '2' , '1' , 'CONTENTS' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '2' , '1' , 'CONTENTS_MAIN' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '2' , '1' , 'SLIDE' , 'itgood' , 'N' );
INSERT INTO t_power_authority( power_idx , auth_type , menu_code , regmemid , delyn ) VALUES ( '2' , '1' , 'CONTRACT' , 'itgood' , 'N' );



-- =============================  t_manager
-- 관리자 추가
-- admin/admin 통합관리자
-- sitemng/sitemng 사이트관리자
-- normng/normng 일반관리자
INSERT INTO t_manager
  (mng_id, mng_name, mng_pass, mng_phone, mng_mobile, mng_email, mng_fax, group_code, position_code, mng_work, site_code, mng_ipyn, mng_ip, mng_passtrycnt, regmemid, delyn, mng_type, mng_auth)
VALUES
  ('admin', '통합관리자', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '031-386-0651', '010-0000-0000', 'admin@cubecms.com', '031-375-3322', 'group01', '', '통합관리자', '', 'N', '', 0, 'itgood', 'N', 1, '90');

INSERT INTO t_manager
  (mng_id, mng_name, mng_pass, mng_phone, mng_mobile, mng_email, mng_fax, group_code, position_code, mng_work, site_code, mng_ipyn, mng_ip, mng_passtrycnt, regmemid, delyn, mng_type, mng_auth)
VALUES
  ('sitemng', '사이트관리자', '7fbf7d428f9e10142173f96f3dae0de7a323808f5de5e507dd401c6e550221c0', '031-386-0651', '010-0000-0000', 'sitemng@cubecms.com', '031-375-3322', 'group01', '', '사이트관리자', '', 'N', '', 0, 'itgood', 'N', 1, '80');

INSERT INTO t_manager
  (mng_id, mng_name, mng_pass, mng_phone, mng_mobile, mng_email, mng_fax, group_code, position_code, mng_work, site_code, mng_ipyn, mng_ip, mng_passtrycnt, regmemid, delyn, mng_type, mng_auth)
VALUES
  ('normng', '일반관리자', 'bd2dda88a244c58dafe18797d4e1ea9449407e2c098d7e758fa994123147b943', '031-386-0651', '010-0000-0000', 'normng@cubecms.com', '', 'group01', '', '일반관리자', '', 'N', '', 0, 'itgood', 'N', 2, '80');

-- INSERT INTO t_manager
--  (mng_id, mng_name, mng_pass, mng_phone, mng_mobile, mng_email, mng_fax, group_code, position_code, mng_work, site_code, mng_ipyn, mng_ip, mng_passdt, mng_passtrycnt, regdt, upddt, deldt, regmemid, updmemid, delmemid, delyn, auth_idx, mng_type)
-- VALUES
--  ('itgood', '관리자', '$2a$10$FnW4eDJdhEKM72UEh5vuPuEs1CfB3UMvutR6OnviMO5hiV.lrZDFa', '031-386-0651', '', 'hyw@itgood.co.kr', '', 'group01', '', '관리', '', 'N', '', '2016-01-22 16:05:21', 0, '2016-01-22 16:05:21', '2016-03-09 10:40:48', NULL, '', 'itgood', '', 'N', 1, 'itgood');

-- ============================= t_board_config
INSERT INTO t_board_config
  (bc_id, bc_name, bc_skin, bc_topinfo, bc_viewcount, bc_list, bc_view, bc_regist, bc_update, bc_reply, bc_replyyn, bc_fileyn, bc_secretyn, bc_noticeyn, bc_groupyn, bc_groupcode, bc_filecount, bc_filesize, bc_defaultpage, bc_editoryn, bc_prevnextyn, bc_koglyn, regdt, upddt, deldt, regmemid, updmemid, delmemid, delyn, bc_mngr_list, bc_mngr_view, bc_mngr_regist, bc_mngr_update, bc_mngr_reply, bc_type, bc_thumbyn, bc_thumbcount, bc_thumbwidth, bc_thumbheight, bc_thumbratioyn, bc_filetypedesc, bc_RSS, bc_comment)
VALUES
  ('notice', '공지사항', 'default', '', 10, '100', '100', '900', '200', 'Y', 'Y', 'Y', 'Y', 'N', '_notice', 10, 100, 'list', 'Y', 'N', 'N',now(),now(),'', 'itgood', 'itgood', '', 'N', '200', '200', '200', '200', '200','' , 'N', 1, 100, 100, 'N', 'all', 'N', 0);
-- 기본 공지사항에서 사용 할 코드
INSERT INTO t_code
  (c_code, c_name, c_pcode, c_depth, c_order, regmemid, delyn)
VALUES
  ('_notice', '공지사항', 'board', 2, 1, 'itgood', 'N');


-- ============================= t_site
-- 기본 사이트 추가
--  경콘 개발서버 부분에 사이트 명 입력 예)'아이티굿'

INSERT INTO t_site
  (site_code, site_name)
VALUES
  ('web', 'CUBECMS');

INSERT INTO t_menu
  (menu_code, menu_name, menu_type, menu_url, menu_navi, menu_depth, menu_pcode, menu_order, menu_memo, menu_useyn, menu_showtype, menu_mngurl, menu_chargeuseyn, mng_id, menu_researchuseyn, menu_pfullname, menu_pfullcode, menu_usetype, menu_qruseyn, menu_contents, regmemid, delyn, menu_sitecode)
VALUES
  ('web',  'CUBECMS', '5', '', '', 1, '0', 1, '', 'Y', '0', '', 'N', '', '', '>CUBECMS', '>web', '0', 'Y', '', 'itgood','N', 'web');


-- 기본 프로그램 : CMS 메뉴관리에서 아래 메뉴를  해당하는 코드로 생성해야함(소스에 하드코딩 되어 있음)


insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('사이트맵','/main/sitemap.do','-');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('로그인','/login/login.do','/_mngr_/loginconfig/loginConfigMain.do');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('로그아웃','/login/logout.do','-');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('회원가입','/member/memberRegist.do','/_mngr_/joinformconfig/mngrJoinFormRegist.do');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('통합검색','/program/combineSearch.do','-');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('소셜미디어','socialhub','/_mngr_/program/systemconfigSns.do');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('약관정책','/program/contract.do','/_mngr_/program/mngrContract.do');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('회원정보수정','/member/informationMain.do','-');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('비밀번호 변경','/member/passMain.do','-');
insert into t_program (prog_name, prog_userurl, prog_mngrurl) values ('아이디/비밀번호 찾기','/member/findMyInfo.do','-');


-- 관리자 - 메뉴 관리에서 아래 메뉴 추가
-- 사이트맵 : (sitecode)Sitemap : 메뉴타입 - 프로그램 : 선택 "사이트맵"
-- 로그인 	: (sitecode)Login  : 메뉴타입 - 프로그램 : 선택 "로그인"
-- 로그아웃 : (sitecode)Logout : 메뉴타입 - 프로그램 : 선택 "로그아웃"
-- 회원가입 : (sitecode)MemReg : 메뉴타입 - 프로그램 : 선택 "회원가입"
-- 통합검색 : (sitecode)Search : 메뉴타입 - 프로그램 : 선택 "통합검색"
-- 소셜미디어: social : 메뉴타입 - 프로그램 : 선택 "소셜미디어"
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('common',	'공통프로그램',		'0',''	,				''		,2,'web'	,1,	'>CUBECMS>공통프로그램','>web>common','itgood','001','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('policyPersonal','개인정보처리방침',	'2','7'	,'/program/contract.do'	,'/_mngr_/program/mngrContract.do',3,'common'	,1,	'>CUBECMS>공통프로그램>개인정보처리방침','>web>common>policyPersonal','itgood','001001','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('policyTerms',	'이용 약관',		'2','7'	,'/program/contract.do'	,'/_mngr_/program/mngrContract.do',3,'common'	,2,	'CUBECMS>공통프로그램>이용 약관','>web>common>policyTerms','itgood','001002','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('tkdwonMemReg',	'회원가입',		'2','4'	,'/member/memberRegist.do',	'/_mngr_/joinformconfig/mngrJoinFormRegist.do',3,'common'	,3,	'>CUBECMS>공통프로그램>회원가입','>web>common>tkdwonMemReg','itgood','001003','web');
insert into `t_menu`(`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,`menu_navi`,`menu_depth`,`menu_pcode`,`menu_order`,`menu_memo`,`menu_useyn`,`menu_showtype`,`menu_mngurl`,`menu_chargeuseyn`,`mng_id`,`menu_lnbuseyn`,`menu_researchuseyn`,`menu_pfullname`,`menu_pfullcode`,`menu_usetype`,`menu_qruseyn`,`menu_contents`,`regmemid`,`updmemid`,`delyn`,`menu_fullorder`,`menu_mainpage`,`menu_snsshareyn`,`menu_sitecode`)
			values ('tkdwonMyInfo','회원정보수정','1','','','',3,'tkdwonMyPage',1,'','Y','0','','N','','Y','N','>CUBECMS>마이페이지>회원정보수정','>web>tkdwonMyPage>tkdwonMyInfo','0','N','','itgood',null,'N','009001',0,'N','web');
insert into `t_menu`(`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,`menu_navi`,`menu_depth`,`menu_pcode`,`menu_order`,`menu_memo`,`menu_useyn`,`menu_showtype`,`menu_mngurl`,`menu_chargeuseyn`,`mng_id`,`menu_lnbuseyn`,`menu_researchuseyn`,`menu_pfullname`,`menu_pfullcode`,`menu_usetype`,`menu_qruseyn`,`menu_contents`,`regmemid`,`updmemid`,`delyn`,`menu_fullorder`,`menu_mainpage`,`menu_snsshareyn`,`menu_sitecode`)
			values ('tkdwonMyPage','마이페이지','0','','','',2,'web',7,'','Y','0','','N','','Y','N','>CUBECMS>마이페이지','>web>tkdwonMyPage','1','N','','itgood',null,'N','009',0,'N','web');

insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('tkdwonLogin',		'로그인',		'2','2'	,'/login/login.do'	,'/_mngr_/loginconfig/loginConfigMain.do',3,'common'	,4,	'>CUBECMS>공통프로그램>로그인','>web>common>tkdwonLogin','itgood','001004','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('tkdwonLogout',	'로그아웃',		'2','3'	,'/login/logout.do'	,'-',3,'common'	,5,	'>CUBECMS>공통프로그램>로그아웃','>web>common>tkdwonLogout','itgood','001005','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('tkdwonSitemap',	'사이트맵',		'2','1'	,'/main/sitemap.do'	,'-',3,'common'	,6,	'>CUBECMS>공통프로그램>사이트맵','>web>common>tkdwonSitemap','itgood','001006','web');

insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('search','통합검색',		'0',''	,				''		,2,'web',	2,	'>CUBECMS>통합검색','>web>search','itgood','001','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('tkdwonSearch',	'통합검색',		'2','5'	,'/program/combineSearch.do'	,'-',3,'search'	,1,	'>CUBECMS>통합검색>통합검색','>web>search>tkdwonSearch','itgood','002001','web');

insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('social',	'소셜미디어',		'0',''	,				''	,2,'web',	3,	'>CUBECMS>소셜미디어','>web>social','itgood','001','web');
insert into t_menu (`menu_code`,`menu_name`,`menu_type`,`menu_subType`,`menu_url`,menu_mngurl,`menu_depth`,`menu_pcode`,`menu_order`,`menu_pfullname`,`menu_pfullcode`,`regmemid`,`menu_fullorder`,`menu_sitecode`)
			values ('tkdwonSocial',	'소셜미디어',		'2','6'	,'socialhub'	,'/_mngr_/program/systemconfigSns.do',3,'social'	,1,	'>CUBECMS>소셜미디어>소셜미디어','>web>social>tkdwonSocial','itgood','003001','web');



-- 기본 템플릿 : CMS 메뉴관리에서 아래 메뉴를  해당하는 코드로 생성해야함(소스에 하드코딩 되어 있음)
INSERT INTO `t_templete` (`temp_code`, `temp_name`, `recent_bd_cnt`, `regmemid`,`sitecode`) 	VALUES ('default', 'basic templet', '2','itgood','web');
INSERT INTO `t_templete` (`temp_code`, `temp_name`, `recent_bd_cnt`, `regmemid`,`sitecode`) 	VALUES ('cms1', 'special templet', '3', 'itgood','web');
INSERT INTO `t_templete` (`temp_code`, `temp_name`, `recent_bd_cnt`,`regmemid`,`sitecode`) 		VALUES ('cms2', 'normal templet', '0', 'itgood','web');



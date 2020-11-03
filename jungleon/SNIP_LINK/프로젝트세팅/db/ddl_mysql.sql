CREATE TABLE `j_attachfile` (
  `FILE_ID` varchar(13) NOT NULL,
  `FILE_SEQ` int(11) NOT NULL,
  `FILE_NAME` varchar(100) NOT NULL,
  `FILE_SIZE` int(11) DEFAULT NULL,
  `FILE_FOLDER` varchar(300) DEFAULT NULL,
  `FILE_MASK` varchar(100) DEFAULT NULL,
  `DOWNLOAD_COUNT` int(11) DEFAULT NULL,
  `DOWNLOAD_EXPIRE_DATE` varchar(8) DEFAULT NULL,
  `DOWNLOAD_LIMIT_COUNT` int(11) DEFAULT NULL,
  `REG_DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DELETE_YN` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`FILE_ID`,`FILE_SEQ`),
  UNIQUE KEY `J_ATTACHFILE_PK` (`FILE_ID`,`FILE_SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `T_FILEMANAGE` (
	`FILE_IDX` INT(11) NOT NULL AUTO_INCREMENT COMMENT '파일인덱스',
	`FILE_ID` VARCHAR(20) DEFAULT NULL COMMENT '파일아이디',
	`FILE_ORGNAME` VARCHAR(50) DEFAULT NULL COMMENT '기존파일명',
	`FILE_SAVENAME` VARCHAR(50) DEFAULT NULL COMMENT '저장파일명',
	`FILE_SIZE` int(11) DEFAULT NULL COMMENT '파일사이즈',
	`FILE_MASK` varchar(100) DEFAULT NULL COMMENT '파일유형',
	`FILE_STATUS` VARCHAR(20) DEFAULT NULL COMMENT '파일상태',
	`FILE_DN_CNT` int(11) DEFAULT NULL COMMENT '다운로드횟수',
	`FILE_DN_EXP_DATE` varchar(8) DEFAULT NULL COMMENT '다운로드허용일',
	`FILE_DN_LMT_CNT` int(11) DEFAULT NULL COMMENT '다운로드제한횟수',
	`ETC1` VARCHAR(50) DEFAULT NULL COMMENT '여분필드1',
	`ETC2` VARCHAR(50) DEFAULT NULL COMMENT '여분필드2',
	`USEYN` CHAR(1) DEFAULT 'Y' COMMENT '사용여부',
	`REGDT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	`UPDDT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
	`DELDT` DATETIME DEFAULT NULL COMMENT '삭제일',
	`REGMEMID` VARCHAR(20) DEFAULT NULL COMMENT '등록자아이디',
	`UPDMEMID` VARCHAR(20) DEFAULT NULL COMMENT '수정자아이디',
	`DELMEMID` VARCHAR(20) DEFAULT NULL COMMENT '삭제자아이디',
	`DELYN` CHAR(1) DEFAULT 'N' COMMENT '삭제',
	PRIMARY KEY (`FILE_IDX`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='파일정보';

CREATE TABLE `t_board` (
  `bd_idx` bigint(20) NOT NULL DEFAULT '0' COMMENT '게시물인덱스',
  `bc_id` varchar(20) DEFAULT NULL COMMENT '게시판아이디',
  `bd_code` varchar(20) DEFAULT NULL COMMENT '카테고리',
  `bd_writer` varchar(20) DEFAULT NULL COMMENT '작성자명',
  `bd_title` varchar(100) DEFAULT NULL COMMENT '제목',
  `bd_content` longtext COMMENT '내용',
  `bd_readnum` int(11) DEFAULT NULL COMMENT '조회수',
  `bd_passwd` varchar(100) DEFAULT NULL COMMENT '비밀번호',
  `bd_secret` char(1) DEFAULT NULL COMMENT '비밀글',
  `bd_notice` char(1) DEFAULT NULL COMMENT '공지글',
  `bd_useyn` char(1) DEFAULT NULL COMMENT '게시여부',
  `bd_ip` varchar(64) DEFAULT NULL COMMENT '아이피',
  `bd_phone` varchar(20) DEFAULT NULL COMMENT '전화번호',
  `bd_mobile` varchar(20) DEFAULT NULL COMMENT '휴대폰번호',
  `bd_email` varchar(100) DEFAULT NULL COMMENT '이메일주소',
  `bd_addr1` varchar(100) DEFAULT NULL COMMENT '주소1',
  `bd_addr2` varchar(100) DEFAULT NULL COMMENT '주소2',
  `bd_reidx` bigint(20) DEFAULT NULL COMMENT '답변글인덱스',
  `bd_relevel` smallint(6) DEFAULT NULL COMMENT '답변글레벨',
  `bd_reorder` smallint(6) DEFAULT NULL COMMENT '답변글순서',
  `bd_kogluseyn` char(1) DEFAULT NULL COMMENT '공공누리사용여부',
  `bd_kogltype1` varchar(50) DEFAULT NULL COMMENT '공공누리타입1',
  `bd_kogltype2` varchar(50) DEFAULT NULL COMMENT '공공누리타입2',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '작성자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  `bd_notice_sdt` varchar(10) DEFAULT NULL COMMENT '공지 시작일',
  `bd_notice_edt` varchar(10) DEFAULT NULL COMMENT '공지 종료일',
  `bd_use_sdt` varchar(10) DEFAULT NULL COMMENT '게시 시작일',
  `bd_use_edt` varchar(10) DEFAULT NULL COMMENT '게시 종료일',
  `file_id` varchar(13) DEFAULT NULL COMMENT '첨부파일 ID',
  `bd_use_termyn` char(1) DEFAULT NULL COMMENT '게시여부 기간사용YN',
  `bd_notice_termyn` char(1) DEFAULT NULL COMMENT '공지여부 기간사용YN',
  `group_code` varchar(20) DEFAULT NULL COMMENT '부서코드',
  `bd_thumb1` varchar(100) DEFAULT NULL COMMENT '썸네일1',
  `bd_thumb2` varchar(100) DEFAULT NULL COMMENT '썸네일2',
  `bd_thumb3` varchar(100) DEFAULT NULL COMMENT '썸네일3',
  `bd_thumb1_alt` varchar(500) DEFAULT NULL COMMENT '썸네일1 대체텍스트',
  `bd_thumb2_alt` varchar(500) DEFAULT NULL COMMENT '썸네일2 대체텍스트',
  `bd_thumb3_alt` varchar(500) DEFAULT NULL COMMENT '썸네일3 대체텍스트',
  `bd_answer` text COMMENT '답변내용',
  `bd_answer_writer` varchar(20) DEFAULT NULL COMMENT '답변 등록자',
  `bd_movie` varchar(100) DEFAULT NULL COMMENT '동영상',
  `bd_how_movie` char(1) DEFAULT NULL COMMENT '동영상 업로드 방식',
  PRIMARY KEY (`bd_idx`),
  UNIQUE KEY `bd_idx` (`bd_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='공통게시판';


CREATE TABLE `t_board_config` (
  `bc_id` varchar(50) NOT NULL DEFAULT '' COMMENT '게시판아이디',
  `bc_name` varchar(100) DEFAULT NULL COMMENT '게시판이름',
  `bc_skin` varchar(20) DEFAULT NULL COMMENT '게시판스킨',
  `bc_topinfo` varchar(255) DEFAULT NULL COMMENT '상단정보',
  `bc_viewcount` smallint(6) DEFAULT NULL COMMENT '게시물갯수',
  `bc_list` varchar(10) DEFAULT '100' COMMENT '목록권한',
  `bc_view` varchar(10) DEFAULT '100' COMMENT '조회권한',
  `bc_regist` varchar(10) DEFAULT '900' COMMENT '등록권한',
  `bc_update` varchar(10) DEFAULT '900' COMMENT '수정권한',
  `bc_reply` varchar(10) DEFAULT '900' COMMENT '답변권한',
  `bc_replyyn` char(1) DEFAULT NULL COMMENT '답변사용여부',
  `bc_fileyn` char(1) DEFAULT NULL COMMENT '첨부사용여부',
  `bc_secretyn` char(1) DEFAULT NULL COMMENT '비밀글사용여부',
  `bc_noticeyn` char(1) DEFAULT NULL COMMENT '공지글사용여부',
  `bc_groupyn` char(1) DEFAULT NULL COMMENT '카테고리사용여부',
  `bc_groupcode` varchar(200) DEFAULT NULL COMMENT '카테고리코드',
  `bc_filecount` smallint(6) DEFAULT NULL COMMENT '첨부갯수',
  `bc_filesize` smallint(6) DEFAULT NULL COMMENT '첨부용량',
  `bc_defaultpage` varchar(50) DEFAULT NULL COMMENT '기본페이지',
  `bc_editoryn` char(1) DEFAULT NULL COMMENT '에디터사용여부',
  `bc_prevnextyn` char(1) DEFAULT NULL COMMENT '이전/다음사용여부',
  `bc_koglyn` char(1) DEFAULT NULL COMMENT '공공누리사용여부',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  `bc_mngr_list` varchar(10) DEFAULT NULL COMMENT '관리자 목록권한',
  `bc_mngr_view` varchar(10) DEFAULT NULL COMMENT '관리자 조회권한',
  `bc_mngr_regist` varchar(10) DEFAULT NULL COMMENT '관리자 등록권한',
  `bc_mngr_update` varchar(10) DEFAULT NULL COMMENT '관리자 수정권한',
  `bc_mngr_reply` varchar(10) DEFAULT NULL COMMENT '관리자 답변권한',
  `bc_type` char(1) DEFAULT NULL COMMENT '게시판유형(1공통.2커스텀)',
  `bc_thumbyn` char(1) DEFAULT NULL COMMENT '썸네일사용여부',
  `bc_thumbcount` smallint(6) DEFAULT '1' COMMENT '썸네일갯수',
  `bc_thumbwidth` smallint(6) DEFAULT NULL COMMENT '썸네일 가로사이즈',
  `bc_thumbheight` smallint(6) DEFAULT NULL COMMENT '썸네일 세로사이즈',
  `bc_thumbratioyn` char(1) DEFAULT NULL COMMENT '비율유지 Y유지N고정',
  `bc_filetypedesc` varchar(100) DEFAULT 'all' COMMENT '첨부파일 확장자 descripter ',
  `bc_RSS` char(1) DEFAULT NULL COMMENT 'RSS 사용 여부',
  `bc_comment` int(11) DEFAULT '0' COMMENT '댓글 사용어부',
  PRIMARY KEY (`bc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판관리';


CREATE TABLE `t_code` (
  `c_code` varchar(50) NOT NULL COMMENT '코드',
  `c_name` varchar(50) DEFAULT NULL COMMENT '코드명',
  `c_pcode` varchar(20) DEFAULT NULL COMMENT '부모코드',
  `c_depth` smallint(6) DEFAULT NULL COMMENT '뎁스',
  `c_order` smallint(6) DEFAULT NULL COMMENT '코드순서',
  `c_auth` char(2) DEFAULT '00' COMMENT '코드권한',
  `etc1` varchar(50) DEFAULT NULL COMMENT '기타',
  `etc2` varchar(100) DEFAULT NULL COMMENT '기타',
  `exp1` varchar(1000) DEFAULT NULL COMMENT '설명1',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `defaultyn` char(1) DEFAULT 'N' COMMENT '기본생성코드',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  PRIMARY KEY (`c_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='코드관리';

CREATE TABLE `t_comember` (
	`comem_idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '기업인덱스',
	`comem_id` varchar(20) DEFAULT NULL COMMENT '기업아이디',
	`comem_comno` varchar(12) DEFAULT NULL COMMENT '사업자등록번호',
	`comem_name` varchar(50) DEFAULT NULL COMMENT '기업명',
	`comem_ceonm` varchar(20) DEFAULT NULL COMMENT '대표자이름',
	`comem_code_type` varchar(20) DEFAULT NULL COMMENT '업태',
	`comem_code_cate` varchar(20) DEFAULT NULL COMMENT '업종',
	`comem_empl` varchar(5) DEFAULT NULL COMMENT '상시근로자수',
	`comem_post` varchar(6) DEFAULT NULL COMMENT '우편번호(도로명)',
	`comem_addr1` varchar(200) DEFAULT NULL COMMENT '주소(도로명)',
	`comem_addr2` varchar(200) DEFAULT NULL COMMENT '주소 상세(도로명)',
	`comem_chrge_name` varchar(20) DEFAULT NULL COMMENT '담당자성명',
	`comem_chrge_grp` varchar(20) DEFAULT NULL COMMENT '담당자부서',
	`comem_chrge_pos` varchar(20) DEFAULT NULL COMMENT '담당자직위',
	`comem_chrge_post` varchar(6) DEFAULT NULL COMMENT '담당자 우편번호(도로명)',
	`comem_chrge_addr1` varchar(200) DEFAULT NULL COMMENT '담당자 주소(도로명)',
	`comem_chrge_addr2` varchar(200) DEFAULT NULL COMMENT '담당자 주소 상세(도로명)',
	`comem_chrge_cell` varchar(15) DEFAULT NULL COMMENT '담당자휴대폰',
	`comem_chrge_tel` varchar(15) DEFAULT NULL COMMENT '담당자회사전화',
	`comem_chrge_mail` varchar(100) DEFAULT NULL COMMENT '담당자이메일',
	`comem_chrge_tname` varchar(20) DEFAULT NULL COMMENT '팀장성명',
	`comem_chrge_tmail` varchar(100) DEFAULT NULL COMMENT '팀장이메일',
	`comem_status` varchar(20) DEFAULT NULL COMMENT '기업상태',
	`etc1` varchar(50) DEFAULT NULL COMMENT '여분필드1',
	`etc2` varchar(50) DEFAULT NULL COMMENT '여분필드2',
	`useyn` char(1) DEFAULT 'Y' COMMENT '사용여부',
	`regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
	`upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
	`deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
	`regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
	`updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
	`delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
	`delyn` char(1) DEFAULT 'N' COMMENT '삭제',
	PRIMARY KEY (`comem_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='기업정보';

CREATE TABLE `t_comment` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '댓글 인덱스',
  `c_contents` longtext NOT NULL COMMENT '댓글 내용',
  `regmemid` varchar(20) NOT NULL COMMENT '작성자 아이디',
  `regdt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '작성일',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자 아이디',
  `upddt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  `delyn` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자 아이디',
  `deldt` datetime DEFAULT NULL COMMENT '삭제일',
  `bd_idx` int(11) NOT NULL COMMENT '게시글 번호',
  `c_reidx` int(11) NOT NULL COMMENT '대댓글 인덱스',
  `c_recomid` varchar(20) DEFAULT NULL COMMENT '대댓글 아이디',
  PRIMARY KEY (`idx`),
  UNIQUE KEY `idx_UNIQUE` (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='댓글 테이블';



CREATE TABLE `t_connection_log` (
  `CL_IDX` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '접속인덱스',
  `CL_AGENT` varchar(500) DEFAULT NULL COMMENT '접속정보',
  `CL_OS` varchar(150) DEFAULT NULL COMMENT '운영체제',
  `CL_BROWSER` varchar(150) DEFAULT NULL COMMENT '브라우저',
  `CL_KEYWORD` varchar(100) DEFAULT NULL COMMENT '검색어',
  `CL_REFERER` varchar(500) DEFAULT NULL COMMENT '유입경로',
  `CL_IP` varchar(50) DEFAULT NULL COMMENT '접속아이피',
  `CL_LANGUAGE` varchar(50) DEFAULT NULL COMMENT '접속언어',
  `REGDT` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '접속일',
  PRIMARY KEY (`CL_IDX`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='접속로그데터이터';


CREATE TABLE `t_count_date` (
  `CD_IDX` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `CNT_OPTION` varchar(50) NOT NULL COMMENT '구분',
  `CNT_YEAR` char(4) CHARACTER SET latin1 NOT NULL DEFAULT '2000' COMMENT '년도',
  `CNT_MONTH` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '월',
  `CNT_DAY` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '일',
  `CNT_HOUR` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '24시',
  `CNT_COUNT` bigint(20) NOT NULL DEFAULT '1' COMMENT '카운트',
  `SITE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
  `ETC` varchar(100) DEFAULT NULL COMMENT '기타',
  PRIMARY KEY (`CD_IDX`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='날짜별 접속통계정보';


CREATE TABLE `t_count_menu` (
  `CM_IDX` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `CNT_OPTION` varchar(50) NOT NULL,
  `CNT_NAME` varchar(50) NOT NULL COMMENT '메뉴이름',
  `CNT_YEAR` char(4) CHARACTER SET latin1 NOT NULL DEFAULT '2000' COMMENT '년도',
  `CNT_MONTH` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '월',
  `CNT_DAY` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '일',
  `CNT_COUNT` bigint(20) NOT NULL DEFAULT '1' COMMENT '카운트',
  `SITE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
  `ETC` varchar(100) DEFAULT NULL COMMENT '기타',
  PRIMARY KEY (`CM_IDX`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='메뉴별 접속통계정보';


CREATE TABLE `t_count_option` (
  `CO_IDX` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `CNT_OPTION` varchar(50) NOT NULL COMMENT '구분',
  `CNT_NAME` varchar(50) NOT NULL COMMENT '이름',
  `CNT_YEAR` char(4) CHARACTER SET latin1 NOT NULL DEFAULT '2000' COMMENT '년도',
  `CNT_MONTH` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '월',
  `CNT_DAY` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '일',
  `CNT_COUNT` bigint(20) NOT NULL DEFAULT '1' COMMENT '카운트',
  `SITE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
  `ETC` varchar(100) DEFAULT NULL COMMENT '기타',
  PRIMARY KEY (`CO_IDX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='조건별 접속통계정보';

CREATE TABLE t_count_popup (
   CP_IDX bigint(20) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
   POP_IDX bigint(20) NOT NULL COMMENT '팝업 인덱스',
   CNT_OPTION varchar(50) NOT NULL COMMENT '구분',
   CNT_YEAR char(4) CHARACTER SET latin1 NOT NULL DEFAULT '0000' COMMENT '년도',
   CNT_MONTH char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '월',
   CNT_DAY char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '일',
   CNT_COUNT bigint(20) NOT NULL DEFAULT '1' COMMENT '카운트',
   SITE_CODE varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
   ETC varchar(100) COMMENT '기타',
  PRIMARY KEY (`CP_IDX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='팝업 통계정보';

CREATE TABLE `t_count_sns` (
  `CS_IDX` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `CNT_NAME` varchar(50) NOT NULL COMMENT '메뉴이름',
  `CNT_URL` varchar(200) NOT NULL COMMENT 'URL',
  `CNT_SM_NAME` varchar(20) NOT NULL COMMENT 'SNS이름',
  `CNT_OPTION` varchar(50) NOT NULL COMMENT '구분',
  `CNT_YEAR` char(4) CHARACTER SET latin1 NOT NULL DEFAULT '0000' COMMENT '년도',
  `CNT_MONTH` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '월',
  `CNT_DAY` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '00' COMMENT '일',
  `CNT_COUNT` bigint(20) NOT NULL DEFAULT '1' COMMENT '카운트',
  `SITE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
  `ETC` varchar(100) COMMENT '기타',
  PRIMARY KEY (`CS_IDX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SNS 공유 통계정보';

CREATE TABLE `t_group` (
  `group_code` varchar(20) NOT NULL DEFAULT '' COMMENT '부서코드',
  `group_name` varchar(20) NOT NULL DEFAULT '' COMMENT '부서명',
  `group_pcode` varchar(20) NOT NULL DEFAULT '' COMMENT '부서 부모코드',
  `group_depth` smallint(6) NOT NULL DEFAULT '0' COMMENT '부서뎁스',
  `group_order` smallint(6) NOT NULL DEFAULT '0' COMMENT '부서순서',
  `group_tel` varchar(15) DEFAULT NULL COMMENT '부서전화번호',
  `group_memo` varchar(255) DEFAULT NULL COMMENT '부서업무/설명',
  PRIMARY KEY (`group_code`,`group_name`,`group_pcode`,`group_depth`,`group_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='부서관리';


CREATE TABLE `t_ipcountry` (
  `startipnum` varchar(11) DEFAULT NULL,
  `endipnum` varchar(11) DEFAULT NULL,
  `countrycode2` varchar(50) DEFAULT NULL,
  `countrycode3` varchar(50) DEFAULT NULL,
  `countryname` varchar(61) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `t_login_log` (
  `log_regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '접속일시',
  `log_id` varchar(30) DEFAULT NULL COMMENT '아이디',
  `log_type` char(1) DEFAULT NULL COMMENT '로그인타입(사용자,관리자)',
  `log_ip` varchar(64) DEFAULT NULL COMMENT '아이피',
  `log_agent` varchar(500) DEFAULT NULL COMMENT '브라우저 정보',
  `log_os` varchar(50) DEFAULT NULL COMMENT '운영체제',
  `log_device` varchar(50) DEFAULT NULL COMMENT '디바이스',
  `log_browser` varchar(50) DEFAULT NULL COMMENT '브라우저',
  `log_site` varchar(20) DEFAULT NULL COMMENT '로그인사이트'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='로그인 로그';


CREATE TABLE `t_manager` (
  `mng_id` varchar(20) NOT NULL COMMENT '관리자아이디',
  `mng_name` varchar(20) DEFAULT NULL COMMENT '이름',
  `mng_pass` varchar(64) DEFAULT NULL COMMENT '비밀번호',
  `mng_phone` varchar(64) DEFAULT NULL COMMENT '전화번호',
  `mng_mobile` varchar(64) DEFAULT NULL COMMENT '휴대폰번호',
  `mng_email` varchar(64) DEFAULT NULL COMMENT '이메일주소',
  `mng_fax` varchar(64) DEFAULT NULL COMMENT '팩스번호',
  `group_code` varchar(20) DEFAULT NULL COMMENT '부서코드',
  `position_code` varchar(20) DEFAULT NULL COMMENT '직위',
  `mng_work` text COMMENT '담당업무',
  `site_code` varchar(20) DEFAULT NULL COMMENT '사이트코드',
  `mng_ipyn` char(1) DEFAULT NULL COMMENT '아이피제한사용여부',
  `mng_ip` varchar(300) DEFAULT NULL COMMENT '아이피',
  `mng_passdt` DATETIME DEFAULT NULL COMMENT '비밀번호수정일',
  `mng_passtrycnt` smallint(6) DEFAULT NULL COMMENT '비밀번호오류횟수',
  `regdt` timestamp NOT NULL DEFAULT current_timestamp COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  `auth_idx` bigint(20) DEFAULT NULL,
  `mng_type` varchar(20) DEFAULT NULL COMMENT '관리자구분',
  `mng_auth` char(2) DEFAULT '00' COMMENT '관리자권한',
  PRIMARY KEY (`mng_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자정보';


CREATE TABLE `t_manager_list` (
  `idx` varchar(11) NOT NULL,
  `code` varchar(8) NOT NULL,
  `name` varchar(40) NOT NULL,
  `power` varchar(300) DEFAULT NULL,
  `regmemid` varchar(20) DEFAULT NULL,
  `regdate` varchar(20) DEFAULT NULL,
  `upddt` varchar(20) DEFAULT NULL,
  `updmemid` varchar(20) DEFAULT NULL,
  `delyn` char(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자 등급 리스트';


CREATE TABLE `t_manager_log` (
  `mlog_regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '저장일시',
  `mlog_class` varchar(255) DEFAULT NULL COMMENT '클래스명',
  `mlog_method` varchar(255) DEFAULT NULL COMMENT '메쏘드명',
  `mlog_type` char(1) DEFAULT NULL COMMENT '작업구분',
  `mng_id` varchar(30) DEFAULT NULL COMMENT '관리자아이디',
  `mng_name` varchar(30) DEFAULT NULL COMMENT '관리자이름',
  `mlog_ip` varchar(64) DEFAULT NULL COMMENT '접속아이피',
  `mlog_url` varchar(1000) DEFAULT NULL COMMENT '접속주소',
  `mlog_referer` varchar(1000) DEFAULT NULL COMMENT 'referer',
  `mlog_personalinfo` char(1) DEFAULT '0' COMMENT '개인정보접근권한변경'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='관리자 작업 로그';


CREATE TABLE `t_member` (
  `id` varchar(20) NOT NULL COMMENT '회원아이디',
  `name` varchar(20) DEFAULT NULL COMMENT '이름',
  `nickname` varchar(50) DEFAULT NULL COMMENT '닉네임',
  `pass` varchar(64) DEFAULT NULL COMMENT '비밀번호',
  `passdt` DATETIME DEFAULT NULL COMMENT '비밀번호수정일',
  `passtrycnt` int(11) DEFAULT '0' COMMENT '비밀번호오류횟수',
  `phone` varchar(64) DEFAULT NULL COMMENT '전화번호',
  `mobile` varchar(64) DEFAULT NULL COMMENT '휴대전화',
  `email` varchar(64) DEFAULT NULL COMMENT '이메일',
  `fax` varchar(64) DEFAULT NULL COMMENT '팩스',
  `oldpost` varchar(10) DEFAULT NULL COMMENT '구 우편번호',
  `oldaddr1` varchar(200) DEFAULT NULL COMMENT '구 주소',
  `oldaddr2` varchar(200) DEFAULT NULL COMMENT '구 주소 상세',
  `newpost` varchar(6) DEFAULT NULL COMMENT '신 우편주소(도로명)',
  `newaddr1` varchar(200) DEFAULT NULL COMMENT '신 주소(도로명)',
  `newaddr2` varchar(200) DEFAULT NULL COMMENT '신 주소 상세(도로명)',
  `birth` varchar(10) DEFAULT NULL COMMENT '생년월일',
  `sex` char(1) DEFAULT 'M' COMMENT '성별',
  `type` VARCHAR(20) DEFAULT NULL COMMENT '회원타입',
  `group` char(2) DEFAULT '00' COMMENT '회원그룹',
  `code` char(2) DEFAULT '00' COMMENT '회원코드',
  `comem_idx` bigint(20) DEFAULT NULL COMMENT '기업회원 인덱스(연계시 사용)',
  `position`varchar(20) DEFAULT NULL COMMENT '직급',
  `loginip` varchar(20) DEFAULT NULL COMMENT '로그인아이피',
  `logindt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '로그인일자',
  `logincountrycd` char(2) DEFAULT NULL COMMENT '접속국가코드',
  `logincountryname` varchar(100) DEFAULT NULL COMMENT '접속국가명',
  `loginbrowser` varchar(100) DEFAULT NULL COMMENT '접속브라우져',
  `loginbrowsericon` varchar(100) DEFAULT NULL COMMENT '로그인브라우져아이콘',
  `loginos` varchar(100) DEFAULT NULL COMMENT '접속 OS',
  `loginosicon` varchar(100) DEFAULT NULL COMMENT '로그인os아이콘',
  `regid` varchar(20) DEFAULT NULL COMMENT '가입자아이디',
  `regip` varchar(20) DEFAULT NULL COMMENT '가입아이피',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
  `regcountrycd` char(2) DEFAULT NULL COMMENT '가입국가코드',
  `regcountryname` varchar(100) DEFAULT NULL COMMENT '가입국가명',
  `regbrowser` varchar(100) DEFAULT NULL COMMENT '가입 브라우져',
  `regbrowsericon` varchar(100) DEFAULT NULL,
  `regos` varchar(100) DEFAULT NULL COMMENT '가입 OS',
  `regosicon` varchar(100) DEFAULT NULL,
  `updid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `updip` varchar(20) DEFAULT NULL COMMENT '수정자아이피',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `status` VARCHAR(20) DEFAULT NULL COMMENT '회원상태: 0:정상, 1:차단,2:삭제(탈퇴)',
  `delId` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delIp` varchar(20) DEFAULT NULL COMMENT '삭제자아이피',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `cutoffdt` DATETIME DEFAULT NULL COMMENT '차단일자',
  `cutoffreason` text COMMENT '차단사유',
  `smsyn` char(1) DEFAULT 'Y' COMMENT '문자수신여부',
  `emailyn` char(1) DEFAULT 'Y' COMMENT '이메일수신여부',
  `infoopenyn` char(1) DEFAULT 'Y' COMMENT '정보공개허용여부',
  `regsitecode` varchar(20) DEFAULT '' COMMENT '가입한 사이트코드',
  `unionmem` tinyint(4) DEFAULT '1' COMMENT '통합회원 사용 여부',
  `etc1` varchar(45) DEFAULT NULL COMMENT '여분필드',
  PRIMARY KEY (`id`),
  KEY `INDEX` (`id`,`name`,`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `t_menu` (
  `menu_code` varchar(50) NOT NULL DEFAULT '' COMMENT '메뉴코드',
  `menu_name` varchar(50) DEFAULT NULL COMMENT '메뉴이름',
  `menu_type` char(1) DEFAULT NULL COMMENT '메뉴타입',
  `menu_subType` varchar(100) DEFAULT NULL COMMENT '메뉴타입하위선택',
  `menu_url` varchar(100) DEFAULT NULL COMMENT '링크주소',
  `menu_navi` varchar(255) DEFAULT NULL COMMENT '네비게이션',
  `menu_depth` smallint(6) DEFAULT NULL COMMENT '뎁스',
  `menu_pcode` varchar(20) DEFAULT NULL COMMENT '부모메뉴코드',
  `menu_order` int(100) DEFAULT NULL COMMENT '순서',
  `menu_memo` text COMMENT '메모',
  `menu_useyn` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `menu_showtype` char(1) DEFAULT NULL COMMENT '메뉴방식',
  `menu_mngurl` varbinary(100) DEFAULT NULL COMMENT '관리자주소',
  `menu_chargeuseyn` char(1) DEFAULT NULL COMMENT '담당자사용여부',
  `mng_id` varchar(20) DEFAULT NULL COMMENT '담당자아이디',
  `menu_lnbuseyn` char(1) DEFAULT NULL COMMENT '사이드메뉴사용여부',
  `menu_researchuseyn` char(1) DEFAULT NULL COMMENT '만족도사용여부',
  `menu_pfullname` varchar(255) DEFAULT NULL COMMENT '메뉴 전체이름',
  `menu_pfullcode` varbinary(255) DEFAULT NULL COMMENT '메뉴 전체코드',
  `menu_usetype` char(1) DEFAULT NULL COMMENT '메뉴사용구분',
  `menu_qruseyn` char(1) DEFAULT NULL COMMENT 'QR사용여부',
  `menu_contents` longtext COMMENT '내용',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제여부',
  `menu_fullorder` varchar(100) DEFAULT NULL COMMENT '계층유지 순서',
  `menu_mainpage` int(1) DEFAULT '0' COMMENT '메인페이지 노출',
  `menu_snsshareyn` char(1) DEFAULT NULL COMMENT 'SNS공유 사용 여부',
  `menu_usefixwidth` char(1) DEFAULT '0' COMMENT '페이지형태',
  `menu_sitecode` varchar(20) DEFAULT NULL COMMENT '메뉴가 속한 사이트 ',
  PRIMARY KEY (`menu_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴관리';


CREATE TABLE `t_menu_contents` (
  `mc_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '컨텐츠관리 인덱스',
  `menu_code` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `mc_content` text COMMENT '내용',
  `mc_memo` text COMMENT '메모',
  `mc_previewyn` char(1) DEFAULT NULL COMMENT '미리보기사용여부',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  PRIMARY KEY (`mc_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='컨텐츠관리';


CREATE TABLE `t_menu_satisfaction` (
  `menu_code` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `id` varchar(20) DEFAULT NULL COMMENT '아이디',
  `type` char(1) DEFAULT NULL COMMENT '구분',
  `answer1` varchar(20) DEFAULT NULL COMMENT '응답1',
  `answer2` varchar(20) DEFAULT NULL COMMENT '응답2',
  `answer3` varchar(20) DEFAULT NULL COMMENT '응답3',
  `answer4` varchar(20) DEFAULT NULL COMMENT '응답4',
  `answer5` varchar(20) DEFAULT NULL COMMENT '응답5',
  `answer6` varchar(500) DEFAULT NULL COMMENT '응답6',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `ip` varchar(64) DEFAULT NULL COMMENT '아이피'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='메뉴 만족도';


CREATE TABLE `t_menu_program` (
  `menu_code` varchar(20) NOT NULL COMMENT '메뉴코드',
  `prog_idx` bigint(20) NOT NULL COMMENT '프로그램관리인덱스',
  `mp_opt1` varchar(20) DEFAULT NULL COMMENT '옵션1',
  `mp_opt2` varchar(20) DEFAULT NULL COMMENT '옵션2',
  `mp_opt3` varchar(20) DEFAULT NULL COMMENT '옵션3',
  `mp_value1` varchar(200) DEFAULT NULL COMMENT '값1',
  `mp_value2` varchar(200) DEFAULT NULL COMMENT '값2',
  `mp_value3` varchar(200) DEFAULT NULL COMMENT '값3',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`menu_code`,`prog_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='메뉴 프로그램 상세';


CREATE TABLE `t_popup` (
  `popup_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '팝업인덱스',
  `popup_type` char(1) DEFAULT NULL COMMENT '팝업구분',
  `popup_title` varchar(100) DEFAULT NULL COMMENT '제목',
  `popup_useyn` char(1) DEFAULT NULL COMMENT '사용여부',
  `popup_mobile` char(1) DEFAULT 'N' COMMENT '모바일 표출 여부',
  `popup_sdt` date DEFAULT NULL COMMENT '시작일',
  `popup_stm` varchar(10) DEFAULT NULL COMMENT '시작시',
  `popup_edt` date DEFAULT NULL COMMENT '종료일',
  `popup_etm` varchar(10) DEFAULT NULL COMMENT '종료시',
  `popup_img` varchar(100) DEFAULT NULL COMMENT '이미지',
  `popup_alt` text COMMENT '대체텍스트',
  `popup_url` varchar(150) DEFAULT NULL COMMENT '주소',
  `popup_linktype` char(1) DEFAULT NULL COMMENT '링크타입',
  `popup_width` smallint(6) DEFAULT NULL COMMENT '가로사이즈',
  `popup_height` smallint(6) DEFAULT NULL COMMENT '세로사이즈',
  `popup_order` smallint(6) DEFAULT NULL COMMENT '순서',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  `expires` varchar(3) DEFAULT NULL COMMENT '닫기설정',
  `popup_file` varchar(100) DEFAULT NULL COMMENT '첨부파일',
  `old_file_nm` varchar(100) DEFAULT NULL COMMENT '첨부파일명',
  `mv_file` varchar(100) DEFAULT NULL COMMENT '동영상 파일',
  `old_mv_file` varchar(100) DEFAULT NULL COMMENT '동영상 파일명',
  `upload_type` varchar(10) DEFAULT NULL COMMENT '업로드 형식',
  `stream_url` varchar(100) DEFAULT NULL COMMENT '실시간 동영상',
  PRIMARY KEY (`popup_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='팝업관리';

CREATE TABLE `t_popup_site` (
  `ps_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '팝업사이트인덱스',
  `popup_idx` bigint(20) NOT NULL COMMENT '팝업인덱스',
  `site_code` varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
  PRIMARY KEY (`ps_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='팝업사이트';

CREATE TABLE `t_power` (
  `power_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '권한 인덱스',
  `power_name` varchar(50) DEFAULT NULL COMMENT '권한 이름',
  `power_code` varchar(50) DEFAULT NULL COMMENT '권한 코드',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제',
  `power` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`power_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='관리자 권한 관리';

CREATE TABLE `t_power_authority` (
  `auth_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '권한인덱스',
  `auth_type` char(1) DEFAULT NULL COMMENT '권한구분',
  `menu_code` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `mng_id` varchar(20) DEFAULT NULL COMMENT '관리자아이디',
  `power_idx` bigint(20) DEFAULT NULL COMMENT '관리자권한 인덱스',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  PRIMARY KEY (`auth_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='관리자권한관리';

CREATE TABLE `t_program` (
  `prog_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '프로그램관리 인덱스',
  `prog_name` varchar(50) DEFAULT NULL COMMENT '프로그램 명',
  `prog_userurl` varchar(100) DEFAULT NULL COMMENT '사용자 주소',
  `prog_mngrurl` varchar(100) DEFAULT NULL COMMENT '관리자 주소',
  PRIMARY KEY (`prog_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='프로그램 관리';


CREATE TABLE `t_role` (
  `role_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '권한 롤 인덱스',
  `role_name` varchar(50) DEFAULT NULL COMMENT '권한 롤 이름',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제',
  PRIMARY KEY (`role_idx`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='권한 롤 관리';

CREATE TABLE `t_role_authority` (
  `auth_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '권한인덱스',
  `auth_type` char(1) DEFAULT NULL COMMENT '권한구분',
  `menu_code` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `mng_id` varchar(20) DEFAULT NULL COMMENT '관리자아이디',
  `role_idx` bigint(20) DEFAULT NULL COMMENT '권한 롤 인덱스',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT NULL COMMENT '삭제여부',
  PRIMARY KEY (`auth_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='권한관리';

CREATE TABLE `t_site` (
  `site_code` varchar(20) NOT NULL DEFAULT '' COMMENT '사이트코드',
  `site_name` varchar(20) DEFAULT NULL COMMENT '사이트이름',
  PRIMARY KEY (`site_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사이트관리';

CREATE TABLE `t_slide_item` (
  `slitem_idx` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '슬라이드인덱스',
  `slides_idx` bigint(20) DEFAULT NULL COMMENT '슬라이드셋인덱스',
  `slitem_title` varchar(100) DEFAULT NULL COMMENT '제목',
  `slitem_img` varchar(100) DEFAULT NULL COMMENT '이미지',
  `slitem_imgalt` text COMMENT '이미지대체텍스트',
  `slitem_linkgubun` char(1) DEFAULT '0' COMMENT '링크사용구분,0.사용안함,1.텍스트,2.이미지',
  `slitem_linkTimg` varchar(100) DEFAULT NULL COMMENT '링크아이템 타이틀이미지',
  `slitem_linkTtxt` varchar(200) DEFAULT NULL COMMENT '링크아이템 타이틀텍스트',
  `slitem_linktcolor` varchar(50) DEFAULT NULL COMMENT '링크아이템 타이틀색상',
  `slitem_linkSimg` varchar(100) DEFAULT NULL COMMENT '링크아이템 설명이미지',
  `slitem_linkStxt` varchar(200) DEFAULT NULL COMMENT '링크텍스트 설명텍스트',
  `slitem_linkscolor` varchar(50) DEFAULT NULL COMMENT '링크아이템 설명색상',
  `slitem_linkbtn` varchar(50) DEFAULT NULL COMMENT '링크아이템 바로가기버튼',
  `slitem_linkurl` varchar(100) DEFAULT NULL COMMENT '링크주소',
  `slitem_linkPosHor` varchar(20) DEFAULT 'l' COMMENT '링크위치 가로정렬(l,c,r)',
  `slitem_linkPosVer` varchar(20) DEFAULT 't' COMMENT '링크위치 세로정렬(t,m,b)',
  `slitem_linktype` char(1) DEFAULT '1' COMMENT '링크타입,1.현재창,2.새창',
  `slitem_order` smallint(6) DEFAULT NULL COMMENT '순서',
  `slitem_etc1` varchar(50) DEFAULT NULL COMMENT '여분필드1',
  `slitem_etc2` varchar(50) DEFAULT NULL COMMENT '여분필드2',
  `useyn` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제여부',
  PRIMARY KEY (`slitem_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='슬라이드이미지관리';

CREATE TABLE `t_slides` (
  `slides_idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '슬라이드셋인텍스',
  `slides_code` varchar(20) NOT NULL DEFAULT '' COMMENT '슬라이드셋코드',
  `slides_name` varchar(20) DEFAULT NULL COMMENT '슬라이드셋이름',
  `slides_type` varchar(20) DEFAULT '1' COMMENT '슬라이드셋타입',
  `slides_etc1` varchar(50) DEFAULT NULL COMMENT '여분필드1',
  `slides_etc2` varchar(50) DEFAULT NULL COMMENT '여분필드2',
  `useyn` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제',
  PRIMARY KEY (`slides_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='슬라이드셋관리';

CREATE TABLE `t_smaccesstoken` (
  `site_code` varchar(20) NOT NULL,
  `sm_name` varchar(20) NOT NULL,
  `sm_accesstoken` longtext,
  `sm_accessible` char(1) NOT NULL DEFAULT 'N',
  `sm_userid` longtext,
  `sm_issueDate` timestamp NULL DEFAULT NULL,
  `sm_etc2` longtext,
  PRIMARY KEY (`site_code`,`sm_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_smkeys` (
  `smkey_idx` INT NOT NULL AUTO_INCREMENT COMMENT '소셜미디어키인덱스',
  `sm_name` varchar(20) NOT NULL COMMENT '소셜미디어이름',
  `sm_appkey` longtext COMMENT '소셜미디어앱키',
  `sm_secretkey` longtext COMMENT '소셜미디어시크릿키',
  `useyn` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `sm_etc1` longtext COMMENT 'etc1',
  `sm_etc2` longtext COMMENT 'etc2',
  `regmemid` varchar(20) NOT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `regdt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  `deldt` timestamp NULL DEFAULT NULL COMMENT '삭제일',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제여부',
  `account_id` varchar(20) DEFAULT NULL COMMENT '소셜미디어계정아이디',
  `exp` longtext COMMENT '설명',
  PRIMARY KEY (`smkey_idx`),
  UNIQUE KEY `smkey_idx_UNIQUE` (`smkey_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='소셜미디어 관련 키 테이블';

CREATE TABLE `t_smprogram` (
  `smpro_idx` int NOT NULL AUTO_INCREMENT COMMENT '소셜미디어프로그램인덱스',
  `menu_code` varchar(20) NOT NULL COMMENT '프로그램메뉴코드',
  `smkey_idx` int NOT NULL COMMENT '소셜미디어키인덱스',
  `useyn` char(1) NOT NULL COMMENT '사용여부',
  `prom_text` longtext COMMENT '홍보문구',
  PRIMARY KEY (`smpro_idx`),
  UNIQUE KEY `smpro_idx_UNIQUE` (`smpro_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='소셜미디어프로그램 관련 테이블';

CREATE TABLE `t_templete` (
  `temp_idx` INT NOT NULL AUTO_INCREMENT COMMENT '템플릿인텍스',
  `temp_code` varchar(20) NOT NULL DEFAULT '' COMMENT '템플릿코드',
  `temp_name` varchar(20) DEFAULT NULL COMMENT '템플릿이름',
  `recent_bd_cnt` varchar(20) NOT NULL DEFAULT '1' COMMENT '최신글게시판개수',
  `temp_etc1` varchar(50) DEFAULT NULL COMMENT '여분필드1',
  `temp_etc2` varchar(50) DEFAULT NULL COMMENT '여분필드2',
  `useyn` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자아이디',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제',
  PRIMARY KEY (`temp_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿설정관리';

CREATE TABLE `t_ipmanage` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `site_code` varchar(45) NOT NULL,
  `ip_desc_type` int(1) DEFAULT NULL,
  `ip_desc` longtext,
  `regmemid` varchar(45) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(45) DEFAULT NULL COMMENT '수정자아이디',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`no`),
  UNIQUE KEY `no_UNIQUE` (`no`),
  KEY `sc_index` (`site_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='사용자 IP 관리';

CREATE TABLE `t_joinform` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `name` int(1) DEFAULT '0' COMMENT '이름',
  `nickname` int(1) DEFAULT '0' COMMENT '닉네임',
  `passtrycnt` int(11) DEFAULT '0' COMMENT '비밀번호오류횟수',
  `phone` int(1) DEFAULT '0' COMMENT '전화번호',
  `mobile` int(1) DEFAULT '0' COMMENT '휴대전화',
  `email` int(1) DEFAULT '0' COMMENT '이메일',
  `fax` int(1) DEFAULT '0' COMMENT '팩스',
  `address` int(1) DEFAULT '0' COMMENT '주소',
  `birth` int(1) DEFAULT '0' COMMENT '생년월일',
  `sex` int(1) DEFAULT '0' COMMENT '성별',
  `grp` int(1) DEFAULT '0' COMMENT '회원그룹',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록자아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자아이디',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `contractDesc` varchar(50) DEFAULT '' COMMENT '약관 descriptor',
  `sitecode` varchar(20) DEFAULT '' COMMENT 'sitecode',
  `use_joinwait` int(1) DEFAULT '0' COMMENT '가입승인',
  PRIMARY KEY (`no`),
  KEY `siteCode` (`sitecode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='회원 가입 폼 설정 테이블(0사용하지 않음,1:사용함(필수), 2:사용함(선택))';

CREATE TABLE `t_contract` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  `title` varchar(45) NOT NULL COMMENT '약관 제목',
  `contents` longtext NOT NULL COMMENT '약관 내용',
  `required` tinyint(4) NOT NULL DEFAULT '1' COMMENT '필수/선택 여부',
  `regmemid` varchar(20) DEFAULT NULL COMMENT '등록 관리자 ID',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정 관리자 ID',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제 관리자 ID',
  `regdt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `upddt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `deldt` DATETIME DEFAULT NULL COMMENT '삭제일',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제 여부',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='회원 약관';

CREATE TABLE `t_survey` (
  `sv_idx` int(11) NOT NULL COMMENT '설문 인덱스',
  `sv_title` longtext NOT NULL COMMENT '설문 제목',
  `sv_outline` longtext DEFAULT NULL COMMENT '설문 개요',
  `sv_explain` longtext DEFAULT NULL COMMENT '설문 설명',
  `sv_startdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '설문 시작일\n',
  `sv_enddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '설문 종료일',
  `regdt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일',
  `upddt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정일',
  `deldt` timestamp NULL DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) NOT NULL COMMENT '등록자 아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자 아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자 아이디',
  `useyn` char(1) NOT NULL DEFAULT 'N' COMMENT '사용 여부',
  `delyn` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  `etc1` longtext DEFAULT NULL COMMENT '여분 컬럼1',
  `etc2` longtext DEFAULT NULL COMMENT '여분 컬럼2',
  PRIMARY KEY (`sv_idx`),
  UNIQUE KEY `idx_UNIQUE` (`sv_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문조사 기본 정보 테이블';


CREATE TABLE `t_surveyanswer` (
  `sa_idx` int(11) NOT NULL COMMENT '답변 정보 인덱스',
  `sv_idx` int(11) NOT NULL COMMENT '설문 인덱스',
  `sa_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '답변 일자',
  `sa_id` varchar(20) NOT NULL COMMENT '답변자 아이디',
  PRIMARY KEY (`sa_idx`),
  UNIQUE KEY `sa_idx_UNIQUE` (`sa_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설문 답변 정보 테이블';


CREATE TABLE `t_surveyoption` (
  `so_idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '선택항목 인덱스',
  `sq_idx` int(11) NOT NULL COMMENT '설문 문항 인덱스(참조값)',
  `so_content` longtext NOT NULL COMMENT '선택항목 설명',
  `so_order` int(11) NOT NULL DEFAULT 0 COMMENT '선택항목 정렬값',
  `so_value` longtext DEFAULT NULL,
  `etc1` longtext DEFAULT NULL,
  `etc2` longtext DEFAULT NULL,
  PRIMARY KEY (`so_idx`),
  UNIQUE KEY `suro_idx_UNIQUE` (`so_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8 COMMENT='설문조사 선택항목 테이블';


CREATE TABLE `t_surveyquestion` (
  `sq_idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사 문항 인텍스',
  `sv_idx` int(11) NOT NULL COMMENT '설문조사 인덱스(참조값)',
  `sq_answertype` varchar(50) NOT NULL COMMENT '설문조사 문항 답변 타입',
  `sq_question` longtext NOT NULL COMMENT '설문조사 문항 질문',
  `regdt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '등록일',
  `upddt` timestamp NULL DEFAULT NULL COMMENT '수정일',
  `deldt` timestamp NULL DEFAULT NULL COMMENT '삭제일',
  `regmemid` varchar(20) NOT NULL COMMENT '삭제자 아이디',
  `updmemid` varchar(20) DEFAULT NULL COMMENT '수정자 아이디',
  `delmemid` varchar(20) DEFAULT NULL COMMENT '삭제자 아이디',
  `sq_order` int(11) NOT NULL DEFAULT 0 COMMENT '문항 순서',
  `delyn` char(1) DEFAULT 'N' COMMENT '삭제 여부',
  `sq_required` char(1) DEFAULT 'N' COMMENT '필수값 여부',
  `prof_idx` int(11) DEFAULT NULL COMMENT '강사 인덱스(참조값)',
  `etc1` longtext DEFAULT NULL,
  `etc2` longtext DEFAULT NULL,
  PRIMARY KEY (`sq_idx`),
  UNIQUE KEY `surq_index_UNIQUE` (`sq_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='설문조사 문항 테이블';


CREATE TABLE `t_surveyvalue` (
  `sa_idx` int(11) NOT NULL,
  `sq_idx` int(11) NOT NULL,
  `so_idx` int(11) DEFAULT NULL,
  `so_value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='답변 값 테이블';


CREATE TABLE T_PERSON_INFO_INQUIRY_LOG (
  INQIRE_INDX int(11) NOT NULL AUTO_INCREMENT COMMENT '조회인덱스',
  INQIRE_DATE datetime COMMENT '조회일시',
  MBER_ID varchar(30) COMMENT '회원아이디',
  REASON varchar(1000) COMMENT '조회사유',
  INQIRE_ID varchar(30) COMMENT '조회자아이디',
  INQIRE_NM varchar(30) COMMENT '조회자이름',
  INQIRE_IP varchar(64) COMMENT '조회아이피',
  REG_ID varchar(30) COMMENT '등록자',
  UPDT_ID varchar(30) COMMENT '수정자',
  DELETE_ID varchar(30) COMMENT '삭제자',
  REG_DATE datetime COMMENT '조회일시',
  UPDT_DATE datetime COMMENT '수정일시',
  DELETE_DATE datetime COMMENT '삭제일시',
  DELETE_YN char(1) DEFAULT 'N' COMMENT '삭제여부',
  PRIMARY KEY (INQIRE_INDX),
  UNIQUE KEY INQIRE_INDX (INQIRE_INDX)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='개인정보 조회 로그';

/*20180803 mysql 컨버전*/
ALTER TABLE t_smkeys
ADD COLUMN `site_code` VARCHAR(50) NULL DEFAULT NULL AFTER `exp`;
ALTER TABLE t_templete
ADD COLUMN `sitecode` VARCHAR(20) NULL DEFAULT NULL AFTER `delyn`;

CREATE TABLE t_manager_role (
  `MR_IDX` INT NOT NULL COMMENT '인덱스',
  `MR_MNG_ID` VARCHAR(20) NOT NULL COMMENT '권한적용된 ID',
  `MR_ROLE_IDX` VARCHAR(20) NULL COMMENT '권한인덱스',
  `REGMEMID` VARCHAR(20) NULL COMMENT '권한부여ID',
  `REGDATE` VARCHAR(20) NULL COMMENT '권한부여일',
  `DELYN` CHAR(1) NULL DEFAULT 'N' COMMENT '삭제여부',
  `MR_ID` VARCHAR(20) NULL COMMENT '권한 ID',
  `MR_SITE_CODE` VARCHAR(20) NULL COMMENT '사이트코드',
  `DELDATE` VARCHAR(20) NULL COMMENT '삭제일',
  `DELMEMID` VARCHAR(20) NULL COMMENT '삭제자ID',
  PRIMARY KEY (`MR_IDX`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COMMENT = '관리자 작업 권한';

ALTER TABLE t_role
ADD COLUMN `SITE_CODE` VARCHAR(20) NULL COMMENT '사이트코드' AFTER `delyn`;

ALTER TABLE t_popup
ADD COLUMN `EDIT_CONTENTS` TEXT NULL COMMENT '에디터 내용' AFTER `stream_url`;

ALTER TABLE t_manager
CHANGE COLUMN `auth_idx` `auth_idx` VARCHAR(200) NULL DEFAULT NULL ;

ALTER TABLE t_member
ADD COLUMN `DELYN` CHAR(1) NULL COMMENT '삭제여부' AFTER `etc1`;

ALTER TABLE t_role_authority
ADD COLUMN `SITE_CODE` VARCHAR(20) NULL COMMENT '사이트코드' AFTER `delyn`;

ALTER TABLE t_board
ADD COLUMN `BD_SCH_SDT` VARCHAR(20) NULL AFTER `bd_how_movie`,
ADD COLUMN `BD_SCH_EDT` VARCHAR(20) NULL AFTER `BD_SCH_SDT`;

ALTER TABLE t_comment
CHANGE COLUMN `idx` `c_idx` INT(11) NOT NULL AUTO_INCREMENT COMMENT '댓글 인덱스' ,
ADD COLUMN `C_WRITER` VARCHAR(60) NULL DEFAULT NULL COMMENT '댓글 작성자' AFTER `c_idx`,
ADD COLUMN `C_RECOMNAME` VARCHAR(60) NULL DEFAULT NULL COMMENT '대댓글 이름' AFTER `c_recomid`;

ALTER TABLE `t_member`
ADD COLUMN `di` CHAR(64) NULL DEFAULT NULL COMMENT '개인 회원의 중복가입여부 확인 키' AFTER `DELYN`,
ADD COLUMN `ci` CHAR(88) NULL DEFAULT NULL COMMENT '주민등록번호와 1:1로 매칭되는 고유키' AFTER `di`,
ADD COLUMN `p_name` VARCHAR(20) NULL DEFAULT NULL COMMENT '부모님이름' AFTER `ci`,
ADD COLUMN `p_mobile` VARCHAR(64) NULL DEFAULT NULL COMMENT '부모님핸드폰' AFTER `p_name`,
ADD COLUMN `dormant` CHAR(1) NULL DEFAULT NULL COMMENT '휴면계좌 Y:휴면 N:정상' AFTER `p_mobile`,
CHANGE COLUMN `type` `type` VARCHAR(20) NULL DEFAULT NULL COMMENT 'member: 일반 child: 어린이 foreigner: 외국인' ;

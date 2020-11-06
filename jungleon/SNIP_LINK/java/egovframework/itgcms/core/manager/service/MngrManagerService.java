/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.itgcms.core.manager.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.ItgMap;
import org.springframework.ui.ModelMap;

/**
 * @파일명 : MngrManagerService.java
 * @파일정보 : 관리자관리 서비스 interface
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 5. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
public interface MngrManagerService {

    /**
	 * 관리자 목록을 조회한다(로그용).
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    List<?> selectMngrManagerList(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    /**
	 * 관리자 목록을 조회한다(모듈용).
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    List<?> mMngrManagerList(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    /**
	 * 관리자 수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
    int mngrManagerListTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    void insertMngrManagerProc(MngrManagerVO mngrManagerVO) throws IOException, SQLException;

    MngrManagerVO mngrManagerView(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    String mngrManagerCheckPower(MngrManagerVO mngrManagerVO) throws IOException, SQLException;

	String updateMngrManagerUpdateProc(MngrManagerVO mngrManagerVO) throws IOException, SQLException;

	void deleteMngrManagerProc(MngrManagerVO mngrManagerVO)throws IOException, SQLException;

	void deleteMngrManagerChkProc(MngrManagerVO mngrManagerVO)throws IOException, SQLException;

	int mngrManagerCheckId(MngrManagerSearchVO mngrManagerSearchVO)throws IOException, SQLException;

	void mngrManagerInitPass(MngrManagerVO managerVO)throws IOException, SQLException;

	void increaseMngPassTryCnt(MngrManagerVO managerVO)throws IOException, SQLException;

	List<MngrManagerVO> mngrManagerListAjax(MngrManagerSearchVO mngrManagerSearchVO)throws IOException, SQLException;

	List<?> mngrManagerAuthListAjax(String mngRole) throws IOException, SQLException;

	List<?> mngrManagerAuthPowerListAjax(String powerCode) throws IOException, SQLException;

	void mngrManagerLoginLogInsert(MngrManagerLoginLogVO mngrManagerLoginLogVO) throws IOException, SQLException;

	List<MngrManagerLoginLogVO> mngrManagerLoginLogAjax(String log_id) throws IOException, SQLException;

	List<MngrManagerLoginLogVO> selectMngrManagerLoginLogList(
			MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws IOException, SQLException;

	int mngrManagerLoginLogListTotCnt(
			MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws IOException, SQLException;

	void deleteMngrManagerLoginLogProc(
			MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws IOException, SQLException;

	String chkPassBfView(String mngrId) throws IOException, SQLException;

	/** 3.07 버전 추가 **/
    /**
	 * 관리자 목록을 조회한다(사이트별 모듈용).
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
	 * @return 관리자목록
	 * @exception Exception
	 */
    List<?> managerListBySite(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;
    int managerListBySiteTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;
    List<?> managerListBySiteForIndividual(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;
    int managerListBySiteForIndividualTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

	/**
	 * 관리자 목록을 조회한다 (조직도 부서 관리자)
	 * @param model
	 * @param itgMap - 조회할 정보가 담긴 map
	 * @throws IOException
	 * @throws SQLException
	 */
	void selectOrgManager(ModelMap model, ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자 목록을 조회한다 (조직도 부서 사용자)
	 * @param model
	 * @param itgMap - 조회할 정보가 담긴 map
	 * @throws IOException
	 * @throws SQLException
	 */
	void selOrgManager(ModelMap model, ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자 목록을 조회한다 (조직도 관리자 추가)
	 * @param itgMap
	 * @return String
	 */
	String selectOrgAllManagerList(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자 부서를 추가한다 (조직도 관리자 부서 추가)
	 * @param itgMap
	 * @return int
	 * @throws IOException
	 * @throws SQLException
	 */
	int inputOrgMngGroup(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자를 부서에서 제외한다 (조직도 관리자 부서 제외)
	 * @param itgMap
	 * @return int
	 */
	int deleteOrgMngGroup(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자를 부서에서 제외한다 (조직도 관리자 부서 제외)
	 * @param itgMap
	 * @return int
	 */
	int updateOrgMngGroupOrder(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 오류신고 담당자 목록 조회
	 * @param itgMap
	 * @return List
	 * @throws IOException
	 * @throws SQLException
	 */
	List<ItgMap> selectErrorManagerList(ItgMap itgMap) throws IOException, SQLException;

	MngrManagerVO selectManagerForCheck(MngrManagerVO managerVO) throws IOException, SQLException;

	int updateManagerPassword(MngrManagerVO managerVO) throws IOException, SQLException;

    /**
	 * 관리자 목록을 조회한다(마이그레이션용).
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    List<ItgMap> mMngrManagerListForMigration(ItgMap paramMap) throws IOException, SQLException;

	void updateManagerPartInfo(MngrManagerVO managerVO) throws SQLException;

	void selectOrgchtSchMngView(ModelMap model, ItgMap itgMap) throws SQLException;
}
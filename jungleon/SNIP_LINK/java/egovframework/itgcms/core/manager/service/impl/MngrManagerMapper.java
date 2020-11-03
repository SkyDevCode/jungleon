/*
 * Copyright 2011 MOPAS(Ministry of Public Mngristration and Security).
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
package egovframework.itgcms.core.manager.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogVO;
import egovframework.itgcms.core.manager.service.MngrManagerSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * manager에 관한 데이터처리 매퍼 클래스
 *
 * @author  표준프레임워크센터
 * @since 2014.01.24
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2014.01.24        표준프레임워크센터          최초 생성
 *
 * </pre>
 */
@Mapper("mngrManagerMapper")
public interface MngrManagerMapper {

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    List<?> mngrManagerList(MngrManagerSearchVO searchVO) throws SQLException;

    /**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
    int mngrManagerListTotCnt(MngrManagerSearchVO searchVO) throws SQLException;

    int insertMngrManagerProc(MngrManagerVO managerVO) throws SQLException;

    MngrManagerVO mngrManagerView(MngrManagerSearchVO searchVO) throws SQLException;

	int mngrManagerUpdateProc(MngrManagerVO managerVO) throws SQLException;

	void deleteMngrManagerProc(MngrManagerVO managerVO)throws SQLException;

	void deleteMngrManagerChkProc(MngrManagerVO managerVO)throws SQLException;

	int mngrManagerCheckId(MngrManagerSearchVO mngrManagerSearchVO)throws SQLException;

	void mngrManagerInitPass(MngrManagerVO managerVO)throws SQLException;

	void increaseMngPassTryCnt(MngrManagerVO managerVO)throws SQLException;

	List<MngrManagerVO> mngrManagerListAjax(MngrManagerSearchVO mngrManagerSearchVO)throws SQLException;

	List<?> mngrManagerAuthListAjax(String mngRole)throws SQLException;

	List<?> mngrManagerAuthPowerListAjax(String powerCode)throws SQLException;

	void mngrManagerLoginLogInsert(MngrManagerLoginLogVO mngrManagerLoginLogVO)throws SQLException;

	List<MngrManagerLoginLogVO> mngrManagerLoginLogAjax(String log_id)throws SQLException;

	List<MngrManagerLoginLogVO> selectMngrManagerLoginLogList(
			MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws SQLException;


	int mngrManagerLoginLogListTotCnt(
			MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws SQLException;

	void deleteMngrManagerLoginLogProc(
			MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws SQLException;

	/**
	 * 회원정보 상세 진입 중 비밀번호 입력폼에서 비밀번호 체크
	 * @param String
	 */
	String mngrChkPassBfView(String mngrId) throws SQLException ;

	/**
	 * 관리자상세 - 관리자구분 변경 시 해당 관리등급의 권한 SELECT
	 * @param mngrManagerVO
	 */
	String mngrManagerCheckPower(MngrManagerVO managerVO) throws SQLException ;


	/** 3.07 버전 추가 **/
	int putManagerSite(ItgMap paramMap)throws SQLException;

	int deleteManagerSitebyMngr(ItgMap paramMap)throws SQLException;

	int deleteManagerSitebySite(ItgMap paramMap)throws SQLException;

    List<?> managerListBySite(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    int managerListBySiteTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    List<?> managerListBySiteForIndividual(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

    int managerListBySiteForIndividualTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException;

	/**
	 * 관리자 목록을 조회한다 (조직도 부서 관리자)
	 * @param List<ItgMap>
	 */
    List<ItgMap> selectOrgManager(ItgMap itgmap) throws IOException, SQLException;

    /**
	 * 관리자 목록을 조회한다 (조직도 부서 사용자)
	 * @param List<ItgMap>
	 */
    List<ItgMap> selOrgManager(ItgMap itgmap) throws IOException, SQLException;
	/**
	 * 모든 관리자 목록을 조회한다 (조직도 부서 관리자)
	 * @param List<ItgMap>
	 */
    List<ItgMap> selectOrgAllManagerList(ItgMap itgmap) throws IOException, SQLException;

	/**
	 * 관리자 부서를 추가한다 (조직도 관리자 부서 추가)
	 * @param itgMap
	 * @return int
	 */
	int inputOrgMngGroup(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자를 부서에서 제외한다 (조직도 관리자 부서 제외)
	 * @param itgMap
	 * @return int
	 */
	int deleteOrgMngGroup(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 관리자 부서 내 순서를 변경한다.
	 * @param itgMap
	 * @return int
	 */
	int updateOrgMngGroupOrder(ItgMap itgMap) throws IOException, SQLException;

	List<ItgMap> selectErrorMangerList (ItgMap itgMap) throws IOException, SQLException;

	MngrManagerVO selectManagerForCheck(MngrManagerVO managerVO) throws SQLException;

	int updateManagerPassword(MngrManagerVO managerVO) throws SQLException;

	/**
	 * 관리자리스트를 조회(마이그레이션용)
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
    List<ItgMap> mMngrManagerListForMigration(ItgMap paramMap) throws SQLException;

	void updateManagerPartInfo(MngrManagerVO managerVO) throws SQLException;

	List<ItgMap> selectOrgchtSchMngView(ItgMap itgMap) throws SQLException;
}
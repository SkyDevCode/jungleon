package egovframework.itgcms.module.organization.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @파일명 : OrganizationService.java
 * @파일정보 : 조직도 관리 및 조회 클래스
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @jyl 2017. 10. 16. 최초생성
 * @jimbae 2019. 10. 14. 국립중앙도서관에 맞춰 수정
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */
public interface OrganizationService {

	/**
	 * 조직도 부서목록 불러오기
	 * @return List<ItgMap>
	 * @throws IOException
	 * @throws SQLException
	 */
    public String selectOrganizationList() throws IOException, SQLException;


    /**
     * 조직도 부서목록 불러오기
     * @return List<ItgMap>s
     * @throws IOException
     * @throws SqlException
     */
    public List<ItgMap> selectOrganizationListMap() throws IOException, SQLException;

	/**
	 * 조직도 부서 기본정보 조회
	 * @param orgMap
	 * @return ItgMap
	 */
	public ItgMap selectOrganizationView(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 조직도 코드 중복검사
	 * @param itgMap
	 * @return int
	 * @throws IOException
	 * @throws SQLException
	 */
	public int selectOrganizationDupl(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 조직도 부서 등록
	 * @param itgMap
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 */
	public String insertOrganization(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 조직도 부서 수정
	 * @param itgMap
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 */
	public String updateOrganization(ItgMap itgMap) throws IOException, SQLException;

	/**
	 * 조직도 부서 삭제
	 * @param itgMap
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 */
	public String deleteOrganization(ItgMap itgMap) throws IOException, SQLException;


	/**
	 * 부서 위치 변경
	 * @param itgMap
	 * @return String
	 * @throws IOException
	 * @throws SQLException
	 */
	public String updateOrganizationUpDown(ItgMap itgMap) throws IOException, SQLException;

}

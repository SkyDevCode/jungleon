package egovframework.itgcms.module.organization.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("organizationMapper")
public interface OrganizationMapper {

	/**
	 * 조직도 부서목록 불러오기
	 * @return List<ItgMap>
	 * @throws SQLException
	 */
	List<ItgMap> selectOrganizationList() throws SQLException;

	/**
	 * 조직도 부서 기본정보 조회
	 * @param itgMap
	 * @return
	 */
	ItgMap selectOrganizationView(ItgMap itgMap) throws SQLException;

	/**
	 * 조직도 코드 중복 검사
	 * @param itgMap
	 * @return int
	 */
	int selectOrganizationDupl(ItgMap itgMap) throws SQLException;

	/**
	 * 조직도 자식 노드 검사
	 * @param itgMap
	 * @return int
	 */
	int selectOrganizationSubTree(ItgMap itgMap) throws SQLException;

	/**
	 * 조직도 부서 등록
	 * @param itgMap
	 * @return int
	 */
	int insertOrganization(ItgMap itgMap) throws SQLException;

	/**
	 * 조직도 부서 수정
	 * @param itgMap
	 * @return int
	 */
	int updateOrganization(ItgMap itgMap) throws SQLException;

	/**
	 * 조직도 부서 삭제
	 * @param itgMap
	 * @return int
	 */
	int deleteOrganization(ItgMap itgMap) throws SQLException;

	/**
	 * 조직도 부서 위치 변경대상 불러오기
	 * @param itgMap
	 * @return
	 * @throws SQLException
	 */
	ItgMap selectOrganizationSwapTarget(ItgMap itgMap) throws SQLException;

	/**
	 * 부서 위치 변경
	 * @param map
	 * @return
	 */
	void updateOrganizationUpDown(ItgMap map);


}

package egovframework.itgcms.project.cominfo.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.project.cominfo.service.CominfoSearchVO;
import egovframework.itgcms.project.cominfo.service.CominfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("cominfoMapper")
public interface CominfoMapper {

	int selectCominfoListTotCnt(CominfoSearchVO searchVO) throws SQLException;

	List<CominfoVO> selectCominfoList(CominfoSearchVO searchVO) throws SQLException;

	CominfoVO selectCominfoView(CominfoSearchVO searchVO) throws SQLException;

	List<EgovMap> selectKsicSearch(DefaultVO searchVO) throws SQLException;

	int updateCominfo(CominfoVO cominfoVO) throws SQLException;

	int deleteCominfoProc(CominfoVO cominfoVO) throws SQLException;

	List<EgovMap> selectCominfoViewPrevNext(CominfoSearchVO searchVO) throws SQLException;

	int insertCominfo(CominfoVO cominfoVO) throws SQLException;

	int selectCominfoCheckBusiRegNo(CominfoVO cominfoVO) throws SQLException;

	CominfoVO selectCominfoViewById(CominfoVO cominfoVO) throws SQLException;

	int updateDeleteCominfoByID(CominfoVO cominfoVO) throws SQLException;

	HashMap<String, Object> selectMemberJoinCompanyInfo(String id) throws SQLException;

	MemberVO selectMember4FindID(CominfoVO cominfoVO) throws SQLException;


	MemberExtVO selectMemberChecPwdQuest(MemberExtVO member) throws SQLException;
	MemberExtVO selectMemberInfo(MemberVO member) throws SQLException;

}

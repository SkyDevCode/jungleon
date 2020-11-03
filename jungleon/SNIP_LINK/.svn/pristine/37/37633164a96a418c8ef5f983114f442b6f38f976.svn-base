package egovframework.itgcms.project.cominfo.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CominfoService {

	int selectCominfoListTotCnt(CominfoSearchVO searchVO) throws SQLException;

	List<CominfoVO> selectCominfoList(CominfoSearchVO searchVO) throws SQLException;

	CominfoVO selectCominfoView(CominfoSearchVO searchVO)  throws SQLException;

	List<EgovMap> selectKsicSearch(DefaultVO searchVO) throws SQLException;

	int updateCominfo(CominfoVO cominfoVO) throws SQLException;

	int deleteCominfoProc(CominfoVO cominfoVO) throws SQLException;

	int deleteCominfoMultiProc(CominfoSearchVO searchVO) throws SQLException;

	List<EgovMap> selectCominfoViewPrevNext(CominfoSearchVO searchVO) throws SQLException;

	int insertCominfo(MemberExtVO memberVO, CominfoVO cominfoVO) throws SQLException;
	int insertMemberRegist(MemberExtVO memberVO) throws SQLException;
	void updatetMemberRegist(MemberExtVO memberVO) throws SQLException;
	void updateMemberInitPass(MemberVO var1);
	int selectCominfoCheckBusiRegNo(CominfoVO cominfoVO) throws SQLException;

	CominfoVO selectCominfoViewById(CominfoVO cominfoVO) throws SQLException;

	void updateCominfo(MemberExtVO memberVO, CominfoVO cominfoVO) throws SQLException;

	void updateDeleteCominfoWithMemberByID(MemberExtVO memberVO, CominfoVO cominfoVO) throws SQLException;

	HashMap<String, Object> selectMemberJoinCompanyInfo(String id) throws SQLException;

	MemberVO selectMember4FindID(CominfoVO cominfoVO) throws SQLException;

	MemberExtVO selectMemberChecPwdQuest(MemberExtVO member) throws SQLException;

	MemberExtVO selectMemberInfo(MemberVO member) throws SQLException;

	HashMap<String, Object> checkbusiRegNo(CominfoVO var1) throws SQLException;

	void updateMemberTemporaryPassword(MemberExtVO member) throws SQLException;
}

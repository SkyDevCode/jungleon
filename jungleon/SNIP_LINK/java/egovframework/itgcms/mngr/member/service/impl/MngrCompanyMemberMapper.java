package egovframework.itgcms.mngr.member.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mngrCompanyMemberMapper")
public interface MngrCompanyMemberMapper {

	int selectCompanyMemberListTotCnt(MemberVO searchVO) throws SQLException;

	List<EgovMap> selectCompanyMemberList(MemberVO searchVO) throws SQLException;

}

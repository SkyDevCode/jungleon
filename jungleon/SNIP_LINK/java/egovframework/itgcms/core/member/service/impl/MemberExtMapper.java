package egovframework.itgcms.core.member.service.impl;

import java.sql.SQLException;

import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberExtMapper")
public interface MemberExtMapper extends MemberMapper {

	MemberVO selectMemberExtViewByDI(MemberVO paramVO) throws SQLException;

}

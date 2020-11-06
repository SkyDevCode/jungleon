package egovframework.itgcms.core.member.service;

import java.sql.SQLException;

public interface MemberExtService {

	MemberVO selectMemberExtViewByDI(MemberVO paramVO) throws SQLException;

}

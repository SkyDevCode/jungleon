package egovframework.itgcms.module.real.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.member.service.MemberVO;

public interface RealDbService {

	public ItgMap getEnc(ItgMap params) throws SQLException;
	public List<ItgMap> getmemList(ItgMap paramMap)throws SQLException;
	void migrationBoard(ItgMap paramMap)throws SQLException;//보도자료
	void migrationBoard2(ItgMap paramMap)throws SQLException;//보도자료
	void migrationImgBoard(ItgMap paramMap)throws SQLException;//보도자료
	void updatePassAsis2Tobe(MemberVO memberVO) throws   SQLException, NoSuchAlgorithmException, IOException ;

	ItgMap memberPossible(ItgMap params);

	int downloadIncrease(ItgMap params);
}

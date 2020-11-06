package egovframework.itgcms.project.cominfo.service.impl;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.member.service.MemberExtVO;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.core.member.service.impl.MemberMapper;
import egovframework.itgcms.module.real.service.impl.RealDbMapper;
import egovframework.itgcms.project.cominfo.service.CominfoSearchVO;
import egovframework.itgcms.project.cominfo.service.CominfoService;
import egovframework.itgcms.project.cominfo.service.CominfoVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.MD5Crypt;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("cominfoService")
public class CominfoServiceImpl implements CominfoService{

	@Resource(name="cominfoMapper")
	CominfoMapper cominfoMapper;

	@Resource(name="memberMapper")
	MemberMapper memberMapper;
	@Resource(name = "realDbMapper")
	private RealDbMapper realDbMapper;

	@Override
	public int selectCominfoListTotCnt(CominfoSearchVO searchVO) throws SQLException {
		return cominfoMapper.selectCominfoListTotCnt(searchVO);
	}

	@Override
	public List<CominfoVO> selectCominfoList(CominfoSearchVO searchVO) throws SQLException {
		return cominfoMapper.selectCominfoList(searchVO);
	}

	@Override
	public CominfoVO selectCominfoView(CominfoSearchVO searchVO) throws SQLException {
		return cominfoMapper.selectCominfoView(searchVO);
	}

	@Override
	public List<EgovMap> selectKsicSearch(DefaultVO searchVO) throws SQLException {
		return cominfoMapper.selectKsicSearch(searchVO);
	}

	@Override
	public int updateCominfo(CominfoVO cominfoVO) throws SQLException {
		return cominfoMapper.updateCominfo(cominfoVO);
	}

	@Override
	public int deleteCominfoProc(CominfoVO cominfoVO) throws SQLException {
		return cominfoMapper.deleteCominfoProc(cominfoVO);
	}

	@Override
	public int deleteCominfoMultiProc(CominfoSearchVO searchVO) throws SQLException {
		int cnt = 0;
		for(int i = 0; i < searchVO.getChkId().length; i++) {
			CominfoVO vo = new CominfoVO();
			vo.setBusiRegNo(searchVO.getChkId()[i]);
			int result = cominfoMapper.deleteCominfoProc(vo);
			if(result < 1) {
				throw new SQLException("삭제된 데이터가 없습니다 : company busi_reg_no:" + vo.getBusiRegNo());
			}
			cnt ++;
		}
		return cnt;
	}

	@Override
	public List<EgovMap> selectCominfoViewPrevNext(CominfoSearchVO searchVO) throws SQLException {
		return cominfoMapper.selectCominfoViewPrevNext(searchVO);
	}


	@Override
	public int insertCominfo(MemberExtVO memberVO, CominfoVO cominfoVO) throws SQLException {
		memberMapper.insertMemberRegist(memberVO);

		int result = cominfoMapper.insertCominfo(cominfoVO);
		if(result < 1) {
			throw new SQLException("Company registration cominfo insert error1 ");
		}else{
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("id", memberVO.getId());
			siteParamMap.put("pwd", MD5Crypt.crypt(memberVO.getSchOpt5()));
			siteParamMap.put("pwdEnc", memberVO.getPass());
			String url = memberVO.getSchOpt1();
		    if(url.contains("snip.or.kr")){ //개발서버
		    	siteParamMap.put("pwd", realDbMapper.getEnc(siteParamMap).get("enc"));
		    }
			siteParamMap.put("memTpCd", "V013000002");
			siteParamMap.put("pwdQuest", memberVO.getPwdQuest());
			siteParamMap.put("pwdAnswer", memberVO.getPwdAnswer());
			siteParamMap.put("knowPath", memberVO.getKnowpath());
			siteParamMap.put("letterYn", memberVO.getEmailYn());
			siteParamMap.put("useYn","Y");
			siteParamMap.put("outYn", "N");
			siteParamMap.put("userNm", memberVO.getName());
			siteParamMap.put("agreeYn1", "Y");
			siteParamMap.put("agreeYn2", "Y");
			siteParamMap.put("agreeYn3", "Y");

			result = realDbMapper.memberInsert(siteParamMap);
			if(result < 1) {
				throw new SQLException("Company registration cominfo insert error2 ");
			}
		}
		return result;
	}

	@Override
	public int selectCominfoCheckBusiRegNo(CominfoVO cominfoVO) throws SQLException {
		return cominfoMapper.selectCominfoCheckBusiRegNo(cominfoVO);
	}

	@Override
	public CominfoVO selectCominfoViewById(CominfoVO cominfoVO) throws SQLException {
		return cominfoMapper.selectCominfoViewById(cominfoVO);
	}

	@Override
	public void updateCominfo(MemberExtVO memberVO, CominfoVO cominfoVO) throws SQLException {
		memberMapper.updateMember(memberVO);
		int result = cominfoMapper.updateCominfo(cominfoVO);
		if(result < 1) {
			throw new SQLException("Company registration cominfo update error ");
		}else{
			ItgMap siteParamMap = new ItgMap();
			if (!"".equals(CommUtil.isNull(memberVO.getPass2(), ""))) {
				siteParamMap.put("id", memberVO.getId());
				siteParamMap.put("pwd", MD5Crypt.crypt(memberVO.getPass2()));
				String url = memberVO.getSchOpt1();
				if(url.contains("snip.or.kr")){ //개발서버
					try {
						siteParamMap.put("pwd", realDbMapper.getEnc(siteParamMap).get("enc"));
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				try {
					siteParamMap.put("pwdEnc", CommUtil.hexSha256(memberVO.getPass2()));
				} catch (NoSuchAlgorithmException e) {
				} catch (IOException e) {
				}
				result=realDbMapper.memberUpdate(siteParamMap);
				if(result < 1) {
					throw new SQLException("Company registration cominfo insert error2 ");
				}
			}
		}

	}

	@Override
	public void updateDeleteCominfoWithMemberByID(MemberExtVO memberVO, CominfoVO cominfoVO) throws SQLException {
		memberMapper.deleteMemberProc(memberVO);
		int result = cominfoMapper.updateDeleteCominfoByID(cominfoVO);
		if(result < 1) {
			throw new SQLException("updateDeleteCominfoWithMemberByID cominfo update error");
		}
	}

	@Override
	public HashMap<String, Object> selectMemberJoinCompanyInfo(String id) throws SQLException {
		return cominfoMapper.selectMemberJoinCompanyInfo(id);
	}

	@Override
	public MemberVO selectMember4FindID(CominfoVO cominfoVO) throws SQLException {
		return cominfoMapper.selectMember4FindID(cominfoVO);
	}

	@Override
	public MemberExtVO selectMemberChecPwdQuest(MemberExtVO member) throws SQLException {
		return cominfoMapper.selectMemberChecPwdQuest(member);
	}

	@Override
	public MemberExtVO selectMemberInfo(MemberVO member) throws SQLException {
		return cominfoMapper.selectMemberInfo(member);
	}

	@Override
	public HashMap<String, Object> checkbusiRegNo(CominfoVO var1) throws SQLException {
		HashMap<String, Object> json = new HashMap();
		json.put("result", "0");
		json.put("message", "알수없는 오류가 발생했습니다. 다시 시도해 주세요.");
		if ("".equals(CommUtil.isNull(var1.getBusiRegNo(), ""))) {
			return json;
		} else {
			int resultCount = cominfoMapper.selectCominfoCheckBusiRegNo(var1);
			if (resultCount == 0) {
				json.put("result", "1");
			} else {
				json.put("result", "2");
				json.put("message", "중복된 사업자등록번호 입니다.");
			}

			return json;
		}
	}

	@Override
	public int insertMemberRegist(MemberExtVO memberVO) throws SQLException {
		memberMapper.insertMemberRegist(memberVO);
		ItgMap personMap = new ItgMap();
		personMap.put("id", memberVO.getId());
		personMap.put("name", memberVO.getName());
		personMap.put("areaCd", memberVO.getAreaCd());
		personMap.put("email", memberVO.getEmail());
		personMap.put("jungleYn","N");
		int result = realDbMapper.personInsert(personMap);
		if(result < 1) {
			throw new SQLException("member registration personinfo insert error1 ");
		}else{
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("id", memberVO.getId());
			siteParamMap.put("pwd", MD5Crypt.crypt(memberVO.getSchOpt5()));
			siteParamMap.put("pwdEnc", memberVO.getPass());
			String url = memberVO.getSchOpt1();
		    if(url.contains("snip.or.kr")){ //개발서버
		    	siteParamMap.put("pwd", realDbMapper.getEnc(siteParamMap).get("enc"));
		    }
			siteParamMap.put("memTpCd", "V013000001");
			siteParamMap.put("pwdQuest", memberVO.getPwdQuest());
			siteParamMap.put("pwdAnswer", memberVO.getPwdAnswer());
			siteParamMap.put("knowPath", memberVO.getKnowpath());
			siteParamMap.put("letterYn", memberVO.getEmailYn());
			siteParamMap.put("useYn","Y");
			siteParamMap.put("outYn", "N");
			siteParamMap.put("userNm", memberVO.getName());
			siteParamMap.put("agreeYn1", "Y");
			siteParamMap.put("agreeYn2", "Y");
			siteParamMap.put("agreeYn3", "Y");

			result = realDbMapper.memberInsert(siteParamMap);
			if(result < 1) {
				throw new SQLException("Company registration cominfo insert error2 ");
			}
		}
		return result;
	}

	@Override
	public void updateMemberInitPass(MemberVO mngrMemberVO) {
		MemberVO memberVO = new MemberVO();
		memberVO.setUpdId(CommUtil.getMngrMemId());
		ItgMap siteParamMap = new ItgMap();
		siteParamMap.put("id", mngrMemberVO.getId());
		siteParamMap.put("pwd", MD5Crypt.crypt(mngrMemberVO.getId()));
		String url = mngrMemberVO.getSchOpt1();
	    if(url.contains("snip.or.kr")){ //개발서버
	    	try {
				siteParamMap.put("pwd", realDbMapper.getEnc(siteParamMap).get("enc"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    }
		try {
			siteParamMap.put("pwdEnc", CommUtil.hexSha256(mngrMemberVO.getId()));
		} catch (NoSuchAlgorithmException e) {
		} catch (IOException e) {
		}
		realDbMapper.memberUpdate(siteParamMap);
		try {
			memberVO.setPass(CommUtil.hexSha256(mngrMemberVO.getId()));
		} catch (NoSuchAlgorithmException var4) {
		} catch (IOException var5) {
		}

		memberVO.setUpdIp(CommUtil.getUserIP());
		memberVO.setId(mngrMemberVO.getId());
		memberMapper.updateMemberInitPass(memberVO);

	}

	@Override
	public void updatetMemberRegist(MemberExtVO memberVO) throws SQLException {
		ItgMap siteParamMap = new ItgMap();
		memberMapper.updateMember(memberVO);
		if (!"".equals(CommUtil.isNull(memberVO.getPass(), ""))) {
			siteParamMap.put("id", memberVO.getId());
			siteParamMap.put("pwd", MD5Crypt.crypt(memberVO.getPass2()));
			String url = memberVO.getSchOpt1();
			if(url.contains("snip.or.kr")){ //개발서버
				try {
					siteParamMap.put("pwd", realDbMapper.getEnc(siteParamMap).get("enc"));
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			try {
				siteParamMap.put("pwdEnc", CommUtil.hexSha256(memberVO.getPass2()));
			} catch (NoSuchAlgorithmException e) {
			} catch (IOException e) {
			}
			realDbMapper.memberUpdate(siteParamMap);
		}
	}

	@Override
	public void updateMemberTemporaryPassword(MemberExtVO memberVO) throws SQLException {

		ItgMap siteParamMap = new ItgMap();

		try {
			siteParamMap.put("id", memberVO.getId());
			siteParamMap.put("pwd",  MD5Crypt.crypt(memberVO.getPass()));
			siteParamMap.put("pwdEnc", CommUtil.hexSha256(memberVO.getPass()));

			realDbMapper.memberUpdate(siteParamMap);

			memberVO.setPass((String) siteParamMap.get("pwdEnc"));

			memberMapper.updateMemberInitPass(memberVO);

		} catch (NoSuchAlgorithmException | IOException e) {
			e.printStackTrace();
		}
	}
}
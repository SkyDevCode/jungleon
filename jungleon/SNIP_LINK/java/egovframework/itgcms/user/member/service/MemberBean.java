package egovframework.itgcms.user.member.service;

import java.util.List;


public class MemberBean{

    private static final long serialVersionUID = -2324887965690944253L;


    private String busiRegNo;
    private String email;

    private String snp;
    private String id;
    private String memTpCd;
    private String rollCd;
    private String pwd;
    private String pwdEnc;
	private String pwdQuest;
    private String pwdAnswer;
    private String letterYn;
    private String useYn = "Y";
    private String outYn = "N";
    private String lostYn = "N";
    private String lostDt;
    private String loginDt;
    private String logoutDt;
    private String regDt;
    private String modDt;
    private String concernsCd;
    private String outReason;
    private String vipYn = "N";
    private String knowPath;
    private String userNm;
    private String areaCd;

    private String comNm;
    private String pwdQuestNm;
    private String memTpNm;
    private String[] concerns;


	public String getSnp() {
		return snp;
	}
	public void setSnp(String snp) {
		this.snp = snp;
	}
	public String getId() {
    	return id;
    }
	public void setId(String id) {
    	this.id = id;
    }
	public String getMemTpCd() {
    	return memTpCd;
    }
	public void setMemTpCd(String memTpCd) {
    	this.memTpCd = memTpCd;
    }
	public String getRollCd() {
    	return rollCd;
    }
	public void setRollCd(String rollCd) {
    	this.rollCd = rollCd;
    }
	public String getPwd() {
    	return pwd;
    }
	public void setPwd(String pwd) {
    	this.pwd = pwd;
    }
	public String getPwdQuest() {
    	return pwdQuest;
    }
	public void setPwdQuest(String pwdQuest) {
    	this.pwdQuest = pwdQuest;
    }
	public String getPwdAnswer() {
    	return pwdAnswer;
    }
	public void setPwdAnswer(String pwdAnswer) {
    	this.pwdAnswer = pwdAnswer;
    }
	public String getLetterYn() {
    	return letterYn;
    }
	public void setLetterYn(String letterYn) {
    	this.letterYn = letterYn;
    }
	public String getUseYn() {
    	return useYn;
    }
	public void setUseYn(String useYn) {
    	this.useYn = useYn;
    }
	public String getOutYn() {
    	return outYn;
    }
	public void setOutYn(String outYn) {
    	this.outYn = outYn;
    }
	public String getLostYn() {
    	return lostYn;
    }
	public void setLostYn(String lostYn) {
    	this.lostYn = lostYn;
    }
	public String getLostDt() {
    	return lostDt;
    }
	public void setLostDt(String lostDt) {
    	this.lostDt = lostDt;
    }
	public String getLoginDt() {
    	return loginDt;
    }
	public void setLoginDt(String loginDt) {
    	this.loginDt = loginDt;
    }
	public String getLogoutDt() {
    	return logoutDt;
    }
	public void setLogoutDt(String logoutDt) {
    	this.logoutDt = logoutDt;
    }
	public String getRegDt() {
    	return regDt;
    }
	public void setRegDt(String regDt) {
    	this.regDt = regDt;
    }
	public String getModDt() {
    	return modDt;
    }
	public void setModDt(String modDt) {
    	this.modDt = modDt;
    }
	public String getOutReason() {
    	return outReason;
    }
	public void setOutReason(String outReason) {
    	this.outReason = outReason;
    }
	public String getVipYn() {
    	return vipYn;
    }
	public void setVipYn(String vipYn) {
    	this.vipYn = vipYn;
    }
	public String getKnowPath() {
    	return knowPath;
    }
	public void setKnowPath(String knowPath) {
    	this.knowPath = knowPath;
    }
	public String getUserNm() {
    	return userNm;
    }
	public void setUserNm(String userNm) {
    	this.userNm = userNm;
    }
	public String getConcernsCd() {
    	return concernsCd;
    }
	public void setConcernsCd(String concernsCd) {
    	this.concernsCd = concernsCd;
    }
	public String getPwdQuestNm() {
    	return pwdQuestNm;
    }
	public void setPwdQuestNm(String pwdQuestNm) {
    	this.pwdQuestNm = pwdQuestNm;
    }
	public String[] getConcerns() {
    	return concerns;
    }
	public void setConcerns(String[] concerns) {
    	this.concerns = concerns;
    }
	public String getMemTpNm() {
    	return memTpNm;
    }
	public void setMemTpNm(String memTpNm) {
    	this.memTpNm = memTpNm;
    }
	public String getBusiRegNo() {
    	return busiRegNo;
    }
	public void setBusiRegNo(String busiRegNo) {
    	this.busiRegNo = busiRegNo;
    }
	public String getEmail() {
    	return email;
    }
	public void setEmail(String email) {
    	this.email = email;
    }
	public String getAreaCd() {
    	return areaCd;
    }
	public void setAreaCd(String areaCd) {
    	this.areaCd = areaCd;
    }
	public String getComNm() {
    	return comNm;
    }
	public void setComNm(String comNm) {
    	this.comNm = comNm;
    }
    public String getPwdEnc() {
		return pwdEnc;
	}
	public void setPwdEnc(String pwdEnc) {
		this.pwdEnc = pwdEnc;
	}
}

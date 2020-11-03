package egovframework.itgcms.project.cominfo.service;

import java.io.Serializable;

import egovframework.itgcms.util.CommUtil;

public class CominfoVO implements Serializable{

	private String busiRegNo     = "";
	private String comNm         = "";
	private String areaCd        = "";
	private String comTp         = "";
	private String ceoNm         = "";
	private String ceoEmail      = "";
	private String officeTel01   = "";
	private String officeTel02   = "";
	private String officeTel03   = "";
	private String faxNo01       = "";
	private String faxNo02       = "";
	private String faxNo03       = "";
	private String zip           = "";
	private String addr01        = "";
	private String addr02        = "";
	private String regDt         = "";
	private String mainProduct   = "";
	private String modDt         = "";
	private String regId         = "";
	private String modId         = "";
	private String id            = "";
	private String unCd          = "";
	private String useYn         = "";
	private String hPage         = "";
	private String estDt         = "";
	private String busiRegNoReal = "";
	private String snp           = "";
	private String jungleYn      = "";
	
	
	private String unNm			= "";
	private String comTpName    = "";
	
	private String faxNo 		= "";
	
	public String getBusiRegNo() {
		return busiRegNo;
	}
	public void setBusiRegNo(String busiRegNo) {
		this.busiRegNo = busiRegNo;
	}
	public String getComNm() {
		return comNm;
	}
	public void setComNm(String comNm) {
		this.comNm = comNm;
	}
	public String getAreaCd() {
		return areaCd;
	}
	public void setAreaCd(String areaCd) {
		this.areaCd = areaCd;
	}
	public String getComTp() {
		return comTp;
	}
	public void setComTp(String comTp) {
		this.comTp = comTp;
	}
	public String getCeoNm() {
		return ceoNm;
	}
	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}
	public String getCeoEmail() {
		return ceoEmail;
	}
	public void setCeoEmail(String ceoEmail) {
		this.ceoEmail = ceoEmail;
	}
	public String getOfficeTel01() {
		return officeTel01;
	}
	public void setOfficeTel01(String officeTel01) {
		this.officeTel01 = officeTel01;
	}
	public String getOfficeTel02() {
		return officeTel02;
	}
	public void setOfficeTel02(String officeTel02) {
		this.officeTel02 = officeTel02;
	}
	public String getOfficeTel03() {
		return officeTel03;
	}
	public void setOfficeTel03(String officeTel03) {
		this.officeTel03 = officeTel03;
	}
	public String getFaxNo01() {
		return faxNo01;
	}
	public void setFaxNo01(String faxNo01) {
		this.faxNo01 = faxNo01;
	}
	public String getFaxNo02() {
		return faxNo02;
	}
	public void setFaxNo02(String faxNo02) {
		this.faxNo02 = faxNo02;
	}
	public String getFaxNo03() {
		return faxNo03;
	}
	public void setFaxNo03(String faxNo03) {
		this.faxNo03 = faxNo03;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddr01() {
		return addr01;
	}
	public void setAddr01(String addr01) {
		this.addr01 = addr01;
	}
	public String getAddr02() {
		return addr02;
	}
	public void setAddr02(String addr02) {
		this.addr02 = addr02;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getMainProduct() {
		return mainProduct;
	}
	public void setMainProduct(String mainProduct) {
		this.mainProduct = mainProduct;
	}
	public String getModDt() {
		return modDt;
	}
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUnCd() {
		return unCd;
	}
	public void setUnCd(String unCd) {
		this.unCd = unCd;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String gethPage() {
		return hPage;
	}
	public void sethPage(String hPage) {
		this.hPage = hPage;
	}
	public String getEstDt() {
		return estDt;
	}
	public void setEstDt(String estDt) {
		this.estDt = estDt;
	}
	public String getBusiRegNoReal() {
		return busiRegNoReal;
	}
	public void setBusiRegNoReal(String busiRegNoReal) {
		this.busiRegNoReal = busiRegNoReal;
	}
	public String getSnp() {
		return snp;
	}
	public void setSnp(String snp) {
		this.snp = snp;
	}
	public String getJungleYn() {
		return jungleYn;
	}
	public void setJungleYn(String jungleYn) {
		this.jungleYn = jungleYn;
	}
	public String getUnNm() {
		return unNm;
	}
	public void setUnNm(String unNm) {
		this.unNm = unNm;
	}
	public String getComTpName() {
		if("V006000001".equals( CommUtil.isNull(this.comTp, ""))) return "개인기업";
		else if("V006000002".equals( CommUtil.isNull(this.comTp, ""))) return "법인기업";
		else return "";
	}
	public String getFaxNo() {
		String resultStr = "";
		if(!"".equals(CommUtil.isNull(this.faxNo01, ""))
			&& !"".equals(CommUtil.isNull(this.faxNo02, ""))
			&& !"".equals(CommUtil.isNull(this.faxNo03, ""))
			) {
			resultStr = String.format("{0}-{1}-{2}", faxNo01, faxNo02, faxNo03);
		}
		return resultStr;
	}
}    

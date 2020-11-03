package egovframework.itgcms.project.totalTable.service;

import egovframework.itgcms.project.totalTable.service.TotalTbEnum.TOTALTB_GRSTEP;

public class TotalTbVO {

	private String bsIdx			 = "";
	private String bsYear			 = "";
	private String gpName 			 = "";
	private String grStep 			 = "";
	private String cgName 			 = "";
	private String bsName 			 = "";
	private String bsLocation		 = "";
	private String bsPeriod		 	 = "";
	private String regid             = "";
	private String regdt             = "";
	private String updid             = "";
	private String upddt             = "";
	private String delid             = "";
	private String deldt             = "";
	private String delyn             = "";
	private String grStepName 		 = "";

	private String strGpName		= "";
	private String strCgName		= "";

	private String menuCode 		= "";
	private String menuName 		= "";
	private String menuPfullcode 		= "";
	private String menuPfullname 		= "";
	private String cgArr 		= "";



	public String getBsIdx() {
		return bsIdx;
	}
	public void setBsIdx(String bsIdx) {
		this.bsIdx = bsIdx;
	}
	public String getBsYear() {
		return bsYear;
	}
	public void setBsYear(String bsYear) {
		this.bsYear = bsYear;
	}
	public String getGpName() {
		return gpName;
	}
	public void setGpName(String gpName) {
		this.gpName = gpName;
	}
	public String getGrStep() {
		return grStep;
	}
	public void setGrStep(String grStep) {
		this.grStep = grStep;
	}
	public String getCgName() {
		return cgName;
	}
	public void setCgName(String cgName) {
		this.cgName = cgName;
	}
	public String getBsName() {
		return bsName;
	}
	public void setBsName(String bsName) {
		this.bsName = bsName;
	}
	public String getBsLocation() {
		return bsLocation;
	}
	public void setBsLocation(String bsLocation) {
		this.bsLocation = bsLocation;
	}
	public String getBsPeriod() {
		return bsPeriod;
	}
	public void setBsPeriod(String bsPeriod) {
		this.bsPeriod = bsPeriod;
	}
	public String getRegid() {
		return regid;
	}
	public void setRegid(String regid) {
		this.regid = regid;
	}
	public String getRegdt() {
		return regdt;
	}
	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}
	public String getUpdid() {
		return updid;
	}
	public void setUpdid(String updid) {
		this.updid = updid;
	}
	public String getUpddt() {
		return upddt;
	}
	public void setUpddt(String upddt) {
		this.upddt = upddt;
	}
	public String getDelid() {
		return delid;
	}
	public void setDelid(String delid) {
		this.delid = delid;
	}
	public String getDeldt() {
		return deldt;
	}
	public void setDeldt(String deldt) {
		this.deldt = deldt;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}


	public void setGrStepName(String grStepName) {
		this.grStepName = grStepName;
	}

	public String getGrStepName() {
		String returnValue = "";
		for(TOTALTB_GRSTEP grstep : TOTALTB_GRSTEP.values()) {
			if(("," + this.grStep + ",").indexOf("," + grstep.getValue() + ",") > -1) {
				returnValue += grstep.getName() + ",";
			}
		}
		if(!"".equals(returnValue)) {
			returnValue = returnValue.substring(0, returnValue.length() -1);
		}
		return returnValue;
	}


	public String getStrGpName() {
		return strGpName;
	}
	public void setStrGpName(String strGpName) {
		this.strGpName = strGpName;
	}

	public String getStrCgName() {
		return strCgName;
	}
	public void setStrCgName(String strCgName) {
		this.strCgName = strCgName;
	}



	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}


	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuPfullcode() {
		return menuPfullcode;
	}
	public void setMenuPfullcode(String menuPfullcode) {
		this.menuPfullcode = menuPfullcode;
	}
	public String getMenuPfullname() {
		return menuPfullname;
	}
	public void setMenuPfullname(String menuPfullname) {
		this.menuPfullname = menuPfullname;
	}
	@Override
	public String toString() {
		return "TotalTbVO [bsIdx=" + bsIdx + ", bsYear=" + bsYear + ", gpName=" + gpName + ", grStep=" + grStep
				+ ", cgName=" + cgName + ", bsName=" + bsName + ", bsLocation=" + bsLocation + ", bsPeriod=" + bsPeriod
				+ ", regid=" + regid + ", regdt=" + regdt + ", updid=" + updid + ", upddt=" + upddt + ", delid=" + delid
				+ ", deldt=" + deldt + ", delyn=" + delyn + ", grStepName=" + grStepName + "]";
	}
	public String getCgArr() {
		return cgArr;
	}
	public void setCgArr(String cgArr) {
		this.cgArr = cgArr;
	}
















}


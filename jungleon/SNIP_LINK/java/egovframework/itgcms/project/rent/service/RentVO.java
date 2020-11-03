package egovframework.itgcms.project.rent.service;

import egovframework.itgcms.project.rent.service.RentEnum.FACILITY;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_CUSTOMER;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_EQUIPMENT;
import egovframework.itgcms.project.rent.service.RentEnum.RENT_MEET;

public class RentVO {
	private String rIdx              = "";
	private String rId               = "";
	private String rName             = "";
	private String rTel              = "";
	private String rEmail            = "";
	private String rAddr             = "";
	private String rCustType         = "";
	private String rComName          = "";
	private String rMeetType         = "";
	private String rPersonNum        = "";
	private String rCarry            = "";
	private String fileId            = "";
	private String rFacility         = "";
	private String rEquipment        = "";
	private String rReserveDt        = "";
	private String rReserveTm        = "";
	private String rCharge           = "";
	private String rStatus           = "";
	private String regid             = "";
	private String regdt             = "";
	private String updid             = "";
	private String upddt             = "";
	private String delid             = "";
	private String deldt             = "";
	private String delyn             = "";
	
	private String year  			= "";
	private String month  			= "";
	
	//코드관리 사용
	private String rStatusName		= ""; 
	
	private String rFacilityName 	= "";
	private String rMeetTypeName	= "";
	private String rCustTypeName	= "";
	private String rEquipmentName 	= "";
	private String getrReserveTmName	= "";
	
	public String getrIdx() {
		return rIdx;
	}
	public void setrIdx(String rIdx) {
		this.rIdx = rIdx;
	}
	public String getrId() {
		return rId;
	}
	public void setrId(String rId) {
		this.rId = rId;
	}
	public String getrName() {
		return rName;
	}
	public void setrName(String rName) {
		this.rName = rName;
	}
	public String getrTel() {
		return rTel;
	}
	public void setrTel(String rTel) {
		this.rTel = rTel;
	}
	public String getrEmail() {
		return rEmail;
	}
	public void setrEmail(String rEmail) {
		this.rEmail = rEmail;
	}
	public String getrAddr() {
		return rAddr;
	}
	public void setrAddr(String rAddr) {
		this.rAddr = rAddr;
	}
	public String getrCustType() {
		return rCustType;
	}
	public void setrCustType(String rCustType) {
		this.rCustType = rCustType;
	}
	public String getrComName() {
		return rComName;
	}
	public void setrComName(String rComName) {
		this.rComName = rComName;
	}
	public String getrMeetType() {
		return rMeetType;
	}
	public void setrMeetType(String rMeetType) {
		this.rMeetType = rMeetType;
	}
	public String getrPersonNum() {
		return rPersonNum;
	}
	public void setrPersonNum(String rPersonNum) {
		this.rPersonNum = rPersonNum;
	}
	public String getrCarry() {
		return rCarry;
	}
	public void setrCarry(String rCarry) {
		this.rCarry = rCarry;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getrFacility() {
		return rFacility;
	}
	public void setrFacility(String rFacility) {
		this.rFacility = rFacility;
	}
	public String getrEquipment() {
		return rEquipment;
	}
	public void setrEquipment(String rEquipment) {
		this.rEquipment = rEquipment;
	}
	public String getrReserveDt() {
		return rReserveDt;
	}
	public void setrReserveDt(String rReserveDt) {
		this.rReserveDt = rReserveDt;
	}
	public String getrReserveTm() {
		return rReserveTm;
	}
	public void setrReserveTm(String rReserveTm) {
		this.rReserveTm = rReserveTm;
	}
	public String getrCharge() {
		return rCharge;
	}
	public void setrCharge(String rCharge) {
		this.rCharge = rCharge;
	}
	public String getrStatus() {
		return rStatus;
	}
	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
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
	
	
	public String getrFacilityName() {
		String returnValue = "";
		for(FACILITY fac : FACILITY.values()) {
			if(this.rFacility.equals(fac.getValue())) {
				returnValue = fac.getName();
				break;
			}
		}
		return returnValue;
	}
	
	public String getrMeetTypeName() {
		String returnValue = "";
		for(RENT_MEET meet : RENT_MEET.values()) {
			if(this.rMeetType.equals(meet.getValue())) {
				returnValue = meet.getName();
				break;
			}
		}
		return returnValue;
	}
	
	public String getrCustTypeName() {
		String returnValue = "";
		for(RENT_CUSTOMER customer : RENT_CUSTOMER.values()) {
			if(this.rCustType.equals(customer.getValue())) {
				returnValue = customer.getName();
				break;
			}
		}
		return returnValue;
	}
	
	public String getrEquipmentName() {
		String returnValue = "";
		for(RENT_EQUIPMENT equip : RENT_EQUIPMENT.values()) {
			if(("," + this.rEquipment + ",").indexOf("," + equip.getValue() + ",") > -1) {
				returnValue += equip.getName() + ",";
			}
		}
		if(!"".equals(returnValue)) {
			returnValue = returnValue.substring(0, returnValue.length() -1);
		}
		return returnValue;
	}
	
	
	public String getrStatusName() {
		return rStatusName;
	}
	
	public String getrReserveTmName() {
		String returnValue = "";
		if(!"".equals(this.rReserveTm)) {
			String[] arrTm = this.rReserveTm.split(",");
			returnValue += arrTm[0] + ":00~" + (Integer.parseInt(arrTm[arrTm.length -1]) + 1) + ":00" ;
		}
		return returnValue;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	
	
	
	
}

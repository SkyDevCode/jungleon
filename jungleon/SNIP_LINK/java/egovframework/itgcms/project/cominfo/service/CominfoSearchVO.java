package egovframework.itgcms.project.cominfo.service;

import java.io.UnsupportedEncodingException;

import egovframework.itgcms.common.DefaultVO;

public class CominfoSearchVO extends DefaultVO{
	private String schArea = "";
	private String root = "";
	private String[] arrArea = {};
	private String schKsicCd = "";
	private String schKsicNm = "";
	
	public String getSchArea() {
		return schArea;
	}

	public void setSchArea(String schArea) {
		this.schArea = schArea;
	}

	
	public String getRoot() {
		return root;
	}

	public void setRoot(String root) {
		this.root = root;
	}

	public String[] getArrArea() {
		return arrArea;
	}

	public void setArrArea(String[] arrArea) {
		this.arrArea = arrArea;
	}

	
	public String getSchKsicCd() {
		return schKsicCd;
	}

	public void setSchKsicCd(String schKsicCd) {
		this.schKsicCd = schKsicCd;
	}

	public String getSchKsicNm() {
		return schKsicNm;
	}

	public void setSchKsicNm(String schKsicNm) {
		this.schKsicNm = schKsicNm;
	}

	public String getQuery() {
		String query = super.queryString();
		try {
			if(!"".equals(java.net.URLEncoder.encode(this.schArea, "UTF-8"))){ query += "&schArea=" + java.net.URLEncoder.encode(this.schArea, "UTF-8");}
			if(!"".equals(java.net.URLEncoder.encode(this.schKsicCd, "UTF-8"))){ query += "&schKsicCd=" + java.net.URLEncoder.encode(this.schKsicCd, "UTF-8");}
			if(!"".equals(java.net.URLEncoder.encode(this.schKsicNm, "UTF-8"))){ query += "&schKsicNm=" + java.net.URLEncoder.encode(this.schKsicNm, "UTF-8");}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return query;
	}
}

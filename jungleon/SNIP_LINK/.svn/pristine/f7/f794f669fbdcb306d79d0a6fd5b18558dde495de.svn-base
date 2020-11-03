package egovframework.itgcms.project.totalTable.service;

import java.io.UnsupportedEncodingException;

import egovframework.itgcms.common.DefaultVO;

public class TotalTbSearchVO extends DefaultVO{

	private String schStatus = "";

	public String getSchStatus() {
		return schStatus;
	}

	public void setSchStatus(String schStatus) {
		this.schStatus = schStatus;
	}

	public String getQuery() {
		String query = super.queryString();
		try {
			if(!"".equals(java.net.URLEncoder.encode(this.schStatus, "UTF-8"))){ query += "&schStatus=" + java.net.URLEncoder.encode(this.schStatus, "UTF-8");}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return query;
	}
}

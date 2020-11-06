package egovframework.itgcms.core.manager.service;

import java.io.UnsupportedEncodingException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import egovframework.itgcms.common.DefaultVO;;

public class MngrManagerLoginLogSearchVO extends DefaultVO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5358593433818756365L;
	private static final Logger logger = LogManager.getLogger(MngrManagerLoginLogSearchVO.class);

	/** 관리자 아이디 */
	String id = ""; //검색조건 유지

	String query = "";
	
	String schSdt = ""; //기간검색 시작일
	String schEdt = ""; //기간검색 종료일
	String schType = ""; //로그구분
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
	public String getSchSdt() {
		return schSdt;
	}

	public void setSchSdt(String schSdt) {
		this.schSdt = schSdt;
	}

	public String getSchEdt() {
		return schEdt;
	}

	public void setSchEdt(String schEdt) {
		this.schEdt = schEdt;
	}

	public String getSchType() {
		return schType;
	}

	public void setSchType(String schType) {
		this.schType = schType;
	}

	public String getQuery() {
		String query = super.queryString();
		try{
			query += "&id=" + java.net.URLEncoder.encode(this.id, "UTF-8");
			query += "&schSdt=" + java.net.URLEncoder.encode(this.schSdt, "UTF-8");
			query += "&schEdt=" + java.net.URLEncoder.encode(this.schEdt, "UTF-8");
			query += "&schType=" + java.net.URLEncoder.encode(this.schType, "UTF-8");
		}catch(UnsupportedEncodingException e){
			logger.error("예외 상황 발생");
		}
		return query;
	}
}

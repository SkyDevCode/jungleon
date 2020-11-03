package egovframework.itgcms.core.manager.service;

import java.io.UnsupportedEncodingException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import egovframework.itgcms.common.DefaultVO;;

public class MngrManagerSearchVO extends DefaultVO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5358593433818756365L;
	private static final Logger logger = LogManager.getLogger(MngrManagerSearchVO.class);

	/** 관리자 아이디 */
	String id = ""; //검색조건 유지
	
	/** 관리자 정보수정 */
	String isMyInfo = "Y"; //검색조건 유지

	String query = "";
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIsMyInfo() {
		return isMyInfo;
	}

	public void setIsMyInfo(String isMyInfo) {
		this.isMyInfo = isMyInfo;
	}

	public String getQuery() {
		String query = super.queryString();
		try{
			query += "&id=" + java.net.URLEncoder.encode(this.id, "UTF-8");
			query += "&isMyInfo=" + java.net.URLEncoder.encode(this.isMyInfo, "UTF-8");
		}catch(UnsupportedEncodingException e){
			logger.error("예외 상황 발생");
		}
		return query;
	}
}

package egovframework.itgcms.project.newsletter.service;

import java.util.Date;

public class NewsletterArticleVO {

	private String nlaIdx;  		// 기사인덱스
	private String nlIdx;			// 글인덱스
	private String nlaSubject;		// 제목
	private String nlaContent;		// 내용
	private String nlaContentText;	// 내용텍스트
	private String nlaReadnum;		// 조회수
	private String nlaHtmlyn;		// 컨텐츠 HTML사용YN
	private Date regdt;				// 등록일자
	private Date upddt;				// 수정일자
	private Date delDt;				// 삭제일자
	private String regmemid;		// 등록자ID
	private String updmemid;		// 수정자ID
	private String delmemid;		// 삭제자ID
	private String delyn;			// 사용여부

	public String getNlaIdx() {
		return nlaIdx;
	}
	public void setNlaIdx(String nlaIdx) {
		this.nlaIdx = nlaIdx;
	}
	public String getNlIdx() {
		return nlIdx;
	}
	public void setNlIdx(String nlIdx) {
		this.nlIdx = nlIdx;
	}
	public String getNlaSubject() {
		return nlaSubject;
	}
	public void setNlaSubject(String nlaSubject) {
		this.nlaSubject = nlaSubject;
	}
	public String getNlaContent() {
		return nlaContent;
	}
	public void setNlaContent(String nlaContent) {
		this.nlaContent = nlaContent;
	}
	public String getNlaContentText() {
		return nlaContentText;
	}
	public void setNlaContentText(String nlaContentText) {
		this.nlaContentText = nlaContentText;
	}
	public String getNlaReadnum() {
		return nlaReadnum;
	}
	public void setNlaReadnum(String nlaReadnum) {
		this.nlaReadnum = nlaReadnum;
	}
	public String getNlaHtmlyn() {
		return nlaHtmlyn;
	}
	public void setNlaHtmlyn(String nlaHtmlyn) {
		this.nlaHtmlyn = nlaHtmlyn;
	}
	public Date getRegdt() {
		return regdt;
	}
	public void setRegdt(Date regdt) {
		this.regdt = regdt;
	}
	public Date getUpddt() {
		return upddt;
	}
	public void setUpddt(Date upddt) {
		this.upddt = upddt;
	}
	public Date getDelDt() {
		return delDt;
	}
	public void setDelDt(Date delDt) {
		this.delDt = delDt;
	}
	public String getRegmemid() {
		return regmemid;
	}
	public void setRegmemid(String regmemid) {
		this.regmemid = regmemid;
	}
	public String getUpdmemid() {
		return updmemid;
	}
	public void setUpdmemid(String updmemid) {
		this.updmemid = updmemid;
	}
	public String getDelmemid() {
		return delmemid;
	}
	public void setDelmemid(String delmemid) {
		this.delmemid = delmemid;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}

	@Override
	public String toString() {
		return "NewsletterArticleVO [nlaIdx=" + nlaIdx + ", nlIdx=" + nlIdx + ", nlaSubject=" + nlaSubject
				+ ", nlaContent=" + nlaContent + ", nlaContentText=" + nlaContentText + ", nlaReadnum=" + nlaReadnum
				+ ", nlaHtmlyn=" + nlaHtmlyn + ", regdt=" + regdt + ", upddt=" + upddt + ", delDt=" + delDt
				+ ", regmemid=" + regmemid + ", updmemid=" + updmemid + ", delmemid=" + delmemid + ", delyn=" + delyn
				+ "]";
	}
}


package egovframework.itgcms.project.newsletter.service;

import java.util.Date;

public class NewsletterVO {
	private String nlIdx;			// 인덱스
	private String nlTitle;			// 제목
	private String nlCharger;		// 담당자
	private String nlReadNum;		// 조회수
	private String nlUseYn;			// 사용여부
	private String nlUseTermYn;		// 게시여부
	private String nlUseSdt;		// 게시시작일자
	private String nlUseEdt;		// 게시종료일자
	private String fileId;			// 파일ID
	private String nlThumb1;		// 썸네일이미지
	private String nlThumb1Alt;		// 썸네일대체텍스트
	private Date regdt;				// 등록일자
	private Date upddt;				// 수정일자
	private Date delDt;				// 삭제일자
	private String regmemid;		// 등록자ID
	private String updmemid;		// 수정자ID
	private String delmemid;		// 삭제자ID
	private String delyn;			// 사용여부
	public String getNlIdx() {
		return nlIdx;
	}
	public void setNlIdx(String nlIdx) {
		this.nlIdx = nlIdx;
	}
	public String getNlTitle() {
		return nlTitle;
	}
	public void setNlTitle(String nlTitle) {
		this.nlTitle = nlTitle;
	}
	public String getNlCharger() {
		return nlCharger;
	}
	public void setNlCharger(String nlCharger) {
		this.nlCharger = nlCharger;
	}
	public String getNlReadNum() {
		return nlReadNum;
	}
	public void setNlReadNum(String nlReadNum) {
		this.nlReadNum = nlReadNum;
	}
	public String getNlUseYn() {
		return nlUseYn;
	}
	public void setNlUseYn(String nlUseYn) {
		this.nlUseYn = nlUseYn;
	}
	public String getNlUseTermYn() {
		return nlUseTermYn;
	}
	public void setNlUseTermYn(String nlUseTermYn) {
		this.nlUseTermYn = nlUseTermYn;
	}
	public String getNlUseSdt() {
		return nlUseSdt;
	}
	public void setNlUseSdt(String nlUseSdt) {
		this.nlUseSdt = nlUseSdt;
	}
	public String getNlUseEdt() {
		return nlUseEdt;
	}
	public void setNlUseEdt(String nlUseEdt) {
		this.nlUseEdt = nlUseEdt;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getNlThumb1() {
		return nlThumb1;
	}
	public void setNlThumb1(String nlThumb1) {
		this.nlThumb1 = nlThumb1;
	}
	public String getNlThumb1Alt() {
		return nlThumb1Alt;
	}
	public void setNlThumb1Alt(String nlThumb1Alt) {
		this.nlThumb1Alt = nlThumb1Alt;
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
		return "NewsletterVO [nlIdx=" + nlIdx + ", nlTitle=" + nlTitle + ", nlCharger=" + nlCharger + ", nlReadNum="
				+ nlReadNum + ", nlUseYn=" + nlUseYn + ", nlUseTermYn=" + nlUseTermYn + ", nlUseSdt=" + nlUseSdt
				+ ", nlUseEdt=" + nlUseEdt + ", fileId=" + fileId + ", nlThumb1=" + nlThumb1 + ", nlThumb1Alt="
				+ nlThumb1Alt + ", regdt=" + regdt + ", upddt=" + upddt + ", delDt=" + delDt + ", regmemid=" + regmemid
				+ ", updmemid=" + updmemid + ", delmemid=" + delmemid + ", delyn=" + delyn + "]";
	}




}


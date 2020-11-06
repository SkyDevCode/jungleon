package egovframework.itgcms.project.sosqna.service;

import java.io.Serializable;

public class SOSQnaVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String seq				= "";
	private String id            = "";
	private String title         = "";
	private String question      = "";
	private String addQuestion   = "";
	private String mgrId         = "";
	private String reply         = "";
	private String endDt         = "";
	private String userFileSeq   = "";
	private String mgrFileSeq    = "";
	private String statusCd      = "";
	private String delYn         = "";
	private String regDt         = "";
	private String modiDt        = "";
	
	private String name = "";
	private String mgrName = "";
	private String statusName = "";
	
	private String prevnext = "";
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAddQuestion() {
		return addQuestion;
	}
	public void setAddQuestion(String addQuestion) {
		this.addQuestion = addQuestion;
	}
	public String getMgrId() {
		return mgrId;
	}
	public void setMgrId(String mgrId) {
		this.mgrId = mgrId;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	
	public String getUserFileSeq() {
		return userFileSeq;
	}
	public void setUserFileSeq(String userFileSeq) {
		this.userFileSeq = userFileSeq;
	}
	public String getMgrFileSeq() {
		return mgrFileSeq;
	}
	public void setMgrFileSeq(String mgrFileSeq) {
		this.mgrFileSeq = mgrFileSeq;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getModiDt() {
		return modiDt;
	}
	public void setModiDt(String modiDt) {
		this.modiDt = modiDt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getMgrName() {
		return mgrName;
	}
	public void setMgrName(String mgrName) {
		this.mgrName = mgrName;
	}
	
	public String getPrevnext() {
		return prevnext;
	}
	public void setPrevnext(String prevnext) {
		this.prevnext = prevnext;
	}
	
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	@Override
	public String toString() {
		return "SOSQnAVO [seq=" + seq + ", id=" + id + ", title=" + title + ", question=" + question + ", addQuestion="
				+ addQuestion + ", mgrId=" + mgrId + ", reply=" + reply + ", endDt=" + endDt + ", userFileSeq="
				+ userFileSeq + ", mgrFileSeq=" + mgrFileSeq + ", statusCd=" + statusCd + ", delYn=" + delYn
				+ ", regDt=" + regDt + ", modiDt=" + modiDt + ", name=" + name + "]";
	}

	
}                       

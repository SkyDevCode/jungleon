package egovframework.itgcms.user.main.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import egovframework.itgcms.common.ItgMap;

public class MainBsnsVO implements Serializable {

	private String tempCode;
	private String anchorHref;
	private String boardTitle;
	private String boardSkin;
	private String boardMemo;
	private List<ItgMap> boardList;

	public String getTempCode() {
		return this.tempCode;
	}

	public void setTempCode(String tempCode) {
		this.tempCode = tempCode;
	}

	public String getAnchorHref() {
		return this.anchorHref;
	}

	public void setAnchorHref(String anchorHref) {
		this.anchorHref = anchorHref;
	}

	public String getBoardTitle() {
		return this.boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public List<ItgMap> getBoardList() {
		return this.boardList != null ? new ArrayList(this.boardList) : null;
	}

	public void setBoardList(List<ItgMap> boardList) {
		this.boardList = new ArrayList(boardList);
	}

	public void setBoardSkin(String boardSkin) {
		this.boardSkin = boardSkin;
	}

	public String getBoardSkin() {
		return this.boardSkin;
	}

	public String getBoardMemo() {
		return this.boardMemo;
	}

	public void setBoardMemo(String boardMemo) {
		this.boardMemo = boardMemo;
	}


	@Override
	public String toString() {
		return "MainBsnsVO [tempCode=" + tempCode + ", anchorHref=" + anchorHref + ", boardTitle=" + boardTitle
				+ ", boardSkin=" + boardSkin + ", boardMemo=" + boardMemo + ", boardList=" + boardList + "]";
	}


}

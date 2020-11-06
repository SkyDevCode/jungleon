package egovframework.itgcms.module.board.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.common.UserSessionVO;
import egovframework.itgcms.core.comment.service.CommentService;
import egovframework.itgcms.core.comment.service.CommentVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CommentRestController {

	private static final int PAGE_UNIT = 10;
	private static final int PAGE_SIZE = 10;

	@Resource(name="commentService")
	private CommentService commentService;


	@RequestMapping(value="/comment/list/{bdIdx}/{page}.do", method=RequestMethod.GET)
	@ResponseBody
	public EgovMap reqCommentList(@PathVariable("bdIdx") int bdIdx, @PathVariable("page") int page) throws IOException, SQLException, RuntimeException {

		EgovMap result = new EgovMap();

		CommentVO searchVo = new CommentVO();

		searchVo.setPageUnit(PAGE_UNIT);
		searchVo.setPageSize(PAGE_SIZE);

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(searchVo.getPageUnit());
		paginationInfo.setPageSize(searchVo.getPageSize());

		searchVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVo.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVo.setBdIdx(bdIdx);

		List<CommentVO> resultList =  commentService.commentListByBdIdx(searchVo);
		int totCnt = commentService.countCommentTotalCount(bdIdx);
		paginationInfo.setTotalRecordCount(totCnt);

		result.put("list", resultList);
		result.put("pageInfo", paginationInfo);

		return result;
	}


	@RequestMapping(value="/comment/com/{bdIdx}.do", method=RequestMethod.POST)
	@ResponseBody
	public int registComment(@PathVariable("bdIdx") int bdIdx, @RequestParam("content") String contents, @RequestParam("id") String id, HttpSession session, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		int result = -1;

		if (!sessionIdCheck(session, id)) {	return 0;}
		if (!(bdIdx > 0)) {return 0;}

		contents = CommUtil.getAntiHtml(contents, "");
		if ("".equals(contents)) { return result;	}

		CommentVO com = new CommentVO();

		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();

		if(CommUtil.notEmpty(mngrSessionVO) && "99".equals(mngrSessionVO.getMngAuth())) {com.setAct("super");}

		com.setcContents(HtmlUtils.htmlEscape(contents));
		com.setRegMemId(id);
		com.setBdIdx(bdIdx);

		if (commentService.registComment(com) >0) {
			result = commentService.countCommentTotalCount(bdIdx);
			result = ((int) result / com.getPageUnit())+1;
		}

		return result;
	}

	@RequestMapping(value="/comment/com/{bdIdx}/{reIdx}.do", method=RequestMethod.POST)
	@ResponseBody
	public int registReComment(@PathVariable("bdIdx") int bdIdx, @PathVariable("reIdx") int reIdx,
			@RequestParam("content") String contents, @RequestParam("id") String id, @RequestParam("recomId") String reComId, HttpSession session, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		int result = -1;

		if (!sessionIdCheck(session, id)) {	return 0; }
		if (!(bdIdx > 0)) {return 0;}
		if (!(reIdx > 0)) {return 0;}
		if ("".equals(reComId)) {return 0;}

		contents = CommUtil.getAntiHtml(contents, "");
		if ("".equals(contents)) { return result;	}

		CommentVO com = new CommentVO();
		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		if(CommUtil.notEmpty(mngrSessionVO) && "99".equals(mngrSessionVO.getMngAuth())) {com.setAct("super");}

		com.setcReIdx(reIdx);
		com.setBdIdx(bdIdx);
		com.setcContents(HtmlUtils.htmlEscape(contents));
		com.setRegMemId(id);
		com.setcReComId(reComId);

		result =	commentService.registReComment(com);

		return result;
	}

	@RequestMapping(value="/comment/com/mod/{cIdx}.do", method=RequestMethod.POST)
	@ResponseBody
	public int modifyComment(@PathVariable("cIdx") int cIdx, @RequestParam("id") String id, @RequestParam("content") String contents, HttpSession session, HttpServletRequest request) throws IOException, SQLException, RuntimeException {

		int result = -1;

		if (!sessionIdCheck(session, id)) {	return 0; }
		if (!(cIdx > 0)) {return 0;}

		contents = CommUtil.getAntiHtml(contents, "");
		if ("".equals(contents)) { return result;	}

		CommentVO com = new CommentVO();

		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		if(CommUtil.notEmpty(mngrSessionVO) && "99".equals(mngrSessionVO.getMngAuth())) {com.setAct("super");}

		com.setCIdx(cIdx);
		com.setcContents(HtmlUtils.htmlEscape(contents));
		com.setUpdMemId(id);

		result = commentService.modifyComment(com);

		return result;
	}

	@RequestMapping(value="/comment/com/del{cIdx}.do", method=RequestMethod.POST)
	@ResponseBody
	public int deleteComment(@PathVariable("cIdx") int cIdx, @RequestParam("id") String id, @RequestParam("regId") String regId, HttpSession session) throws IOException, SQLException, RuntimeException {

		int result = -1;

		if (!sessionIdCheck(session, id)) {	return 0; }
		if (!sessionIdCheck(session, regId)) {	return 0; }
		if (!(cIdx > 0)) {return 0;}

		CommentVO com = new CommentVO();

		com.setCIdx(cIdx);
		com.setDelMemId(id);

		result = commentService.deleteComment(com);

		return result;
	}


	boolean sessionIdCheck(HttpSession session, String id){
		UserSessionVO userSession = (UserSessionVO)session.getAttribute("userSessionVO");
		if (userSession != null && userSession.getId().equals(id)) {
			return true;
		}

		MngrSessionVO mngrSessionVO = CommUtil.getMngrSessionVO();
		if (mngrSessionVO != null) {
			return true;
		}
		return false;
	}

}

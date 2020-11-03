package egovframework.itgcms.module.board.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.common.MngrSessionVO;
import egovframework.itgcms.core.board.service.BoardReactionSearchVO;
import egovframework.itgcms.core.board.service.BoardService;
import egovframework.itgcms.core.comment.service.CommentVO;
import egovframework.itgcms.core.site.service.MngrSiteService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MngrBoardReactionController {

	@Resource(name="boardService")
	private BoardService boardService;

	@Resource(name="mngrSiteService")
	private MngrSiteService siteService;

	@RequestMapping(value="/_mngr_/boardReaction/reply_list.do")
	public String mngrReplyMainPage(@ModelAttribute("boardSearchVO") BoardReactionSearchVO boardSearchVO,
			@ModelAttribute("commentVO") CommentVO commentVO,
			ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, RuntimeException{

		String siteCode = CommUtil.getManagerSiteCode(request);

/*		if (siteCode == null || "".equals(siteCode)) {
			siteCode = "all";
		}*/

		String pageType = request.getParameter("pageType");
		if (pageType == null || "".equals(pageType)) {
			pageType="replList";
		}


		if ("replList".equals(pageType)) {

			boardSearchVO.setSiteCode(siteCode);
			MngrSessionVO mngrSessionVo = (MngrSessionVO)request.getSession().getAttribute("mngrSessionVO");
			String mngrId = mngrSessionVo.getId();


			boardSearchVO.setSchRegmemid(mngrId);


			boardSearchVO.setPageUnit(Integer.parseInt(boardSearchVO.getViewCount()));//viewCount
			boardSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

			int page = Integer.parseInt(boardSearchVO.getPage());
			/** paging setting */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(page);
			paginationInfo.setRecordCountPerPage(boardSearchVO.getPageUnit());
			paginationInfo.setPageSize(boardSearchVO.getPageSize());

			boardSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			boardSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			boardSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			if (boardSearchVO.getSiteCode()==null || "".equals(boardSearchVO.getSiteCode())) {
				boardSearchVO.setSiteCode("all");
			}
			int totCnt = boardService.getReplyTotCnt(boardSearchVO);
			List<ItgMap> replList = boardService.selectReplyList(boardSearchVO);

			model.addAttribute("resultList", replList);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("totCnt", totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링

		} else if ("commentList".equals(pageType)) {

			boardSearchVO.setSiteCode(siteCode);
			MngrSessionVO mngrSessionVo = (MngrSessionVO)request.getSession().getAttribute("mngrSessionVO");
			String mngrId = mngrSessionVo.getId();


			boardSearchVO.setSchRegmemid(mngrId);


			boardSearchVO.setPageUnit(Integer.parseInt(boardSearchVO.getViewCount()));//viewCount
			boardSearchVO.setPageSize(10);//pageblockcount(<< < 1 2 3 4 5 6 7 8 9 10 > >>)

			int page = Integer.parseInt(boardSearchVO.getPage());
			/** paging setting */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(page);
			paginationInfo.setRecordCountPerPage(boardSearchVO.getPageUnit());
			paginationInfo.setPageSize(boardSearchVO.getPageSize());

			boardSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			boardSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			boardSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			if (boardSearchVO.getSiteCode()==null || "".equals(boardSearchVO.getSiteCode())) {
				boardSearchVO.setSiteCode("all");
			}
			int totCnt = boardService.getCommentTotCnt(boardSearchVO);
			List<ItgMap> commentList = boardService.selectCommentList(boardSearchVO);

			model.addAttribute("resultList", commentList);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("totCnt", totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("listNo", (totCnt - ((page - 1)* paginationInfo.getRecordCountPerPage()))); //페이지 No 의 시작 값 가상의 넘버링


		}


		model.addAttribute("pageType", pageType);
		model.addAttribute("siteList", siteService.getMngrSiteList());
		model.addAttribute("searchSite", siteCode);

		return "itgcms/global/board/mng_reply_list";
	}

}

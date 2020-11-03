package egovframework.itgcms.module.serch.service.impl;


import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;
import egovframework.itgcms.core.menu.service.impl.MngrMenuMapper;
import egovframework.itgcms.core.site.service.MngrSiteSearchVO;
import egovframework.itgcms.core.site.service.MngrSiteVO;
import egovframework.itgcms.core.systemconfig.service.SiteconfigVO;
import egovframework.itgcms.module.serch.service.SearchService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("searchService")
public class SearchServiceImpl extends EgovAbstractServiceImpl implements SearchService {
	private final Logger LOGGER = Logger.getLogger(this.getClass());
	@Resource(name = "mngrMenuMapper")
	private MngrMenuMapper mngrMenuMapper;
	@Resource(name = "searchMapper")
	private SearchMapper searchMapper;

	public String searchAll(ModelMap model, MngrBoardconfigVO mngrBoardconfigVO, BoardSearchVO boardSearchVO,
			HttpServletRequest request, HttpServletResponse response, String returnPage)
			throws IOException, SQLException {
		String introMsg = "검색을 통해 유용한 정보를 더욱 손쉽게 제공해 드리고자 통합 검색 서비스를 제공합니다";
		String schFld = CommUtil.isNull(model.get("schFld"), "");
		SiteconfigVO siteconfigVO = CommUtil.getSiteconfigVO(boardSearchVO.getSiteCode());
		String searchCnd = siteconfigVO.getTotalSearch();
		if ("all".equals(searchCnd)) {
			schFld="all";
		} else {
			schFld=boardSearchVO.getSiteCode();
		}
		if (CommUtil.notEmpty(boardSearchVO.getSchStr())) {
			boardSearchVO.setLastIndex(5);

			if (schFld.equals("all")){
				boardSearchVO.setSiteCode("SNIP");
				List<ItgMap> bbsResultList = this.searchMapper.searchAllBoard(boardSearchVO);
				String bbsCnt = this.searchMapper.searchAllCntBoard(boardSearchVO);
				model.addAttribute("bbsResultList", bbsResultList);
				model.addAttribute("bbsCnt", bbsCnt);

				List<ItgMap> ctsResultList = this.searchMapper.searchAllContents(boardSearchVO);
				String ctsCnt = this.searchMapper.searchAllCntContents(boardSearchVO);
				model.addAttribute("ctsResultList", ctsResultList);
				model.addAttribute("ctsCnt", ctsCnt);


			}else if(schFld.equals("SNIP")){
				boardSearchVO.setSiteCode(schFld);
				List<ItgMap> bbsResultList = this.searchMapper.searchAllBoard(boardSearchVO);
				String bbsCnt = this.searchMapper.searchAllCntBoard(boardSearchVO);
				model.addAttribute("bbsResultList", bbsResultList);
				model.addAttribute("bbsCnt", bbsCnt);

				List<ItgMap> ctsResultList = this.searchMapper.searchAllContents(boardSearchVO);
				String ctsCnt = this.searchMapper.searchAllCntContents(boardSearchVO);
				model.addAttribute("ctsResultList", ctsResultList);
				model.addAttribute("ctsCnt", ctsCnt);

				List<ItgMap> gongResultList = this.searchMapper.searchAllGonggo(boardSearchVO);
				String gongCnt = this.searchMapper.searchAllCntGonggo(boardSearchVO);
				model.addAttribute("gongResultList", gongResultList);
				model.addAttribute("gongCnt", gongCnt);
			}
		}

		model.addAttribute("introMsg", introMsg);
		model.addAttribute("boardSearchVO", boardSearchVO);
		return returnPage;
	}

	@Override
	public String searchDetail(ModelMap model, ItgMap itgMap, BoardSearchVO boardSearchVO, String returnPage) {
		List<?> list = new ArrayList();
		String totCnt = "0";
		int viewcount  = 10;
		boardSearchVO.setViewCount(String.valueOf(viewcount));
		boardSearchVO.setPageUnit(viewcount);
		boardSearchVO.setPageSize(10);
		int page = Integer.parseInt(boardSearchVO.getPage());
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(boardSearchVO.getPageUnit());
		paginationInfo.setPageSize(boardSearchVO.getPageSize());
		boardSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		boardSearchVO.setSchStr(CommUtil.isNull(itgMap.get("detailStr"),"") );
		boardSearchVO.setSiteCode(CommUtil.isNull(itgMap.get("detailSiteCode"),""));

		if("bd".equals(itgMap.get("detailFld"))) {
			list = this.searchMapper.searchAllBoard(boardSearchVO);
			totCnt = this.searchMapper.searchAllCntBoard(boardSearchVO);
		}else if("cts".equals(itgMap.get("detailFld"))) {
			list = this.searchMapper.searchAllContents(boardSearchVO);
			totCnt = this.searchMapper.searchAllCntContents(boardSearchVO);
		}else if("gong".equals(itgMap.get("detailFld"))) {
			list = this.searchMapper.searchAllGonggo(boardSearchVO);
			totCnt = this.searchMapper.searchAllCntGonggo(boardSearchVO);
		}
		model.addAttribute("boardSearchVO", boardSearchVO);
		model.addAttribute("list", list);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("itgMap", itgMap);
		paginationInfo.setTotalRecordCount(Integer.parseInt(totCnt));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("listNo", Integer.parseInt(totCnt) - (page - 1) * paginationInfo.getRecordCountPerPage());


		return returnPage;
	}

}
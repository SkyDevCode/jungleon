package egovframework.itgcms.util;

import java.text.MessageFormat;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ResponsivePaginationRenderer extends AbstractPaginationRenderer {

	public ResponsivePaginationRenderer() {
		firstPageLabel = "<a href=\"#none\" class=\"sp sp_start\" onclick=\"{0}({1}); return false;\"  aria-label=\"맨 처음 페이지로\"></a>"; 
		previousPageLabel = "<a href=\"#none\" class=\"sp sp_prev\" onclick=\"{0}({1}); return false;\" aria-label=\"이전 페이지로\"></a>";
		nextPageLabel = "<a href=\"#none\" class=\"sp sp_next\" onclick=\"{0}({1}); return false;\" aria-label=\"다음 페이지로\"></a>";
		lastPageLabel = "<a href=\"#none\" class=\"sp sp_finish\" onclick=\"{0}({1}); return false;\" aria-label=\"맨 마지막 페이지로\"></a>";
	}
	@Override
	public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
		StringBuffer strBuff = new StringBuffer();

		int firstPageNo = paginationInfo.getFirstPageNo();
		int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
		int totalPageCount = paginationInfo.getTotalPageCount();
		int pageSize = paginationInfo.getPageSize();
		int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
		int currentPageNo = paginationInfo.getCurrentPageNo();
		int lastPageNo = paginationInfo.getLastPageNo();

		if (currentPageNo > firstPageNo) {
			strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
			strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(currentPageNo - 1) }));
		}

		/*for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
			if (i == currentPageNo) {
				strBuff.append(MessageFormat.format(currentPageLabel, new Object[] { Integer.toString(i) }));
			} else {
				strBuff.append(MessageFormat.format(otherPageLabel, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
			}
		}*/
		strBuff.append("<div class=\"paginate_input_wrap\">");
		strBuff.append("<input type=\"text\" name=\"moveToPageNum\"  id=\"moveToPageNum\" onkeydown=\"if(event.keyCode === 13){"+jsFunction+"($('#moveToPageNum').val()); return false;}\" "
				+ 	"class=\"paginate_input paginate_input2\" aria-label=\"현재 페이지\" title=\"현재 페이지\" value=\""+currentPageNo+"\" />"
				+	"<span>/</span>"
				+	"<span class=\"blind\">총 페이지</span>"
				+	"<span class=\"total_num\">"+lastPageNo+"</span>"
				+   "<a href=\"#none\" onclick=\""+jsFunction+"($('#moveToPageNum').val());return false;\" class=\"btn_page_go\">이동</a>");
		strBuff.append("</div>");
		if (currentPageNo < lastPageNo) {
				strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(currentPageNo + 1) }));
				strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
		}
		return strBuff.toString();
	}
	
	
	
}

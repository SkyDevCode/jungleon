package egovframework.itgcms.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class UserPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	String type ;
	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public UserPaginationRenderer() {
		// no-op
	}

	public void initVariables(){
		String strWebDir = "/resource/common/img/common/";
			firstPageLabel = "<a href=\"#none\" class=\"btn prevAll\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">처음페이지</span></a>"; 
			previousPageLabel = "<a href=\"#none\" class=\"btn prev\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">이전페이지</span></a>";
			currentPageLabel = "<strong class=\"on\">{0}</strong>";
			otherPageLabel = "<a href=\"#none\" onclick=\"{0}({1}); return false;\">{2}</a>";
			nextPageLabel = "<a href=\"#none\" class=\"btn next\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">다음페이지</span></a>";
			lastPageLabel = "<a href=\"#none\" class=\"btn nextAll\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">마지막페이지</span></a>";
			
		/*	<a href=\"#none\" class=\"btn prevAll\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">처음페이지</span></a>
	        <a href=\"#none\" class=\"btn prev\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">이전페이지</span></a>
	        <strong class=\"on\">{0}</strong>
	        <a href=\"#none\" onclick=\"{0}({1}); return false;\">{2}</a>
	        <a href=\"#none\" class=\"btn next\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">다음페이지</span></a>
	        <a href=\"#none\" class=\"btn nextAll\" onclick=\"{0}({1}); return false;\"><span class=\"blind\">마지막페이지</span></a>
	        */
/*//이미지 방식
		firstPageLabel = "<a class=\"btn prevAll\" href=\"#\" onclick=\"{0}({1}); return false;\">" +
							"<img src='" + strWebDir + "prevAll.png' border='0' alt='첫페이지'/></a>&#160;"; 
        previousPageLabel = "<a class=\"btn prev\" href=\"#\" onclick=\"{0}({1}); return false;\">" +
        						"<img src='" + strWebDir + "prev.png' border='0' alt='이전페이지'/></a>&#160;";
        currentPageLabel = "<strong class='on'>{0}</strong>&#160;";
        otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
        nextPageLabel = "<a class=\"btn next\" href=\"#\" onclick=\"{0}({1}); return false;\">" +
        					"<img src='" + strWebDir + "next.png' border='0' alt='다음페이지'/></a>&#160;";
        lastPageLabel = "<a class=\"btn nextAll\" href=\"#\" onclick=\"{0}({1}); return false;\">" +
        					"<img src='" + strWebDir + "nextAll.png' border='0' alt='마지막페이지'/></a>&#160;";
	
*/	
	/*
		firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_prevend.gif\" alt=\"처음\"   border=\"0\"/></a>&#160;";
        previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_prev.gif\"    alt=\"이전\"   border=\"0\"/></a>&#160;";
        currentPageLabel  = "<strong>{0}</strong>&#160;";
        otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a>&#160;";
        nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_next.gif\"    alt=\"다음\"   border=\"0\"/></a>&#160;";
        lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_nextend.gif\" alt=\"마지막\" border=\"0\"/></a>&#160;";
	*/
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}

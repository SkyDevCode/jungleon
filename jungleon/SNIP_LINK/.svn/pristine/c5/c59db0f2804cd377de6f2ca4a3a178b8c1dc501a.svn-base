package egovframework.itgcms.util;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.main.service.MngrManagerMenuVO;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.util.CommUtil;

public class CreateTreeTag extends RequestContextAwareTag  {

	private static final long serialVersionUID = -2753931298991253239L;

	@Autowired
    MngrCodeService mngrCodeService;

    String tagOption;
    List menuList;

	public CreateTreeTag() {
	}

	public void setTagOption(String tagOption) {
		this.tagOption = tagOption;
	}

	public void setMenuList(List menuList) {
		this.menuList = new ArrayList();
		if(CommUtil.notEmpty(menuList)){
			this.menuList.addAll(menuList);
		}
	}

	@Override
	protected int doStartTagInternal() throws IOException, SQLException {
		// TODO Auto-generated method stub

			StringBuilder sb = new StringBuilder();
        	String mngrRoot = "";
    		String resultStr = "";

			switch (tagOption) {
	            case "sys":

	            	mngrRoot = "/_mngr_/";
	            	for(int i = 0; i < menuList.size(); i++){
	            		MngrManagerMenuVO menuVO = (MngrManagerMenuVO)menuList.get(i);

	        			String preStr = "";
	            		String iconSet = "";
	            		if(!"".equals(menuVO.getMenuIcon())){
	            			iconSet = "<i class=\"fa "+menuVO.getMenuIcon()+"\"></i>";
	            		}else {
	            			iconSet = "<i class=\"fa fa-circle-o\"></i>";
	            		}
	            		preStr += "<li class=\"treeview\" id=\"LEFT_"+menuVO.getMenuCode().toUpperCase()+"\">\n";
	            		preStr += "<a href=\""+mngrRoot+menuVO.getMenuUrl()+".do\" title=\""+menuVO.getMenuName()+"\">\n";
	            		preStr += iconSet+"<span>"+menuVO.getMenuName()+"</span>\n";
	            		String str = "";
	            		if(menuVO.getMngrManagerMenuList() != null){
	            			str = (String)(sysChildMenu(menuVO.getMngrManagerMenuList(), 0, "LEFT", 2, 4, mngrRoot).get("str"));
	            		}
	            		if(!"".equals(str)){
	            			preStr += "<i class=\"fa fa-angle-left pull-right\"></i>\n";
	            			str = "<ul class=\"treeview-menu\">\n"+str + "</ul>\n";
	            		}

	            		preStr += "</a>\n";

	            		resultStr += preStr + str + "</li>\n";

	            	}
	            	sb.append(resultStr);
	            	break;
	            case "mngr":
	            	for(int i = 0; i < menuList.size(); i++){
	            		MngrMenuVO menuVO = (MngrMenuVO)menuList.get(i);

	        			String preStr = "";
	            		String iconSet = "<i class=\"fa fa-circle-o\"></i>";
	            		preStr += "<li class=\"treeview\" id=\"LEFT_"+menuVO.getMenuCode().toUpperCase()+"\">\n";
	            		preStr += "<a href=\"#none\" onclick=\"fn_goMenu('"+menuVO.getMenuCode()+"','"+menuVO.getMenuType()+"','"+menuVO.getMenuMngurl()+"');\" title=\""+menuVO.getMenuName()+"\">";
	            		preStr += iconSet+"<span>"+menuVO.getMenuName()+"</span>\n";
	            		String str = "";
	            		if(menuVO.getMngrMenuList() != null){
	            			str = (String)(mngrChildMenu(menuVO.getMngrMenuList(), 0, "LEFT", 2, 4, mngrRoot).get("str"));
	            		}
	            		if(!"".equals(str)){
	            			preStr += "<i class=\"fa fa-angle-left pull-right\"></i>\n";
	            			str = "<ul class=\"treeview-menu\">\n"+str + "</ul>\n";
	            		}

	            		preStr += "</a>\n";

	            		resultStr += preStr + str + "</li>\n";

	            	}
	            	sb.append(resultStr);

            		break;
	            case "user":
	            	break;
	            default:
                    break;
	        }

			pageContext.getOut().write(sb.toString());

		return SKIP_BODY;
	}

	private ItgMap sysChildMenu(List<MngrManagerMenuVO> result, int count, String type, int sDepth, int eDepth, String mngrRoot){
		ItgMap returnMap = new ItgMap();
		String str = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrManagerMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();
			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode().toUpperCase()+"\"";

			if(menuVO.getMngrManagerMenuList() != null && menuVO.getMngrManagerMenuList().size() > 0){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				str += "<li "+idName+" class=\"treeview haveSub\">\n";
				str += getSysMenuLink(menuVO, mngrRoot, depth);
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
						if(menuVO.getMngrManagerMenuList().size() > 0)
							str += sysChildMenu(menuVO.getMngrManagerMenuList(), ++count, type, sDepth, eDepth, mngrRoot).get("str");
					}
			}else{
				str += "<li "+idName+" class=\"treeview\">\n";
				str += getSysMenuLink(menuVO, mngrRoot, depth);
			}
			str += "</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)

			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 2);
			if("2".equals(dp) || "3".equals(dp)){
				str = "\n<ul class=\"treeview-menu\">\n" + str + "</ul>\n";
			}else{
				str = "\n<ul>\n" + str + "</ul>\n";
			}
		}

		returnMap.put("str", str);
		return returnMap;
	}

	private String getSysMenuLink(MngrManagerMenuVO menuVO, String mngrRoot, String depth){
		String url = "#none"; //url에 입력된 값이 없으면 링크 없음
		String str = "";
		if(!"".equals(menuVO.getMenuUrl())){
			url = mngrRoot+menuVO.getMenuUrl()+".do";
		}
		str += "<a href='"+url+"'>";

		if("5".equals(depth)){
			str += "<i class=\"fa  fa-angle-right\"></i> <span>";
		}else{
			str += "<i class=\"fa  fa-circle-o\"></i> <span>";
		}
		str += menuVO.getMenuName().replaceAll("&", "&amp;")+"</span>";
		if(menuVO.getMngrManagerMenuList() != null && menuVO.getMngrManagerMenuList().size() > 0){//서브메뉴가 있으면
			str += "<i class=\"fa fa-angle-left pull-right\"></i>\n";
		}
		str += "</a>";
		return str;
	}


	private ItgMap mngrChildMenu(List<MngrMenuVO> result, int count, String type, int sDepth, int eDepth, String mngrRoot){
		ItgMap returnMap = new ItgMap();
		String str = "";
		int nowCount = count;
		String depth = "";
		for(int i = 0;i < result.size(); i++){
			MngrMenuVO menuVO = result.get(i);
			depth = menuVO.getMenuDepth();
			String idName = ""; //left메뉴 선택표시를 위한 아이디설정

			idName = "id=\""+type+"_"+menuVO.getMenuCode().toUpperCase()+"\"";

			if(menuVO.getMngrMenuList() != null && menuVO.getMngrMenuList().size() > 0){//하위메뉴가  있으면 하위메뉴 호출	(재귀호출)
				str += "<li "+idName+" class=\"treeview haveSub\">\n";
				str += getMngrMenuLink(menuVO, mngrRoot, depth);
					if(Integer.valueOf(menuVO.getMenuDepth()) >= sDepth  && Integer.valueOf(menuVO.getMenuDepth()) <= eDepth){
						if(menuVO.getMngrMenuList().size() > 0)
							str += mngrChildMenu(menuVO.getMngrMenuList(), ++count, type, sDepth, eDepth, mngrRoot).get("str");
					}
			}else{
				str += "<li "+idName+" class=\"treeview\">\n";
				str += getMngrMenuLink(menuVO, mngrRoot, depth);
			}
			str += "</li>\n";
		}
		if(nowCount > 0){//처음엔 ul이 필요없음.(코딩에 의한 설정)

			String dp = "";
			if(!"".equals(depth)) dp = String.valueOf(Integer.parseInt(depth) - 2);
			if("2".equals(dp) || "3".equals(dp)){
				str = "\n<ul class=\"treeview-menu\">\n" + str + "</ul>\n";
			}else{
				str = "\n<ul>\n" + str + "</ul>\n";
			}
		}

		returnMap.put("str", str);
		return returnMap;
	}

	private String getMngrMenuLink(MngrMenuVO menuVO, String mngrRoot, String depth){
		String url = "#none"; //url에 입력된 값이 없으면 링크 없음
		String str = "";
		if(!"".equals(menuVO.getMenuUrl())){
			url = mngrRoot+menuVO.getMenuUrl()+".do";
		}

		str += "<a href=\"#none\" onclick=\"fn_goMenu('"+menuVO.getMenuCode()+"','"+menuVO.getMenuType()+"','"+menuVO.getMenuMngurl()+"');\" title=\""+menuVO.getMenuName()+"\">";

		//if("2".equals(depth)){
			str += "<i class=\"fa  fa-angle-right\"></i> <span>";
		//}else{
		//	str += "<i class=\"fa  fa-circle-o\"></i> <span>";
		//}
		str += menuVO.getMenuName().replaceAll("&", "&amp;")+"</span>";
		if(menuVO.getMngrMenuList() != null && menuVO.getMngrMenuList().size() > 0){//서브메뉴가 있으면
			str += "<i class=\"fa fa-angle-left pull-right\"></i>\n";
		}
		str += "</a>";
		return str;
	}


}
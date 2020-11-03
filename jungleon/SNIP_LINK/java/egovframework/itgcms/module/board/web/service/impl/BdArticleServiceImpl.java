package egovframework.itgcms.module.board.web.service.impl;

import java.sql.SQLException;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.module.board.web.service.BdArticleService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("bdArticleService")
public class BdArticleServiceImpl extends EgovAbstractServiceImpl implements BdArticleService {
	@Resource(name = "bdArticleMapper")
	private BdArticleMapper bdArticleMapper;

	@Override
	public String insertArticleRegistProc(ItgMap boardMap) throws SQLException {

		int nowRowNum = Integer.parseInt(boardMap.get("nowRowNum").toString());
		int rowNum = Integer.parseInt(boardMap.get("rowNum").toString());

		if(rowNum > 0){
			if(nowRowNum > 1){
				for(int i = 1; i < nowRowNum; i++){
					/*boardMap.put("pubListId", CustomUtil.idMake("") + "" + i);*/
					boardMap.put("baIdx", CustomUtil.idMake("E") + "" + i);

					String arSub = "arSubject" + i;
					String arSubject = "";
					if(boardMap.get(arSub) != null){
						arSubject = boardMap.get(arSub).toString();
					}
					boardMap.put("arSubject", arSubject);

					String arCon = "arContent" + i;
					String arContent = "";
					if(boardMap.get(arCon) != null){
						/*arContents = boardMap.get(arCon).toString();*/
						arContent =  CommUtil.decodeHTMLTagFilter(CommUtil.isNull(boardMap.get(arCon), ""));
						/*boardMap.put("arContents", CommUtil.decodeHTMLTagFilter(CommUtil.isNull(boardMap.get(arCon), "")));*/
					}
					boardMap.put("arContent", arContent);

					if(arSubject != "" && arContent != ""){
						bdArticleMapper.insertBdArticle(boardMap);
					}
				}
			}
		}


		return "";
	}

}

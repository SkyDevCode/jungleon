package egovframework.itgcms.project.newsletter.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.module.jfile.service.JFileService;
import egovframework.itgcms.project.newsletter.service.NewsletterService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("newsletterServiceImpl")
public class NewsletterServiceImpl implements NewsletterService {

	@Autowired
    private JFileService service;

	@Resource(name="newsletterMapper")
	NewsletterMapper newsletterMapper;


	@Override
	public int insertNewsletterProc(ItgMap itgMap) throws IOException, SQLException {

		itgMap.put("nlIdx", CustomUtil.idMake("N"));


		int nowRowNum = Integer.parseInt(itgMap.get("nowRowNum").toString());
		int rowNum = Integer.parseInt(itgMap.get("rowNum").toString());
		int arcnt = 0;

		if(rowNum > 0){
			if(nowRowNum > 1){
				for(int i = 1; i < nowRowNum; i++){
					itgMap.put("nlaIdx", CustomUtil.idMake("A") + "" + i);

					String nlaSub = "nlaSubject" + i;
					String nlaSubject = "";
					if(itgMap.get(nlaSub) != null){
						nlaSubject = itgMap.get(nlaSub).toString();
					}
					itgMap.put("nlaSubject", nlaSubject);

					String nlaCon = "nlaContent" + i;
					String nlaContent = "";
					if(itgMap.get(nlaCon) != null){
						nlaContent =  CommUtil.decodeHTMLTagFilter(CommUtil.isNull(itgMap.get(nlaCon), ""));
					}
					itgMap.put("nlaContent", nlaContent);

					if(nlaSubject != "" && nlaContent != ""){
						newsletterMapper.insertNewsletterArticle(itgMap);
						arcnt++;
					}
				}
			}
		}

		itgMap.put("nlArCnt", arcnt);
		newsletterMapper.insertNewsletter(itgMap);


		return 1;
	}


	@Override
	public List<ItgMap> selectNewsletterList(DefaultVO searchVO) throws IOException, SQLException {

		return newsletterMapper.selectNewsletterList(searchVO);
	}


	@Override
	public List<ItgMap> selectNewsletterArticleList(DefaultVO searchVO) throws IOException, SQLException {

		return newsletterMapper.selectNewsletterArticleList(searchVO);
	}


	@Override
	public int selectMngrNewsletterCnt(DefaultVO searchVO) throws IOException, SQLException {

		return newsletterMapper.selectMngrNewsletterCnt(searchVO);
	}


	@Override
	public ItgMap selectNewsletterView(ItgMap itgMap) throws IOException, SQLException {

		return newsletterMapper.selectNewsletterView(itgMap);
	}


	@Override
	public List<ItgMap> selectNewsletterArticleView(ItgMap itgMap) throws IOException, SQLException {

		return newsletterMapper.selectNewsletterArticleView(itgMap);
	}


	@Override
	public int updateMngrNewsletter(ItgMap itgMap) throws IOException, SQLException {

		int resultArticle = newsletterMapper.deleteMngrNewsletterArticleList(itgMap);

		int nowRowNum = Integer.parseInt(itgMap.get("nowRowNum").toString());
		int rowNum = Integer.parseInt(itgMap.get("rowNum").toString());
		int arcnt = 0;

		if(rowNum > 0){
			if(nowRowNum > 1){
				for(int i = 1; i < nowRowNum; i++){
					itgMap.put("nlaIdx", CustomUtil.idMake("A") + "" + i);

					String nlaSub = "nlaSubject" + i;
					String nlaSubject = "";
					if(itgMap.get(nlaSub) != null){
						nlaSubject = itgMap.get(nlaSub).toString();
					}
					itgMap.put("nlaSubject", nlaSubject);

					String nlaCon = "nlaContent" + i;
					String nlaContent = "";
					if(itgMap.get(nlaCon) != null){
						nlaContent =  CommUtil.decodeHTMLTagFilter(CommUtil.isNull(itgMap.get(nlaCon), ""));
					}
					itgMap.put("nlaContent", nlaContent);

					if(nlaSubject != "" && nlaContent != ""){
						newsletterMapper.insertNewsletterArticle(itgMap);
						arcnt++;
					}
				}
			}
		}

		itgMap.put("nlArCnt", arcnt);
		newsletterMapper.updateMngrNewsletter(itgMap);

		return 1;
	}


	@Override
	public String deleteMngrNewsletter(ItgMap itgMap) throws IOException, SQLException {

		newsletterMapper.deleteMngrNewsletterArticleList(itgMap);
		int result = newsletterMapper.deleteMngrNewsletter(itgMap);

		if(result < 1) {
			return "삭제 처리중 오류가 발생했습니다. 확인후 다시 시도해 주세요.";
		}

		//썸네일 삭제
		String oldNlThumb1 = CommUtil.isNull(itgMap.get("oldNlThumb1"), "");
		String fileId = CommUtil.isNull(itgMap.get("fileId"), "");

		//완전삭제
		if(!"".equals(oldNlThumb1)) {
			CommUtil.fileDel(CommUtil.getFileRoot("") + File.separator + "newsletter" + File.separator + oldNlThumb1);
		}
		// 멀티첨부 삭제(delete_yn flag "Y"
		if(!"".equals(fileId)) {
			service.updateAttachFileDeleteYnByFileId(fileId, "Y");
		}

		return "";
	}


	@Override
	public int deleteNewsletterMulti(DefaultVO searchVO) throws IOException, SQLException {

		int cnt = 0;
		for(int i = 0; i < searchVO.getChkId().length; i++) {
			ItgMap itgMap = new ItgMap();
			itgMap.put("nlIdx", searchVO.getChkId()[i]);
			itgMap.put("delmemid", CommUtil.getMngrMemId());
			int result = newsletterMapper.deleteMngrNewsletter(itgMap);
			int resultArticle = newsletterMapper.deleteMngrNewsletterArticleList(itgMap);
			if(result < 1) {
				throw new SQLException("삭제된 데이터가 없습니다");
			}
			cnt ++;
		}
		return cnt;
	}


	@Override
	public List<ItgMap> selectNewsletterListAll(DefaultVO searchVO) throws IOException, SQLException {

		List<ItgMap> selectNewsletterUserList = newsletterMapper.selectNewsletterUserList(searchVO);
		List<ItgMap> newsArticleList = new ArrayList();

		for (int i  = 0; i < selectNewsletterUserList.size(); i++) {
			ItgMap tmpMap = selectNewsletterUserList.get(i);
			String nlIdx = (String) tmpMap.get("nlIdx");

			List<ItgMap> nlArticle = newsletterMapper.selectNewsletterArticle(nlIdx);
			tmpMap.put("subList", nlArticle);
			newsArticleList.add(tmpMap);

		}

		return newsArticleList;
	}


	@Override
	public List<ItgMap> selectOldNewsList() throws IOException, SQLException {


		return newsletterMapper.selectOldNewsList();
	}


	@Override
	public ItgMap selectNewsletterOne(String nlaIdxStr) throws IOException, SQLException {

		return newsletterMapper.selectNewsletterOne(nlaIdxStr);
	}



}

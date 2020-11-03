package egovframework.itgcms.project.newsletter.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface NewsletterService {

	int insertNewsletterProc(ItgMap itgMap) throws IOException, SQLException;

	List<ItgMap> selectNewsletterList(DefaultVO searchVO) throws IOException, SQLException;

	List<ItgMap> selectNewsletterArticleList(DefaultVO searchVO) throws IOException, SQLException;

	int selectMngrNewsletterCnt(DefaultVO searchVO) throws IOException, SQLException;

	ItgMap selectNewsletterView(ItgMap itgMap) throws IOException, SQLException;

	List<ItgMap> selectNewsletterArticleView(ItgMap itgMap) throws IOException, SQLException;

	int updateMngrNewsletter(ItgMap itgMap) throws IOException, SQLException;

	String deleteMngrNewsletter(ItgMap itgMap) throws IOException, SQLException;

	int deleteNewsletterMulti(DefaultVO searchVO) throws IOException, SQLException;

	List<ItgMap> selectNewsletterListAll(DefaultVO searchVO) throws IOException, SQLException;

	List<ItgMap> selectOldNewsList() throws IOException, SQLException;

	ItgMap selectNewsletterOne(String nlaIdxStr) throws IOException, SQLException;


}

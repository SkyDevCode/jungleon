package egovframework.itgcms.project.newsletter.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.project.newsletter.service.NewsletterVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("newsletterMapper")
public interface NewsletterMapper {

	void insertNewsletter(ItgMap itgMap) throws SQLException;

	void insertNewsletterArticle(ItgMap itgMap) throws SQLException;

	List<ItgMap> selectNewsletterList(DefaultVO searchVO) throws SQLException;

	List<ItgMap> selectNewsletterArticleList(DefaultVO searchVO) throws SQLException;

	int selectMngrNewsletterCnt(DefaultVO searchVO) throws SQLException;

	ItgMap selectNewsletterView(ItgMap itgMap) throws SQLException;

	List<ItgMap> selectNewsletterArticleView(ItgMap itgMap) throws SQLException;

	int updateMngrNewsletter(ItgMap itgMap) throws SQLException;

	int deleteMngrNewsletterArticleList(ItgMap itgMap) throws SQLException;

	int deleteMngrNewsletter(ItgMap itgMap) throws SQLException;

	List<ItgMap> selectNewsletterArticle(String nlIdx) throws SQLException;

	List<ItgMap> selectNewsletterArticle() throws SQLException;

	List<ItgMap> selectNewsletterUserList(DefaultVO searchVO) throws SQLException;

	List<ItgMap> selectOldNewsList() throws SQLException;

	ItgMap selectNewsletterOne(String nlaIdxStr) throws SQLException;

}

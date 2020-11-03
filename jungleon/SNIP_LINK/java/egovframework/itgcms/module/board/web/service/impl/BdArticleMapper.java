package egovframework.itgcms.module.board.web.service.impl;

import java.sql.SQLException;

import egovframework.itgcms.common.ItgMap;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("bdArticleMapper")
public interface BdArticleMapper {

	void insertBdArticle(ItgMap boardMap) throws SQLException;

}

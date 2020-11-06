package egovframework.itgcms.module.serch.service.impl;

import java.util.List;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("searchMapper")
public interface SearchMapper {

	List<ItgMap> searchAllBoard(BoardSearchVO boardSearchVO);

	String searchAllCntBoard(BoardSearchVO boardSearchVO);

	List<ItgMap> searchAllContents(BoardSearchVO boardSearchVO);

	String searchAllCntContents(BoardSearchVO boardSearchVO);

	List<ItgMap> searchAllGonggo(BoardSearchVO boardSearchVO);

	String searchAllCntGonggo(BoardSearchVO boardSearchVO);

}

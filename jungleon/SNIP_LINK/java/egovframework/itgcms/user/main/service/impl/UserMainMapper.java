package egovframework.itgcms.user.main.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMainMapper")
public interface UserMainMapper  {

	List selectBsnsList(BoardSearchVO boardSearchVO) throws IOException, SQLException;

}

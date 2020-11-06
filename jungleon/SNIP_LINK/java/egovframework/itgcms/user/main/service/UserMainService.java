package egovframework.itgcms.user.main.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.core.board.service.BoardSearchVO;

public interface UserMainService {

	List selectBsnsList(BoardSearchVO boardSearchVO) throws IOException, SQLException;

}

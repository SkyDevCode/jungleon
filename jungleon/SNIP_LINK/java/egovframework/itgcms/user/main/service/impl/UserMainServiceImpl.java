package egovframework.itgcms.user.main.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.user.main.service.UserMainService;

@Service("userMainService")
public class UserMainServiceImpl implements UserMainService {

	@Resource(name="userMainMapper")
	UserMainMapper userMainMapper;

	@Override
	public List selectBsnsList(BoardSearchVO boardSearchVO) throws IOException, SQLException {

		return userMainMapper.selectBsnsList(boardSearchVO);
	}

}

package egovframework.itgcms.module.serch.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.board.service.BoardSearchVO;
import egovframework.itgcms.core.boardconfig.service.MngrBoardconfigVO;

public interface SearchService {

	String searchAll(ModelMap model, MngrBoardconfigVO mngrBoardconfigVO, BoardSearchVO boardSearchVO,
			HttpServletRequest request, HttpServletResponse response, String returnPage) throws IOException, SQLException;

	String searchDetail(ModelMap model, ItgMap itgMap, BoardSearchVO boardSearchVO, String returnPage) throws IOException, SQLException;
}

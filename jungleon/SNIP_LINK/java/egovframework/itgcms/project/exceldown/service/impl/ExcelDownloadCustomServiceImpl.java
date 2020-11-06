package egovframework.itgcms.project.exceldown.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.project.exceldown.service.ExcelDownloadCustomService;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;

@Service("ExcelDownloadCustomService")
public class ExcelDownloadCustomServiceImpl implements ExcelDownloadCustomService {

	@Resource(name="excelDownloadCustomMapper")
	ExcelDownloadCustomMapper excelDownloadCustomMapper;

	@Override
	public List<ItgMap> selectMngrBsnsPblancData(String bbsBcId) throws IOException, SQLException {

		return excelDownloadCustomMapper.selectMngrBsnsPblancData(bbsBcId);
	}

	@Override
	public List<ItgMap> selectMngrSpBussinessIngData(String bbsBcId) throws IOException, SQLException {

		return excelDownloadCustomMapper.selectMngrSpBussinessIngData(bbsBcId);
	}

	@Override
	public List<ItgMap> selectMngrSpBussinessEndData(String bbsBcId) throws IOException, SQLException {

		return excelDownloadCustomMapper.selectMngrSpBussinessEndData(bbsBcId);
	}

	@Override
	public List<ItgMap> selectMngrEmptyData(String bbsBcId) throws IOException, SQLException {

		return excelDownloadCustomMapper.selectMngrEmptyData(bbsBcId);
	}

	@Override
	public List<ItgMap> selectMngrMaPuNotiData(String bbsBcId) throws IOException, SQLException {

		return excelDownloadCustomMapper.selectMngrMaPuNotiData(bbsBcId);
	}



}

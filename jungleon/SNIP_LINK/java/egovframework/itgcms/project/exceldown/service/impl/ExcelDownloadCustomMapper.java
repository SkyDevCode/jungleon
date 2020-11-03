package egovframework.itgcms.project.exceldown.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.project.totalTable.service.TotalTbVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("excelDownloadCustomMapper")
public interface ExcelDownloadCustomMapper {

	List<ItgMap> selectMngrBsnsPblancData(String bbsBcId)  throws IOException, SQLException;

	List<ItgMap> selectMngrSpBussinessIngData(String bbsBcId) throws IOException, SQLException;

	List<ItgMap> selectMngrSpBussinessEndData(String bbsBcId) throws IOException, SQLException;

	List<ItgMap> selectMngrEmptyData(String bbsBcId) throws IOException, SQLException;

	List<ItgMap> selectMngrMaPuNotiData(String bbsBcId) throws IOException, SQLException;

}

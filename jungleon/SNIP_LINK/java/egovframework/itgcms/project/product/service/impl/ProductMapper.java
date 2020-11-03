package egovframework.itgcms.project.product.service.impl;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.project.product.service.ProductSearchVO;
import egovframework.itgcms.project.product.service.ProductVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("productMapper")
public interface ProductMapper {

	int selectProductListTotCnt(ProductSearchVO searchVO) throws SQLException;

	List<ProductVO> selectProductList(ProductSearchVO searchVO) throws SQLException;

	ProductVO selectProductView(ProductSearchVO searchVO) throws SQLException;

	int deleteProductProc(ProductVO productVO) throws SQLException;

	int updateProduct(ProductVO productVO) throws SQLException;

	List<EgovMap> selectProductViewPrevNext(ProductSearchVO searchVO) throws SQLException;

	List<EgovMap> selectUnspscSearch(EgovMap paramMap)  throws SQLException;

	int insertProduct(ProductVO productVO) throws SQLException;

}

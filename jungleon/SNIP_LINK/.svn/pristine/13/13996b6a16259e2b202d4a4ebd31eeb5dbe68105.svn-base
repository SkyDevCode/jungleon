package egovframework.itgcms.project.product.service;

import java.sql.SQLException;
import java.util.List;

import egovframework.itgcms.common.DefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ProductService {

	int selectProductListTotCnt(ProductSearchVO searchVO) throws SQLException;

	List<ProductVO> selectProductList(ProductSearchVO searchVO) throws SQLException;

	ProductVO selectProductView(ProductSearchVO searchVO) throws SQLException;

	int deleteProductMultiProc(ProductSearchVO searchVO) throws SQLException;

	int updateProduct(ProductVO productVO) throws SQLException;

	int deleteProductProc(ProductVO productVO) throws SQLException;

	List<EgovMap> selectProductViewPrevNext(ProductSearchVO searchVO) throws SQLException;

	List<EgovMap> selectUnspscSearch(EgovMap paramMap) throws SQLException;

	int insertProduct(ProductVO productVO) throws SQLException;
}

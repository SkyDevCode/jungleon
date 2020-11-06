package egovframework.itgcms.project.product.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.project.product.service.ProductSearchVO;
import egovframework.itgcms.project.product.service.ProductService;
import egovframework.itgcms.project.product.service.ProductVO;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("productService")
public class ProductServiceImpl implements ProductService{

	@Resource(name="productMapper")
	ProductMapper productMapper;

	@Override
	public int selectProductListTotCnt(ProductSearchVO searchVO) throws SQLException {
		return productMapper.selectProductListTotCnt(searchVO);
	}

	@Override
	public List<ProductVO> selectProductList(ProductSearchVO searchVO) throws SQLException {
		return productMapper.selectProductList(searchVO);
	}

	@Override
	public ProductVO selectProductView(ProductSearchVO searchVO) throws SQLException {
		return productMapper.selectProductView(searchVO);
	}

	@Override
	public int updateProduct(ProductVO productVO) throws SQLException {
		return productMapper.updateProduct(productVO);
	}
	
	@Override
	public int deleteProductProc(ProductVO productVO) throws SQLException {
		return productMapper.deleteProductProc(productVO);
	}

	@Override
	public int deleteProductMultiProc(ProductSearchVO searchVO) throws SQLException {
		int cnt = 0;
		for(int i = 0; i < searchVO.getChkId().length; i++) {
			ProductVO vo = new ProductVO();
			vo.setPrdNo(searchVO.getChkId()[i]);
			int result = productMapper.deleteProductProc(vo);
			if(result < 1) {
				throw new SQLException("삭제된 데이터가 없습니다 : product prdNo:" + vo.getBusiRegNo());
			}
			cnt ++;
		}
		return cnt;
	}

	@Override
	public List<EgovMap> selectProductViewPrevNext(ProductSearchVO searchVO) throws SQLException {
		return productMapper.selectProductViewPrevNext(searchVO);
	}

	@Override
	public List<EgovMap> selectUnspscSearch(EgovMap paramMap) throws SQLException {
		String depth = CommUtil.isNull(paramMap.get("depth"), "");
		String unCd = CommUtil.isNull(paramMap.get("unCd"), "");
		if("".equals(depth) || "".equals(unCd)) return new ArrayList<EgovMap>();
		if("1".equals(depth)) {
			paramMap.put("likeUnCd", "%000000");
		} else if("2".equals(depth)) {
			paramMap.put("likeUnCd", unCd.substring(0, 2) + "%0000");
		} else if("3".equals(depth)) {
			paramMap.put("likeUnCd", unCd.substring(0, 4) + "%00");
		} else if("4".equals(depth)) {
			paramMap.put("likeUnCd", unCd.substring(0, 6) + "%");
			
		}
		return productMapper.selectUnspscSearch(paramMap);
	}

	@Override
	public int insertProduct(ProductVO productVO) throws SQLException {
		return productMapper.insertProduct(productVO);
	}
	
	
}

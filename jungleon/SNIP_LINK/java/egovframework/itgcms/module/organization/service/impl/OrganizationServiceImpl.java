package egovframework.itgcms.module.organization.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.itgcms.common.DefaultVO;
import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.code.service.MngrCodeService;
import egovframework.itgcms.core.code.service.MngrCodeVO;
import egovframework.itgcms.core.main.service.MngrMainService;
import egovframework.itgcms.core.menu.service.MngrMenuVO;
import egovframework.itgcms.module.organization.service.OrganizationService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.ExcelDownloadView;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("organizationService")
public class OrganizationServiceImpl extends EgovAbstractServiceImpl implements OrganizationService {

	@Resource(name="organizationMapper")
	private OrganizationMapper organizationMapper;

	@Override
	public String selectOrganizationList() throws IOException, SQLException {
		List<ItgMap> result = organizationMapper.selectOrganizationList();

		String json = "[";
		for(ItgMap map : result){
			json += "{"
					+ "\"id\": \"" + map.get("orCode").toString() + "\" "
					+ ",\"code\": \"" + map.get("orCode").toString() + "\" "
					+ ",\"name\": \"" + (map.get("orName").toString()).replace("<br/>", "\\n") + " (" + map.get("orCode").toString() + ")" + "\" "
					+ ",\"pId\": \"" + map.get("orPcode").toString() + "\" "
					+ ",\"pCode\": \"" + map.get("orPcode").toString() + "\" "
					+ ",\"tId\": \"" + map.get("orCode").toString() + "\" "
					+ ",\"depth\": \"" + map.get("orDepth").toString() + "\" "
					+ "}" ;
			if(result.indexOf(map)+1!=result.size()){
				json += ",";
			}
		}
		json += "]";

		return json;
	}

	@Override
	public List<ItgMap> selectOrganizationListMap() throws IOException, SQLException {
		return organizationMapper.selectOrganizationList();
	}

	@Override
	public ItgMap selectOrganizationView(ItgMap itgMap) throws IOException, SQLException{
		return organizationMapper.selectOrganizationView(itgMap);
	}

	@Override
	public String insertOrganization(ItgMap itgMap) throws IOException, SQLException {
		String result = "0";
		String message = "데이터 저장 중 오류가 발생했습니다. 다시 시도해 주세요";

		if("".equals(CommUtil.isNull(itgMap.get("orCode"), ""))){
			result = "3";
			message = "코드를 입력 해 주세요.";
		} else if("".equals(CommUtil.isNull(itgMap.get("orName"), ""))){
			result = "3";
			message = "부서명을 입력 해 주세요.";
		}else { //입력값 정상
			int resultCnt = organizationMapper.selectOrganizationDupl(itgMap);
			if(resultCnt > 0){
				result = "2";
				message = "코드가 중복 되었습니다. 확인 후 다시 시도해 주세요";
			}else{
				// 코드 정상
				itgMap.put("orRegId", CommUtil.getMngrMemId());
				int isSuc = organizationMapper.insertOrganization(itgMap);
				if(isSuc==1){
					result = "1";
					message = "등록 되었습니다.";
				}
			}
		}

		return "{\"result\" : "+result+", \"message\" : \""+message+"\"}";
	}


	@Override
	public String updateOrganization(ItgMap itgMap) throws IOException, SQLException {
		String result = "0";
		String message = "데이터 수정 중 오류가 발생했습니다. 다시 시도해 주세요";

		if("".equals(CommUtil.isNull(itgMap.get("orCode"), ""))){
			result = "3";
			message = "코드정보가 없습니다. 확인 후 다시 시도해 주세요.";
		} else if("".equals(CommUtil.isNull(itgMap.get("orName"), ""))){
			result = "3";
			message = "부서명을 입력 해 주세요.";
		}else { //입력값 정상
			itgMap.put("orUpdId", CommUtil.getMngrMemId());
			int isSuc = organizationMapper.updateOrganization(itgMap);
			if(isSuc==1){
				result = "1";
				message = "수정 되었습니다.";
			}
		}
		return "{\"result\" : "+result+", \"message\" : \""+message+"\"}";
	}

	@Override
	public String deleteOrganization(ItgMap itgMap) throws IOException, SQLException {
		int subCnt = organizationMapper.selectOrganizationSubTree(itgMap);
		String result = "0";
		if(subCnt > 0){
			result = "2";
		}else{
			itgMap.put("orDelId", CommUtil.getMngrMemId());
			int isSuc = organizationMapper.deleteOrganization(itgMap);
			if(isSuc==1){
				result = "1";
			}
		}
		return "{\"result\" : "+result+"}";
	}

	@Override
	public int selectOrganizationDupl(ItgMap itgMap) throws IOException, SQLException {
		return organizationMapper.selectOrganizationDupl(itgMap);
	}

	@Override
	public String updateOrganizationUpDown(ItgMap itgMap) throws IOException, SQLException {
		//두개의 정보를 동시에 변경해야 하기때문에 트랜젝션이 필요해서 service에서 처리함.
		ItgMap target = organizationMapper.selectOrganizationSwapTarget(itgMap);
		if(target == null){
			return "2"; // 첫번째, 마지막 위치
		}
		itgMap.put("schCode", itgMap.get("id"));
		ItgMap source = organizationMapper.selectOrganizationView(itgMap);

		ItgMap map = new ItgMap();
		/* 타겟의 오더순서를 소스의 오더순서로 설정*/
		map.put("orCode", target.get("orCode"));
		map.put("orOrder", source.get("orOrder"));
		organizationMapper.updateOrganizationUpDown(map);

		/* 소스의 오더순서를 타겟의 오더순서로 설정*/
		map.put("orCode", source.get("orCode"));
		map.put("orOrder", target.get("orOrder"));
		organizationMapper.updateOrganizationUpDown(map);
		return "1";
	}

}
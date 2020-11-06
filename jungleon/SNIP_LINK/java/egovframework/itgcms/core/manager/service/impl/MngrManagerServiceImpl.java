/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.itgcms.core.manager.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerLoginLogVO;
import egovframework.itgcms.core.manager.service.MngrManagerSearchVO;
import egovframework.itgcms.core.manager.service.MngrManagerService;
import egovframework.itgcms.core.manager.service.MngrManagerVO;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogService;
import egovframework.itgcms.module.menuAuth.service.impl.MenuAuthMapper;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.CustomUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명 : ManagerServiceImpl.java
 * @파일정보 : 관리자 서비스 구현 클래스
 * @수정이력
 * @수정자 수정일 수정내용
 * @------- ------------ ----------------
 * @woonee 2014. 9. 5. 최초생성
 * @---------------------------------------
 * @author (주)아이티굿 개발팀
 * @since 2009. 01.14
 * @version 1.0 Copyright (C) ITGOOD All right reserved.
 */

@Service("mngrManagerService")
public class MngrManagerServiceImpl extends EgovAbstractServiceImpl implements MngrManagerService {
	@Autowired
	HttpServletRequest request;

	private static final Logger LOGGER = LoggerFactory.getLogger(MngrManagerServiceImpl.class);

	/** ManagerDAO */
	// ibatis 사용
	/*@Resource(name="ManagerDAO")
	private ManagerDAO managerDAO;*/
	// mybatis 사용
    @Resource(name="mngrManagerMapper")
	private MngrManagerMapper mngrManagerMapper;

    @Resource(name="menuAuthMapper")
    private MenuAuthMapper menuAuthMapper;

    /** mngrManagerLogService */
	@Resource(name = "mngrManagerLogService")
	private MngrManagerLogService mngrManagerLogService;

    /**
   	 * 관리자 목록을 조회한다.(로그용)
   	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
   	 * @return 글 목록
   	 * @exception Exception
   	 */
	public List<?> selectMngrManagerList(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerList(mngrManagerSearchVO);
	}

    /**
  	 * 관리자 목록을 조회한다.(모듈용)
  	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
  	 * @return 글 목록
  	 * @exception Exception
  	 */
    public List<?> mMngrManagerList(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
    	return mngrManagerMapper.mngrManagerList(mngrManagerSearchVO);
    }

       /**
   	 * 글 총 갯수를 조회한다.
   	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
   	 * @return 글 총 갯수
   	 * @exception
   	 */
       public int mngrManagerListTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
   		return mngrManagerMapper.mngrManagerListTotCnt(mngrManagerSearchVO);
   	}


	public void insertMngrManagerProc(MngrManagerVO mngrManagerVO) throws IOException, SQLException {
    	int result = mngrManagerMapper.insertMngrManagerProc(mngrManagerVO);

    	if(result>0){
    		if(CommUtil.notEmpty(mngrManagerVO.getSiteCodeMeta())) {
	    		String[] siteArry = mngrManagerVO.getSiteCodeMeta().split(",");

				for(String site : siteArry) {

					ItgMap siteParamMap = new ItgMap();
					siteParamMap.put("siteCode", site);
					siteParamMap.put("mngId", mngrManagerVO.getMngId());
					siteParamMap.put("siteCode", site);
					siteParamMap.put("loginId", mngrManagerVO.getRegmemid());
					mngrManagerMapper.putManagerSite(siteParamMap);
				}
	    	}
    	}
	}

    /**
	 * 글을 조회한다.
	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 searchVO
	 * @return 조회 결과
	 * @exception Exception
	 */
	public MngrManagerVO mngrManagerView(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
		MngrManagerVO resultVO = mngrManagerMapper.mngrManagerView(mngrManagerSearchVO);
        return resultVO;
	}

    /**
	 * 권한리스트를 스트링형태로 가져온다.
	 * @param mngrManagerVO - mngType 정보가 들어있는 VO
	 * @return 조회 결과
	 * @exception Exception
	 */
	public String mngrManagerCheckPower(MngrManagerVO mngrManagerVO) throws IOException, SQLException {
        return mngrManagerMapper.mngrManagerCheckPower(mngrManagerVO);
	}

	public String updateMngrManagerUpdateProc(MngrManagerVO mngrManagerVO) throws IOException, SQLException {

		MngrManagerVO beforeMngVO = mngrManagerMapper.mngrManagerView(mngrManagerVO);
		int result = mngrManagerMapper.mngrManagerUpdateProc(mngrManagerVO);

		if(result>0){
			if(!mngrManagerVO.getSiteCode().equals(mngrManagerVO.getSiteCodeMeta())) {
				ItgMap paramMap = new ItgMap();
				paramMap.put("mngId", mngrManagerVO.getId());
				mngrManagerMapper.deleteManagerSitebyMngr(paramMap);
				if(CommUtil.notEmpty(mngrManagerVO.getSiteCodeMeta())) {
					String[] siteArry = mngrManagerVO.getSiteCodeMeta().split(",");

					for(String site : siteArry) {

						ItgMap siteParamMap = new ItgMap();
						siteParamMap.put("siteCode", site);
						siteParamMap.put("mngId", mngrManagerVO.getId());
						siteParamMap.put("siteCode", site);
						siteParamMap.put("loginId", mngrManagerVO.getUpdmemid());
						mngrManagerMapper.putManagerSite(siteParamMap);
					}
				}
			}
		}

/*		String beforePowers = mngrManagerMapper.mngrManagerCheckPower(beforeMngVO);
		String powers = mngrManagerMapper.mngrManagerCheckPower(mngrManagerVO);
		if(!CommUtil.strInArrChk(beforePowers, "MEMBER_USER")){		// 권한이 바뀌기 전 개인정보 접근권한이 없었으나..
			if(CommUtil.strInArrChk(powers, "MEMBER_USER")){			// 신규 권한에 개인정보 접근권한이 발생할경우 로그에 기록한다.
				MngrManagerLogVO mngrManagerLogVO = new MngrManagerLogVO();
				mngrManagerLogVO.setMlogClass("MngrManagerServiceImpl");
				mngrManagerLogVO.setMlogMethod("mngrManagerUpdateProc");
				mngrManagerLogVO.setMlogType("U");
				mngrManagerLogVO.setMngId(CommUtil.getMngrMemId());
				mngrManagerLogVO.setMngName(CommUtil.getMngrSessionVO().getName());
				mngrManagerLogVO.setMlogIp(CommUtil.getClientIP(request));
				mngrManagerLogVO.setMlogReferer(request.getHeader("REFERER"));
				mngrManagerLogVO.setMlogPersonalinfo("1");

				String url = request.getRequestURL().toString();
				if(url != null && request.getQueryString() != null){
					url += "?" + request.getQueryString();
				}
				mngrManagerLogVO.setMlogUrl(url);

				if(!"".equals(CommUtil.getMngrMemId())){ //관리자 아이디가 없으면 로그저장 안함
					try {
						mngrManagerLogService.mngrManagerLogInsert(mngrManagerLogVO);
					} catch (SQLException e) {
						LOGGER.error("예외 상황 발생");
					}
				}
			}
		}*/

		return "";
	}

	public void deleteMngrManagerProc(MngrManagerVO mngrManagerVO) throws IOException, SQLException {
		/** 1. 관리자를 지우기 전 관리자 개별 권한을 먼저 삭제해 준다**/
		//1. 파라메터 세팅
		ItgMap paramMap = new ItgMap();
		paramMap.put("mngId", mngrManagerVO.getId()); //관리자아이디
		//2. 관리자에게 개별 부여된 메뉴코드들을 삭제
		menuAuthMapper.deleteMenuAuthItem(paramMap);
		//3. 해당관리자에게 연결된 권한연결정보 삭제(권한을 삭제하는게 아님. 연결정보만 삭제)
		menuAuthMapper.deleteManagerMenuAuth(paramMap);
		//4. 관리자개별권한 삭제
		menuAuthMapper.deleteMenuAuth(paramMap);

		/** 2.관리자-사이트 연결정보삭제**/
		mngrManagerMapper.deleteManagerSitebyMngr(paramMap);

		/** 3.관리자정보삭제**/
		mngrManagerMapper.deleteMngrManagerProc(mngrManagerVO);
	}

	@Override
	public void deleteMngrManagerChkProc(MngrManagerVO mngrManagerVO) throws IOException, SQLException {
		/**관리자를 지우기 전 관리자 개별 권한을 먼저 삭제해 준다**/
		//1. 파라메터 세팅
		ItgMap paramMap = new ItgMap();
		paramMap.put("mngIds", mngrManagerVO.getChkId()); //관리자아이디배열
		//2. 관리자별 개별권한에 소속된 메뉴코드들을 삭제
		menuAuthMapper.deleteMenuAuthItem(paramMap);
		//3. 해당관리자들에게 연결된 권한연결정보 삭제(권한을 삭제하는게 아님. 연결정보만 삭제)
		menuAuthMapper.deleteManagerMenuAuth(paramMap);
		//4. 관리자별 개별권한 삭제
		menuAuthMapper.deleteMenuAuth(paramMap);

		/** 2.관리자-사이트 연결정보삭제**/
		mngrManagerMapper.deleteManagerSitebyMngr(paramMap);

		mngrManagerMapper.deleteMngrManagerChkProc(mngrManagerVO);
	}

	@Override
	public int mngrManagerCheckId(MngrManagerSearchVO mngrManagerSearchVO)
			throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerCheckId(mngrManagerSearchVO);
	}

	@Override
	public void mngrManagerInitPass(MngrManagerVO managerVO) throws IOException, SQLException {
		mngrManagerMapper.mngrManagerInitPass(managerVO);
	}

	@Override
	public void increaseMngPassTryCnt(MngrManagerVO managerVO) throws IOException, SQLException {
		mngrManagerMapper.increaseMngPassTryCnt(managerVO);
	}

	@Override
	public List<MngrManagerVO> mngrManagerListAjax(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerListAjax(mngrManagerSearchVO);
	}

	@Override
	public List<?> mngrManagerAuthListAjax(String mngRole) throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerAuthListAjax(mngRole);
	}

	@Override
	public List<?> mngrManagerAuthPowerListAjax(String powerCode) throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerAuthPowerListAjax(powerCode);
	}

	@Override
	public void mngrManagerLoginLogInsert(MngrManagerLoginLogVO mngrManagerLoginLogVO) throws IOException, SQLException {
		mngrManagerMapper.mngrManagerLoginLogInsert(mngrManagerLoginLogVO);
	}

	@Override
	public List<MngrManagerLoginLogVO> mngrManagerLoginLogAjax(String log_id) throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerLoginLogAjax(log_id);
	}

	@Override
	public List<MngrManagerLoginLogVO> selectMngrManagerLoginLogList(MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws IOException, SQLException {
		return mngrManagerMapper.selectMngrManagerLoginLogList(mngrManagerLoginLogSearchVO);
	}

	@Override
	public int mngrManagerLoginLogListTotCnt(MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws IOException, SQLException {
		return mngrManagerMapper.mngrManagerLoginLogListTotCnt(mngrManagerLoginLogSearchVO);
	}

	@Override
	public void deleteMngrManagerLoginLogProc(MngrManagerLoginLogSearchVO mngrManagerLoginLogSearchVO) throws IOException, SQLException {
		mngrManagerMapper.deleteMngrManagerLoginLogProc(mngrManagerLoginLogSearchVO);
	}

	@Override
	public String chkPassBfView(String mngrId) throws IOException, SQLException {
		return mngrManagerMapper.mngrChkPassBfView(mngrId);
	}

	/** 3.07 버전 추가 **/
    public List<?> managerListBySite(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
    	return mngrManagerMapper.managerListBySite(mngrManagerSearchVO);
    }

    public int managerListBySiteTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
    	return mngrManagerMapper.managerListBySiteTotCnt(mngrManagerSearchVO);
    }

    public List<?> managerListBySiteForIndividual(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
    	return mngrManagerMapper.managerListBySiteForIndividual(mngrManagerSearchVO);
    }

    public int managerListBySiteForIndividualTotCnt(MngrManagerSearchVO mngrManagerSearchVO) throws IOException, SQLException {
    	return mngrManagerMapper.managerListBySiteForIndividualTotCnt(mngrManagerSearchVO);
    }

	@Override
	public void selectOrgManager(ModelMap model, ItgMap itgMap)throws IOException, SQLException {
		int page = 1;
		int pageCount = 10000;

		if (itgMap.get("page") != null)
			page = Integer.parseInt(itgMap.get("page").toString());
		itgMap.put("page", page);

		List<ItgMap> mngResultList = mngrManagerMapper.selectOrgManager(itgMap);

		int totalCount = 0;
		if (mngResultList.size() > 0) {
			ItgMap rs = (ItgMap) mngResultList.get(0);
			LOGGER.info(rs.get("totalCount").toString());
			totalCount = Integer.parseInt(rs.get("totalCount").toString());
		}

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(pageCount);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalCount);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("mngResult", mngResultList);
		model.addAttribute("listNoRev", ((page - 1) * paginationInfo.getRecordCountPerPage()));
	}

	@Override
	public void selOrgManager(ModelMap model, ItgMap itgMap) throws IOException, SQLException {
		int page = 1;
		int pageCount = 10000;

		if (itgMap.get("page") != null)
			page = Integer.parseInt(itgMap.get("page").toString());
		itgMap.put("page", page);

		List<ItgMap> mngResultList = mngrManagerMapper.selOrgManager(itgMap);

		int totalCount = 0;
		if (mngResultList.size() > 0) {
			ItgMap rs = (ItgMap) mngResultList.get(0);
			LOGGER.info(rs.get("totalCount").toString());
			totalCount = Integer.parseInt(rs.get("totalCount").toString());
		}

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(pageCount);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalCount);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("mngResult", mngResultList);
		model.addAttribute("listNoRev", ((page - 1) * paginationInfo.getRecordCountPerPage()));
	}

	@Override
	public String selectOrgAllManagerList(ItgMap itgMap) throws IOException, SQLException {
		int page = 1;

		if (itgMap.get("page") != null)
			page = Integer.parseInt(itgMap.get("page").toString());
		itgMap.put("page", page);

		List<ItgMap> mngResultList = mngrManagerMapper.selectOrgAllManagerList(itgMap);

		int totalCount = 0;
		if (mngResultList.size() > 0) {
			ItgMap rs = (ItgMap) mngResultList.get(0);
			LOGGER.info(rs.get("totalCount").toString());
			totalCount = Integer.parseInt(rs.get("totalCount").toString());
		}
		int totPage = (totalCount/10==0)?0:((totalCount/10)+1);

		String json = "{\"total\":\""+totalCount+"\",\"currentPage\":\""+page+"\", \"totalPage\":\""+totPage+"\",\"result\":  [";
		for(int i = 0; i < mngResultList.size(); i++){
			ItgMap manager = mngResultList.get(i);
			json += String.format("{\"mngId\":\"%s\",\"mngName\":\"%s\",\"orName\":\"%s\",\"cName\":\"%s\",\"mngPhone\":\"%s\"}",
								manager.get("mngId"),
								manager.get("mngName"),
								CommUtil.isNull(manager.get("orName"),"없음"),
								CommUtil.isNull(manager.get("cName"),"없음"),
								CommUtil.isNull(manager.get("mngPhone"),"-")
								);
			if(i < mngResultList.size() - 1){
				json += ",";
			}

		}
		json += "]}";
		return json;
	}

	@Override
	public int inputOrgMngGroup(ItgMap itgMap) throws IOException, SQLException {
		String[] chkMngId = request.getParameterValues("chkMngId");
		itgMap.put("updmemid", CommUtil.getMngrMemId());
		itgMap.put("chkMngId", chkMngId);
		int result = 0;

		if(CommUtil.empty(itgMap.get("chkMngId"))) result = 2; // 메뉴권한 정보가 올바르지 않습니다.
		else {
			mngrManagerMapper.inputOrgMngGroup(itgMap);
			result = 1;
		}
		return result;
	}

	@Override
	public int deleteOrgMngGroup(ItgMap itgMap) throws IOException, SQLException{
		String[] chkId = request.getParameterValues("chkId");
		itgMap.put("updmemid", CommUtil.getMngrMemId());
		itgMap.put("chkId", chkId);
		int result = 0;

		if(CommUtil.empty(itgMap.get("chkId"))) result = 2; // 메뉴권한 정보가 올바르지 않습니다.
		else {
			mngrManagerMapper.deleteOrgMngGroup(itgMap);
			result = 1;
		}
		return result;
	}

	@Override
	public int updateOrgMngGroupOrder(ItgMap itgMap) throws IOException, SQLException{

		String managerList = CommUtil.isNull(itgMap.get("managerList"),"");
		int result = 0;
		if("".equals(managerList)){ result = 2;}
		else{
			try {
				JSONArray entryJA = CustomUtil.getJsonArrayFromString(managerList);
				List<ItgMap> entryList = CustomUtil.getListItgMapFromJsonArray(entryJA);

				for(int i=0;i<entryList.size();i++){
					ItgMap entryMap = entryList.get(i);
					entryMap.put("updmemid", CommUtil.getMngrMemId());
					mngrManagerMapper.updateOrgMngGroupOrder(entryMap);
				}

				result = 1;

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				LOGGER.error("엔트리파싱에러");
			}
		}
		return result;
	}

	@Override
	public List<ItgMap> selectErrorManagerList(ItgMap itgMap) throws IOException, SQLException {
		return mngrManagerMapper.selectErrorMangerList(itgMap);
	}

	@Override
	public MngrManagerVO selectManagerForCheck(MngrManagerVO managerVO) throws IOException, SQLException {
		return mngrManagerMapper.selectManagerForCheck(managerVO);
	}

	@Override
	public int updateManagerPassword(MngrManagerVO managerVO) throws IOException, SQLException {
		return mngrManagerMapper.updateManagerPassword(managerVO);
	}

    /**
  	 * 관리자 목록을 조회한다.(마이그레이션용)
  	 * @param mngrManagerSearchVO - 조회할 정보가 담긴 VO
  	 * @return 글 목록
  	 * @exception Exception
  	 */
    public List<ItgMap> mMngrManagerListForMigration(ItgMap paramMap) throws IOException, SQLException {
    	return mngrManagerMapper.mMngrManagerListForMigration(paramMap);
    }

	public void updateManagerPartInfo(MngrManagerVO managerVO) throws SQLException {
		mngrManagerMapper.updateManagerPartInfo(managerVO);
	}

	@Override
	public void selectOrgchtSchMngView(ModelMap model, ItgMap itgMap) throws SQLException {
		int page = 1;
		int pageCount = 10000;

		if (itgMap.get("page") != null)
			page = Integer.parseInt(itgMap.get("page").toString());
		itgMap.put("page", page);

		List<ItgMap> mngResultList = mngrManagerMapper.selectOrgchtSchMngView(itgMap);

		int totalCount = 0;
		if (mngResultList.size() > 0) {
			ItgMap rs = (ItgMap) mngResultList.get(0);
			LOGGER.info(rs.get("totalCount").toString());
			totalCount = Integer.parseInt(rs.get("totalCount").toString());
		}

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(page);
		paginationInfo.setRecordCountPerPage(pageCount);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalCount);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("mngResult", mngResultList);
		model.addAttribute("listNoRev", ((page - 1) * paginationInfo.getRecordCountPerPage()));

	}

}

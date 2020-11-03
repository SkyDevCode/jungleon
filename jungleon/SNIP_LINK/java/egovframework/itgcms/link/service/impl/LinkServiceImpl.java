package egovframework.itgcms.link.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.link.service.LinkService;
import egovframework.itgcms.util.CommUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("linkService")
public class LinkServiceImpl extends EgovAbstractServiceImpl implements LinkService {
	private static final Logger LOGGER = LoggerFactory.getLogger(LinkServiceImpl.class);
	@Resource(name = "linkMapper")
	private LinkMapper linkMapper;

	@Override
	public List<Map<String, Object>> selectLinkList(HashMap<String, Object> param) throws IOException, SQLException {
		return linkMapper.selectLinkList(param);
	}

	@Override
	public List<Map<String, Object>> selectCalendarList(HashMap<String, Object> param)
			throws IOException, SQLException {

		String plusGb = (String) CommUtil.isNull(param.get("plusGb"), "");

		String yyyymm = (String) CommUtil.isNull(param.get("yyyymm"), "");

		if(!"".equals(yyyymm))
		{
			String yyyy = yyyymm.substring(0, 4);
			String mm = yyyymm.substring(4);
			int YYYY = Integer.parseInt(yyyy);

			if(mm.equals("01") && plusGb.equals("-1"))
			{
				int YYY = YYYY - 1;
				String YY = Integer.toString(YYY);
				yyyymm = YY + "11";
				plusGb = "1";

				param.put("yyyymm", yyyymm);
				param.put("plusGb", plusGb);
			}
			else if(mm.equals("12") && plusGb.equals("1"))
			{
				int YYY = YYYY + 1;
				String YY = Integer.toString(YYY);
				yyyymm = YY + "02";
				plusGb = "-1";

				param.put("yyyymm", yyyymm);
				param.put("plusGb", plusGb);
			}
		}

		return linkMapper.selectCalendarList(param);
	}

	@Override
	public List<Map<String, Object>> selectCalendarBdList(HashMap<String, Object> param)
			throws IOException, SQLException {
		return linkMapper.selectCalendarBdList(param);
	}

	@Override
	public ItgMap selectFileVO(HashMap<String, Object> param)
			throws IOException, SQLException {
		return linkMapper.selectFileVO(param);
	}

	@Override
	public void updateBoardUpdateProc(ItgMap gMap)
			throws IOException, SQLException {
		linkMapper.updateBoardUpdateProc(gMap);
	}


}

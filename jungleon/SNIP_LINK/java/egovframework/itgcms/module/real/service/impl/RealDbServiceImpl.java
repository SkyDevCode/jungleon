package egovframework.itgcms.module.real.service.impl;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itgcms.common.ItgMap;
import egovframework.itgcms.core.member.service.MemberVO;
import egovframework.itgcms.core.member.service.impl.MemberMapper;
import egovframework.itgcms.module.migration.service.impl.MigrationMapper;
import egovframework.itgcms.module.real.service.RealDbService;
import egovframework.itgcms.util.CommUtil;
import egovframework.itgcms.util.MD5Crypt;

@Service("realDbService")
public class RealDbServiceImpl implements RealDbService {
	@Resource(name = "realDbMapper")
	private RealDbMapper realDbMapper;
	@Resource(name="migrationMapper")
	private MigrationMapper migrationMapper;
	@Resource(name = "memberMapper")
	private MemberMapper memberMapper;
	@Override
	public ItgMap getEnc(ItgMap params) throws SQLException {
		return realDbMapper.getEnc(params);
	}

	@Override
	public List<ItgMap> getmemList(ItgMap paramMap) throws SQLException {
		List<?> memlist2 = realDbMapper.getmemList(paramMap);
		for(int i=0; i<memlist2.size(); i++) {
			ItgMap mem = (ItgMap) memlist2.get(i);
			ItgMap siteParamMap = new ItgMap();
			String type=mem.get("memTpCd")+"";
			if ("V013000002".equals(type)) type="C";
			else type="N";
			siteParamMap.put("id", mem.get("id"));
			siteParamMap.put("name", mem.get("userNm"));
			siteParamMap.put("pass",mem.get("pwdEnc"));
			siteParamMap.put("passtrycnt", "0");
			siteParamMap.put("email", mem.get("email"));
			siteParamMap.put("type", type);
			siteParamMap.put("logindt", CommUtil.isNull(mem.get("loginDt"),"1000-01-01 00:00:00"));
			siteParamMap.put("regid", mem.get("id"));
			siteParamMap.put("regdt", CommUtil.isNull(mem.get("regDt"),"1000-01-01 00:00:00"));
			siteParamMap.put("upddt", CommUtil.isNull(mem.get("modDt"),"1000-01-01 00:00:00"));
			siteParamMap.put("status","mem_normal");
			siteParamMap.put("smsyn", mem.get("smsYn"));
			siteParamMap.put("emailyn", mem.get("letterYn"));
			siteParamMap.put("regsitecode", "SNIP");
			siteParamMap.put("unionmem", "1");
			siteParamMap.put("delyn", "N");
			siteParamMap.put("etc1", mem.get("pwd"));
			siteParamMap.put("pwdQuest", mem.get("pwdQuest"));
			siteParamMap.put("pwdAnswer", mem.get("pwdAnswer"));
			siteParamMap.put("knowpath", mem.get("knowPath"));
			siteParamMap.put("areaCd", mem.get("areaCd"));
			ItgMap concern=realDbMapper.getConcernList(siteParamMap);
			if (concern!=null) {
				siteParamMap.put("concerns", CommUtil.isNull(concern.get("bizTp"),""));
			}
			migrationMapper.putMember(siteParamMap);
		}
		return realDbMapper.getmemList(paramMap);
	}
	@Override
	public void migrationBoard(ItgMap paramMap) throws SQLException {
		paramMap.put("bbsCd", "40");
		List<?> boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "emptyRoom");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
	}
	@Override
	public void migrationBoard2(ItgMap paramMap) throws SQLException {
		// 일반형게시판보도자료
		List<?> boardlist = realDbMapper.getBoardList(paramMap);
		/*paramMap.put("bbsCd", "3");
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "newsData");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}*/
		//카테고리 분류 공지,입찰,채용
		paramMap.put("bbsCd", "1");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			String bcId="";
			if ("1003".equals(board.get("ctgCd")+"")) {
				bcId="notice";
			}else if ("1001".equals(board.get("ctgCd")+"")) {
				bcId="opBidding";
			}else if ("1002".equals(board.get("ctgCd")+"")) {
				bcId="employment";
			}
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", bcId);
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
						path = path.substring(0, path.length()-1);
					}
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
		//유관기관소식
		paramMap.put("bbsCd", "2");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "reInNews");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
		// 경영공시
		/*paramMap.put("bbsCd", "31");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			String bdcode=board.get("ctgCd")+"";
			switch (bdcode)
			{
				case "1001":	bdcode = "_maPuNotiTab01"; 	break;
				case "1002":	bdcode = "_maPuNotiTab02"; 	break;
				case "1003":	bdcode = "_maPuNotiTab03"; 	break;
				case "1004":	bdcode = "_maPuNotiTab04"; 	break;
				case "1005":	bdcode = "_maPuNotiTab05"; 	break;
				case "1006":	bdcode = "_maPuNotiTab06"; 	break;
			}
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", bdcode);
			siteParamMap.put("bcId", "maPuNotiTab");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
						path = path.substring(0, path.length()-1);
					}
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}*/
		//계약정보
		paramMap.put("bbsCd", "4");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "coInfoTab");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
		// 계약서식
		/*paramMap.put("bbsCd", "59");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "coFormTab");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
		// 부패행위자
		paramMap.put("bbsCd", "53");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "corPuStatus");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
		// 경제정책연구
		paramMap.put("bbsCd", "58");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "inteData");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}
		paramMap.put("bbsCd", "56");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "default");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			migrationMapper.putBoard(siteParamMap);
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					fileparamMap.put("fileId", file.get("fileSeq"));
					fileparamMap.put("fileSeq", file.get("orderNo"));
					fileparamMap.put("fileName", file.get("orgFileNm"));
					fileparamMap.put("fileSize", fileSize);
					fileparamMap.put("fileFolder", path);
					fileparamMap.put("fileMask", file.get("fileNm"));
					fileparamMap.put("downloadCount", file.get("downCnt"));
					fileparamMap.put("regDate", file.get("regDt"));
					fileparamMap.put("deleteYn", "N");

					migrationMapper.putFileInfo(fileparamMap);

				}
			}
		}*/
	}

	@Override
	public void migrationImgBoard(ItgMap paramMap) throws SQLException {
		// 갤러리형 진흥원발자취
		paramMap.put("bbsCd", "10");
		List<?> boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "snipMarks");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdHowMovie", "0");
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
				        path = path.substring(0, path.length()-1);
				    }
					if ("master".equals(file.get("inputNm"))) {
						siteParamMap.put("bdThumb1", path+"/"+file.get("fileNm"));
						siteParamMap.put("bdThumb1Alt", file.get("orgFileNm"));
					}else{
						fileparamMap.put("fileId", file.get("fileSeq"));
						fileparamMap.put("fileSeq", file.get("orderNo"));
						fileparamMap.put("fileName", file.get("orgFileNm"));
						fileparamMap.put("fileSize", fileSize);
						fileparamMap.put("fileFolder", path);
						fileparamMap.put("fileMask", file.get("fileNm"));
						fileparamMap.put("downloadCount", file.get("downCnt"));
						fileparamMap.put("regDate", file.get("regDt"));
						fileparamMap.put("deleteYn", "N");

						migrationMapper.putFileInfo(fileparamMap);

					}
				}
			}
			migrationMapper.putBoard(siteParamMap);
		}
		// 링크형 - 성남기업탐방
		paramMap.put("bbsCd", "9");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "epSearch");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));
			siteParamMap.put("bdLnUrl", board.get("newsLink"));
			siteParamMap.put("bdHowMovie", "0");
			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
						path = path.substring(0, path.length()-1);
					}
					if ("master".equals(file.get("inputNm"))) {
						siteParamMap.put("bdThumb1", path+"/"+file.get("fileNm"));
						siteParamMap.put("bdThumb1Alt", file.get("orgFileNm"));
					}else{
						fileparamMap.put("fileId", file.get("fileSeq"));
						fileparamMap.put("fileSeq", file.get("orderNo"));
						fileparamMap.put("fileName", file.get("orgFileNm"));
						fileparamMap.put("fileSize", fileSize);
						fileparamMap.put("fileFolder", path);
						fileparamMap.put("fileMask", file.get("fileNm"));
						fileparamMap.put("downloadCount", file.get("downCnt"));
						fileparamMap.put("regDate", file.get("regDt"));
						fileparamMap.put("deleteYn", "N");

						migrationMapper.putFileInfo(fileparamMap);

					}
				}
			}
			migrationMapper.putBoard(siteParamMap);
		}
		//snip동영상
		paramMap.put("bbsCd", "54");
		boardlist=new ArrayList<>();
		boardlist = realDbMapper.getBoardList(paramMap);
		for(int i=0; i<boardlist.size(); i++) {

			ItgMap board = (ItgMap) boardlist.get(i);
			ItgMap siteParamMap = new ItgMap();
			siteParamMap.put("bdCode", "");
			siteParamMap.put("bcId", "movie");
			siteParamMap.put("bdWriter", board.get("writerNm"));
			siteParamMap.put("charger", board.get("writerNm"));
			siteParamMap.put("bdTitle", board.get("title"));
			siteParamMap.put("bdContent", board.get("question"));
			siteParamMap.put("bdReadnum", board.get("readCnt"));
			siteParamMap.put("bdNotice", "0");
			siteParamMap.put("bdNoticeTermyn", "N");
			siteParamMap.put("fileId", board.get("fileSeq"));
			siteParamMap.put("bdIp", "1.241.77.135");
			siteParamMap.put("regdt", board.get("regDt"));
			siteParamMap.put("upddt", board.get("modiDt"));
			siteParamMap.put("regmemid", board.get("mgrId"));
			siteParamMap.put("updmemid", board.get("mgrId"));
			siteParamMap.put("delyn", "N");
			siteParamMap.put("fileSeq", board.get("fileSeq"));

			List<?> filelist = realDbMapper.getFileInfoList(siteParamMap);
			ItgMap fileparamMap = new ItgMap();
			if (filelist.size()>0) {
				for (int j = 0; j < filelist.size(); j++) {
					ItgMap file = (ItgMap) filelist.get(j);
					String str = file.get("filesize")+"";
					String restr = str.replaceAll("[^0-9]","");
					String restr2 = str.replace("[0-9]", "");
					int fileSize = 0;
					if (restr2.contains("kb")||restr2.contains("KB")) {
						fileSize=Integer.parseInt(restr)*1024;
					}else if(restr2.contains("mb")||restr2.contains("MB")) {
						fileSize=Integer.parseInt(restr)*1048576;
					}else if(restr2.contains("bytes")) {
						fileSize=Integer.parseInt(restr);
					}
					String str2 = file.get("filePath")+"";
					String[] strarr=str2.split("\\\\");
					String path="";
					for (int k = 1; k < strarr.length-1; k++) {
						path+=strarr[k]+"/";
					}
					if (path.charAt(path.length()-1)=='/'){
						path = path.substring(0, path.length()-1);
					}
					if ("master".equals(file.get("inputNm"))) {
						siteParamMap.put("bdThumb1", path+"/"+file.get("fileNm"));
						siteParamMap.put("bdThumb1Alt", file.get("orgFileNm"));
					}else{
						siteParamMap.put("bdMovie", path+"/"+file.get("fileNm"));
						siteParamMap.put("bdHowMovie", "1");
					}
				}
			}
			migrationMapper.putBoard(siteParamMap);
		}
	}

	@Override
	public void updatePassAsis2Tobe(MemberVO memberVO) throws SQLException, NoSuchAlgorithmException, IOException {
		String url = memberVO.getSchOpt5();
	    if(url.contains("snip.or.kr")){ //개발서버
	    	ItgMap paramMap = new ItgMap();
	    	paramMap.put("pwd", MD5Crypt.crypt(memberVO.getPass()));
	    	paramMap.put("id", memberVO.getId());
	    	ItgMap memInfoMap = realDbMapper.getmemInfo(paramMap);
	    	if (realDbMapper.getEnc(paramMap).get("enc").equals(memInfoMap.get("etc1"))) {
	    		MemberVO newPassMemberVO = new MemberVO();
	    		newPassMemberVO.setPass(CommUtil.hexSha256(memberVO.getPass()));
	    		newPassMemberVO.setUpdId(memberVO.getId());
	    		newPassMemberVO.setUpdIp(CommUtil.getUserIP());
	    		newPassMemberVO.setId(memberVO.getId());
	    		memberMapper.updateMemberInitPass(newPassMemberVO);
	    	}
	    }
	}

	@Override
	public ItgMap memberPossible(ItgMap params) {
		return realDbMapper.memberPossible(params);
	}

	@Override
	public int downloadIncrease(ItgMap params) {
		return realDbMapper.downloadIncrease(params);
	}




}

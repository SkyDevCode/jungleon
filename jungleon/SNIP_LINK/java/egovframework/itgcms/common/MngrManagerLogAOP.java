package egovframework.itgcms.common;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import egovframework.itgcms.core.managerlog.service.MngrManagerLogService;
import egovframework.itgcms.core.managerlog.service.MngrManagerLogVO;
import egovframework.itgcms.core.menu.service.MngrMemIpManageVO;
import egovframework.itgcms.util.CommUtil;

/*@Component
@Aspect*/
public class MngrManagerLogAOP {
	@Autowired
	HttpServletRequest request;

	/** mngrManagerLogService */
	@Resource(name = "mngrManagerLogService")
	private MngrManagerLogService mngrManagerLogService;

	private static final Logger logger = LogManager.getLogger(MngrManagerLogAOP.class);

	public void mngrAopSelect(JoinPoint thisJoinPoint) throws IOException, SQLException{
		if("".equals(CommUtil.getMngrMemId())) return; //관리자 아이디가 없으면 로그저장 안함
		try {
			MngrManagerLogVO mngrManagerLogVO = getManagerLog(thisJoinPoint, "R");
			if(CommUtil.isNull(mngrManagerLogVO.getMlogUrl(), "null").indexOf("_mngr_") != -1){
				mngrManagerLogService.mngrManagerLogInsert(mngrManagerLogVO);
			}
		} catch (IOException e) {
			logger.error("예외 상황 발생");;
		}
	}
	public void mngrAopInsert(JoinPoint thisJoinPoint) throws IOException, SQLException{
		if("".equals(CommUtil.getMngrMemId())) return; //관리자 아이디가 없으면 로그저장 안함
		try {
			MngrManagerLogVO mngrManagerLogVO = getManagerLog(thisJoinPoint, "C");
			if(CommUtil.isNull(mngrManagerLogVO.getMlogUrl(), "null").indexOf("_mngr_") != -1){
				mngrManagerLogService.mngrManagerLogInsert(mngrManagerLogVO);
			}
		} catch (IOException e) {
			logger.error("예외 상황 발생");;
		}
	}
	public void mngrAopUpdate(JoinPoint thisJoinPoint) throws IOException, SQLException{
		if("".equals(CommUtil.getMngrMemId())) return; //관리자 아이디가 없으면 로그저장 안함
		try {
			MngrManagerLogVO mngrManagerLogVO = getManagerLog(thisJoinPoint, "U");
			if(CommUtil.isNull(mngrManagerLogVO.getMlogUrl(), "null").indexOf("_mngr_") != -1){
				mngrManagerLogService.mngrManagerLogInsert(mngrManagerLogVO);
			}
		} catch (IOException e) {
			logger.error("예외 상황 발생");;
		}
	}
	public void mngrAopDelete(JoinPoint thisJoinPoint) throws IOException, SQLException{
		if("".equals(CommUtil.getMngrMemId())) return; //관리자 아이디가 없으면 로그저장 안함
		try {
			MngrManagerLogVO mngrManagerLogVO = getManagerLog(thisJoinPoint, "D");
			if(CommUtil.isNull(mngrManagerLogVO.getMlogUrl(), "null").indexOf("_mngr_") != -1){
				String uri = request.getRequestURI().toString();
				mngrManagerLogService.mngrManagerLogInsert(mngrManagerLogVO);
			}
		} catch (IOException e) {
			logger.error("예외 상황 발생");;
		}
	}

	private MngrManagerLogVO getManagerLog(JoinPoint thisJoinPoint, String logType) throws IOException, SQLException{
		MngrManagerLogVO mngrManagerLogVO = new MngrManagerLogVO();
		mngrManagerLogVO.setMlogClass(	thisJoinPoint.getTarget().getClass().getName()	);
		mngrManagerLogVO.setMlogMethod(	thisJoinPoint.getSignature().getName()	);
		mngrManagerLogVO.setMlogType(logType);
		mngrManagerLogVO.setMngId(CommUtil.getMngrMemId());
		mngrManagerLogVO.setMngName(CommUtil.getMngrSessionVO().getName());
		mngrManagerLogVO.setMlogIp(CommUtil.getClientIP(request));
		mngrManagerLogVO.setMlogReferer(request.getHeader("REFERER"));

		String url = request.getRequestURL().toString();
		if(url != null && request.getQueryString() != null){
			url += "?" + request.getQueryString();
		}
		mngrManagerLogVO.setMlogUrl(url);

		return mngrManagerLogVO;
	}

	/*
	 * 관리자 로그 기록이 필요한 컨트롤러 체크
	 * itgcms 패키지의 모든 web 컨트롤러
	 * 해당 AOP의 결과값을 제대로 리턴 받기 위해서는 해당 JoinPoint에 HttpServletResponse를 파라미터에 포함시켜야함.
	*/
/*	@Around("execution(* egovframework.itgcms.mngr.*.web.*Controller.*(..))")
	private Object aroundMngrWebPackage(ProceedingJoinPoint joinPoint) throws Throwable{

		String regex = "(";
		//+union|select|from|where
		regex += "MngrSystemconfigController";
		regex += ")";

		Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(joinPoint.getTarget().getClass().getName());

		if(matcher.find()){
		    //System.out.println("################################################ aroundMngrWebPackage ########################");
		    if(joinPoint.getSignature().getName().contains("View")) mngrAopSelect(joinPoint);
		    if(joinPoint.getSignature().getName().contains("Edit")) mngrAopUpdate(joinPoint);
		    if(joinPoint.getSignature().getName().contains("Insert")) mngrAopInsert(joinPoint);
		    if(joinPoint.getSignature().getName().contains("Delete")) mngrAopDelete(joinPoint);
		}

		return joinPoint.proceed();
	}*/

/*
	public void sendError(ProceedingJoinPoint joinPoint) throws IOException {

		HttpServletResponse response = null;
		// joinPoint(컨트롤러 메소드)의 파라미터 중 response 객체를 추출함
		for (Object obj : joinPoint.getArgs()) {
			if (obj instanceof HttpServletResponse) {
				response = (HttpServletResponse)obj;
			}
		}
		// 추출한 response에 404에러를 보냄
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}*/
}

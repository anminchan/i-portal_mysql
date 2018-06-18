package kr.plani.ccis.base.controller;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;
/*****************************************************************
* 기본 공통 컨트롤
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2014. 8. 12. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 01.		mcahn		최초 생성
* </pre>
*******************************************************************/

public class BaseCommonController implements MessageSourceAware{
	Logger logger = LoggerFactory.getLogger(BaseCommonController.class);
	
	/** 메세지 설정  */
	public MessageSource messageSource;
	
	@Override
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
	
	/*****************************************************************
	* setCommon 기본값 세팅용
	* @param baseService
	* @param request
	* @param model
	* @param obj
	* @return 
	* @throws Exception
	*******************************************************************/
	public void setCommon(BaseService baseService, HttpServletRequest request, Model model, Object obj, SiteSet siteSet) throws Exception {
		DefaultDomain objRtn = null;
		
		logger.info("siteSet.mainGubun>>>"+siteSet.mainGubun);
		model.addAttribute("mainGubun", siteSet.mainGubun);
		if(!siteSet.mainGubun.equals("main")){
			// 기본 
			objRtn = (DefaultDomain)baseService.readLocation(obj);
			if(objRtn.getOutResult().equals("FAILURE")){
				return;
			}
		}else{
			objRtn = (DefaultDomain)obj;
			siteSet.mainGubun = "";	//메인 구분 초기화
		}

		//세션값 가져오기
		SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
		
		String strUserId = "";
		if(scUser == null){
			strUserId = "guest";
		}else{
			strUserId = scUser.getUserId();
		}
		objRtn.setMyId(strUserId);

		//사이트 정보 조회
		HashMap siteInfo = (HashMap)baseService.selectSiteInfo(objRtn);
		logger.info(">>>>>>>>>>" + siteInfo);
		
		//사이트 정보가 없을경우 에러 처리
		if(siteInfo == null){
			siteSet.siteType = "";
			return;
		}
		model.addAttribute("siteInfo", siteInfo);
		
		siteSet.siteLang = (String)siteInfo.get("SITELANGUAGE");
		
		//메뉴 정보 조회
		HashMap menuInfo = (HashMap)baseService.selectMenuInfo(objRtn);
		model.addAttribute("menuInfo", menuInfo);
		
		String strSiteType = (String)siteInfo.get("SITETYPE");
		siteSet.siteType = strSiteType;
		siteSet.siteKye = (String)siteInfo.get("SITEKEY");
		
		if(strSiteType.equals("M")){
			siteSet.siteLayer = "mobile";
		}else{
			//siteSet.siteLayer = "common";
			siteSet.siteLayer = (String)siteInfo.get("SITEKEY");
		}
		
		// 사용자 메뉴조회
		DefaultDomain objParam = (DefaultDomain)obj;
		objParam.setMySiteId(objRtn.getMySiteId());
		objParam.setMyId(strUserId);
		
		DefaultDomain objMenu = (DefaultDomain)baseService.listUserMenu(objParam);

		model.addAttribute("rtnLoction", objRtn.getNavigation());
		model.addAttribute("rtnMenuName", objRtn.getMenuName());
		model.addAttribute("rtnUserMenu", objMenu.getOutUserMenuCursor()); // 사용자 메뉴 return
		
	}
		
	/*****************************************************************
	* resultLog 패키지 호출 실행결과 로깅
	* @param obj
	* @return 
	* @throws Exception
	*******************************************************************/
	public void resultLog(DefaultDomain obj) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("ObjectName : " + obj.getOutObjectName());
			logger.debug("Result     : " + obj.getOutResult());
			logger.debug("RowCount   : " + obj.getOutRowCount());
			logger.debug("Notice     : " + obj.getOutNotice());
			logger.debug("Cursor     : " + obj.getOutCursor());	
		}
	}
	
	/*****************************************************************
	 * printWriterLog
	 * @param obj
	 * @return 
	 * @throws Exception
	 *******************************************************************/
	public void printWriterLog(String msg, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head><title>설정정보  error page</title></head>");
        out.println("<script type='text/javascript'>");
        out.println("alert('"+messageSource.getMessage(msg, null, LocaleContextHolder.getLocale())+"');"); 
        out.println("history.back(-1);");
        out.println("</script>");
        out.println("</html>");
	}
	
	/*****************************************************************
	* Message 메세지 처리 공통
	* @param DefaultDomain
	* @throws Exception
	*******************************************************************/
	public void setMessage(HttpServletRequest request, DefaultDomain obj) throws Exception {
		String strMsg = obj.getOutNotice();
		String[] strNotice = null;
		if(strMsg.lastIndexOf("]") > 0) {
			strNotice = StringUtil.getStringSplit(strMsg, "]");
			strMsg = strNotice[1];
        }
		
		FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
	    fm.put("msgFlag", "Y");
	    fm.put("result", obj.getOutResult());
	    fm.put("message", strMsg); 
	}
	
}

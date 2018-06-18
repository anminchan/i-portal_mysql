package kr.plani.ccis.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminLoginCheckInterceptor extends HandlerInterceptorAdapter {


	private static final Logger logger = LoggerFactory.getLogger(AdminLoginCheckInterceptor.class);

	/**
	 * 클라이언트의 요청을 컨트롤러에게 전달하기 전에 호출 리턴값 : true/false false인 경우 다음
	 * handlerinterceptor 혹은 컨트롤러를 실행시키지 않고 요청 처리를 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object controller) throws Exception {

		//logger.info("LoginCheckInterceptor > preHandle > start");
		// 로그인 검사 예외
		if ("/i-portal".equals(request.getServletPath()) ||
		    "/i-portal/loginForm".equals(request.getServletPath()) ||
		    "/mgr".equals(request.getServletPath()) ||
		    "/mgr/loginForm".equals(request.getServletPath()) ||
		    "/mgr/login".equals(request.getServletPath()) || 
		    "/mgr/logout".equals(request.getServletPath()) || 
		    "/mgr/listCode".equals(request.getServletPath()) || 
		    "/mgr/listCate".equals(request.getServletPath()) ||
		    "/mgr/listSearch".equals(request.getServletPath()) ||
		    "/mgr/contentMgr/replyList".equals(request.getServletPath()) ||
		    "/mgr/contentMgr/replyAct".equals(request.getServletPath())
		    )
			return true;

		Object siteLogin = request.getSession().getAttribute("ADMUSER");

		if (siteLogin == null) {
			logger.info("로그인 필요");
			throw new ModelAndViewDefiningException(new ModelAndView("redirect:/i-portal/loginForm"));
		} else {

		}
		//logger.info("LoginCheckInterceptor > preHandle > finish");

		return true;
	}

	/**
	 * 컨트롤러가 요청을 실행한 후 처리, view(jsp)로 forward되기 전에 리턴값 : void 컨트롤러 실행도중 예외 발생인
	 * 경우 postHandle()는 실행되지 않음
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object controller, ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 클라이언트의 요청을 처리한 뒤에 실행 리턴값 : void 컨트롤러 처리 도중이나 view 생성과정 중에 예외가 발생하더라도
	 * afterCompletion()은 실행됨
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object controller, Exception e) throws Exception {

	}
}

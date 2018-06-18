package kr.plani.ccis.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.ips.domain.common.User;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {


	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);

	/**
	 * 클라이언트의 요청을 컨트롤러에게 전달하기 전에 호출 리턴값 : true/false false인 경우 다음
	 * handlerinterceptor 혹은 컨트롤러를 실행시키지 않고 요청 처리를 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object controller) throws Exception {

		logger.info("LoginCheckInterceptor > preHandle > start");
		logger.info("request.getServletPath() >> " + request.getServletPath());
		// 로그인 검사 예외
		if ("/loginForm".equals(request.getServletPath()) || 
		    "/login".equals(request.getServletPath()) 
		    )
			return true;

		// 기존 세션 정보 있을 시 제거
		HttpSession session = request.getSession(false);
		
		if(session != null){
			session.invalidate(); 
		}
		
		session = request.getSession(true);
		Object loginInfo = session.getAttribute("USER");
		
		//게스트 계정 생성
		if (loginInfo == null) {
			
			User scUser = new User();
			scUser.setUserId("guest");
			scUser.setkName("게스트");
			
			// 세션 생성
			SCookie sc = new SCookie(request, response, 
									scUser.getUserId(), scUser.getkName(), 
									scUser.getKind(), scUser.getKindName(),
									scUser.getCorpRegNo()
									);
			sc.setCookies();
			
			session.setAttribute("USER", sc);
		} else {
		}
		logger.info("LoginCheckInterceptor > preHandle > finish");

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

package kr.plani.ccis.common.advice;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandlerController implements MessageSourceAware {

	private MessageSource messageSource;
	
	@Override
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView defaultErrorHandler(HttpServletRequest request, Exception exception) {
		ModelAndView mav = new ModelAndView("exception.runtime");
		mav.addObject("url", request.getRequestURL().toString());
		mav.addObject("exception", exception);
		return mav;
	}
	
	/**
	 * 404 Not Found Error Handler
	 * 
	 * @param request
	 * @param exception
	 * @return
	 */
	@ExceptionHandler(NoHandlerFoundException.class)
	public ModelAndView noHandlerFoundException(HttpServletRequest request, Exception exception) {
		Locale locale = LocaleContextHolder.getLocale();
		String errorMessage = messageSource.getMessage("error.bad.url",  null, locale);
		ModelAndView mav = new ModelAndView("error.notfound");
		mav.addObject("url", request.getRequestURL().toString());
		mav.addObject("errorMessage", errorMessage);
		return mav;
	}
}

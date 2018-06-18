package kr.plani.ccis.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Component("identification")
public class Identification {

	private static final Logger logger = LoggerFactory.getLogger(Identification.class);
	
	// 1. 실명인증 휴대폰 인증 
	public void setSciSecuPccCheckEncDataHp(HttpServletRequest request, HttpServletResponse response, Model model, String gubun, String serviceNo){
	        
	}
	
	// 2. 개인회원 휴대폰 인증 결과 처리
	@RequestMapping(value="/*/sciSecuPccCheckHp")
	public ModelAndView sciSecuPccCheckHp(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		

		/*ModelAndView mav = new ModelAndView();
		mav.setViewName("");
		return mav;*/
		return null;
	}

	// 3. 실명인증 아이핀 인증 
	public void setSciSecuPccCheckEncDataIpin(HttpServletRequest request, HttpServletResponse response, Model model, String gubun, String serviceNo){
	        
	}
	
	// 4. 개인회원 아이핀 인증 결과 처리
	@RequestMapping(value="/*/sciSecuPccCheckIpin")
	public ModelAndView sciSecuPccCheckIpin(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		/*ModelAndView mav = new ModelAndView();
		mav.setViewName("");
		return mav;*/
		return null;
	}	
	
}

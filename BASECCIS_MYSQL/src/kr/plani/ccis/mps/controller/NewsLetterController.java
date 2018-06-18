package kr.plani.ccis.mps.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.plani.ccis.ips.domain.site.NewsLetter;
import kr.plani.ccis.ips.service.site.NewsLetterMgrService;

@Controller
@RequestMapping(value="/newsLetter")
public class NewsLetterController extends BaseController
{
	@Resource
	NewsLetterMgrService newsLetterMgrService;
	
	/*****************************************************
	 * preView - 뉴스레터 미리보기
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/preView")
	public ModelAndView preView(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		model.addAttribute("newsLetter", newsLetterMgrService.getNewsLetter(newsLetter));
		model.addAttribute("portletLineList", newsLetterMgrService.getNewsLetterPortletLineList(newsLetter));
		model.addAttribute("portletList", newsLetterMgrService.getNewsLetterPortletList(newsLetter));

		newsLetter.setJsp("ips/site/newsLetterMgr/preView");
		newsLetter.setViewTitle("");

		return new ModelAndView("emptyNL.layout", "obj", newsLetter);
	}
	
	
	@RequestMapping(method=RequestMethod.GET, value="/preViewHTML")
	public ModelAndView preViewHTML(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		model.addAttribute("newsLetter", newsLetterMgrService.getNewsLetter(newsLetter));

		newsLetter.setJsp("ips/site/newsLetterMgr/preViewHTML");
		newsLetter.setViewTitle("");

		return new ModelAndView("emptyNL.layout", "obj", newsLetter);
	}
}

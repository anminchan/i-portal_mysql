package kr.plani.ccis.base.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.ips.domain.site.PersonalInfo;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.PersonalInfoMgrService;

@Controller
@RequestMapping("/personalInfo")
public class PersonalInfoController extends BaseCommonController {
	
	/** 개인정보처리방침관리 서비스   */
	@Resource
	private PersonalInfoMgrService personalInfoMgrService;

	@Resource
	CommonService commonService;
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView form(@ModelAttribute PersonalInfo personalInfo, HttpServletRequest request, HttpSession session, Model model ) throws Exception{
		
		personalInfo.setInParam(request);
		SiteSet siteSet = new SiteSet();
		this.setCommon(commonService, request, model, personalInfo, siteSet);

		String maxId = personalInfoMgrService.getMaxId();
		
		if(personalInfo.getPersonalInfoId() == null){
			personalInfo.setPersonalInfoId(maxId);
		}
		Object object = personalInfoMgrService.getObject(personalInfo);
		List<PersonalInfo> list = (List<PersonalInfo>)personalInfoMgrService.getObjectList2(personalInfo);
		model.addAttribute("result", object);
		model.addAttribute("resultList", list);
		personalInfo.setJsp("/base/personalInfo/view");
		if(siteSet.getSiteKye().equals("mps")){
			return new ModelAndView("mps.content" ,"obj", personalInfo);
		}else{
			return new ModelAndView("common.content", "obj", personalInfo);
		}
	}
	
}

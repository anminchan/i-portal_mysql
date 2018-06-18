package kr.plani.ccis.ips.controller.system;

import java.net.URLEncoder;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.base.domain.MemberInfo;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.system.CompanyUser;
import kr.plani.ccis.ips.domain.system.Member;
import kr.plani.ccis.ips.domain.system.PersonUser;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.system.MemberMgrService;

/*****************************************************************
 * 회원정보를 처리하는 비즈니스 구현 클래스
 * <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
 * fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
 * @author 플랜아이 mcahn
 * @since  2014. 8. 22. 
 * @version 1.0
 * <pre>
 * 수정내용 : 
 *  수정일				수정자         	수정내용
 * ------------------------------------------------------
 * 2014. 8. 22.		mcahn		최초 생성
 * </pre>
 *******************************************************************/

@Controller
@RequestMapping("/mgr/memberMgr")
public class MemberMgrController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberMgrController.class);
	
	@Resource
	CommonService commonService;
	
	@Resource
	MemberMgrService memberMgrService;
	
	@Resource
	private BaseService baseService;
	
	/*****************************************************
	 * list 회원목록 조회
	 * @param member
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Member member, HttpServletRequest request, Model model) throws Exception{
		
		member.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, member);
		
		if(member.getSchStartDate() != null && member.getSchEndDate() != null){			
			//member.setInSchStartDate(member.getSchStartDate().replaceAll("-", ""));
			//member.setInSchEndDate(member.getSchEndDate().replaceAll("-", ""));
			
		}else{
			Calendar cal = new GregorianCalendar();
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String sDay = formatter.format(new java.util.Date()).substring(0,10); //현재날짜
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date d = df.parse(sDay, new ParsePosition(0));
			cal.setTime(d);
			cal.add(Calendar.MONTH, -24);
			String boforeMonth = df.format(cal.getTime()); //24개월전 날짜
			
			/*member.setSchStartDate(boforeMonth);
			member.setSchEndDate(sDay);*/
			
			//검색 시작일
			//member.setInSchStartDate(member.getSchStartDate().replaceAll("-", ""));
			
			//검색 종료일
			//member.setInSchEndDate(member.getSchEndDate().replaceAll("-", ""));
			
			member.setKind("K");
		}
		
		member.setInSchType(member.getSchType());
		member.setInSchText(member.getSchText());
		
		//Member objRtn = (Member)memberMgrService.getObjectList(member);
		
		List<?> objRtn = null;
		int rtnCount = 0;
		objRtn = (List<?>) memberMgrService.getObjectList(member);
		rtnCount = memberMgrService.getObjectListCnt(member);
		
		model.addAttribute("rtnMemberList", objRtn);
		
		//페이징 정보
		model.addAttribute("rowCnt", member.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", rtnCount);				    //전체 카운트
		
		//회원별 건수
		//model.addAttribute("multiCount", objRtn.getMultiCount().split("#"));
		
		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(member.getMenuId())+
				"&kind="+StringUtil.nullCheck(member.getKind())+
				"&siteId="+StringUtil.nullCheck(member.getSiteId())+
				"&schStartDate="+StringUtil.nullCheck(member.getSchStartDate())+
				"&schEndDate="+StringUtil.nullCheck(member.getSchEndDate()) +
				"&schType="+StringUtil.nullCheck(member.getSchType())+
				"&schText="+StringUtil.nullCheck(member.getSchText());
		
		model.addAttribute("link", strLink);
		
		if(member.getKind() != null){
			member.setJsp("system/memberMgr/list"+member.getKind());
		}else {
			member.setJsp("system/memberMgr/listK");
		}
		return new ModelAndView("ips.layout", "obj", member);
	}
	
	/******************************************************
	 * form 회원정보 입력/수정 폼
	 * @param member
	 * @param model
	 * @param obj
	 * @return
	 * @throws Exception
	 ******************************************************/
	@RequestMapping(value="/form")
	public ModelAndView view(@ModelAttribute Member member, HttpServletRequest request, Model model) throws Exception{
		
		member.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, member);
				
		if("K".equals(member.getKind())){
			//내부직원 부서정보쿼리 실행
			Member rtnTeamList = (Member)memberMgrService.getMemberTeamList(member);
			
			try{
				model.addAttribute("rtnMemberTeamList", rtnTeamList.getOutCursor());
			}catch(Exception e){
				//logger.info("Exception/////////////////"+e);
	        	System.out.println("처리 중 오류가 발생했습니다.");
			}
		}
		
		//쿼리 실행
		//Member rtnObj = (Member)memberMgrService.getObject(member);
		HashMap<?,?> rtnMember = (HashMap<?,?>)memberMgrService.getObject(member);
		List <HashMap<?,?>> rtnGroupList = (List <HashMap<?,?>>)memberMgrService.getUserGroupList(member);
		
		//회원정보
		model.addAttribute("rtnMember", rtnMember);
		
		//그룹정보
		model.addAttribute("rtnGroupList", rtnGroupList);
		
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(member.getMenuId())+
				"&kind="+StringUtil.nullCheck(member.getKind())+
				"&siteId="+StringUtil.nullCheck(member.getSiteId())+
				"&schStartDate="+StringUtil.nullCheck(member.getSchStartDate())+
				"&schEndDate="+StringUtil.nullCheck(member.getSchEndDate()) +
				"&schType="+StringUtil.nullCheck(member.getSchType())+
				"&schText="+StringUtil.nullCheck(member.getSchText());
		
		model.addAttribute("link", strLink);
		
		if(member.getKind() != null){
			member.setJsp("system/memberMgr/form"+member.getKind());
		}else {
			member.setJsp("system/memberMgr/formP");
		}
		return new ModelAndView("ips.layout", "obj", member);
	}
	
	/******************************************************
	 * form 회원정보 입력 폼
	 * @param member
	 * @param model
	 * @param obj
	 * @return
	 * @throws Exception
	 ******************************************************/
	@RequestMapping(value="/regForm")
	public ModelAndView regForm(@ModelAttribute Member member, HttpServletRequest request, Model model) throws Exception{
		
		member.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, member);
		
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(member.getMenuId())+
				"&kind="+StringUtil.nullCheck(member.getKind())+
				"&siteId="+StringUtil.nullCheck(member.getSiteId())+
				"&schStartDate="+StringUtil.nullCheck(member.getSchStartDate())+
				"&schEndDate="+StringUtil.nullCheck(member.getSchEndDate()) +
				"&schType="+StringUtil.nullCheck(member.getSchType())+
				"&schText="+StringUtil.nullCheck(member.getSchText());
		
		model.addAttribute("link", strLink);
		
		member.setJsp("system/memberMgr/form");
		return new ModelAndView("ips.layout", "obj", member);
	}
	
	/**************************************************
	 * companyAction 개인/기업회원 입력
	 * @param companyUser
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 **************************************************/
	@RequestMapping(method=RequestMethod.POST, value="/userAction")
	public ModelAndView userAction(@ModelAttribute Member member, @ModelAttribute PersonUser personUser, @ModelAttribute CompanyUser companyUser, HttpServletRequest request, Model model) throws Exception {
		
		String password = null;
		
		//기본 데이터 설정
		if(member.getKind().equals("P")){			
			personUser.setInWorkName("개인회원관리자관리");
			personUser.setInCondition("입력");
			personUser.setInParam(request);
			password = personUser.getPassword();
			
			if( password.length() > 0){ //비밀번호가 입력되었을때 암호화해준다.
				//비밀번호 암호화
				ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
				//encoder.setEncodeHashAsBase64(true);
				personUser.setPassword(encoder.encodePassword(password, null));
			}else{ //비밀번호가 입력되지 않았을때에는 예전 비밀번호(암호화되있는)를 넣어준다.
				personUser.setPassword(personUser.getPrePassword());
			}
			
			//개인회원 이후데이터
			personUser.setInAfterData(personUser.makeDataString());
			
			//개인회원 전송데이터
			personUser.setInDMLData(personUser.makeDMLDataString());
			
			//개인회원 정보 수정
			memberMgrService.updatePersonUser(personUser);
			
			//실행결과 메세지처리
			this.setMessage(request, personUser); 
			
		}else if(member.getKind().equals("C")){			
			companyUser.setInWorkName("기업회원관리자관리");
			companyUser.setInCondition("입력");
			companyUser.setInParam(request);
			password = companyUser.getPassword();
			
			if( password.length() > 0){ //비밀번호가 입력되었을때 암호화해준다.
				//비밀번호 암호화
				ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
				//encoder.setEncodeHashAsBase64(true);
				companyUser.setPassword(encoder.encodePassword(password, null));
			}else{ //비밀번호가 입력되지 않았을때에는 예전 비밀번호(암호화되있는)를 넣어준다.
				companyUser.setPassword(companyUser.getPrePassword());
			}
			
			//기업회원 이후데이터
			companyUser.setInAfterData(companyUser.makeDataString());
			
			//기업회원 전송데이터
			companyUser.setInDMLData(companyUser.makeDMLDataString());
			
			//기업회원 정보 수정
			memberMgrService.updateCompanyUser(companyUser);
			
			//실행결과 메세지처리
			this.setMessage(request, companyUser);
		}

		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(member.getMenuId())+
				  "&userId="+StringUtil.nullCheck(member.getUserId())+
				  "&kind="+StringUtil.nullCheck(member.getKind())+
				  "&inSchStartDate="+StringUtil.nullCheck(member.getInSchStartDate())+
				  "&inSchEndDate="+StringUtil.nullCheck(member.getInSchEndDate())+
				  "&siteId="+StringUtil.nullCheck(member.getSiteId())+
				  "&schStartDate="+StringUtil.nullCheck(member.getSchStartDate())+ 
				  "&schEndDate="+StringUtil.nullCheck(member.getSchEndDate())+
				  "&schText="+StringUtil.nullCheck(URLEncoder.encode(member.getSchText(), "UTF-8"))+
				  "&schType="+StringUtil.nullCheck(member.getSchType());
		
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/memberMgr?").concat(strLink));
		return new ModelAndView(rv);
	}
	
	/**************************************************
	 * companyAction 기업회원 수정
	 * @param companyUser
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 **************************************************/
	@RequestMapping(method=RequestMethod.POST, value="/companyAction")
	public ModelAndView companyAction(@ModelAttribute CompanyUser companyUser, HttpServletRequest request, Model model) throws Exception {
		
		companyUser.setInParam(request);
		
		//기본 데이터 설정
		companyUser.setInWorkName("기업회원관리");
		companyUser.setInCondition("수정");
		
		String password = companyUser.getPassword();
		
		if( password.length() > 0){ //비밀번호가 입력되었을때 암호화해준다.
			//비밀번호 암호화
			ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
			//encoder.setEncodeHashAsBase64(true);
			companyUser.setPassword(encoder.encodePassword(password, null));
		}else{ //비밀번호가 입력되지 않았을때에는 예전 비밀번호(암호화되있는)를 넣어준다.
			companyUser.setPassword(companyUser.getPrePassword());
		}
		
		//기업회원 이후데이터
		companyUser.setInAfterData(companyUser.makeDataString());
		
		//기업회원 전송데이터
		companyUser.setInDMLData(companyUser.makeDMLDataString());
		
		//기업회원 정보 수정
		memberMgrService.updateCompanyUser(companyUser);
		
		//실행결과 메세지처리
		this.setMessage(request, companyUser);
		
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(companyUser.getMenuId())+
				"&userId="+StringUtil.nullCheck(companyUser.getUserId())+
				"&kind="+StringUtil.nullCheck(companyUser.getKind())+
				"&inSchStartDate="+StringUtil.nullCheck(companyUser.getInSchStartDate())+
				"&inSchEndDate="+StringUtil.nullCheck(companyUser.getInSchEndDate())+
				"&siteId="+StringUtil.nullCheck(companyUser.getSiteId())+
				"&schStartDate="+StringUtil.nullCheck(companyUser.getSchStartDate())+
				"&schEndDate="+StringUtil.nullCheck(companyUser.getSchEndDate())+
				"&schText="+StringUtil.nullCheck(URLEncoder.encode(companyUser.getSchText(), "UTF-8"))+
				"&schType="+StringUtil.nullCheck(companyUser.getSchType());
		
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/memberMgr/form?").concat(strLink));
		return new ModelAndView(rv);
	}
	
	/**************************************************
	 * personAction 개인회원 수정
	 * @param personUser
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***************************************************/
	@RequestMapping(method=RequestMethod.POST, value="/personAction")
	public ModelAndView personAction(@ModelAttribute PersonUser personUser, HttpServletRequest request, Model model) throws Exception {
		
		personUser.setInParam(request);
		
		//기본 데이터 설정
		personUser.setInWorkName("개인회원관리");
		personUser.setInCondition("수정");
		
		String password = personUser.getPassword();
		
		if( password.length() > 0){ //비밀번호가 입력되었을때 암호화해준다.
			//비밀번호 암호화
			ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
			//encoder.setEncodeHashAsBase64(true);
			personUser.setPassword(encoder.encodePassword(password, null));
		}else{ //비밀번호가 입력되지 않았을때에는 예전 비밀번호(암호화되있는)를 넣어준다.
			personUser.setPassword(personUser.getPrePassword());
		}
		
		//개인회원 이후데이터
		personUser.setInAfterData(personUser.makeDataString());
		
		//개인회원 전송데이터
		personUser.setInDMLData(personUser.makeDMLDataString());
		
		//개인회원 정보 수정
		memberMgrService.updatePersonUser(personUser);
		
		//실행결과 메세지처리
		this.setMessage(request, personUser); 
		
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(personUser.getMenuId())+
				"&userId="+StringUtil.nullCheck(personUser.getUserId())+
				"&kind="+StringUtil.nullCheck(personUser.getKind())+
				"&inSchStartDate="+StringUtil.nullCheck(personUser.getInSchStartDate())+
				"&inSchEndDate="+StringUtil.nullCheck(personUser.getInSchEndDate())+
				"&siteId="+StringUtil.nullCheck(personUser.getSiteId())+
				"&schStartDate="+StringUtil.nullCheck(personUser.getSchStartDate())+ 
				"&schEndDate="+StringUtil.nullCheck(personUser.getSchEndDate())+
				"&schText="+StringUtil.nullCheck(URLEncoder.encode(personUser.getSchText(), "UTF-8"))+
				"&schType="+StringUtil.nullCheck(personUser.getSchType());
		
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/memberMgr/form?").concat(strLink));
		return new ModelAndView(rv);
	}
	
	/*@RequestMapping(value="/addTeamForm", method=RequestMethod.GET)
	public ModelAndView deptAdditionPopup(@ModelAttribute KhidiUser khidiUser, HttpServletRequest request, Model model) throws Exception {
		
		//Parameter 설정
		khidiUser.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, khidiUser);
		
		List<HashMap<String, String>> rtnDeptList  = null;
		List<HashMap<String, String>> rtnDutyList  = null;
		List<HashMap<String, String>> rtnPositionList  = null;
		
		// 부서리스트 조회
		rtnDeptList = memberMgrService.getDeptList();
		
		// 직위리스트 조회
		rtnDutyList = memberMgrService.getDutyList();
		
		// 직급리스트 조회
		rtnPositionList = memberMgrService.getPositionList();
		
		// View 설정
		model.addAttribute("mainDeptId", khidiUser.getMainDeptId()); // 내부직원 ID
		model.addAttribute("userId", khidiUser.getUserId()); // 내부직원 ID
		model.addAttribute("deptId", khidiUser.getDeptId() ); // 부서코드
		model.addAttribute("deptSeq", khidiUser.getDeptSeq() ); // 부서코드
		model.addAttribute("dutyId", khidiUser.getDutyId()); // 직위코드
		model.addAttribute("positionId", khidiUser.getPositionId() ); // 직급코드
		model.addAttribute("chargeWork", khidiUser.getChargeWork()); // 담당업무
		model.addAttribute("phone", khidiUser.getPhone()); // 전화번호
		model.addAttribute("fax", khidiUser.getFax()); // 전화번호
		model.addAttribute("sort", khidiUser.getSort()); // 구분
		
		model.addAttribute("rtnDeptlist", rtnDeptList); // 부서리스트
		model.addAttribute("rtnDutylist", rtnDutyList); // 직위리스트
		model.addAttribute("rtnPositionlist", rtnPositionList); // 직급리스트
		
		khidiUser.setJsp("system/memberMgr/addTeamForm");
		khidiUser.setViewTitle("내부직원 겸직 등록/수정"); // 화면 title 세팅
		return new ModelAndView("ips.layoutPopup", "obj", khidiUser);
	}*/	
	
	/**************************************************
	 * personAction 개인회원 수정
	 * @param personUser
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***************************************************/
	/*@RequestMapping(method=RequestMethod.POST, value="/insertTeam")
	public ModelAndView insertTeam(@ModelAttribute KhidiUser khidiUser, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		khidiUser.setInParam(request);		
		
		khidiUser.setInWorkName("조직관리");
		
		//조직정보 전송데이터
		khidiUser.setInDMLData(khidiUser.getInputGRVal());
		
		if("입력".equals(khidiUser.getInCondition())){
			//조직정보 입력/수정
			memberMgrService.insertTeamInfo(khidiUser);			
		}else{
			
			memberMgrService.deleteTeamInfo(khidiUser);
		}
		
		//실행결과 메세지처리
		this.setMessage(request, khidiUser);
		
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(khidiUser.getMenuId())+
				"&userId="+StringUtil.nullCheck(khidiUser.getUserId())+
				"&kind="+StringUtil.nullCheck(khidiUser.getKind())+
				"&inSchStartDate="+StringUtil.nullCheck(khidiUser.getInSchStartDate())+
				"&inSchEndDate="+StringUtil.nullCheck(khidiUser.getInSchEndDate())+
				"&siteId="+StringUtil.nullCheck(khidiUser.getSiteId())+
				"&schStartDate="+StringUtil.nullCheck(khidiUser.getSchStartDate())+ 
				"&schEndDate="+StringUtil.nullCheck(khidiUser.getSchEndDate());
				
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/memberMgr/form?").concat(strLink));
		return new ModelAndView(rv);
	
	}*/
	
	/**************************************************
	 * personAction 회원 삭제
	 * @param member
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***************************************************/
	@RequestMapping(method=RequestMethod.POST, value="/deleteUser")
	public ModelAndView deleteUser(@ModelAttribute Member member, HttpServletRequest request, Model model) throws Exception {
		
		member.setInParam(request);
		
		//기본 데이터 설정
		PersonUser personUser = new PersonUser();
		CompanyUser companyUser = new CompanyUser();
		MemberInfo memberInfo = new MemberInfo();
		
		String userKind = "";
		String userIds = "";
		String[] userIdv;
		String userId = "";
		
		for(int i=0; i<member.getChkUserIds().length; i++){
			
			userIds = member.getChkUserIds()[i];
			
			userIdv = userIds.split("-");
			userId = userIdv[0];
			memberInfo.setMyId(userId);
			
			//userKind = memberInfoService.getUserKind(memberInfo);
			
		
			if("P".equals(userKind))
			{
				
				personUser.setInParam(request);
				
				personUser.setInWorkName("개인회원관리");
				personUser.setInCondition("삭제");
				personUser.setState("F");
				personUser.setPasswordTime("20161111111111"); 
				personUser.setWithDrawTime("20161111111111");
				
				personUser.setUserId(userId);
				
				//개인회원 이후데이터
				personUser.setInAfterData(personUser.makeDataString());
				
				//개인회원 전송데이터
				personUser.setInDMLData(personUser.makeDMLDataString());
				
				//개인회원 정보 수정
				memberMgrService.updatePersonUser(personUser);
				
				//실행결과 메세지처리
				this.setMessage(request, personUser);
			}
			else if("C".equals(userKind)){
				
				companyUser.setInParam(request);
				
				companyUser.setInWorkName("기업회원관리");
				companyUser.setInCondition("삭제");
				
				companyUser.setState("F");
				companyUser.setPasswordTime("20161111111111"); 
				companyUser.setWithDrawTime("20161111111111"); 
				
				companyUser.setUserId(userId);
				//기업회원 이후데이터
				companyUser.setInAfterData(companyUser.makeDataString());
				//기업회원 전송데이터
				companyUser.setInDMLData(companyUser.makeDMLDataString());
				//개인회원 정보 수정
				memberMgrService.updateCompanyUser(companyUser);
				
				//실행결과 메세지처리
				this.setMessage(request, companyUser);
			}
		}
			
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(member.getMenuId())+
				"&schType="+StringUtil.nullCheck(member.getSchType())+
				"&schText="+StringUtil.nullCheck(member.getSchText())+
				"&siteId="+StringUtil.nullCheck(member.getSiteId())+
				"&state="+StringUtil.nullCheck(member.getState())+
				"&schStartDate="+StringUtil.nullCheck(member.getSchStartDate())+ 
				"&schEndDate="+StringUtil.nullCheck(member.getSchEndDate())+
				"&inSchStartDate="+StringUtil.nullCheck(member.getInSchStartDate())+ 
				"&inSchEndDate="+StringUtil.nullCheck(member.getInSchEndDate())+
				"&key1="+StringUtil.nullCheck(member.getKey1())+ 
				"&key2="+StringUtil.nullCheck(member.getKey2())+
				"&key3="+StringUtil.nullCheck(member.getKey3());
				
		model.addAttribute("link", strLink);
		
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/memberMgr?").concat(strLink));
		return new ModelAndView(rv);
		
	}
	
}
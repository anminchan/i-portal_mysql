package kr.plani.ccis.mps.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.base.controller.BaseCommonController;
import kr.plani.ccis.base.domain.MemberInfo;
import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.common.User;
import kr.plani.ccis.ips.domain.system.PersonUser;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.mps.service.MemberService;


/*****************************************************************
* 대표홈페이지를 보여주는 공통기능 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2017. 05. 20. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         		수정내용
* ------------------------------------------------------
* 2017. 05. 20.		mcahn	최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mps/member")
public class MemberController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(BaseCommonController.class);
	
	@Resource
	private BaseService baseService;
	
	@Resource
	private MemberService memberService;
	
	@Resource
	CommonService commonService;
	
	/**
	 * 로그인폼
	 * @param defaultDomain
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/loginForm")
	public ModelAndView loginForm(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		// Parameter 설정
		defaultDomain.setInParam(request);
		
		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, defaultDomain, siteSet);
		
		String url =request.getHeader("referer");
		
		String idSynthUrl = StringUtil.paramUnscript(StringUtil.nullCheck(request.getParameter("idSynthUrl")));
		String rtnUrl = StringUtil.paramUnscript(StringUtil.nullCheck(defaultDomain.getRtnUrl())); 
		
		// 서신평 휴대폰인증 Form
		//this.setSciSecuPccCheckEncDataHp(request, response, model, "member", "001001"); //개발 : 002003, 운영 001001
		// 서신평 ipin인증 Form
		//this.setSciSecuPccCheckEncDataIpin(request, response, model, "member", "001001"); //개발 : 002001, 운영 001001
		
		//이전페이지 저장
		if(!"".equals(idSynthUrl) && idSynthUrl != null){ //ID통합 창에서 보낸 URL이  
			model.addAttribute("rtnUrl", idSynthUrl);
		}else if( !"".equals(rtnUrl) && rtnUrl != null){ 
			model.addAttribute("rtnUrl", rtnUrl);	//rtnUrl이 있을때
		}else{
			model.addAttribute("rtnUrl", url);
		}
		
		//model.addAttribute("mySiteId", StringUtil.paramUnscript(StringUtil.nullCheck(request.getParameter("mySiteId"))));
		
		defaultDomain.setJsp("member/loginForm");
		return new ModelAndView("mps.sub.layout", "obj", defaultDomain);
	}
	
	/**
	 * 로그인
	 * @param defaultDomain
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login")
	public @ResponseBody Object login(@ModelAttribute DefaultDomain defaultDomain, @ModelAttribute User user, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String strRtnUrl = request.getHeader("referer");
		
		user.setInParam(request);
		
		String notice = "";
		String password = user.getPassword();
		
		/*MemberInfo memberInfo = new MemberInfo();
		memberInfo.setMyId(user.getUserId());
		String mySiteId = user.getMySiteId();*/
		
		//비밀번호 암호화
		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
		//encoder.setEncodeHashAsBase64(true);
		user.setPassword(encoder.encodePassword(password, null));
		
		logger.info("user.getPassword()/////////////////"+user.getPassword());
		
		Object[] objRtn = baseService.getLogin(user);
		
		List<?> rtnList = (List<?>)objRtn[2];
		User scUser = (User)rtnList.get(0);
		
		if(objRtn[0].toString().equals("SUCCESS")){
			// 세션 생성
			SCookie sc = new SCookie(request, response, 
									scUser.getUserId(), scUser.getkName(), 
									scUser.getKind(), scUser.getKindName(),
									scUser.getCorpRegNo()
									);
			
			sc.setCellPhone(scUser.getCellPhone());
			sc.setCookies();

			request.getSession().setAttribute("USER", sc);
			request.getSession().setAttribute("ADMUSER", null); // 관리자 세션제거

			HashMap<String, String> rtnDateYn = memberService.getWithDrawPwChageYn(scUser.getUserId());
			String withDrawTimeflag = rtnDateYn.get("WITHDRAWTIMEFLAG"); //개인정보 재동의 날짜 2년 경과여부 한달전옂부
			String withDrawTime = rtnDateYn.get("WITHDRAWTIME"); //개인정보 재동의 날짜 2년 경과여부 한달전옂부
			String passwordTimeflag = rtnDateYn.get("PASSWORDTIMEFLAG"); //패스워드 변경 3개월 유무
			String passwordImsiflag = rtnDateYn.get("PASSWORDIMSIFLAG"); //임시패스워드유무
			
			if("Y".equals(withDrawTimeflag)){
				FlashMap fm = RequestContextUtils.getOutputFlashMap(request);  
			    fm.put("withdrawFlag", "W");  
			    fm.put("result", user.getOutResult());  
			    fm.put("message", scUser.getkName()+"님은 "+withDrawTime+"까지 홈페이지에 재동의 하지 않을 경우 자동으로 회원 탈퇴 처리됨을 알려드립니다. 개인정보 재동의 절차를 진행해 주세요");
				
			}else if("Y".equals(passwordTimeflag)){
				FlashMap fm = RequestContextUtils.getOutputFlashMap(request);  
			    fm.put("pwchageFlag", "P");  
			    fm.put("result", user.getOutResult());  
			    fm.put("message", "비밀번호 최종 변경일이 3개월을 초과하였습니다. 주기적인 비밀번호 변경을 통해 개인정보를 안전하게 보호하세요");	
				
			}else if("Y".equals(passwordImsiflag)){
				FlashMap fm = RequestContextUtils.getOutputFlashMap(request);  
			    fm.put("pwImsiFlag", "I");  
			    fm.put("result", user.getOutResult());  
			    fm.put("message", "임시비밀번호로 로그인 하셨습니다. 비밀번호을 변경해 주세요");	
			}
			
			if(!defaultDomain.getRtnUrl().equals("")){
				strRtnUrl = defaultDomain.getRtnUrl();
				if(strRtnUrl.indexOf("/memberSearch") > -1){
					strRtnUrl = "/mps";
				}
			}else{
				strRtnUrl = "/mps";
			}
			
			//로그인아웃 로그 처리
			user.setUserId(user.getUserId());
			user.setInCondition("INS");
			user.setInGubun("USER");
			
			commonService.insertUserLogInOutLog(user);
			
		}else if(objRtn[0].toString().equals("FAILURE")){
			if(!defaultDomain.getRtnUrl().equals("")){
				strRtnUrl = defaultDomain.getRtnUrl();
				if(strRtnUrl.indexOf("loginForm") > -1 || strRtnUrl.indexOf("idSynthesis") > -1){
					strRtnUrl = "/mps";
				}
			}
			
			notice = objRtn[1].toString();
			model.addAttribute("rtnUrl", strRtnUrl);
			
			strRtnUrl = request.getContextPath()+"/mps/member/loginForm?menuId="+defaultDomain.getMenuId();
			
			user.setOutNotice(notice);
			this.setMessage(request, user);
		}


		RedirectView rv = new RedirectView(request.getContextPath().concat(strRtnUrl));
		return new ModelAndView(rv);
	}
	
	/**
	 * 비회원
	 * @param defaultDomain
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/loginNoUser")
	public @ResponseBody Object loginNotUser(@ModelAttribute DefaultDomain defaultDomain, @ModelAttribute User user, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String strRtnUrl = "";
		
		// 세션 생성 kind : N(비회원 인증)
		SCookie sc = new SCookie(request, response, 
								"guest", user.getkName(), 
								"N", "비회원", null);
		sc.setdKey(user.getDkey());
		sc.setCookies();
		request.getSession().setAttribute("USER", sc);
		
		if(!defaultDomain.getRtnUrl().equals("")){
			strRtnUrl = defaultDomain.getRtnUrl();
			if(strRtnUrl.indexOf("/member") > -1 || strRtnUrl.indexOf("/memberSearch") > -1){
				strRtnUrl = "/mps";
			}
		}
		
		RedirectView rv = new RedirectView(request.getContextPath().concat(strRtnUrl));
		return new ModelAndView(rv);
	}
	
	/**
	 * 로그아웃
	 * @param defaultDomain
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/logout")
	public @ResponseBody Object logout(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		defaultDomain.setInParam(request);
		
		request.getSession().setAttribute("USER", null);
		request.getSession().setAttribute("ADMUSER", null);
		request.getSession().setAttribute("inisafe", null);
		
		String siteId = defaultDomain.getSiteId();
		String rtnUrl = request.getContextPath()+"/mps";
		
		if(!"SITE00002".equals(siteId)){
			rtnUrl = request.getContextPath()+"/site?siteId="+siteId;
		}
		
		//로그인아웃 로그 처리
		defaultDomain.setUserId(defaultDomain.getMyId());
		defaultDomain.setInCondition("UPD");
		defaultDomain.setState("Y");
		
		commonService.insertUserLogInOutLog(defaultDomain);
		
		response.sendRedirect(rtnUrl);

		return null;
	}

	/**
	 * 회원가입 개인회원 본인인증
	 * @param personUser
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/confirm")
	public ModelAndView confirmPerson(@ModelAttribute PersonUser personUser, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		// Parameter 설정
		personUser.setInParam(request);
		
		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, personUser, siteSet);
		
		// 서신평 휴대폰인증 Form
		//this.setSciSecuPccCheckEncDataHp(request, response, model, "member", "001002"); //개발 : 002004, 운영 001002
		
		// 서신평 ipin인증 Form
		//this.setSciSecuPccCheckEncDataIpin(request, response, model, "member", "001002"); //개발 : 002002, 운영 001002
		
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(personUser.getMenuId());
		
		model.addAttribute("link", strLink);	
		
		personUser.setJsp("/member/confirm");
		return new ModelAndView("mps.sub.layout", "obj", personUser);
	}	
		
	/**
	 * 개인회원입력폼
	 * @param memberInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/joinForm")
	public ModelAndView joinform(@ModelAttribute MemberInfo memberInfo, HttpServletRequest request, Model model) throws Exception {

		memberInfo.setInParam(request);
		
		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, memberInfo, siteSet);
		
		String certification = memberInfo.getCertification();
		String dkey			 = memberInfo.getDkey();		
		String birthDate	 = memberInfo.getBirthDate();
		String KName		 = memberInfo.getKName();
		String corpRegno	 = memberInfo.getCorpRegno();
		String kind	 		 = memberInfo.getKind();
		String gender		 = memberInfo.getGender();
		
		model.addAttribute("certification", certification);
		model.addAttribute("dkey", dkey);
		model.addAttribute("birthDate", birthDate);
		model.addAttribute("KName", KName);
		model.addAttribute("corpRegno", corpRegno);
		model.addAttribute("kind", kind);
		model.addAttribute("gender", gender);
		model.addAttribute("rejoinYn", "N");
		
		memberInfo.setJsp("/member/joinForm");
			
		//링크설정
		String strLink = null;
		strLink = "menuId="+StringUtil.nullCheck(memberInfo.getMenuId());
		
		model.addAttribute("link", strLink);	
		
		return new ModelAndView("mps.sub.layout", "obj", memberInfo);
	}
		
	/**************************************************
	 * personAction 개인회원 등록
	 * @param personUser
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***************************************************/
	@RequestMapping(value="/personAction")
	public ModelAndView personAction(@ModelAttribute PersonUser personUser, HttpServletRequest request, Model model) throws Exception {
		
		//기본 데이터 설정
		personUser.setInWorkName("개인회원관리");
		
		// Parameter 설정
		personUser.setInParam(request);
		
		//기본셋팅
		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, personUser, siteSet);
		
		String password = personUser.getPassword();
		
		//비밀번호 암호화
		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
		//encoder.setEncodeHashAsBase64(true);
		personUser.setPassword(encoder.encodePassword(password, null));

		// 세션값 가져오기 웹프로시 변조를 방지하기 위해 dkey는 세션에서 가져옴 
		//SCookie loginInfo = (SCookie)request.getSession().getAttribute("DUPINFO");
				
		String dKey = "";//loginInfo.getCorpRegNo();
						
		personUser.setDkey(dKey); //dkey를    CorpRegNo에 담았음
				
		request.getSession().setAttribute("DUPINFO", null); // dupinfo 세션제거		
		
		//개인회원 이후데이터
		personUser.setInAfterData(personUser.makeDataString());
		
		//개인회원 전송데이터
		personUser.setInDMLData(personUser.makeDMLDataString());
		
		//개인회원 정보 등록
		memberService.updatePersonUser(personUser, request);

		//실행결과 메세지처리
		this.setMessage(request, personUser); 

		personUser.setJsp("/member/complete");
				
		return new ModelAndView("mps.sub.layout", "obj", personUser);		
	}
	
	@RequestMapping(value="/idSearchFrom")
	public ModelAndView searchIdForm(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		defaultDomain.setInParam(request);

		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, defaultDomain, siteSet);

		// 서신평 휴대폰인증 Form
		//this.setSciSecuPccCheckEncDataHp(request, response, model, "memberSearch", "001005"); //개발 : 002005, 운영 001005
		
		// 서신평 아이핀인증 Form
		//this.setSciSecuPccCheckEncDataIpin(request, response, model, "memberSearch", "001003"); //개발 : 002003, 운영 001003
		
		String url =request.getHeader("referer");
				
		//이전페이지 저장
		model.addAttribute("rtnUrl", url);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(defaultDomain.getMenuId());
		
		model.addAttribute("link", strLink);
		
		defaultDomain.setJsp("member/idSearch");
		
		return new ModelAndView("mps.sub.layout", "obj", defaultDomain);
	}
	
	@RequestMapping(value="/passwordSearchFrom")
	public ModelAndView searchPwForm(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		defaultDomain.setInParam(request);

		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, defaultDomain, siteSet);
		
		// 서신평 휴대폰인증 Form
		//this.setSciSecuPccCheckEncDataHp(request, response, model, "memberSearch", "001006"); //개발 : 002006, 운영 001006
		
		// 서신평 아이핀인증 Form
		//this.setSciSecuPccCheckEncDataIpin(request, response, model, "memberSearch", "001004"); //개발 : 002004, 운영 001004
				
		String url =request.getHeader("referer");
						
		//이전페이지 저장
		model.addAttribute("rtnUrl", url);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(defaultDomain.getMenuId());
		
		model.addAttribute("link", strLink);
		
		defaultDomain.setJsp("member/pwSearch");
		
		return new ModelAndView("mps.sub.layout", "obj", defaultDomain);
	}
	
	@RequestMapping(value="/idSearch", method=RequestMethod.GET)
	public @ResponseBody Object listCateJson(@ModelAttribute User user, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		user.setInParam(request);
		
		if(user.getSchType() == 0){ //dkey 체크일 경우
			
			// 세션값 가져오기 웹프로시 변조를 방지하기 위해 dkey는 세션에서 가져옴
			SCookie loginInfo = (SCookie)request.getSession().getAttribute("DUPINFO");
			
			user.setDkey(loginInfo.getCorpRegNo()); //dkey를    CorpRegNo에 담았음
			
		}
		
		User rtnUser = new User();
		
		//카테고리 조회
		User objRtn = (User)memberService.getObject(user);
		
		if(objRtn.getOutCursor() == null){
			rtnUser = null;
		}else{
			rtnUser = (User)objRtn.getOutCursor();
		}

		return rtnUser;
	}
	
	@RequestMapping(value="/idSearchCompany", method=RequestMethod.GET)
	public @ResponseBody List<HashMap<String, String>> idSearchCompany(@ModelAttribute MemberInfo memberInfo, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		memberInfo.setInParam(request);
		
		//검색체계 분야 조회
		List<HashMap<String, String>> objRtn = memberService.idSearchCompany(memberInfo);
		
		return objRtn;		
	}
	
	@RequestMapping(value="/pwSearchCompany", method=RequestMethod.GET)
	public @ResponseBody List<HashMap<String, String>> pwSearchCompany(@ModelAttribute MemberInfo memberInfo, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		memberInfo.setInParam(request);
		
		//검색체계 분야 조회
		List<HashMap<String, String>> objRtn = memberService.pwSearchCompany(memberInfo);
		
		return objRtn;		
	}
	
	@RequestMapping(value="/idFind")
	public ModelAndView searchId(@ModelAttribute User user, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		user.setInParam(request);

		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, user, siteSet);
		
		String url =request.getHeader("referer");

		//이전페이지 저장
		model.addAttribute("rtnUrl", url);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(user.getMenuId());
		
		model.addAttribute("link", strLink);
		
		// View 설정
		model.addAttribute("rtnUser", user);
				
		user.setJsp("member/idFind");
		
		return new ModelAndView("mps.sub.layout", "obj", user);
	}
	
	@RequestMapping(value="/passwordMailCorfirm")
	public @ResponseBody Object passwordCorfirm(@ModelAttribute User user, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		//파라미터 설정
		user.setInParam(request);

		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, user, siteSet);
		
		// 세션 생성
		SCookie sc = new SCookie(request, response, 
				user.getUserId(), user.getkName(), 
				user.getKind(), user.getKindName(),
				user.getCorpRegNo()
				);
		
		sc.setCookies();
		// pw찾기 세션생성
		request.getSession().setAttribute("PWSEARCHINFO", sc);
		
		//파라미터 설정
		user.setInParam(request);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(user.getMenuId());
		
		model.addAttribute("link", strLink);
		
		// View 설정
		model.addAttribute("rtnUser", user);
				
		user.setJsp("member/pwMailConfirm");
		
		return new ModelAndView("mps.sub.layout", "obj", user);
	}
	
	@RequestMapping(value="/passwordSearch")
	public ModelAndView searchPassword(@ModelAttribute User user, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		user.setInParam(request);

		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, user, siteSet);
		
		user.setInWorkName("임시비밀번호발급관리");
		user.setInCondition("수정");
		
		// 세션값 가져오기
		SCookie loginInfo = (SCookie)request.getSession().getAttribute("PWSEARCHINFO");
		
		user.setUserId(loginInfo.getUserId());
		request.getSession().setAttribute("PWSEARCHINFO", null); // pw찾기 세션제거
			
		String url =request.getHeader("referer");

		// 임시비밀번호 생성
		String tempEncPw = getTmpPwd(5);
		//String tempPw = tempEncPw;
		
		//비밀번호 암호화
		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
		//encoder.setEncodeHashAsBase64(true);
		encoder.encodePassword(tempEncPw, null);
		
		user.setPassword(encoder.encodePassword(tempEncPw, null));
		
		// 변경후 데이타 저장(inAfterData)
		user.setInAfterData(user.makeTempPasswordDataString());

		//InDMLData ::  UserID|Password
		user.setInDMLData(user.makeTempPasswordDMLDataString());

		User objRtn = (User)memberService.insertObject(user);
		
		/*
		 * 메일 전송 작성 END
		 * 임시번호 발송 
		 */
		
		//실행결과 로기 생성
		this.resultLog(user);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//이전페이지 저장
		model.addAttribute("rtnUrl", url);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(user.getMenuId());
		
		model.addAttribute("link", strLink);
				
		// View 설정
		model.addAttribute("rtnUser", user);
				
		user.setJsp("member/pwFind");
		
		return new ModelAndView("mps.sub.layout", "obj", user);
	}
				
	/*****************************************************************
	* 임시비밀번호만들기
	* @param len
	* @throws Exception
	*******************************************************************/
    
   public static String getTmpPwd(int len) {
 
		char[] tmpChar = new char[]{
		'a','b','c','d','e','f','g','h','i','j','k','m'
		,'n','p','q','r','s','t','u','v','w','x','y'
		,'2','3','4','5','6','7','8','9'};
 
 
 		StringBuffer sb = new StringBuffer();

 		for(int i=0; i<len; i++){
 			int seq = (int)(tmpChar.length*Math.random());
 			sb.append(tmpChar[seq]);
 		}
 
 		return sb.toString();
	 }
   
   
   /**
    * MD5+SHA256 방식으로 암호화
    * @param strData
    * @return
    */
   public static String encrypt(String strData) {
       return encryptSHA256(encryptMD5toUpper(strData));
   }

   /**
    * MD5 방식으로 암호화(대문자로)
    * @param strData
    * @return
    */
   public static String encryptMD5toUpper(String strData) { // 암호화 시킬 데이터
       String strENCData = "";
       MessageDigest md = null;
       try {
               md = MessageDigest.getInstance("MD5"); // 'MD5 형식으로 암호화' 
           byte[] bytData = strData.getBytes();
           md.update(bytData);
           byte[] digest = md.digest();  //배열로 저장을 한다.
               for (int i = 0; i < digest.length; i++) {
                   strENCData = strENCData + Integer.toHexString(digest[i] & 0xFF).toUpperCase();
               }
       } catch (NoSuchAlgorithmException e) {
           //log.error('암호화 에러' + e.toString());
           //e.toString();
       		System.out.println("처리 중 오류가 발생했습니다.");
    	   
       }
       return strENCData;  // 암호화된 데이터를 리턴...
   }
   
   /**
    * MD5 방식으로 암호화(소문자로)
    * @param strData
    * @return
    */
   public static String encryptMD5(String strData) { // 암호화 시킬 데이터
       String strENCData = "";
       MessageDigest md = null;
       try {
               md = MessageDigest.getInstance("MD5"); // 'MD5 형식으로 암호화' 
           byte[] bytData = strData.getBytes();
           md.update(bytData);
           byte[] digest = md.digest();  //배열로 저장을 한다.
               for (int i = 0; i < digest.length; i++) {
                   strENCData = strENCData + Integer.toHexString(digest[i] & 0xFF);
               }
       } catch (NoSuchAlgorithmException e) {
           //log.error('암호화 에러' + e.toString());
           //e.toString();
      		System.out.println("처리 중 오류가 발생했습니다.");
       }
       return strENCData;  // 암호화된 데이터를 리턴...
   }       
   
   /**
    * SHA-256 방식으로 암호화(대문자로)
    * @param strData
    * @return
    */
   public static String encryptSHA256(String strData) {
       String strENCData = "";
       try {
           MessageDigest md = MessageDigest.getInstance("SHA-256");
           StringBuffer sb = new StringBuffer();
           md.update(strData.getBytes());
           byte[] digest = md.digest();
           for (int i = 0; i < digest.length; i++) {
               sb.append(Integer.toString((digest[i] & 0xFF) + 0x100, 16).substring(1).toUpperCase());
           }
           strENCData = sb.toString();
       } catch (NoSuchAlgorithmException e) {
    	   //e.printStackTrace();
      		System.out.println("처리 중 오류가 발생했습니다.");
       }
       return strENCData;
   }
   
   /**
    * my-sql old_password 방식으로 암호화
    * @param strData
    * @return
    */
   public static String old_password(String inpara) {
	   
	   byte[] bpara = new byte[inpara.length()];
	   
	   long lvar1 = 1345345333;
	   long ladd = 7;
	   long lvar2 = 0x12345671;
	   int i;
	   
	   if (inpara.length() <= 0)
		   return "";
	   
	   for (i=0; i < inpara.length(); i++)
		   bpara[i] = (byte)(inpara.charAt(i) & 0xff );
	   
	   for (i=0; i < inpara.length(); i++) {
		   if (bpara[i] == ' ' ||  bpara[i] == '\t') continue;
		   lvar1 ^= (((lvar1 & 63) + ladd) * bpara[i]) + (lvar1 << 8);
		   lvar2 += (lvar2 << 8) ^ lvar1;
		   ladd += bpara[i];
	   }
	   
	   lvar1 = lvar1 & 0x7fffffff;
	   lvar2 = lvar2 & 0x7fffffff;
	   
	   StringBuffer r = new StringBuffer(16);
	   
	   String x = Long.toHexString(lvar1);
	   
	   for (i = 8; i > x.length(); i --)
	   r.append("0");
	   	   r.append(x);
	   x = Long.toHexString(lvar2);
	   for (i = 8; i > x.length(); i --)
	   r.append("0");
	   r.append(x);
	   return r.toString();
   }
   
}
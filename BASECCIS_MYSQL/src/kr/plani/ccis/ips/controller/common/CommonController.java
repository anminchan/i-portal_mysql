package kr.plani.ccis.ips.controller.common;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.namo.crossuploader.CrossUploaderException;
import com.namo.crossuploader.FileItem;
import com.namo.crossuploader.FileUpload;

import kr.plani.ccis.base.domain.MemberInfo;
import kr.plani.ccis.common.util.FileDownloadView;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.common.Editor;
import kr.plani.ccis.ips.domain.common.User;
import kr.plani.ccis.ips.domain.site.Category;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.domain.stat.Stat;
import kr.plani.ccis.ips.domain.system.Code;
import kr.plani.ccis.ips.domain.system.CompanyUser;
import kr.plani.ccis.ips.domain.system.Group;
import kr.plani.ccis.ips.domain.system.Member;
import kr.plani.ccis.ips.domain.system.Site;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentMgrService;
import kr.plani.ccis.ips.service.site.IpManagementMgrService;
import kr.plani.ccis.ips.service.stat.SystemStatService;
import kr.plani.ccis.ips.service.system.CodeMgrService;
import kr.plani.ccis.ips.service.system.MemberMgrService;
import net.coobird.thumbnailator.Thumbnails;

@Controller
public class CommonController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	/** 공통기능 서비스   */
	@Resource
	private CommonService commonService;
	
	@Resource
	private CodeMgrService codeMgrService;
	
	@Resource
	private MemberMgrService memberMgrService;
		
	@Resource
	private IpManagementMgrService ipManagementMgrService;

	@Resource
	private SystemStatService systemStatService;
	
	@Resource
	private ContentMgrService contentMgrService;
	
	@Value("#{config['upload.dir']}")
	private String uploadDir;

	@RequestMapping(value="/i-portal")
	public ModelAndView preLogin(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		defaultDomain.setInParam(request);
				
		//IP허용여부체크
		/*String ip = request.getHeader("X-Forwarded-For");
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("Proxy-Client-IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("WL-Proxy-Client-IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("HTTP_CLIENT_IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("X-Real-IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("X-RealIP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getRemoteAddr(); 
		 }*/
		/*String ip = request.getRemoteAddr();
		defaultDomain.setInDMLIp(ip);
		String ipAllYnCheck = ipManagementMgrService.selectIpAllYnCheck(defaultDomain);
		if(ipAllYnCheck.equals("N")){
    		ModelAndView mav = new ModelAndView("ip.block");
    		return mav;
    	}*/
		
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		RedirectView rv = null;
		logger.info(">>>" + sc);
		if (sc == null) {
			rv = new RedirectView(request.getContextPath().concat("/i-portal/loginForm"));
			return new ModelAndView(rv);
		}else{
			// 사용자 메뉴조회
			DefaultDomain objParam = new DefaultDomain();
			objParam.setMySiteId(this.getSiteId());
			objParam.setMyId(sc.getUserId());
			
			//DefaultDomain objMenu = (DefaultDomain)commonService.listUserMenu(objParam);
			//List<?> aList = (List<?>)objMenu.getOutUserMenuCursor();
			List<?> aList = (List<?>)commonService.listUserMenu(objParam);
			
			String strMenuId = "";
			for(int i=0; i<aList.size(); i++){
				HashMap siteInfo = (HashMap) aList.get(i);
				strMenuId = "/"+(String)siteInfo.get("MENUID");
				break;
			}
			
			if(strMenuId.equals("")){
				request.getSession().setAttribute("USER", null);
				request.getSession().setAttribute("ADMUSER", null);
				defaultDomain.setOutNotice("관리자페이지 접속권한이 없습니다.");
				this.setMessage(request, defaultDomain);
				strMenuId = "/i-portal/loginForm";
			}
			
			/*rv = new RedirectView(request.getContextPath().concat("/mgr/main"));
			return new ModelAndView(rv);*/
			
			rv = new RedirectView(request.getContextPath().concat(strMenuId));
			return new ModelAndView(rv);
		}
	}
	
	@RequestMapping(value="/mgr/main")
	public ModelAndView adminMain(@ModelAttribute DefaultDomain defaultDomain, Stat stat, Title title, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		defaultDomain.setInParam(request);
		
		//세션값 가져오기
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		logger.info("objRtn.getUserId()>>"+sc.getUserId());
		
		// 사용자 메뉴조회
		defaultDomain.setMySiteId(this.getSiteId());
		defaultDomain.setMyId(sc.getUserId());
		
		DefaultDomain objMenu = (DefaultDomain)commonService.listUserMenu(defaultDomain);
		
		// 사용자 메뉴 return
		model.addAttribute("rtnUserMenu", objMenu.getOutUserMenuCursor());
		
		if(!StringUtil.isNotBlank(stat.getSiteId())) stat.setSiteId(getSiteId());
		
		// 통계조회
		String splitData[] = null;
		String result = "";
		
		// 기본 셋팅
		if(!StringUtil.isNotBlank(stat.getStatisSchGubun())) stat.setStatisSchGubun("MONTH");
		if(StringUtil.isNotBlank(stat.getSchStartDate()) && StringUtil.isNotBlank(stat.getSchEndDate())){
			splitData = stat.getSchStartDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
			}
			//검색 시작일
			stat.setInSchStartDate(result);
			
			splitData = null; 
			result = "";
			splitData = stat.getSchEndDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
			}
			//검색 종료일
			stat.setInSchEndDate(result);
			
			Stat objRtn = (Stat)systemStatService.getObjectList(stat);
			
			// 메인 시스템 통계
			model.addAttribute("resultUser", objRtn.getOutCursor());
			model.addAttribute("resultGuest", objRtn.getOutCursor1());
			model.addAttribute("resultBrowser", objRtn.getOutCursor2());
			model.addAttribute("statisSchGubun", stat.getStatisSchGubun());// 탭 구분
		}
		
		// 답변글 Count
		model.addAttribute("resultAnswer", contentMgrService.selectAnswerCountList(defaultDomain));
		
		// CMS 공지사항
		//title.setMenuId("MENU00115");
		//title.setRowCnt(5);
		//List<?> boardList = contentMgrService.getBoardList(title);
		//int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		//페이징 정보
		//model.addAttribute("resultNotice", boardList);
		//model.addAttribute("totalNoticeCnt", boardListCnt);	//전체 카운트
		
		stat.setJsp("main");
		return new ModelAndView("ips.main.layout", "obj", stat);
	}
	
	@RequestMapping(value="/mgr/listSite")
	public @ResponseBody List<?> listSiteJson(@ModelAttribute Site site, HttpServletRequest request, Model model) throws Exception {

		site.setRowCnt(999);
		// Parameter 설정
		site.setInParam(request);
		// 사이트 조회
		//Site objRtn = (Site)commonService.listSite(site);
		List<?> rtnList = (List<?>) commonService.listSite(site);
		
		return rtnList;
	}
	
	@RequestMapping(value="/mgr/listAdminSite")
	public @ResponseBody List<?> listAdminSiteJson(@ModelAttribute Site site, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		site.setInParam(request);
		
		// 사이트 조회
		//Site objRtn = (Site)commonService.listAdminSite(site);
		List<?> rtnList = (List<?>) commonService.listAdminSite(site);
		
		return rtnList;
	}
	
	@RequestMapping(value="/mgr/listCode")
	public @ResponseBody List<?> listCodeJson(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		code.setInParam(request);
		code.setInCode(code.getHigherCode());
		
		//코드 조회
		//Code objRtn = (Code)codeMgrService.getComboList(code);
		List<?> rtnList = (List<?>) codeMgrService.getComboList(code);
		
		return rtnList;
	}
	
	@RequestMapping(value="/mgr/listSiteCode")
	public @ResponseBody List<?> listSiteCodeJson(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		code.setInParam(request);
		code.setInCode(code.getHigherCode());
		
		//코드 조회
		//Code objRtn = (Code)codeMgrService.getComboList(code);
		List<?> rtnList = (List<?>) codeMgrService.getComboList(code);
		
		return rtnList;
	}
	
	@RequestMapping(value="/mgr/listCate")
	public @ResponseBody List<?> listCateJson(@ModelAttribute Category category, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		category.setInParam(request);
		
		//카테고리 조회
		//Category objRtn = (Category)commonService.listCate(category);
		List<?> rtnList = commonService.listCate(category);
		
		return rtnList;
	}
	
	@RequestMapping(value="/mgr/listGroup")
	public @ResponseBody List<?> listGroupJson(@ModelAttribute Group group, HttpServletRequest request, Model model) throws Exception {

		group.setRowCnt(999);
		
		// Parameter 설정
		group.setInParam(request);
		
		// 사이트 조회
		//Group objRtn = (Group)commonService.listGroup(group);
		List<?> rtnList = commonService.listGroup(group);
		
		return rtnList;
	}
		
	@RequestMapping(value="/mgr/listMemberPopup")
	public ModelAndView listUserPopup(@ModelAttribute Member member, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		member.setInParam(request);
				
		// 회원구분 파라메타 세팅
		member.setKind(request.getParameter("kind"));
		
		// 회원 조회
		//Member objRtn = (Member)memberMgrService.getMemberPopupList(member);
		List<?> objRtn = (List<?>)memberMgrService.getMemberPopupList(member);

		//실행결과 로그 생성
		this.resultLog(member);
				
		// View 설정
		model.addAttribute("result", objRtn);
		
		model.addAttribute("schKind", request.getParameter("schKind")); // 회원구분 파라메타
		model.addAttribute("pKind", member.getKind()); // 회원구분 파라메타
		model.addAttribute("pOutDataForm", request.getParameter("outDataForm")); // 전달받을 데이터 형태 파라메타
		model.addAttribute("pType", request.getParameter("type")); // 전달받을 갯수타입 파라메타
		model.addAttribute("pParentInputId", request.getParameter("parentInputId")); // 전달받을 부모출력태그Id
		model.addAttribute("pParentInputName", request.getParameter("parentInputName")); // 전달받을 부모출력태그Name
				
		member.setJsp("common/popup/listMemberPopup");
		member.setViewTitle("회원정보검색"); // 화면 title 세팅
		return new ModelAndView("ips.layoutPopup", "obj", member);
	}
	
	@RequestMapping(value="/i-portal/loginForm")
	public ModelAndView loginForm(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, Model model) throws Exception {
		
		//IP허용여부체크
		/*String ip = request.getHeader("X-Forwarded-For");
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("Proxy-Client-IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("WL-Proxy-Client-IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("HTTP_CLIENT_IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("X-Real-IP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getHeader("X-RealIP"); 
		 } 
		 if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		     ip = request.getRemoteAddr(); 
		 }
		 
		defaultDomain.setInDMLIp(ip);
		String ipAllYnCheck = ipManagementMgrService.selectIpAllYnCheck(defaultDomain);
		if(ipAllYnCheck.equals("N")){
    		ModelAndView mav = new ModelAndView("ip.block");
    		return mav;
    	}*/
				
		String url =request.getHeader("referer");

		//이전페이지 저장
		model.addAttribute("rtnUrl", url);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ips/common/loginForm");
		return mav;
	}
	
	@RequestMapping(value="/mgr/login")
	public @ResponseBody Object login(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String strRtnUrl = "/i-portal";
		
 		User user = new User();
		String password = request.getParameter("userPwd");
		user.setUserId(request.getParameter("userId"));
		
		MemberInfo memberInfo = new MemberInfo();
		
		memberInfo.setMyId(user.getUserId());
		
		//String userKind = memberInfoService.getUserKind(memberInfo);
		
		//logger.info("user.getUserId()//"+user.getUserId()+"//////////////////userKind//"+userKind);
		
		//비밀번호 암호화 
		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
		user.setPassword(encoder.encodePassword(password, null));
		
		/*if("K".equals(userKind)){
			ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
			user.setPassword(encoder.encodePassword(password, null));
		}else{
			ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
			encoder.setEncodeHashAsBase64(true);
			user.setPassword(encoder.encodePassword(password, null));
		}*/
		
		Object[] objRtn = commonService.getLogin(user);
		//List<?> rtnList = (List<?>)objRtn[2];
		User scUser = (User)objRtn[2];
		
		if(objRtn[0].toString().equals("SUCCESS")){
			// 세션 생성
			SCookie sc = new SCookie(request, response, 
									scUser.getUserId(), scUser.getkName(), 
									scUser.getKind(), scUser.getKindName(),
									scUser.getCorpRegNo()
									);
			sc.setTotalAuth(scUser.getTotalAuth());
			sc.setCookies();
			request.getSession().setAttribute("ADMUSER", sc);
			request.getSession().setAttribute("USER", null); // 사용자 세션 제거
			//request.getSession().setAttribute("USER", sc); // 사용자 세션 제거
			
		}else if(objRtn[0].toString().equals("FAILURE")){
			strRtnUrl = request.getHeader("referer");
			user.setOutNotice(objRtn[1].toString());
			this.setMessage(request, user);
		}
		
		//logger.info(">>" + request.getContextPath().concat(strRtnUrl));
		//logger.info(">>" + objRtn[0].toString());
		RedirectView rv = new RedirectView(request.getContextPath().concat(strRtnUrl));
		return new ModelAndView(rv);

	}

	@RequestMapping(value="/mgr/logout")
	public @ResponseBody Object logout(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		request.getSession().setAttribute("ADMUSER", null);
		request.getSession().setAttribute("USER", null);
		
		RedirectView rv = new RedirectView(request.getContextPath().concat("/i-portal"));
		return new ModelAndView(rv);
		
	}
	
	/*****************************************************************
	* 나모 파일 업로드 처리
	* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
	* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
	* @author 플랜아이 
	* @since  2015. 12. 11. 
	* @version 1.0
	* <pre>
	* 수정내용 : 
	*  수정일				수정자         	수정내용
	* ------------------------------------------------------
	* 2015. 12. 11.		mcahn		최초 생성
	* </pre>
	 * @throws IOException 
	*******************************************************************/
	// 파일등록
	@RequestMapping(method=RequestMethod.POST, value="/fileUpload")
	@ResponseBody
	public Object fileUpload(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("fileUpload start !!! ");	
			logger.debug("uploadDir : " + uploadDir);
		}
		
		// 파일이 저장될 서버측 전체경로
		String saveDir = "";
		String strFileGubun = request.getParameter("fileGubun");
		String strMenuId = request.getParameter("menuId");
		Files uploadFiles = new Files();
		FileUpload fileUpload = new FileUpload(request, response);
				
		try {
			saveDir = uploadDir + File.separator + strFileGubun + File.separator + strMenuId;
			
			// autoMakeDirs를 true로 설정하면 파일 저장 및 이동시 파일생성에 필요한 상위 디렉토리를 모두 생성합니다.
			fileUpload.setAutoMakeDirs(true);
			
			String saveDirPath = saveDir + File.separator;
			
			// saveDirPath에 지정한 경로로 파일 업로드를 시작합니다.  
			fileUpload.startUpload(saveDirPath); 	
			
			/**
			* 입력한 name을 키로 갖는 마지막 FileItem 객체를 리턴합니다.
			* "files"는 UploadForm.jsp에서 입력한 값입니다. <input type="file" name="files"> 
			*/
			FileItem fileItem = fileUpload.getFileItem("files");
			
			if(fileItem != null) { 
				String origFname = fileItem.getFileName();
				
				//파일업로드 보안 취약점 보강
				String [] ExtFilters = {"jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
				String originalFileName = "";
				String strExt = "";
				
				if(origFname != null){
					
					originalFileName = origFname.split("\\.")[0];
					strExt = origFname.substring(origFname.lastIndexOf(".")+1);
					
					// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
					for (int j = 0; j < ExtFilters.length; j++) {
						if(strExt.equalsIgnoreCase(ExtFilters[j])){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("/") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("\\") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf(".") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}
					}
				}
				
				// 저장 파일명을 타임스탬프+확장자 형식으로 변경
				if (fileItem.getFileName() != null)
				{
					int ext_pos = fileItem.getFileName().lastIndexOf(".");
					String ext = fileItem.getFileName().substring(ext_pos);
					Date time = new Date();
					
					fileItem.setFileName(time.getTime()+ext);
				}
				
				// saveDirPath 경로에 원본 파일명으로 저장(이동)합니다. 동일한 파일명이 존재할 경우 다른 이름으로 저장됩니다.
				fileItem.save(saveDirPath); 	
							
				// FileItem 객체로 아래와 같은 정보를 가져올 수 있습니다. 			
				uploadFiles.setUserFileName(origFname);
				uploadFiles.setSystemFileName(fileItem.getLastSavedFileName());
				uploadFiles.setFilePath(fileItem.getLastSavedDirPath().replaceAll("\\\\",  "/"));
				uploadFiles.setFileExtension(fileItem.getFileExtension());
				uploadFiles.setFileSize(Long.toString(fileItem.getFileSize()));
			}
		}
		catch(CrossUploaderException ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		}
		catch(Exception ex) { 
			// 업로드 외 로직에서 예외 발생시 업로드 중인 모든 파일을 삭제합니다. 
			fileUpload.deleteUploadedFiles(); 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		} 
		finally { 
			fileUpload.clear(); 
		}
		
		return uploadFiles;
	}
	
	/*****************************************************************
	* 나모 파일 업로드 처리
	* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
	* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
	* @author 플랜아이 
	* @since  2015. 12. 11. 
	* @version 1.0
	* <pre>
	* 수정내용 : 
	*  수정일				수정자         	수정내용
	* ------------------------------------------------------
	* 2015. 12. 11.		mcahn		최초 생성
	* </pre>
	 * @throws IOException 
	*******************************************************************/
	// 파일등록
	@RequestMapping(method=RequestMethod.POST, value="/multifileUpload")
	@ResponseBody
	public Object multifileUpload(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("fileUpload start !!! ");	
			logger.debug("uploadDir : " + uploadDir);
		}
		
		// 파일이 저장될 서버측 전체경로
		String saveDir = "";
		String strFileGubun = request.getParameter("fileGubun");
		String strMenuId = request.getParameter("menuId");
		Files uploadFiles = new Files();
		FileUpload fileUpload = new FileUpload(request, response);	
		
		try {
			saveDir = uploadDir + File.separator + strFileGubun + File.separator + strMenuId;
			
			// autoMakeDirs를 true로 설정하면 파일 저장 및 이동시 파일생성에 필요한 상위 디렉토리를 모두 생성합니다.
			fileUpload.setAutoMakeDirs(true);
			
			String saveDirPath = saveDir + File.separator;
			
			// saveDirPath에 지정한 경로로 파일 업로드를 시작합니다.  
			fileUpload.startUpload(saveDirPath); 	

			/**
			* 입력한 name을 키로 갖는 마지막 FileItem 객체를 리턴합니다.
			* "files"는 UploadForm.jsp에서 입력한 값입니다. <input type="file" name="files"> 
			*/
			FileItem[] fileItem = fileUpload.getFileItems("files");
			
			if(fileItem != null) { 
				for(int i=0; i<fileItem.length; i++){
				String origFname = fileItem[i].getFileName();
				
				//파일업로드 보안 취약점 보강
				String [] ExtFilters = {"jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
				String originalFileName = "";
				String strExt = "";
				
				if(origFname != null){
					
					originalFileName = origFname.split("\\.")[0];
					strExt = origFname.substring(origFname.lastIndexOf(".")+1);
					
					// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
					for (int j = 0; j < ExtFilters.length; j++) {
						if(strExt.equalsIgnoreCase(ExtFilters[j])){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("/") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("\\") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf(".") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}
					}
				}
				
				// 저장 파일명을 타임스탬프+확장자 형식으로 변경
				if (fileItem[i].getFileName() != null)
				{
					int ext_pos = fileItem[i].getFileName().lastIndexOf(".");
					String ext = fileItem[i].getFileName().substring(ext_pos);
					Date time = new Date();
					
					fileItem[i].setFileName(time.getTime()+ext);
				}
				
				// saveDirPath 경로에 원본 파일명으로 저장(이동)합니다. 동일한 파일명이 존재할 경우 다른 이름으로 저장됩니다.
				fileItem[i].save(saveDirPath); 				
				// FileItem 객체로 아래와 같은 정보를 가져올 수 있습니다. 			
				uploadFiles.setUserFileName(origFname);
				uploadFiles.setSystemFileName(fileItem[i].getLastSavedFileName());
				uploadFiles.setFilePath(fileItem[i].getLastSavedDirPath().replaceAll("\\\\",  "/"));
				uploadFiles.setFileExtension(fileItem[i].getFileExtension());
				uploadFiles.setFileSize(Long.toString(fileItem[i].getFileSize()));		
				}
			}
		}
		catch(CrossUploaderException ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		}
		catch(Exception ex) { 
			// 업로드 외 로직에서 예외 발생시 업로드 중인 모든 파일을 삭제합니다. 
			fileUpload.deleteUploadedFiles(); 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		} 
		finally { 
			fileUpload.clear();
		}
		
		return uploadFiles;
	}
	
	/*****************************************************************
	* 나모 크로스업로더 파일 업로드
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/namoFileUpload")
	public ModelAndView namoFileUpload(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("fileUpload start !!! ");	
			logger.debug("uploadDir : " + uploadDir);
		}
		
		// 파일이 저장될 서버측 전체경로
		String saveDir = "";
		String strFileGubun = defaultDomain.getFileGubun();
		String strMenuId = defaultDomain.getFileMenuId();

		saveDir = uploadDir + File.separator + strFileGubun + File.separator + strMenuId;
		
		PrintWriter writer = response.getWriter();
		FileUpload fileUpload = new FileUpload(request, response);
		
		try {	
			fileUpload.setAutoMakeDirs(true);
			String saveDirPath = saveDir + File.separator;
			
			// saveDirPath에 지정한 경로로 파일 업로드를 시작  
			fileUpload.startUpload(saveDirPath); 	
			
			FileItem fileItem = fileUpload.getFileItem("CU_FILE");
			
			if(fileItem != null) {
				String origFname = fileItem.getFileName();
				
				//파일업로드 보안 취약점 보강
				String [] ExtFilters = {"jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
				String originalFileName = "";
				String strExt = "";
				
				if(origFname != null){
					
					originalFileName = origFname.split("\\.")[0];
					strExt = origFname.substring(origFname.lastIndexOf(".")+1);
					
					// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
					for (int j = 0; j < ExtFilters.length; j++) {
						if(strExt.equalsIgnoreCase(ExtFilters[j])){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("/") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("\\") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf(".") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}
					}
				}
				
				// 저장 파일명을 타임스탬프+확장자 형식으로 변경
				if (fileItem.getFileName() != null){
					int ext_pos = fileItem.getFileName().lastIndexOf(".");
					String ext = fileItem.getFileName().substring(ext_pos);
					Date time = new Date();
					
					fileItem.setFileName(time.getTime()+ext);
				}
				
				fileItem.save(saveDirPath);
				
				logger.debug("fileName : "+fileItem.getFileName()); // 업로드 된 파일의 원본 파일 이름을 반환
				logger.debug("name : "+fileItem.getName()); // http 요청 파라미터의 name 값을 반환
				logger.debug("lastSavedDirPath : "+fileItem.getLastSavedDirPath()); // 업로드 된 파일이 저장된 최종 디렉토리 경로를 반환
				logger.debug("lastSavedFilePath : "+fileItem.getLastSavedFilePath()); // 업로드 된 파일이 저장된 최종 파일 경로를 반환
				logger.debug("lastSavedFileName : "+fileItem.getLastSavedFileName()); // 업로드 된 파일이 저장된 최종 파일 이름을 반환
				logger.debug("fileSize : "+fileItem.getFileSize()); // 업로드 된 파일의 크기를 반환
				logger.debug("fileNameWithoutFileExt", fileItem.getFileNameWithoutFileExt()); // 업로드 된 파일의 확장자를 제외한 파일 이름을 반환 
				logger.debug("fileExtension : "+fileItem.getFileExtension()); // 업로드 된 파일의 확장자를 반환
				logger.debug("contentType : "+fileItem.getContentType()); // 업로드 된 Content-Type을 반환
				logger.debug("isSaved", Boolean.toString(fileItem.isSaved())); // 저장된 파일인지의 여부를 반환
				logger.debug("emptyFile : "+fileItem.isEmptyFile()); // 빈 파일인지의 여부를 반환
				
				JSONObject jsonObject = new JSONObject();

				jsonObject.put("name", fileItem.getName()); 
				jsonObject.put("origfileName", origFname); 
				jsonObject.put("fileName", fileItem.getFileName()); 
				jsonObject.put("lastSavedDirectoryPath", fileItem.getLastSavedDirPath().replaceAll("\\\\", "/")); 
				jsonObject.put("lastSavedFilePath", fileItem.getLastSavedFilePath().replaceAll("\\\\", "/")); 
				jsonObject.put("lastSavedFileName", fileItem.getLastSavedFileName()); 
				jsonObject.put("fileSize", Long.toString(fileItem.getFileSize())); 
				jsonObject.put("fileNameWithoutFileExt", fileItem.getFileNameWithoutFileExt()); 
				jsonObject.put("fileExtension", fileItem.getFileExtension()); 
				jsonObject.put("contentType", fileItem.getContentType()); 
				jsonObject.put("isSaved", Boolean.toString(fileItem.isSaved())); 
				jsonObject.put("isEmptyFile", Boolean.toString(fileItem.isEmptyFile())); 

				StringWriter stringWriter = new StringWriter();
				jsonObject.writeJSONString(stringWriter);
				writer.println(jsonObject.toString());
				
				// 이미지썸네일생성
				if("jpg;jpeg;png;gif;bmp".indexOf(fileItem.getFileExtension().toLowerCase()) > -1){
					File image = new File(saveDirPath+fileItem.getFileName());
					File thumbnail = new File(saveDirPath+"thumbnails"+File.separator+fileItem.getFileName()); 
					if (image.exists()) { 
						thumbnail.getParentFile().mkdirs(); 
						Thumbnails.of(image).size(260, 195).outputFormat(fileItem.getFileExtension()).toFile(thumbnail); 
					}
				}
			}
		}
		catch(CrossUploaderException ex) { 
			//logger.info("", "", ex.getStackTrace());
			logger.info(ex.getMessage());
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		}
		catch(Exception ex) {
			//logger.info("", "", ex.getStackTrace());
			logger.info(ex.getMessage());
			// 업로드 외 로직에서 예외 발생시 업로드 중인 모든 파일을 삭제합니다. 
			fileUpload.deleteUploadedFiles(); 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		} 
		finally { 
			fileUpload.clear(); 
		}
		
		return null;
	}
	
	/*****************************************************************
	 * 나모 크로스업로더 파일 업로드Local
	 * @param site
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/namoFileUploadLocal")
	public ModelAndView namoFileUploadLocal(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
				
		// 파일이 저장될 서버측 전체경로
		String strFilePath = request.getParameter("filePath");
		FileUpload fileUpload = new FileUpload(request, response);
		PrintWriter writer = response.getWriter();
		
		try {	
			fileUpload.setAutoMakeDirs(true);
			String saveDirPath = strFilePath;
			
			// saveDirPath에 지정한 경로로 파일 업로드를 시작  
			fileUpload.startUpload(saveDirPath); 	
			
			FileItem fileItem = fileUpload.getFileItem("CU_FILE");
			
			if(fileItem != null) {
				String origFname = fileItem.getFileName();
				
				//파일업로드 보안 취약점 보강
				String [] ExtFilters = {"jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
				String originalFileName = "";
				String strExt = "";
				
				if(origFname != null){
					
					originalFileName = origFname.split("\\.")[0];
					strExt = origFname.substring(origFname.lastIndexOf(".")+1);
					
					// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
					for (int j = 0; j < ExtFilters.length; j++) {
						if(strExt.equalsIgnoreCase(ExtFilters[j])){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("/") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("\\") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf(".") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}
					}
				}
				
				fileItem.save(saveDirPath);// overwrite 기본은 false
				
				JSONObject jsonObject = new JSONObject();

				jsonObject.put("name", fileItem.getName()); 
				jsonObject.put("origfileName", origFname); 
				jsonObject.put("fileName", fileItem.getFileName()); 
				jsonObject.put("lastSavedDirectoryPath", fileItem.getLastSavedDirPath().replaceAll("\\\\", "/")); 
				jsonObject.put("lastSavedFilePath", fileItem.getLastSavedFilePath().replaceAll("\\\\", "/")); 
				jsonObject.put("lastSavedFileName", fileItem.getLastSavedFileName()); 
				jsonObject.put("fileSize", Long.toString(fileItem.getFileSize())); 
				jsonObject.put("fileNameWithoutFileExt", fileItem.getFileNameWithoutFileExt()); 
				jsonObject.put("fileExtension", fileItem.getFileExtension()); 
				jsonObject.put("contentType", fileItem.getContentType()); 
				jsonObject.put("isSaved", Boolean.toString(fileItem.isSaved())); 
				jsonObject.put("isEmptyFile", Boolean.toString(fileItem.isEmptyFile())); 

				StringWriter stringWriter = new StringWriter();
				jsonObject.writeJSONString(stringWriter);
				writer.println(jsonObject.toString());
			}
		}
		catch(CrossUploaderException ex) { 
			//logger.info("", "", ex.getStackTrace());
			logger.info(ex.getMessage());
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		}
		catch(Exception ex) {
			//logger.info("", "", ex.getStackTrace());
			logger.info(ex.getMessage());
			// 업로드 외 로직에서 예외 발생시 업로드 중인 모든 파일을 삭제합니다. 
			fileUpload.deleteUploadedFiles(); 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		} 
		finally { 
			fileUpload.clear(); 
		}
		
		return null;
	}
	
	/**
	 * 다음에디터 (또는 다른에디터에서도 사용할 수 있음) 에서
	 * 본문에 추가할 이미지를 파일첨부 외에 직접 첨부하는 경우
	 * 이미지를 지정된 장소에 업로드한다
	 * @return "/atchfile/atchfileList" 
	 * @exception Exception
	 */
	@RequestMapping(value="/daumFileUpload")
	public ModelAndView daumFileUpload(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		if(logger.isDebugEnabled()){
			logger.debug("fileUpload start !!! ");	
			logger.debug("uploadDir : " + uploadDir);
		}
		
		// 파일이 저장될 서버측 전체경로
		String saveDir = "";
		FileUpload fileUpload = new FileUpload(request, response);
				
		try {
			saveDir = request.getSession().getServletContext().getRealPath("/resources/component/daumeditor-7.4.27/images");
			
			// autoMakeDirs를 true로 설정하면 파일 저장 및 이동시 파일생성에 필요한 상위 디렉토리를 모두 생성합니다.
			fileUpload.setAutoMakeDirs(true);
			
			String saveDirPath = saveDir + File.separator + "upload" + File.separator;
			
			// saveDirPath에 지정한 경로로 파일 업로드를 시작합니다.  
			fileUpload.startUpload(saveDirPath); 	
			
			/**
			* 입력한 name을 키로 갖는 마지막 FileItem 객체를 리턴합니다.
			* "files"는 UploadForm.jsp에서 입력한 값입니다. <input type="file" name="files"> 
			*/
			FileItem fileItem = fileUpload.getFileItem("file_upload");
			
			if(fileItem != null) { 
				String origFname = fileItem.getFileName();
				
				//파일업로드 보안 취약점 보강
				String [] ExtFilters = {"jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
				String originalFileName = "";
				String strExt = "";
				
				if(origFname != null){
					
					originalFileName = origFname.split("\\.")[0];
					strExt = origFname.substring(origFname.lastIndexOf(".")+1);
					
					// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
					for (int j = 0; j < ExtFilters.length; j++) {
						if(strExt.equalsIgnoreCase(ExtFilters[j])){
							
							logger.info("/////////////////FileUpload///////////////////////ExtFilters check in!!!!!!!!!!");
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("/") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf("\\") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}else if(originalFileName.indexOf(".") > -1){
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
							PrintWriter out = response.getWriter();
							
							out.println("<html>");
							out.println("<head><title>error page</title></head>");
							out.println("<script type='text/javascript'>");
							out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
							out.println("history.back(-1);");
							out.println("</script>");
							out.println("</html>");
							
							return null;
							
						}
					}
				}
				
				// 저장 파일명을 타임스탬프+확장자 형식으로 변경
				if (fileItem.getFileName() != null)
				{
					int ext_pos = fileItem.getFileName().lastIndexOf(".");
					String ext = fileItem.getFileName().substring(ext_pos);
					Date time = new Date();
					
					fileItem.setFileName(time.getTime()+ext);
				}
				
				// saveDirPath 경로에 원본 파일명으로 저장(이동)합니다. 동일한 파일명이 존재할 경우 다른 이름으로 저장됩니다.
				fileItem.save(saveDirPath); 	
							
				String fullpath = request.getRequestURL().indexOf("https://") < 0 ? "http://" : "https://";
	    		fullpath += request.getServerName();
	    		fullpath += request.getServerPort() == 80 || request.getServerPort() == 443 ? "" : ":" + request.getServerPort();
	    		fullpath += request.getContextPath();
	    		fullpath += "/resources/component/daumeditor-7.4.27/images/upload/";
	    		
				// FileItem 객체로 아래와 같은 정보를 가져올 수 있습니다. 				
				model.addAttribute("filePath", fullpath + fileItem.getLastSavedFileName());
	    		model.addAttribute("fileName", fileItem.getLastSavedFileName());
	    		model.addAttribute("fileSize", fileItem.getFileSize());
			}
		}
		catch(CrossUploaderException ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		}
		catch(Exception ex) { 
			// 업로드 외 로직에서 예외 발생시 업로드 중인 모든 파일을 삭제합니다. 
			fileUpload.deleteUploadedFiles(); 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		} 
		finally {
			fileUpload.clear();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("common/editorcallback/file_uploader");
		return mav;
	}
	
	@RequestMapping(value="/uploadifyFileUpload")
	@ResponseBody
	public Object uploadifyFileUpload(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("fileUpload start !!! ");	
			logger.debug("uploadDir : " + uploadDir);
		}
		
		// 파일이 저장될 서버측 전체경로
		String saveDir = "";
		String strFileGubun = defaultDomain.getFileGubun();
		String strMenuId = defaultDomain.getFileMenuId();
		Files uploadFiles = new Files();
		saveDir = uploadDir + File.separator + strFileGubun + File.separator + strMenuId;
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart){
			try{
				int sizeThreshold = 1024 * 1024;	// 메모리에 읽어들일 버퍼의 크기이다. 전체 파일 크기가 아니다.
				File fileUpload = new File(saveDir);  
				
				if(! fileUpload.exists())
					fileUpload.mkdirs();
				
				DiskFileItemFactory factory = new DiskFileItemFactory(sizeThreshold, fileUpload);  
		        ServletFileUpload upload = new ServletFileUpload(factory);  
		        
		        upload.setSizeMax(2 * 1024 * 1024 * 1024);  
		        upload.setHeaderEncoding("UTF-8");  
		        List items = upload.parseRequest(request);  
		        Iterator iter = items.iterator();  
		        
		        while(iter.hasNext()){
		        	org.apache.commons.fileupload.FileItem item =  (org.apache.commons.fileupload.FileItem)iter.next();

		        	if(!item.isFormField()) {
		                String orgFileName = item.getName();  
		                long sizeInBytes = item.getSize();  
		                
		                //파일업로드 보안 취약점 보강
						String [] ExtFilters = {"jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
						String originalFileName = "";
						String strExt = "";
						
						if(orgFileName != null){
							
							originalFileName = orgFileName.split("\\.")[0];
							strExt = orgFileName.substring(orgFileName.lastIndexOf(".")+1);
							
							// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
							for (int j = 0; j < ExtFilters.length; j++) {
								if(strExt.equalsIgnoreCase(ExtFilters[j])){
									response.setCharacterEncoding("utf-8");
									response.setContentType("text/html; charset=utf-8");
									PrintWriter out = response.getWriter();
									
									out.println("<html>");
									out.println("<head><title>error page</title></head>");
									out.println("<script type='text/javascript'>");
									out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
									out.println("history.back(-1);");
									out.println("</script>");
									out.println("</html>");
									
									return null;
									
								}else if(originalFileName.indexOf("/") > -1){
									response.setCharacterEncoding("utf-8");
									response.setContentType("text/html; charset=utf-8");
									PrintWriter out = response.getWriter();
									
									out.println("<html>");
									out.println("<head><title>error page</title></head>");
									out.println("<script type='text/javascript'>");
									out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
									out.println("history.back(-1);");
									out.println("</script>");
									out.println("</html>");
									
									return null;
									
								}else if(originalFileName.indexOf("\\") > -1){
									response.setCharacterEncoding("utf-8");
									response.setContentType("text/html; charset=utf-8");
									PrintWriter out = response.getWriter();
									
									out.println("<html>");
									out.println("<head><title>error page</title></head>");
									out.println("<script type='text/javascript'>");
									out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
									out.println("history.back(-1);");
									out.println("</script>");
									out.println("</html>");
									
									return null;
									
								}else if(originalFileName.indexOf(".") > -1){
									response.setCharacterEncoding("utf-8");
									response.setContentType("text/html; charset=utf-8");
									PrintWriter out = response.getWriter();
									
									out.println("<html>");
									out.println("<head><title>error page</title></head>");
									out.println("<script type='text/javascript'>");
									out.println("alert('제한된 확장자 파일 또는 잘못된 경로값이 포함되어 있습니다.');");
									out.println("history.back(-1);");
									out.println("</script>");
									out.println("</html>");
									
									return null;
								}
							}
						}
		                
		                // 저장 파일명을 타임스탬프+확장자 형식으로 변경
		                String saveFileName = "";
						if (orgFileName != null){
							int ext_pos = orgFileName.lastIndexOf(".");
							String ext = orgFileName.substring(ext_pos);
							Date time = new Date();
							saveFileName = time.getTime()+ext;
						}
						
						String uploadFilePath = saveDir+File.separator+saveFileName;
						File uploadFile = new File(uploadFilePath);
						
		                //logger.info("uploadFile : "+uploadFilePath);
		                item.write(uploadFile);
		                
		                // 이미지썸네일생성
						if("jpg;jpeg;png;gif;bmp".indexOf(strExt.toLowerCase()) > -1){
							File image = new File(uploadFilePath);
							File thumbnail = new File(saveDir+File.separator+"thumbnails"+File.separator+saveFileName); 
							if (image.exists()) { 
								thumbnail.getParentFile().mkdirs(); 
								Thumbnails.of(image).size(260, 195).outputFormat(strExt).toFile(thumbnail); 
							}
						}

						//파일정보
						uploadFiles.setFilePath((saveDir+File.separator).replaceAll("\\\\",  "/"));
						uploadFiles.setSystemFileName(saveFileName);
						uploadFiles.setUserFileName(orgFileName);
						uploadFiles.setFileExtension(strExt);
						uploadFiles.setFileSize(Long.toString(sizeInBytes));
		        	}
		        }  
				
			}catch (FileUploadException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
	        	System.out.println("처리 중 오류가 발생했습니다.");
			}catch (Exception e){
				//e.printStackTrace();
	        	System.out.println("처리 중 오류가 발생했습니다.");
			}
		}
		
		return uploadFiles;
	}
	
	/*****************************************************************
	 * multiPartFileUpload 파일 업로드 처리
	 * @param 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	// 파일등록
	@ResponseBody
	@RequestMapping(method=RequestMethod.POST, value="/multiPartFileUpload")
    public Object uploadFormfiles(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		Files uploadFiles = new Files();
		String saveDir = "";
		
		String strMenuId = request.getParameter("menuId");
		String strFrmFileName = request.getParameter("frmFilename");
		String strUpdateFileName = request.getParameter("updateFilename");
		String strFileGubun = request.getParameter("fileGubun");
		String strFileType = request.getParameter("fileType");
		
		int nCnt = 0;
		String strSplit = "";
		StringBuffer sbUserFileName = new StringBuffer();
		StringBuffer sbSystemFileName = new StringBuffer();
		StringBuffer sbFilePath = new StringBuffer();
		StringBuffer sbFileExtension = new StringBuffer();
		StringBuffer sbFileSize = new StringBuffer();
		List<Files> uploadFileList = new ArrayList();
		
		if(isMultipart) 
		{
			try{
				MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
				List<MultipartFile> files = multipartRequest.getFiles(strFrmFileName);
				saveDir = uploadDir + File.separator + strFileGubun + File.separator + strMenuId;
				String saveDirPath = saveDir + File.separator;
				
				for(int i = 0; i < files.size(); i++){
					MultipartFile file = files.get(i);
					Files domainFiles = new Files();
					if(nCnt > 0) strSplit = "#";
					nCnt++;
					
					if(file.getSize() == 0){
						nCnt--;
						continue;
					}

					String orgFileName = file.getOriginalFilename();
					String sysFileName = "";  
					long sizeInBytes = file.getSize();
					
					int ext_pos = 0;
					String file_ext = "";
					ext_pos = orgFileName.lastIndexOf(".");
					// 파일 확장자 구하기
					file_ext = orgFileName.substring(ext_pos);
					Date time = new Date();
					sysFileName = time.getTime()+file_ext;
					
					// 허용된 파일 이외에는 첨부할 수 없음
					String strExt = orgFileName.substring(orgFileName.lastIndexOf(".")+1);
					
					if("jsp|java|sh|bat|php|asp|bin|cgi|dll|zip|rar|ace|cab|tar|zipx|7z|lzh|alz|agg|xml".indexOf(strExt) > -1){
						throw new Exception("첨부할 수 없는 파일 형식입니다.");
					}
					
					sbUserFileName.append(strSplit).append(orgFileName);					// 파일명
					sbSystemFileName.append(strSplit).append(sysFileName);					// 파일시스템명
					sbFilePath.append(strSplit).append(saveDirPath);						// 파일경로
					sbFileExtension.append(strSplit).append(strExt);						// 파일확장자
					sbFileSize.append(strSplit).append(new Long(sizeInBytes).toString());	// 파일사이즈
										
					domainFiles.setUserFileName(orgFileName);
					domainFiles.setSystemFileName(sysFileName);
					domainFiles.setFilePath(saveDirPath);
					domainFiles.setFileExtension(strExt);
					domainFiles.setFileSize(new Long(sizeInBytes).toString());
					uploadFileList.add(domainFiles);
					
					File dir = new File(saveDirPath);
					if(! dir.exists()){
						dir.mkdirs();
					}
	                
					String uploadPath = saveDirPath + sysFileName;  
					File uploadFile = new File(uploadPath);
					file.transferTo(uploadFile);  
					
					// 이미지썸네일생성
					if("jpg;jpeg;png;gif;bmp".indexOf(strExt) > -1){
						File image = new File(saveDirPath+sysFileName);
						File thumbnail = new File(saveDirPath+"thumbnails"+File.separator+sysFileName); 
						if (image.exists()) { 
							thumbnail.getParentFile().mkdirs(); 
							Thumbnails.of(image).size(260, 195).outputFormat(strExt).toFile(thumbnail); 
						}
					}
				}
				
				// 기존 저장 파일 추가
				String[] fileInfoArray = request.getParameterValues(strUpdateFileName);
				if(fileInfoArray != null && fileInfoArray.length > 0){
					for(int i=0; i<fileInfoArray.length; i++){
						Files domainFiles = new Files();
						if(fileInfoArray[i] != null){
							if(nCnt > 0) strSplit = "#";
							nCnt++;
							String[] fileInfo = fileInfoArray[i].split("@@"); 		// 저장된파일정보
							
							sbUserFileName.append(strSplit).append(fileInfo[0]); 	// 파일명
							sbSystemFileName.append(strSplit).append(fileInfo[1]); 	// 파일시스템명
							sbFileSize.append(strSplit).append(fileInfo[2]); 		// 파일사이즈
							sbFilePath.append(strSplit).append(fileInfo[3]); 		// 파일경로
							sbFileExtension.append(strSplit).append(fileInfo[4]); 	// 파일확장자
							
							domainFiles.setUserFileName(fileInfo[0].toString());
							domainFiles.setSystemFileName(fileInfo[1].toString());
							domainFiles.setFileSize(fileInfo[2].toString());
							domainFiles.setFilePath(fileInfo[3].toString());
							domainFiles.setFileExtension(fileInfo[4].toString());
							uploadFileList.add(domainFiles);
						}
					}
				}
				
				if(strFileType.equals("multi")){
					uploadFiles.setFileCount(nCnt+"");
					uploadFiles.setUserFileName(sbUserFileName.toString());
					uploadFiles.setSystemFileName(sbSystemFileName.toString());
					uploadFiles.setFilePath(sbFilePath.toString());
					uploadFiles.setFileExtension(sbFileExtension.toString());
					uploadFiles.setFileSize(sbFileSize.toString());
					uploadFiles.setFileList(uploadFileList);
				}else if(strFileType.equals("single")){
					uploadFiles.setFileCount((nCnt >= 1 ? 1:nCnt)+"");
					uploadFiles.setUserFileName(sbUserFileName.toString().split("#")[0]);
					uploadFiles.setSystemFileName(sbSystemFileName.toString().split("#")[0]);
					uploadFiles.setFilePath(sbFilePath.toString().split("#")[0]);
					uploadFiles.setFileExtension(sbFileExtension.toString().split("#")[0]);
					uploadFiles.setFileSize(sbFileSize.toString().split("#")[0]);
					uploadFiles.setFileList((List<Files>) uploadFileList.get(0));
				}
								
			}catch (FileUploadException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}catch (IOException e){
				//e.printStackTrace();
			}catch (Exception e){
				//e.printStackTrace();
			}
		}
		return uploadFiles;
	}
	
	@RequestMapping("/fileDownload")
	public ModelAndView download(@ModelAttribute Files files, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		if(StringUtil.isNotBlank(files.getTitleId())){
			int chkCnt = 0;
			
			HashMap hm = new HashMap();
			
			hm.put("TITLEID", files.getTitleId());
			
			SCookie admSc = (SCookie)request.getSession().getAttribute("ADMUSER");

			String menuId = commonService.getChkMenuId(hm);
			
			if (admSc == null) {
				SCookie usrSc = (SCookie)request.getSession().getAttribute("USER");
				
				if (usrSc == null) {
					hm.put("USERID", "guest");
				}else{
					hm.put("USERID", usrSc.getUserId());
				}
				
				chkCnt = (Integer)commonService.getChkGroupRole(hm);
				
				if(chkCnt <= 0){
					
					response.setCharacterEncoding("utf-8");
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					
					out.println("<html>");
					out.println("<script type='text/javascript'>");
					out.println("alert('파일 다운로드 권한이 없습니다.');");
					out.println("history.back(-1);");
					out.println("</script>");
					
					return null;
				}
			}
		}
		
		Files contentsFile = new Files();
		
		// Parameter 설정
		files.setInParam(request);
		
		// 파일조회
		if(StringUtil.isNotBlank(files.getTitleId()) && StringUtil.isNotBlank(files.getFileId())){
			//logger.info("boardFiles");
			contentsFile = (Files)commonService.selectFiles(files);
			
		}else if(StringUtil.isNotBlank(files.getTitleId()) && !StringUtil.isNotBlank(files.getFileId())){
			//logger.info("boardFiles");
			contentsFile = (Files)commonService.selectContentsFile(files);
		}else{
			contentsFile.setUserFileName(files.getUserFileName());
			contentsFile.setSystemFileName(StringUtil.paramUnscript(StringUtil.nullCheck(files.getSystemFileName())));

			//파일다운로드 취약점 : 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
			boolean check1 = fileDownloadCheck(files.getMenuId());
			
			if(!check1){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
			boolean check2 = fileDownloadCheck(files.getFileGubun());
			
			if(!check2){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
			
			String strDir = "";
			strDir = uploadDir + File.separator + StringUtil.paramUnscript(StringUtil.nullCheck(files.getFileGubun())) + File.separator + StringUtil.paramUnscript(StringUtil.nullCheck(files.getMenuId())) + File.separator;
			contentsFile.setFilePath(strDir);
			
		}

		Map<String, Object> mapModel = new HashMap<String, Object>();
		
		if(contentsFile != null) {
			
			//파일다운로드 취약점 : 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
			boolean check1 = fileDownloadCheck(contentsFile.getSystemFileName().toString());
			
			if(!check1){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
			boolean check2 =  fileDownloadCheck(contentsFile.getUserFileName().toString());

			if(!check2){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
						
			String strSystem = contentsFile.getSystemFileName(); 

			mapModel.put("downloadFileName", contentsFile.getUserFileName());
			mapModel.put("downloadFile", contentsFile.getFilePath() + strSystem);
			
			model.addAttribute("downloadFileName", contentsFile.getUserFileName());
			model.addAttribute("downloadFile", contentsFile.getFilePath() + contentsFile.getSystemFileName());
		}
		

		if(StringUtil.isNotBlank(files.getFileDownType()) && files.getFileDownType().equals("C")){
			files.setUserFileName(contentsFile.getUserFileName()); // 파일명
			files.setSystemFileName(contentsFile.getSystemFileName()); // 파일시스템명
			files.setInExecMenuId(request.getParameter("paramMenuId")); // 화면메뉴ID
			
			commonService.fileHitLog(files); // 파일다운COUNT LOG
		}
		
		FileDownloadView fileView = new FileDownloadView();
		fileView.render(mapModel, request, response);
		
		return null;
	}
	
	@RequestMapping("/fileDownloadThumbnails")
	public ModelAndView downloadThumbnails(@ModelAttribute Files files, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		if(StringUtil.isNotBlank(files.getTitleId())){
			int chkCnt = 0;
			
			HashMap hm = new HashMap();
			
			hm.put("TITLEID", files.getTitleId());
			
			SCookie admSc = (SCookie)request.getSession().getAttribute("ADMUSER");

			String menuId = commonService.getChkMenuId(hm);
			
			if (admSc == null) {
				SCookie usrSc = (SCookie)request.getSession().getAttribute("USER");
				
				if (usrSc == null) {
					hm.put("USERID", "guest");
				}else{
					hm.put("USERID", usrSc.getUserId());
				}
				
				chkCnt = (Integer)commonService.getChkGroupRole(hm);
				
				if(chkCnt <= 0){
					
					response.setCharacterEncoding("utf-8");
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					
					out.println("<html>");
					out.println("<script type='text/javascript'>");
					out.println("alert('파일 다운로드 권한이 없습니다.');");
					out.println("history.back(-1);");
					out.println("</script>");
					
					return null;
				}
			}
		}
		
		Files contentsFile = new Files();
		
		// Parameter 설정
		files.setInParam(request);
		
		// 파일조회
		if(StringUtil.isNotBlank(files.getTitleId()) && StringUtil.isNotBlank(files.getFileId())){
			//logger.info("boardFiles");
			contentsFile = (Files)commonService.selectFiles(files);
			
		}else if(StringUtil.isNotBlank(files.getTitleId()) && !StringUtil.isNotBlank(files.getFileId())){
			//logger.info("boardFiles");
			contentsFile = (Files)commonService.selectContentsFile(files);
		}else{
			contentsFile.setUserFileName(files.getUserFileName());
			contentsFile.setSystemFileName(StringUtil.paramUnscript(StringUtil.nullCheck(files.getSystemFileName())));

			//파일다운로드 취약점 : 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
			boolean check1 = fileDownloadCheck(files.getMenuId());
			
			if(!check1){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
			boolean check2 = fileDownloadCheck(files.getFileGubun());
			
			if(!check2){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
			
			String strDir = "";
			strDir = uploadDir + File.separator + StringUtil.paramUnscript(StringUtil.nullCheck(files.getFileGubun())) + File.separator + StringUtil.paramUnscript(StringUtil.nullCheck(files.getMenuId())) + File.separator;
			contentsFile.setFilePath(strDir);
			
		}

		Map<String, Object> mapModel = new HashMap<String, Object>();
		
		if(contentsFile != null) {
			
			//파일다운로드 취약점 : 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
			boolean check1 = fileDownloadCheck(contentsFile.getSystemFileName().toString());
			
			if(!check1){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
			boolean check2 =  fileDownloadCheck(contentsFile.getUserFileName().toString());

			if(!check2){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html>");
				out.println("<head><title>error page</title></head>");
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 경로값이 포함되어 있습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
				out.println("</html>");
				
				return null;
			}
			
						
			String strSystem = contentsFile.getSystemFileName(); 

			mapModel.put("downloadFileName", contentsFile.getUserFileName());
			mapModel.put("downloadFile", contentsFile.getFilePath() + "thumbnails" + File.separator + strSystem);
			
			model.addAttribute("downloadFileName", contentsFile.getUserFileName());
			model.addAttribute("downloadFile", contentsFile.getFilePath() + "thumbnails" + File.separator + contentsFile.getSystemFileName());
		}
		

		if(StringUtil.isNotBlank(files.getFileDownType()) && files.getFileDownType().equals("C")){
			files.setUserFileName(contentsFile.getUserFileName()); // 파일명
			files.setSystemFileName(contentsFile.getSystemFileName()); // 파일시스템명
			files.setInExecMenuId(request.getParameter("paramMenuId")); // 화면메뉴ID
			
			commonService.fileHitLog(files); // 파일다운COUNT LOG
		}
		
		FileDownloadView fileView = new FileDownloadView();
		fileView.render(mapModel, request, response);
		
		return null;
	}
	
	@RequestMapping("/fileViewer")
	public @ResponseBody HashMap<String, String> fileViewer(@ModelAttribute Files files, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		if(StringUtil.isNotBlank(files.getTitleId())){
			int chkCnt = 0;
			
			HashMap hm = new HashMap();
			hm.put("TITLEID", files.getTitleId());
			
			SCookie admSc = (SCookie)request.getSession().getAttribute("ADMUSER");
			if (admSc == null) {
				SCookie usrSc = (SCookie)request.getSession().getAttribute("USER");
				if (usrSc == null) hm.put("USERID", "guest");
				else hm.put("USERID", usrSc.getUserId());
				
				chkCnt = (Integer)commonService.getChkGroupRole(hm);
				if(chkCnt <= 0){
					response.setCharacterEncoding("utf-8");
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					
					out.println("<html>");
					out.println("<script type='text/javascript'>");
					out.println("alert('파일 뷰어 권한이 없습니다.');");
					out.println("history.back(-1);");
					out.println("</script>");
					return null;
				}
			}
		}
		
		Files contentsFile = new Files();
		
		// Parameter 설정
		files.setInParam(request);
		
		// 파일조회
		if(StringUtil.isNotBlank(files.getTitleId()) && StringUtil.isNotBlank(files.getFileId())){
			contentsFile = (Files)commonService.selectFiles(files);
		}else if(StringUtil.isNotBlank(files.getTitleId()) && !StringUtil.isNotBlank(files.getFileId())){
			contentsFile = (Files)commonService.selectContentsFile(files);
		}else{
			contentsFile.setUserFileName(files.getUserFileName());
			contentsFile.setSystemFileName(StringUtil.paramUnscript(StringUtil.nullCheck(files.getSystemFileName())));			
			
			String strDir = "";
			strDir = uploadDir + File.separator + StringUtil.paramUnscript(StringUtil.nullCheck(files.getFileGubun())) + File.separator + StringUtil.paramUnscript(StringUtil.nullCheck(files.getMenuId())) + File.separator;
			contentsFile.setFilePath(strDir);
			
		}	
		
		// 파일뷰어를 통해 한번이상 변환한 파일인지 여부
		HashMap hm = new HashMap();
		hm.put("SYSTEMFILENAME", contentsFile.getSystemFileName());
		String fvInfo = commonService.fileViewerInfo(contentsFile.getSystemFileName().toString());
				
		HashMap<String, String> map = new HashMap();
		String filePath = contentsFile.getFilePath().replaceAll(uploadDir.replaceAll("\\\\",  "/"), "UploadFiles") + contentsFile.getSystemFileName();

		// 변환 여부에 따라 호출변경
		if(fvInfo != null){
			map.put("INFO", fvInfo); // 저장 된 변환 url 리턴
		}else{
			try {
				//URL 호출
				URL url = new URL("http://i-viewer.fitlab.ga/api/convert/");
				Map<String,Object> params = new LinkedHashMap<>(); // 파라미터 세팅
		        params.put("division", 2);
		        params.put("url", "http://220.83.255.200:19091/"+filePath); // 운영 적용시 도메인 적용
		 
		        StringBuilder postData = new StringBuilder();
		        for(Map.Entry<String,Object> param : params.entrySet()) {
		            if(postData.length() != 0) postData.append('&');
		            postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
		            postData.append('=');
		            postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
		        }
		        byte[] postDataBytes = postData.toString().getBytes("UTF-8");
		 
		        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		        conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
		        conn.setDoOutput(true);
		        conn.getOutputStream().write(postDataBytes); // POST 호출
		 
		        //한글 처리 및 데이터 읽기
				InputStreamReader isr = new InputStreamReader(conn.getInputStream(), "UTF-8");
				
				//JSON Parsing // 예외처리
				JSONObject items = (JSONObject) JSONValue.parseWithException(isr); 

				logger.info("items>>"+items);
				logger.info("items>>"+items.get("id"));
				logger.info("items>>"+items.get("name"));
				logger.info("items>>"+items.get("viewer"));
		        
				map.put("INFO", items.get("viewer").toString()); // 뷰어 url 리턴

				// 변환인 정보 저장
				HashMap hmInfo = new HashMap();
				hmInfo.put("SYSTEMFILENAME", contentsFile.getSystemFileName());
				hmInfo.put("ID", items.get("id"));
				hmInfo.put("VIEWER", items.get("viewer"));
				
				commonService.fileViewerLog(hmInfo); // 파일다운COUNT LOG
				
			}catch(Exception e) {
	            //e.printStackTrace();
	        }
		}
		
		return map;
	}
	
	@RequestMapping("/fileDownloadLocal")
	public ModelAndView downloadLocal(@ModelAttribute Files files, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		Map<String, Object> mapModel = new HashMap<String, Object>();
						
		String fileName = request.getParameter("fileName"); 
		String filePath = request.getParameter("filePath");

		mapModel.put("downloadFileName", fileName);
		mapModel.put("downloadFile", filePath);
		
		model.addAttribute("downloadFileName", fileName);
		model.addAttribute("downloadFile", filePath);

		FileDownloadView fileView = new FileDownloadView();
		fileView.render(mapModel, request, response);
		
		return null;
	}
	
	@RequestMapping(value="/mgr/searchCompanyPop")
	public ModelAndView searchCompanyPop(@ModelAttribute CompanyUser companyUser, HttpServletRequest request, Model model) throws Exception {

		model.addAttribute("result", commonService.searchCompanyPop(companyUser));
		
		companyUser.setJsp("common/popup/searchCompanyPop");
		companyUser.setViewTitle("기업회원 선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", companyUser);
	}

	@RequestMapping(value="/mgr/searchMemberPop")
	public ModelAndView searchMemberPop(@ModelAttribute CompanyUser companyUser, HttpServletRequest request, Model model) throws Exception {

		model.addAttribute("result", commonService.searchMemberPop(companyUser));
		
		companyUser.setJsp("common/popup/searchMemberPop");
		companyUser.setViewTitle("개인회원 선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", companyUser);
	}
	
	@RequestMapping(value="/mgr/excelUploadForm")
	public ModelAndView excelUploadForm(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, Model model) throws Exception {
		String url = request.getParameter("actionUrl");
		url = url.replace(",", "&");
		model.addAttribute("actionUrl", url);
		
		defaultDomain.setJsp("common/popup/excelUploadForm"+defaultDomain.getFileFormType());
		defaultDomain.setViewTitle("excel 업로드");
		return new ModelAndView("ips.layoutPopup", "obj", defaultDomain);
	}
		
	@RequestMapping(value="/mgr/editorPopup")
	public ModelAndView editorPopup(@ModelAttribute Editor editor, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		editor.setInParam(request);
		
		model.addAttribute("editorId", editor.getEditorId());
		
		//실행결과 로그 생성
		this.resultLog(editor);
		
		editor.setJsp("common/popup/editorPopup");
		editor.setViewTitle("Editor"); // 화면 title 세팅
		return new ModelAndView("ips.layoutPopup", "obj", editor);
	}
	
	@RequestMapping(value="/mgr/personInfoInsert")
	public @ResponseBody Object personInfoInsert(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		defaultDomain.setInParam(request);
		
		String inRECUserID =  request.getParameter("inRECUserID");
		String inRECDesc =  request.getParameter("inRECDesc");
		String inGubun =  request.getParameter("inGubun");
		String fileGubun =  request.getParameter("fileGubun");
		
		defaultDomain.setFileGubun(fileGubun);
		defaultDomain.setInRECUserID(inRECUserID);
		defaultDomain.setInExecMenuId(defaultDomain.getMenuId()); 
		defaultDomain.setInRECDesc(inRECDesc);
		defaultDomain.setInGubun(inGubun);
		commonService.insertUserInfoLog(defaultDomain);

		return null;
	}
	
	public boolean fileUploadCheck(String checkString, String gubun) throws IOException{
		
		String [] ExtFilters = {"exe","jsp", "java", "sh", "bat", "php", "asp", "bin", "cgi", "dll", "zip", "rar", "ace", "cab", "tar", "zipx", "7z", "lzh", "alz", "agg"};
		String originalFileName = "";
		String strExt = "";
	
		if(checkString != null){
			originalFileName = checkString.split("\\.")[0];
			strExt = checkString.substring(checkString.lastIndexOf(".")+1);
		}

			// 지정된 파일확장자 외의 파일, 또는 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
		for (int j = 0; j < ExtFilters.length; j++) {
			
			if(strExt.equalsIgnoreCase(ExtFilters[j])){
				return false;
			}
			
			if(originalFileName.indexOf("/") > -1 && "T".equals(gubun)){
				return false;
			}
			
			if(originalFileName.indexOf("\\") > -1 && "T".equals(gubun)){
				return false;
			}
			
			if(originalFileName.indexOf(".") > -1 && "T".equals(gubun)){
				return false;
			}
		}
	
		return true;
		
	}
	
	public boolean fileDownloadCheck(String checkString) throws IOException{
		
		String originalFileName = checkString; 
		
		if(originalFileName != null) {
		
		    // 사용자가 입력한 경로값이 있을 경우 웹쉘 공격으로 판단
			if(originalFileName.indexOf("/") > -1){
				return false;
			}else if(originalFileName.indexOf("\\") > -1){
				return false;
			}
		}
		return true;
	}

}

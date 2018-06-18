package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.ExcelDownload;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.PersonalInfo;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.PersonalInfoMgrService;

/*****************************************************************
* 개인정보처리방침관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2014. 9. 04. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2014. 9. 04.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/personalInfoMgr")
public class PersonalInfoMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(PersonalInfoMgrController.class);

	 /** 개인정보처리방침관리 서비스   */
	@Resource
	private PersonalInfoMgrService personalInfoMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*첨부파일관련*/
	@Resource
	private NamoCrossFile namoCrossFile;
	
	/*****************************************************************
	* list 개인정보처리방침 목록 조회
	* @param personalInfo
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute PersonalInfo personalInfo, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		personalInfo.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, personalInfo);

		// 검색 parameter 세팅
		personalInfo.setKName(request.getParameter("schKName"));
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		PersonalInfo objRtn = null;
		List<PersonalInfo> list = null;
		int totalCnt = 0 ;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		
			// 개인정보처리방침설정 조회
			list = (List<PersonalInfo>)personalInfoMgrService.getObjectList(personalInfo);
			totalCnt = personalInfoMgrService.getObjectListCnt(personalInfo);


			model.addAttribute("result", list);
			
			//페이징 정보
			model.addAttribute("rowCnt", personalInfo.getRowCnt());	//페이지 목록수
			model.addAttribute("totalCnt", totalCnt);

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(personalInfo.getMenuId()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		personalInfo.setJsp("site/personalInfoMgr/list");
		return new ModelAndView("ips.layout", "obj", personalInfo);
	}

	/*****************************************************************
	* Form 개인정보처리방침 추가/수정 폼
	* @param personalInfo
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute PersonalInfo personalInfo, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		personalInfo.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, personalInfo);
				
		PersonalInfo rtnPersonalInfo = new PersonalInfo();
			
		// id가 넘어 오지 않을 경우 신규 입력
		if(StringUtil.isNotBlank(personalInfo.getPersonalInfoId())){
					
			// 사이트 상세 조회
			PersonalInfo objRtn = (PersonalInfo)personalInfoMgrService.getObject(personalInfo);
			/*rtnPersonalInfo = (PersonalInfo)objRtn.getOutCursor();*/
			rtnPersonalInfo = objRtn;
						
			//실행결과 로기 생성
			//this.resultLog(personalInfo);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnPersonalInfo.setInBeforeData(rtnPersonalInfo.makeDataString());
			
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(personalInfo.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(personalInfo.getPageNum()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
		
		// View 설정
		model.addAttribute("rtnPersonalInfo", rtnPersonalInfo);					
				
		personalInfo.setJsp("site/personalInfoMgr/form");
		return new ModelAndView("ips.layout", "obj", personalInfo);
	}
	
	/*****************************************************************
	 * insert 개인정보처리방침 추가/수정
	 * @param personalInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute PersonalInfo personalInfo, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		personalInfo.setInParam(request);
		
		personalInfo.setInWorkName("개인정보처리방침관리");
		if(StringUtil.isNotBlank(personalInfo.getPersonalInfoId())){
			personalInfo.setInCondition("수정");
		}else{
			personalInfo.setInCondition("입력");
		}

		// 콘텐츠 설명 CLOB세팅
		personalInfo.setInCLOBData1(personalInfo.getKDesc());
		PersonalInfo objRtn = new PersonalInfo();
		try{

		
		// 변경후 데이타 저장(inAfterData)
		personalInfo.setInAfterData(personalInfo.makeDataString());
		
		//InDMLData :: SiteID|PersonalInfoID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|State
		//personalInfo.setInDMLData(personalInfo.makeDMLDataString());

		// 저장
		objRtn = (PersonalInfo)personalInfoMgrService.insertObject(personalInfo);

		//changLog
		personalInfo.setDmlType(personalInfo.getInCondition().equals("입력") ? "I" : personalInfo.getInCondition().equals("수정") ? "U" : "D");
		personalInfo.setDmlNotice("정상적으로 ("+personalInfo.getInWorkName()+")"+personalInfo.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(personalInfo);
	
		objRtn.setOutNotice("저장되었습니다.");
		}catch(Exception e){
			objRtn.setOutNotice("저장실패되었습니다.");
		}
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(personalInfo.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(personalInfo.getPageNum()) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/personalInfoMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 개인정보처리방침 삭제(데이터삭제)
	 * @param personalInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute PersonalInfo personalInfo, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		personalInfo.setInParam(request);		

		personalInfo.setInWorkName("개인정보처리방침관리");
		personalInfo.setInCondition("삭제");

		//InDMLData ::  SiteID|PersonalInfoID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|State
		personalInfo.setInDMLData(personalInfo.makeDMLDataString());

		// 저장
		personalInfoMgrService.deleteObject(personalInfo);
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);

		//실행결과 메세지처리 시
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(personalInfo.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(personalInfo.getPageNum()) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/personalInfoMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/excelDown")
	public void ghMarkExcelDown(@ModelAttribute PersonalInfo personalInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		personalInfo.setInParam(request);

		// 검색 parameter 세팅
		personalInfo.setKName(request.getParameter("schKName"));
		personalInfo.setExcelDownYn("Y");
		
		// 사이트 조회
		PersonalInfo objRtn = (PersonalInfo)personalInfoMgrService.getObjectList(personalInfo);

		//실행결과 로기 생성
		//this.resultLog(personalInfo);
		
		// View 설정
		List list = (List) objRtn.getOutCursor();

		String[] headerName = {"사이트명", "제목", "게시시작일", "게시종료일", "순서", "사용여부"};
		String[] columnName = {"SITE_NAME", "KNAME", "CSTARTTIME", "CENDTIME", "CSORT", "STATE_KANME"};
		String sheetName = "개인정보처리방침정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
}

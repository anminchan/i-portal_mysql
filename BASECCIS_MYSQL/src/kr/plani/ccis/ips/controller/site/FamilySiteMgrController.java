package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.ExcelDownload;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.FamilySite;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.FamilySiteMgrService;

/*****************************************************************
* 추천사이트관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2014. 9. 11. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2014. 9. 04.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/familySiteMgr")
public class FamilySiteMgrController extends BaseController {

	 /** 추천사이트관리 서비스   */
	@Resource
	private FamilySiteMgrService familySiteMgrService;
	
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 추천사이트 목록 조회
	* @param familySite
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute FamilySite familySite, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		familySite.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, familySite);

		// 검색 parameter 세팅
		familySite.setSiteId(request.getParameter("schSiteId"));
		familySite.setKName(request.getParameter("schKName"));
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		FamilySite objRtn = null;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		if(sc.getTotalAuth().equals("Y")){
			// 추천사이트 조회
			objRtn = (FamilySite)familySiteMgrService.getObjectList(familySite);

			//실행결과 로기 생성
			this.resultLog(familySite);
			
			// View 설정
			model.addAttribute("result", objRtn.getOutCursor());
			
			//페이징 정보
			model.addAttribute("rowCnt", familySite.getRowCnt());	//페이지 목록수
			model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
		}else{
			if(StringUtil.isNotBlank(familySite.getSiteId())){
				// 추천사이트 조회
				objRtn = (FamilySite)familySiteMgrService.getObjectList(familySite);

				//실행결과 로기 생성
				this.resultLog(familySite);
				
				// View 설정
				model.addAttribute("result", objRtn.getOutCursor());
				
				//페이징 정보
				model.addAttribute("rowCnt", familySite.getRowCnt());	//페이지 목록수
				model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
			}
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(familySite.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(familySite.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		familySite.setJsp("site/familySiteMgr/list");
		return new ModelAndView("ips.layout", "obj", familySite);
	}

	/*****************************************************************
	* Form 추천사이트 추가/수정 폼
	* @param familySite
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute FamilySite familySite, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		familySite.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, familySite);
				
		FamilySite rtnFamilySite = new FamilySite();
			
		//siteId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(familySite.getSiteLinkId())){
					
			// 추천사이트 상세 조회
			FamilySite objRtn = (FamilySite)familySiteMgrService.getObject(familySite);
			rtnFamilySite = (FamilySite)objRtn.getOutCursor();
						
			//실행결과 로기 생성
			this.resultLog(familySite);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnFamilySite.setInBeforeData(rtnFamilySite.makeDataString());
		}
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(familySite.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(familySite.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
				
		// View 설정
		model.addAttribute("rtnFamilySite", rtnFamilySite);					
				
		familySite.setJsp("site/familySiteMgr/form");
		return new ModelAndView("ips.layout", "obj", familySite);
	}
	
	/*****************************************************************
	 * insert 추천사이트 추가/수정
	 * @param familySite
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute FamilySite familySite, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		familySite.setInParam(request);
		
		familySite.setInWorkName("추천사이트관리");
		if(StringUtil.isNotBlank(familySite.getSiteLinkId())){
			familySite.setInCondition("수정");
		}else{
			familySite.setInCondition("입력");
		}

		// 콘텐츠 설명 CLOB세팅
		familySite.setInCLOBData1(familySite.getKDesc());
		
		// 변경후 데이타 저장(inAfterData)
		familySite.setInAfterData(familySite.makeDataString());
		
		//InDMLData :: SiteID|FamilySiteID|KName|LinkURL|Sort|State
		familySite.setInDMLData(familySite.makeDMLDataString());

		// 저장
		FamilySite objRtn = (FamilySite)familySiteMgrService.insertObject(familySite);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(familySite.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(familySite.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/familySiteMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 추천사이트 삭제(데이터삭제)
	 * @param familySite
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute FamilySite familySite, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		familySite.setInParam(request);		

		familySite.setInWorkName("추천사이트관리");
		familySite.setInCondition("삭제");

		//InDMLData ::  SiteID|FamilySiteID|KName|LinkURL|Sort|State
		familySite.setInDMLData(familySite.makeDMLDataString());

		// 저장
		FamilySite objRtn = (FamilySite)familySiteMgrService.deleteObject(familySite);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(familySite.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(familySite.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/familySiteMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/excelDown")
	public void ghMarkExcelDown(@ModelAttribute FamilySite familySite, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		familySite.setInParam(request);
		
		// 검색 parameter 세팅
		familySite.setSiteId(request.getParameter("schSiteId"));
		familySite.setKName(request.getParameter("schKName"));
		familySite.setExcelDownYn("Y");
		
		// 사이트 조회
		FamilySite objRtn = (FamilySite)familySiteMgrService.getObjectList(familySite);

		//실행결과 로기 생성
		this.resultLog(familySite);
		
		// View 설정
		List list = (List) objRtn.getOutCursor();

		String[] headerName = {"사이트명", "Family사이트명", "순서", "사용여부"};
		String[] columnName = {"SITE_NAME", "KNAME", "CSORT", "STATE_KANME"};
		String sheetName = "Family사이트정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
	
}

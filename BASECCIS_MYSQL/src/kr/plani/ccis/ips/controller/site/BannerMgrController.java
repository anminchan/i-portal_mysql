package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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
import kr.plani.ccis.common.util.FileUtil;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.Banner;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.BannerMgrService;

/*****************************************************************
* 베너관리를 처리하는 비즈니스 구현 클래스
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
@RequestMapping(value="/mgr/bannerMgr")
public class BannerMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BannerMgrController.class);

	 /** 베너관리 서비스   */
	@Resource
	private BannerMgrService bannerMgrService;
	
	@Resource
	private CommonService commonService;
	
	@Resource
	private FileUtil fileUtil;
	
	/*****************************************************************
	* list 베너 목록 조회
	* @param banner
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Banner banner, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		banner.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, banner);

		// 검색 parameter 세팅
		banner.setSiteId(request.getParameter("schSiteId"));
		banner.setKName(request.getParameter("schKName"));

		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		List<?> list = null;
		int totalCnt = 0 ;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		if(sc.getTotalAuth().equals("Y")){
			// 베너 조회
			list = (List<?>)bannerMgrService.getObjectList(banner);
			totalCnt = bannerMgrService.getObjectListCnt(banner);

			//실행결과 로기 생성
			this.resultLog(banner);
			
			// View 설정
			model.addAttribute("result", list);
			
			//페이징 정보
			model.addAttribute("rowCnt", banner.getRowCnt());		//페이지 목록수
			model.addAttribute("totalCnt", totalCnt);	//전체 카운트
		}else{
			if(StringUtil.isNotBlank(banner.getSiteId())){
				// 베너 조회
				list = (List<?>)bannerMgrService.getObjectList(banner);
				totalCnt = bannerMgrService.getObjectListCnt(banner);

				//실행결과 로기 생성
				this.resultLog(banner);
				
				// View 설정
				model.addAttribute("result", list);
				
				//페이징 정보
				model.addAttribute("rowCnt", banner.getRowCnt());		//페이지 목록수
				model.addAttribute("totalCnt", totalCnt);	//전체 카운트
			}
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(banner.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(banner.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		banner.setJsp("site/bannerMgr/list");
		return new ModelAndView("ips.layout", "obj", banner);
	}

	/*****************************************************************
	* Form 베너 추가/수정 폼
	* @param banner
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form")
	public @ResponseBody Object form(@ModelAttribute Banner banner, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		banner.setInParam(request);
				
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, banner);
				
		Banner rtnBanner = new Banner();
			
		//siteId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(banner.getBannerId())){
			// 페키지 호출 기본 Parameter 설정
			banner.setInParam(request);
					
			// 베너 상세 조회
			rtnBanner = (Banner)bannerMgrService.getObject(banner);
						
			//실행결과 로기 생성
			this.resultLog(banner);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnBanner.setInBeforeData(rtnBanner.makeDataString());
		}
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(banner.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(banner.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
				
		// View 설정
		model.addAttribute("rtnBanner", rtnBanner);					
				
		banner.setJsp("site/bannerMgr/form"+banner.getFileFormType());
		return new ModelAndView("ips.layout", "obj", banner);
	}
	
	/*****************************************************************
	 * insert 베너 추가/수정
	 * @param Banner
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute Banner banner, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		//기본 Parameter 설정
		banner.setInParam(request);
		
		banner.setInWorkName("베너관리");
		if(StringUtil.isNotBlank(banner.getBannerId())){
			banner.setInCondition("수정");
		}else{
			banner.setInCondition("입력");
		}

		// 콘텐츠 설명 CLOB세팅
		banner.setInCLOBData1(banner.getKDesc());

		Files uploadFiles = new Files();
		
		if(banner.getFileFormType().equals("_inputFiles")){ // inputFile
			// multipartFileUpload
			uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "fileImg_upload", "fileImgId", "bannerMgr", "common", "single"); // (request, response, 신규Input파일명, 수정Input파일명, 파일저장기능명, 저장폴더명) 
			banner.setImageFileName(uploadFiles.getUserFileName());
			banner.setImageSFileName(uploadFiles.getSystemFileName());
			banner.setFilePath(uploadFiles.getFilePath());
			
		}else{
			// 첨부파일 JSON정보
			JSONParser jsonParser = new JSONParser();
			Object obj = null;
			JSONArray jsonArray = null;
			JSONObject jsonObject = null;
			
			// 이미지 첨부가 없을경우
			if(!StringUtil.isNotBlank(request.getParameter("modifiedFilesInfoImages"))) {
				if(StringUtil.isNotBlank(banner.getImageFileName())){
					NamoCrossFile.fileDeleteAttempt(banner.getFilePath(), banner.getImageSFileName());
					banner.setImageFileName(null);
					banner.setImageSFileName(null);
					banner.setFilePath(null);
				}
			}
			
			// 이미지 파일 등록
			if(StringUtil.isNotBlank(request.getParameter("uploadedFilesInfoImages"))) {
				String uploadedFilesInfoImages = request.getParameter("uploadedFilesInfoImages");
				obj = jsonParser.parse(uploadedFilesInfoImages); 
				jsonArray = (JSONArray)obj; 
				if(jsonArray.size() > 0){
					if(StringUtil.isNotBlank(banner.getImageFileName())){
						NamoCrossFile.fileDeleteAttempt(banner.getFilePath(), banner.getImageSFileName());
					}
					jsonObject = (JSONObject)jsonArray.get(0);
					
					banner.setImageFileName((String)jsonObject.get("origfileName"));
					banner.setImageSFileName((String)jsonObject.get("fileName"));
					banner.setFilePath((String)jsonObject.get("lastSavedDirectoryPath"));
				}
			}
		}
		
		// 변경후 데이타 저장(inAfterData)
		banner.setInAfterData(banner.makeDataString());
		
		//InDMLData :: SiteID|BannerID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|State
		//banner.setInDMLData(banner.makeDMLDataString());

		// 저장
		Banner objRtn = (Banner)bannerMgrService.insertObject(banner);
		
		//changLog
		banner.setDmlType(banner.getInCondition().equals("입력") ? "I" : banner.getInCondition().equals("수정") ? "U" : "D");
		banner.setDmlNotice("정상적으로 ("+banner.getInWorkName()+")"+banner.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(banner);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(banner.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(banner.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/bannerMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 베너 삭제(데이터삭제)
	 * @param banner
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute Banner banner, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		banner.setInParam(request);		

		banner.setInWorkName("베너관리");
		banner.setInCondition("삭제");

		//InDMLData ::  SiteID|BannerID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|State
		//banner.setInDMLData(banner.makeDMLDataString());

		// 저장
		Banner objRtn = (Banner)bannerMgrService.deleteObject(banner);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시 
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(banner.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(banner.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/bannerMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/excelDown")
	public void ghMarkExcelDown(@ModelAttribute Banner banner, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		banner.setInParam(request);
		
		// 검색 parameter 세팅
		banner.setSiteId(request.getParameter("schSiteId"));
		banner.setKName(request.getParameter("schKName"));
		banner.setExcelDownYn("Y");
		
		// 사이트 조회
		Banner objRtn = (Banner)bannerMgrService.getObjectList(banner);

		//실행결과 로기 생성
		this.resultLog(banner);
		
		// View 설정
		List list = (List) objRtn.getOutCursor();

		String[] headerName = {"사이트명", "베너명", "순서", "사용여부"};
		String[] columnName = {"SITE_NAME", "KNAME", "CSORT", "STATE_KANME"};
		String sheetName = "베너정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
}

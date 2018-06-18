package kr.plani.ccis.ips.controller.site;

import java.io.File;
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
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.domain.site.PopupZone;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.PopupZoneMgrService;

/*****************************************************************
* 팝업존관리를 처리하는 비즈니스 구현 클래스
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
@RequestMapping(value="/mgr/popupZoneMgr")
public class PopupZoneMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(PopupZoneMgrController.class);

	 /** 팝업존관리 서비스   */
	@Resource
	private PopupZoneMgrService popupZoneMgrService;
	
	@Resource
	private CommonService commonService;

	@Resource
	private FileUtil fileUtil;
	
	/*****************************************************************
	* list 팝업존 목록 조회
	* @param popupZone
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute PopupZone popupZone, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		popupZone.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, popupZone);

		// 검색 parameter 세팅
		popupZone.setSiteId(request.getParameter("schSiteId"));
		popupZone.setKName(request.getParameter("schKName"));
		popupZone.setState(request.getParameter("schState"));
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		PopupZone objRtn = null;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		
		if(sc.getTotalAuth().equals("Y")){
			// 팝업존설정 조회
			objRtn = (PopupZone)popupZoneMgrService.getObjectList(popupZone);

			//실행결과 로기 생성
			this.resultLog(popupZone);
			
			// View 설정
			model.addAttribute("result", objRtn.getOutCursor());

			//페이징 정보
			model.addAttribute("rowCnt", popupZone.getRowCnt());	//페이지 목록수
			model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
		}else{
			if(StringUtil.isNotBlank(popupZone.getSiteId())){
				// 팝업존설정 조회
				objRtn = (PopupZone)popupZoneMgrService.getObjectList(popupZone);

				//실행결과 로기 생성
				this.resultLog(popupZone);
				
				// View 설정
				model.addAttribute("result", objRtn.getOutCursor());
				
				//페이징 정보
				model.addAttribute("rowCnt", popupZone.getRowCnt());	//페이지 목록수
				model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
			}
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(popupZone.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		popupZone.setJsp("site/popupZoneMgr/list");
		return new ModelAndView("ips.layout", "obj", popupZone);
	}

	/*****************************************************************
	* Form 팝업존 추가/수정 폼
	* @param popupZone
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute PopupZone popupZone, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		popupZone.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, popupZone);
				
		PopupZone rtnPopupZone = new PopupZone();
			
		//siteId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(popupZone.getPopupZoneId())){
					
			// 사이트 상세 조회
			PopupZone objRtn = (PopupZone)popupZoneMgrService.getObject(popupZone);
			rtnPopupZone = (PopupZone)objRtn.getOutCursor();
						
			//실행결과 로기 생성
			this.resultLog(popupZone);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnPopupZone.setInBeforeData(rtnPopupZone.makeDataString());
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(popupZone.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&pageNum=" + StringUtil.nullCheck(popupZone.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
		
		// View 설정
		model.addAttribute("rtnPopupZone", rtnPopupZone);					
				
		popupZone.setJsp("site/popupZoneMgr/form"+popupZone.getFileFormType());
		return new ModelAndView("ips.layout", "obj", popupZone);
	}
	
	/*****************************************************************
	 * insert 팝업존 추가/수정
	 * @param popupZone
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute PopupZone popupZone, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		//기본 Parameter 설정
		popupZone.setInParam(request);
		
		popupZone.setInWorkName("팝업존관리");
		if(StringUtil.isNotBlank(popupZone.getPopupZoneId())){
			popupZone.setInCondition("수정");
		}else{
			popupZone.setInCondition("입력");
		}

		// 콘텐츠 설명 CLOB세팅
		popupZone.setInCLOBData1(popupZone.getKDesc());

		Files uploadFiles = new Files();
		
		if(popupZone.getFileFormType().equals("_inputFiles")){ // inputFile
			// multipartFileUpload
			uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "fileImg_upload", "fileImgId", "popupZoneMgr", "common", "single"); // (request, response, 신규Input파일명, 수정Input파일명, 파일저장기능명, 저장폴더명) 
			popupZone.setImageFileName(uploadFiles.getUserFileName());
			popupZone.setImageSFileName(uploadFiles.getSystemFileName());
			popupZone.setFilePath(uploadFiles.getFilePath());
			
		}else{
			// 첨부파일 JSON정보
			JSONParser jsonParser = new JSONParser();
			Object jsonObj = null;
	 		JSONArray jsonArray = null;
			JSONObject jsonObject = null;
			
			// 이미지 첨부가 없을경우
			if(!StringUtil.isNotBlank(request.getParameter("modifiedFilesInfoImages"))) {
				if(StringUtil.isNotBlank(popupZone.getImageFileName())){
					NamoCrossFile.fileDeleteAttempt(popupZone.getFilePath(), popupZone.getImageSFileName());
					popupZone.setImageFileName(null);
					popupZone.setImageSFileName(null);
					popupZone.setFilePath(null);
				}
			}else{
				String modifiedFilesInfo = request.getParameter("modifiedFilesInfoImages"); 
				jsonObj = jsonParser.parse(modifiedFilesInfo); 
				jsonArray = (JSONArray)jsonObj; 
				if(jsonArray.size() > 0){
					jsonObject = (JSONObject)jsonArray.get(0); 
					String[] strData = StringUtil.strToArr((String)jsonObject.get("fileId"), "@@");
					if(!Boolean.parseBoolean((String) jsonObject.get("isDeleted"))){
						popupZone.setImageFileName((String)jsonObject.get("fileName"));
						popupZone.setImageSFileName(strData[2]);
						popupZone.setFilePath(strData[3]);
					}else{
						NamoCrossFile.fileDeleteAttempt(strData[3], strData[2]);
						if("jpg;jpeg;png;gif;bmp".indexOf(strData[2].toString().toLowerCase().substring(strData[2].toString().lastIndexOf(".")+1)) > -1){
							NamoCrossFile.fileDeleteAttempt(strData[3]+"thumbnails"+File.separator, strData[2]);
						}
					}
				}
			}
			
			// 이미지 파일 등록
			if(StringUtil.isNotBlank(request.getParameter("uploadedFilesInfoImages"))) {
				String uploadedFilesInfoImages = request.getParameter("uploadedFilesInfoImages");
				jsonObj = jsonParser.parse(uploadedFilesInfoImages); 
				jsonArray = (JSONArray)jsonObj; 
				if(jsonArray.size() > 0){
					if(StringUtil.isNotBlank(popupZone.getImageFileName())){
						NamoCrossFile.fileDeleteAttempt(popupZone.getFilePath(), popupZone.getImageSFileName());
					}
					jsonObject = (JSONObject)jsonArray.get(0);
					
					popupZone.setImageFileName((String)jsonObject.get("origfileName"));
					popupZone.setImageSFileName((String)jsonObject.get("fileName"));
					popupZone.setFilePath((String)jsonObject.get("lastSavedDirectoryPath"));
				}
			}
		}

		// 변경후 데이타 저장(inAfterData)
		popupZone.setInAfterData(popupZone.makeDataString());
		
		//InDMLData :: SiteID|PopupZoneID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|State
		popupZone.setInDMLData(popupZone.makeDMLDataString());

		// 저장
		PopupZone objRtn = (PopupZone)popupZoneMgrService.insertObject(popupZone);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(popupZone.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&pageNum=" + StringUtil.nullCheck(popupZone.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/popupZoneMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 팝업존 삭제(데이터삭제)
	 * @param popupZone
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute PopupZone popupZone, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		popupZone.setInParam(request);		

		popupZone.setInWorkName("팝업존관리");
		popupZone.setInCondition("삭제");

		//InDMLData ::  SiteID|PopupZoneID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|State
		popupZone.setInDMLData(popupZone.makeDMLDataString());

		// 저장
		PopupZone objRtn = (PopupZone)popupZoneMgrService.deleteObject(popupZone);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(popupZone.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&pageNum=" + StringUtil.nullCheck(popupZone.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/popupZoneMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/excelDown")
	public void ghMarkExcelDown(@ModelAttribute PopupZone popupZone, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		popupZone.setInParam(request);

		// 검색 parameter 세팅
		popupZone.setSiteId(request.getParameter("schSiteId"));
		popupZone.setKName(request.getParameter("schKName"));
		popupZone.setState(request.getParameter("schState"));	
		popupZone.setExcelDownYn("Y");
		
		// 사이트 조회
		PopupZone objRtn = (PopupZone)popupZoneMgrService.getObjectList(popupZone);

		//실행결과 로기 생성
		this.resultLog(popupZone);
		
		// View 설정
		List list = (List) objRtn.getOutCursor();

		String[] headerName = {"사이트명", "제목", "게시시작일", "게시종료일", "순서", "사용여부"};
		String[] columnName = {"SITE_NAME", "KNAME", "CSTARTTIME", "CENDTIME", "CSORT", "STATE_KANME"};
		String sheetName = "팝업존정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
}

package kr.plani.ccis.ips.controller.site;

import java.io.File;
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
import kr.plani.ccis.ips.domain.site.Doodles;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.DoodlesMgrService;


@Controller
@RequestMapping(value="/mgr/doodlesMgr")
public class DoodlesMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(DoodlesMgrController.class);
	 /** 두들관리 서비스   */
	@Resource
	private DoodlesMgrService doodlesMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*첨부파일관련*/
	@Resource
	private NamoCrossFile namoCrossFile;
	
	/*****************************************************************
	* list 두들 목록 조회
	* @param doodles
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute Doodles doodles, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		doodles.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, doodles);

		// 검색 parameter 세팅
		doodles.setSiteId(request.getParameter("schSiteId"));
		doodles.setKName(request.getParameter("schKName"));
		doodles.setState(request.getParameter("schState"));
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		Doodles objRtn = null;
		List<Doodles> list = null;
		int totalCnt = 0 ;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		
		if(sc.getTotalAuth().equals("Y")){
			// 두들설정 조회
			list = (List<Doodles>)doodlesMgrService.getObjectList(doodles);
			totalCnt = doodlesMgrService.getObjectListCnt(doodles);

			//실행결과 로기 생성
			//this.resultLog(doodles);
			
			// View 설정
			//model.addAttribute("result", objRtn.getOutCursor());

			model.addAttribute("result", list);
			
			//페이징 정보
			model.addAttribute("rowCnt", doodles.getRowCnt());	//페이지 목록수
			model.addAttribute("totalCnt", totalCnt);
			//model.addAttribute("rowCnt", doodles.getRowCnt());	//페이지 목록수
			//model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
		}else{
			if(StringUtil.isNotBlank(doodles.getSiteId())){
				// 두들설정 조회
				//objRtn = (Doodles)doodlesMgrService.getObjectList(doodles);
				list = (List<Doodles>)doodlesMgrService.getObjectList(doodles);
				totalCnt = doodlesMgrService.getObjectListCnt(doodles);

				model.addAttribute("result", list);
				
				//페이징 정보
				model.addAttribute("rowCnt", doodles.getRowCnt());	//페이지 목록수
				model.addAttribute("totalCnt", totalCnt);
				
				//실행결과 로기 생성
				//this.resultLog(doodles);
				
				// View 설정
				//model.addAttribute("result", objRtn.getOutCursor());
				
				//페이징 정보
				//model.addAttribute("rowCnt", doodles.getRowCnt());	//페이지 목록수
				//model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
			}
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(doodles.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		doodles.setJsp("site/doodlesMgr/list");
		return new ModelAndView("ips.layout", "obj", doodles);
	}

	/*****************************************************************
	* Form 두들 추가/수정 폼
	* @param doodles
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute Doodles doodles, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		doodles.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, doodles);
				
		Doodles rtnDoodles = new Doodles();
			
		// id가 넘어 오지 않을 경우 신규 입력
		if(StringUtil.isNotBlank(doodles.getDoodlesId())){
					
			// 사이트 상세 조회
			Doodles objRtn = (Doodles)doodlesMgrService.getObject(doodles);
			/*rtnDoodles = (Doodles)objRtn.getOutCursor();*/
			rtnDoodles = objRtn;
						
			//실행결과 로기 생성
			//this.resultLog(doodles);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnDoodles.setInBeforeData(rtnDoodles.makeDataString());
			
			// 첨부파일 크기 셋팅
			File file = new File(rtnDoodles.getFilePath()+rtnDoodles.getImageSFileName());
			if(file.exists()){
				long L = file.length();
				rtnDoodles.setFileRealSize(L+"");
			}
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(doodles.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&pageNum=" + StringUtil.nullCheck(doodles.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
		
		// View 설정
		model.addAttribute("rtnDoodles", rtnDoodles);					
				
		doodles.setJsp("site/doodlesMgr/form");
		return new ModelAndView("ips.layout", "obj", doodles);
	}
	
	/*****************************************************************
	 * insert 두들 추가/수정
	 * @param doodles
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute Doodles doodles, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		doodles.setInParam(request);
		
		doodles.setInWorkName("두들관리");
		if(StringUtil.isNotBlank(doodles.getDoodlesId())){
			doodles.setInCondition("수정");
		}else{
			doodles.setInCondition("입력");
		}

		// 콘텐츠 설명 CLOB세팅
		doodles.setInCLOBData1(doodles.getKDesc());
		Doodles objRtn = new Doodles();
		try{

		if(doodles.getDoodlesId().equals("") || doodles.getDoodlesId() == null){ // 신규 파일을 등록하는 경우
			Files uploadFiles = (Files)namoCrossFile.fileUploadAttempt(doodles, request);
			
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
				String extension = uploadFiles.getFileList().get(0).getFileExtension().toLowerCase();
				
				if("jpg;jpeg;png;gif;bmp".indexOf(extension) > -1){
					doodles.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
					doodles.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
					doodles.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
				}
			}
		}else{
			/*if(StringUtil.isNotBlank(doodles.getImageFileName())){	// 기존파일이 있는경우
				NamoCrossFile.fileDeleteAttempt(doodles.getFilePath(), doodles.getImageSFileName());
				NamoCrossFile.fileDeleteAttempt(doodles.getFilePath()+"thumbnails"+File.separator, doodles.getImageSFileName());
			}*/
			Files uploadFiles = (Files)namoCrossFile.fileUploadAttempt(doodles, request);
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
				String extension = uploadFiles.getFileList().get(0).getFileExtension().toLowerCase();
				
				if("jpg;jpeg;png;gif;bmp".indexOf(extension) > -1){
					doodles.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
					doodles.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
					doodles.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
				}
			}
		}
		
		// 변경후 데이타 저장(inAfterData)
		doodles.setInAfterData(doodles.makeDataString());
		
		//InDMLData :: SiteID|DoodlesID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|State
		//doodles.setInDMLData(doodles.makeDMLDataString());

		// 저장
		objRtn = (Doodles)doodlesMgrService.insertObject(doodles);

		//changLog
		doodles.setDmlType(doodles.getInCondition().equals("입력") ? "I" : doodles.getInCondition().equals("수정") ? "U" : "D");
		doodles.setDmlNotice("정상적으로 ("+doodles.getInWorkName()+")"+doodles.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(doodles);
	
		objRtn.setOutNotice("저장되었습니다.");
		}catch(Exception e){
 			objRtn.setOutNotice("저장실패되었습니다.");
		}
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(doodles.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&pageNum=" + StringUtil.nullCheck(doodles.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/doodlesMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 두들 삭제(데이터삭제)
	 * @param doodles
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute Doodles doodles, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		doodles.setInParam(request);		

		doodles.setInWorkName("두들관리");
		doodles.setInCondition("삭제");

		//InDMLData ::  SiteID|DoodlesID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|State
		doodles.setInDMLData(doodles.makeDMLDataString());

		// 저장
		Doodles objRtn = (Doodles)doodlesMgrService.deleteObject(doodles);
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);

		//실행결과 메세지처리 시
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(doodles.getMenuId()) +
				  "&schState=" + StringUtil.nullCheck(request.getParameter("schState")) +
				  "&pageNum=" + StringUtil.nullCheck(doodles.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/doodlesMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/excelDown")
	public void ghMarkExcelDown(@ModelAttribute Doodles doodles, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		doodles.setInParam(request);

		// 검색 parameter 세팅
		doodles.setSiteId(request.getParameter("schSiteId"));
		doodles.setKName(request.getParameter("schKName"));
		doodles.setState(request.getParameter("schState"));	
		doodles.setExcelDownYn("Y");
		
		// 사이트 조회
		Doodles objRtn = (Doodles)doodlesMgrService.getObjectList(doodles);

		//실행결과 로기 생성
		//this.resultLog(doodles);
		
		// View 설정
		List list = (List) objRtn.getOutCursor();

		String[] headerName = {"사이트명", "제목", "게시시작일", "게시종료일", "순서", "사용여부"};
		String[] columnName = {"SITE_NAME", "KNAME", "CSTARTTIME", "CENDTIME", "CSORT", "STATE_KANME"};
		String sheetName = "두들정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
}

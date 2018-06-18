package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.FileUtil;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.AttachFile;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.AttachFileMgrService;

@Controller
@RequestMapping(value="/mgr/attachFileMgr")
public class AttachFileMgrController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(AttachFileMgrController.class);

	/** 콘텐츠관리 서비스   */
	@Resource
	private AttachFileMgrService attachFileMgrService;
	
	@Resource
	private CommonService commonService;

	@Resource
	private NamoCrossFile namoCrossFile;
	
	@Resource
	private FileUtil fileUtil;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST}) 
	public ModelAndView attachlist(@ModelAttribute AttachFile attachFile, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		attachFile.setInParam(request);

		// 기본 셋팅
		this.setCommon(commonService, request, model, attachFile);

		// 구분 목록 조회
		List<?> list = attachFileMgrService.getObjectList(attachFile);
		
		//실행결과 로기 생성
		this.resultLog(attachFile);
		
		// View 설정
		model.addAttribute("result", list);

		//페이징 정보
		model.addAttribute("rowCnt", attachFile.getRowCnt());	//페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT"))));	//전체 카운트
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(attachFile.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(attachFile.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(attachFile.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(attachFile.getSchType())+
		  		  "&schText="+URLEncoder.encode(StringUtil.nullCheck(attachFile.getSchText()), "UTF-8");
		model.addAttribute("link", strLink);
		
		attachFile.setJsp("site/attachFileMgr/list");
		return new ModelAndView("ips.layout", "obj", attachFile);
	}

	@RequestMapping(value="/view")
	public ModelAndView view(@ModelAttribute AttachFile attachFile, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// 페키지 호출 기본 Parameter 설정
		attachFile.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, attachFile);

		Object rtnObject = null;
		List<?> listFile = null;
		
		// 사이트 상세 조회
		rtnObject = attachFileMgrService.getObject(attachFile);
		listFile = attachFileMgrService.selectAttachFiles(attachFile);
			
			//실행결과 로기 생성
			this.resultLog(attachFile);

		// View 설정
		model.addAttribute("result", rtnObject);
		model.addAttribute("resultFile", listFile);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(attachFile.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(attachFile.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(attachFile.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(attachFile.getSchType())+
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(attachFile.getSchText()), "UTF-8");				  
		
		model.addAttribute("link", strLink);
		
		attachFile.setJsp("site/attachFileMgr/view");
		return new ModelAndView("ips.layout", "obj", attachFile);
	}
	
	@RequestMapping(value="/form")
	public ModelAndView form(@ModelAttribute AttachFile attachFile, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// 페키지 호출 기본 Parameter 설정
		attachFile.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, attachFile);

		Object rtnObject = null;
		List<?> listFile = null;
		
		//Id가 넘어 오지 않을경우 신규 입력
		if(attachFile.getAttachFileId() > 0){
		
			// 사이트 상세 조회
			rtnObject = attachFileMgrService.getObject(attachFile);
			listFile = attachFileMgrService.selectAttachFiles(attachFile);
			
			//실행결과 로기 생성
			this.resultLog(attachFile);
		}

		// View 설정
		model.addAttribute("result", rtnObject);
		model.addAttribute("resultFile", listFile);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(attachFile.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(attachFile.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(attachFile.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(attachFile.getSchType())+
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(attachFile.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		attachFile.setJsp("site/attachFileMgr/form"+attachFile.getFileFormType());
		return new ModelAndView("ips.layout", "obj", attachFile);
	}
	
	@RequestMapping(value="/act")
	public ModelAndView act(@ModelAttribute AttachFile attachFile, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		//기본 Parameter 설정
		attachFile.setInParam(request);

		attachFile.setUserId(attachFile.getMyId());
		attachFile.setUserName(attachFile.getMyName());

		// 저장
		if(attachFile.getAttachFileId() > 0){	
			attachFileMgrService.updateAttachFile(attachFile);
		}else{
			attachFileMgrService.insertAttachFile(attachFile);
		}
		
		Files uploadFiles = new Files();
		
		if(attachFile.getFileFormType().equals("_inputFiles")){ // inputFile
			// multipartFileUpload
			uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", "attachFileMgr", "common", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 파일저장기능명, 저장폴더명) 
		}else{ // namoFiles
			uploadFiles = (Files)namoCrossFile.fileUploadAttempt(attachFile, request);
		}
		
		attachFileMgrService.deleteAttachFiles(attachFile);
		
		for(int i=0; i<uploadFiles.getFileList().size(); i++){
			
			// 첨부파일 세팅
			attachFile.setFilePath(uploadFiles.getFileList().get(i).getFilePath());
			attachFile.setUserFileName(uploadFiles.getFileList().get(i).getUserFileName());
			attachFile.setSystemFileName(uploadFiles.getFileList().get(i).getSystemFileName());
			attachFile.setFileExtension(uploadFiles.getFileList().get(i).getFileExtension());
			attachFile.setFileSize(Integer.parseInt(uploadFiles.getFileList().get(i).getFileSize()));
			
			// 저장
			attachFileMgrService.insertAttachFiles(attachFile);
		}
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(attachFile.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(attachFile.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(attachFile.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(attachFile.getSchType())+
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(attachFile.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);

		attachFile.setOutNotice("저장되었습니다.");
		this.setMessage(request, attachFile);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/attachFileMgr?"+strLink));
		return new ModelAndView(rv);
	}

	@RequestMapping(value="/delete")
	public ModelAndView delete(@ModelAttribute AttachFile attachFile, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		//기본 Parameter 설정
		attachFile.setInParam(request);

		String t_attachFileId = attachFile.getAttachFileIds();
		String[] t_attachFileIds = t_attachFileId.split(",");
		
		attachFile.setAttachFileIdsact(t_attachFileIds);

		attachFileMgrService.deleteAttachFile(attachFile);
		attachFileMgrService.deleteAttachFiles(attachFile);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(attachFile.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(attachFile.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(attachFile.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(attachFile.getSchType())+
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(attachFile.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);

		attachFile.setOutNotice("삭제되었습니다.");
		this.setMessage(request, attachFile);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/attachFileMgr?"+strLink));
		return new ModelAndView(rv);
	}
}

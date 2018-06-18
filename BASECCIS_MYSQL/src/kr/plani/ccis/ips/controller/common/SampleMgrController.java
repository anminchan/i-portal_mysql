package kr.plani.ccis.ips.controller.common;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.FileUtil;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.common.Sample;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.common.SampleMgrService;

/*****************************************************************
* 기능을 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2017. 05. 20. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 20.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/sampleMgr")
public class SampleMgrController extends BaseController{
	private static final Logger logger = LoggerFactory.getLogger(SampleMgrController.class);

	/** 공통기능 서비스   */
	@Resource
	private CommonService commonService;
	
	/** 기능 서비스   */
	@Resource
	private SampleMgrService sampleMgrService;

	/** 공통파일업로드 서비스   */
	@Resource
	private NamoCrossFile namoCrossFile;
	
	@Resource
	private FileUtil fileUtil;
	
	/*****************************************************************
	* list 목록 조회
	* @param Sample
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Sample sample, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		sample.setInParam(request); // 공통파라메터 셋팅(사용자아이디, 이름, 기기정보 등)
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, sample); // 메뉴조회, 메뉴 location정보 셋팅
		
		// 목록 조회
		List<?> list = sampleMgrService.getObjectList(sample);
		
		// View 설정
		model.addAttribute("result", list);

		//페이징 정보
		model.addAttribute("rowCnt", sample.getRowCnt()); //페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT")))); //전체 카운트
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(sample.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(sample.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(sample.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(sample.getSchType())+
		  		  "&schText="+ StringUtil.nullCheck(sample.getSchText());
		
		// 링크파라메터
		model.addAttribute("link", strLink);
		
		sample.setJsp("common/sampleMgr/list"); // jsp경로
		return new ModelAndView("ips.layout", "obj", sample); // tiles아이디, domain 셋팅	
	}
	
	/*****************************************************************
	* View 상세보기
	* @param Sample
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/view")
	public ModelAndView view(@ModelAttribute Sample sample, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// 페키지 호출 기본 Parameter 설정
		sample.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, sample); // 메뉴조회, 메뉴 location정보 셋팅

		Object rtnObject = null;
		List<?> listFile = null;
		
		// 사이트 상세 조회
		rtnObject = sampleMgrService.getObject(sample); // 본문내용
		listFile = sampleMgrService.getFileObjectList(sample);
			
		// View 설정
		model.addAttribute("result", rtnObject);
		model.addAttribute("resultFile", listFile);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(sample.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(sample.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(sample.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(sample.getSchType())+
		  		  "&schText="+ StringUtil.nullCheck(sample.getSchText());				  
		
		model.addAttribute("link", strLink);

		sample.setJsp("common/sampleMgr/view"); // jsp경로
		return new ModelAndView("ips.layout", "obj", sample); // tiles아이디, domain 셋팅
	}
	
	/*****************************************************************
	* Form 추가/수정 폼
	* @param sample
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form")
	public ModelAndView form(@ModelAttribute Sample sample, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		sample.setInParam(request); // 공통파라메터 셋팅(사용자아이디, 이름, 기기정보 등)
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, sample); // 메뉴조회, 메뉴 location정보 셋팅
		
		Object rtnObject = null;
		List<?> listFile = null;

		//Id가 넘어 오지 않을경우 신규 입력
		if(sample.getSampleId() > 0){
			// 사이트 상세 조회
			rtnObject = sampleMgrService.getObject(sample); // 본문내용
			listFile = sampleMgrService.getFileObjectList(sample);
		}
		
		// View 설정
		model.addAttribute("result", rtnObject);
		model.addAttribute("resultFile", listFile);		
		
		sample.setJsp("common/sampleMgr/form"+sample.getFileFormType()); // jsp경로
		return new ModelAndView("ips.layout", "obj", sample); // tiles아이디, domain 셋팅
	}
	
	/*****************************************************************
	 * insert 추가/수정/삭제
	 * @param sample
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act")
	public ModelAndView insert(@ModelAttribute Sample sample, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		//기본 Parameter 설정
		sample.setInParam(request);		

		// 저장
		if(sample.getSampleId() > 0){	
			sampleMgrService.updateObject(sample);
			sample.setOutNotice(messageSource.getMessage("success.update.msg", null, LocaleContextHolder.getLocale())); // 메세지설정
		}else{
			sampleMgrService.insertObject(sample);
			sample.setOutNotice(messageSource.getMessage("success.insert.msg", null, LocaleContextHolder.getLocale())); // 메세지설정
		}
		
		sampleMgrService.deleteFileObject(sample); // 파일삭제
		
		Files uploadFiles = new Files();
		
		if(sample.getFileFormType().equals("_inputFiles")){ // inputFile
			// multipartFileUpload
			uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", "sampleFileMgr", "function", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 파일저장기능명, 저장폴더명)
		}else{
			// namoCrossFile 파일 업로드
			uploadFiles = (Files)namoCrossFile.fileUploadAttempt(sample, request); // 나모파일업로드 정보리턴값
		}
		
		for(int i=0; i<uploadFiles.getFileList().size(); i++){
			// 첨부파일 세팅
			sample.setFilePath(uploadFiles.getFileList().get(i).getFilePath());
			sample.setUserFileName(uploadFiles.getFileList().get(i).getUserFileName());
			sample.setSystemFileName(uploadFiles.getFileList().get(i).getSystemFileName());
			sample.setFileExtension(uploadFiles.getFileList().get(i).getFileExtension());
			sample.setFileSize(uploadFiles.getFileList().get(i).getFileSize());
			
			// 저장
			sampleMgrService.insertFileObject(sample);
		}
	
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(sample.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(sample.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(sample.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(sample.getSchType())+
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(sample.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);

		this.setMessage(request, sample); // 메세지 출력처리
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/sampleMgr?"+strLink));
		return new ModelAndView(rv);
	}

	/*****************************************************************
	 * delete (상태값 변경)
	 * @param sample
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete")
	public ModelAndView delete(@ModelAttribute Sample sample, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		sample.setInParam(request);
		
		// 삭제
		sampleMgrService.deleteObject(sample);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(sample.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(sample.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(sample.getRowCnt())+
				  "&schType=" + StringUtil.nullCheck(sample.getSchType())+
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(sample.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		sample.setOutNotice(messageSource.getMessage("success.delete.msg", null, LocaleContextHolder.getLocale())); // 메세지설정
		this.setMessage(request, sample);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/sampleMgr?"+strLink));
		return new ModelAndView(rv);
	}
}

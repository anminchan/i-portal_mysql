package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.domain.site.ImagePool;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ImagePoolMgrService;

/*****************************************************************
* 이미지관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2015. 9. 24. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2015. 9. 23.		sjlee		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/imagePoolMgr")
public class ImagePoolMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ImagePoolMgrController.class);

	 /** 이미지풀관리 서비스   */
	@Resource
	private ImagePoolMgrService imagePoolMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 이미지풀 목록 조회
	* @param imagePool
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute ImagePool imagePool, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		imagePool.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, imagePool);

		// 검색 parameter 세팅
		imagePool.setSiteId(request.getParameter("schSiteId"));
		imagePool.setKName(request.getParameter("schKName"));
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		ImagePool objRtn = null;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		if(sc.getTotalAuth().equals("Y")){
			// 이미지풀 조회
			objRtn = (ImagePool)imagePoolMgrService.getObjectList(imagePool);

			//실행결과 로기 생성
			this.resultLog(imagePool);
			
			// View 설정
			model.addAttribute("result", objRtn.getOutCursor());
			
			//페이징 정보
			model.addAttribute("rowCnt", imagePool.getRowCnt());	//페이지 목록수
			model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
		}else{
			if(StringUtil.isNotBlank(imagePool.getSiteId())){
				// 이미지 조회
				objRtn = (ImagePool)imagePoolMgrService.getObjectList(imagePool);

				//실행결과 로기 생성
				this.resultLog(imagePool);
				
				// View 설정
				model.addAttribute("result", objRtn.getOutCursor());
				
				//페이징 정보
				model.addAttribute("rowCnt", imagePool.getRowCnt());	//페이지 목록수
				model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
			}
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(imagePool.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(imagePool.getPageNum()) + 
				  "&schType=" + StringUtil.nullCheck(imagePool.getSchType()) + 
				  "&schText=" + URLEncoder.encode(StringUtil.nullCheck(imagePool.getSchText()), "UTF-8");
		
		
		model.addAttribute("link", strLink);
		
		imagePool.setJsp("site/imagePoolMgr/imagePoolList");
		return new ModelAndView("ips.layout", "obj", imagePool);
	}

	/*****************************************************************
	* Form 이미지풀 추가/수정 폼
	* @param imagePool
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute ImagePool imagePool, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		imagePool.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, imagePool);
				
		ImagePool rtnImagePool = new ImagePool();
			
		//siteId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(imagePool.getImagePoolId())){
					
			// 비주얼존 상세 조회
			ImagePool objRtn = (ImagePool)imagePoolMgrService.getObject(imagePool);
			rtnImagePool = (ImagePool)objRtn.getOutCursor();
						
			//실행결과 로기 생성
			this.resultLog(imagePool);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnImagePool.setInBeforeData(rtnImagePool.makeDataString());
		}
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(imagePool.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(imagePool.getPageNum()) + 
				  "&schType=" + StringUtil.nullCheck(imagePool.getSchType()) + 
				  "&schText=" + URLEncoder.encode(StringUtil.nullCheck(imagePool.getSchText()), "UTF-8");
				
		model.addAttribute("link", strLink);
				
		// View 설정
		model.addAttribute("rtnImagePool", rtnImagePool);					
				
		imagePool.setJsp("site/imagePoolMgr/imagePoolForm");
		return new ModelAndView("ips.layout", "obj", imagePool);
	}
	
	/*****************************************************************
	 * insert 이미지풀 추가/수정
	 * @param imagePool
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute ImagePool imagePool, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		imagePool.setInParam(request);
		
		imagePool.setInWorkName("이미지풀관리");
		if(StringUtil.isNotBlank(imagePool.getImagePoolId())){
			imagePool.setInCondition("수정");
		}else{
			imagePool.setInCondition("입력");
		}

		// 콘텐츠 설명 CLOB세팅
		imagePool.setInCLOBData1(imagePool.getKDesc());

		// 첨부파일 JSON정보
		JSONParser jsonParser = new JSONParser();
		Object obj = null;
		JSONArray jsonArray = null;
		JSONObject jsonObject = null;
		
		// 이미지 첨부가 없을경우
		if(!StringUtil.isNotBlank(request.getParameter("modifiedFilesInfoImages"))) {
			if(StringUtil.isNotBlank(imagePool.getImageFileName())){
				NamoCrossFile.fileDeleteAttempt(imagePool.getFilePath(), imagePool.getImageSFileName());
				imagePool.setImageFileName(null);
				imagePool.setImageSFileName(null);
				imagePool.setFilePath(null);
			}
		}
		
		// 이미지 파일 등록
		if(StringUtil.isNotBlank(request.getParameter("uploadedFilesInfoImages"))) {
			String uploadedFilesInfoImages = request.getParameter("uploadedFilesInfoImages");
			obj = jsonParser.parse(uploadedFilesInfoImages); 
			jsonArray = (JSONArray)obj; 
			if(jsonArray.size() > 0){
				if(StringUtil.isNotBlank(imagePool.getImageFileName())){
					NamoCrossFile.fileDeleteAttempt(imagePool.getFilePath(), imagePool.getImageSFileName());
				}
				jsonObject = (JSONObject)jsonArray.get(0);
				
				imagePool.setImageFileName((String)jsonObject.get("origfileName"));
				imagePool.setImageSFileName((String)jsonObject.get("fileName"));
				imagePool.setFilePath((String)jsonObject.get("lastSavedDirectoryPath"));
			}
		}
		
		// 변경후 데이타 저장(inAfterData)
		imagePool.setInAfterData(imagePool.makeDataString());
		
		//InDMLData :: SiteID|ImagePoolID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|State
		imagePool.setInDMLData(imagePool.makeDMLDataString());

		// 저장
		ImagePool objRtn = (ImagePool)imagePoolMgrService.insertObject(imagePool);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(imagePool.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(imagePool.getPageNum()) + 
				  "&schType=" + StringUtil.nullCheck(imagePool.getSchType()) + 
				  "&schText=" + URLEncoder.encode(StringUtil.nullCheck(imagePool.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/imagePoolMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 이미지풀 삭제(데이터삭제)
	 * @param imagePool
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute ImagePool imagePool, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		imagePool.setInParam(request);		

		imagePool.setInWorkName("이미지풀관리");
		imagePool.setInCondition("삭제");

		//InDMLData ::  SiteID|ImagePoolID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|State
		imagePool.setInDMLData(imagePool.makeDMLDataString());

		// 저장
		ImagePool objRtn = (ImagePool)imagePoolMgrService.deleteObject(imagePool);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(imagePool.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(imagePool.getPageNum()) + 
				  "&schType=" + StringUtil.nullCheck(imagePool.getSchType()) + 
				  "&schText=" + URLEncoder.encode(StringUtil.nullCheck(imagePool.getSchText()), "UTF-8");
		
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/imagePoolMgr?"+strLink));
		return new ModelAndView(rv);
	}

}

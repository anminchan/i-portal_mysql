package kr.plani.ccis.ips.controller.site;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.controller.system.SiteMgrController;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentDelMgrService;

/*****************************************************************
* 콘첸츠등록관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2015. 09. 22. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2015. 09. 22.		mcahn		수정
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/contentDelMgr")
public class ContentDelMgrController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(SiteMgrController.class);

	/** 콘텐츠관리 서비스   */
	@Resource
	private ContentDelMgrService contentDelMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 삭제콘텐츠 
	* @param content
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 삭제게시판 조회
		//Title rtnDelBoard = (Title)contentDelMgrService.getObjectList(title);
		List<?> rtnDelBoard = contentDelMgrService.getObjectList(title);
		int boardListCnt = contentDelMgrService.getDelBoardListCnt(title);
		
		//페이징 정보
		model.addAttribute("result", rtnDelBoard);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() +				 
				  "&schType="+title.getSchType() + 
				  "&schText="+StringUtil.nullCheck(title.getSchText());
		
		model.addAttribute("link", strLink);
		
		title.setJsp("site/contentDelMgr/list");
		return new ModelAndView("ips.layout", "obj", title);
	}
	
	/*******************************************************************
	 * view 삭제콘텐츠 상세
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public ModelAndView view(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		link.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, link);
		
		// 콘텐츠설정 조회
		//ContentSet setItem = (ContentSet)contentDelMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentDelMgrService.getContentSet(contentSet));

		// 삭제콘텐츠 상세조회
		//Link rtnDeleteBoard = (Link)contentDelMgrService.getObject(link);
		model.addAttribute("rtnContent", contentDelMgrService.getObject(link));
		model.addAttribute("rtnFileList", contentDelMgrService.getAttachFileList(link));
		
		//HashMap hm = (HashMap) rtnDeleteBoard.getOutCursor();
		
		/*Title title = new Title();
		title.setMenuId(link.getMenuId());
		title.setInParam(request);
		title.setTitleId(Integer.parseInt(hm.get("TITLEID").toString()));*/
		
		//실행결과 로기 생성
		//this.resultLog(rtnDeleteBoard);
		
		//ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		String viewJsp = "site/contentDelMgr/view";
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				  "&rowCnt=" + link.getRowCnt() +
				  "&menuId=" + link.getMenuId() + 
				  "&schType="+link.getSchType() + 
				  "&schText="+StringUtil.nullCheck(link.getSchText());
		
		model.addAttribute("link", strLink);
		
		link.setJsp(viewJsp);
		return new ModelAndView("ips.layout", "obj", link);
	}
	
	/*****************************************************************
	 * update 수정
	 * @param content
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView act(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		content.setInParam(request);		

		content.setInWorkName("삭제콘텐츠게시판관리");
		content.setInCondition("수정");

		//다중 수정을위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		// After data 변수
		String contentData = null;
		
		// DML data 변수
		String contentDml = null;
		
		if(arrLinkId.length <= 1){			
			//parameter 설정
			content.setLinkId(arrLinkId[0].split("§§")[0]);
			content.setParamMenuId(arrLinkId[0].split("§§")[1]);
			
			contentData = content.makeDeleteDataString();
			//contentDml = content.makeDeleteDMLDataString();
			
			content.setInAfterData(contentData);
			//content.setInDMLData(contentDml);
			contentDelMgrService.updateObject(content);			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i].split("§§")[0]);
				content.setParamMenuId(arrLinkId[i].split("§§")[1]);
				
				//parameter 설정
				contentData = content.makeDeleteDataString();
				//contentDml = content.makeDeleteDMLDataString();
				
				content.setInAfterData(contentData);
				//content.setInDMLData(contentDml);
				contentDelMgrService.updateObject(content);	
			}
		}
		
		//링크 정보		
		String strLink = request.getParameter("link");
			
		model.addAttribute("link", strLink);
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		rv.setUrl(request.getContextPath().concat("/mgr/contentDelMgr?").concat(strLink));
		
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		content.setInParam(request);		

		content.setInWorkName("삭제콘텐츠게시판관리");
		content.setInCondition("삭제");

		//다중 수정을위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		// After data 변수
		String contentData = null;
		
		// DML data 변수
		String contentDml = null;
		
		if(arrLinkId.length <= 1){			
			//parameter 설정
			content.setLinkId(arrLinkId[0].split("§§")[0]);
			content.setParamMenuId(arrLinkId[0].split("§§")[1]);
			
			contentData = content.makeDeleteDataString();
			contentDml = content.makeDeleteDMLDataString();
			
			content.setInAfterData(contentData);
			//content.setInDMLData(contentDml);
			
			// 첨부파일 삭제
			List <HashMap<?,?>> fileList = (List<HashMap<?,?>>) contentDelMgrService.getAttachFileList(content);
			if(fileList.size() > 0){
				for (int i = 0; i < fileList.size(); i++) {
					try {
						
						// 파일이 저장된 서버측 전체경로
						String saveFilePath = "";
						saveFilePath = fileList.get(i).get("FILEPATH") + "" + fileList.get(i).get("SYSTEMFILENAME");
						
						File file = new File(saveFilePath);
						
						if(file.exists()){
							if(file.delete()){
								//logger.debug("fileDelete success !!! ");
							}else{
								//logger.debug("fileDelete fail !!! ");
							}
						}
						
					} catch (Exception e) {
						//logger.info(e);
			        	System.out.println("처리 중 오류가 발생했습니다.");
					}
				}
			}
			
			contentDelMgrService.updateObject(content);			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i].split("§§")[0]);
				content.setParamMenuId(arrLinkId[i].split("§§")[1]);
				
				//parameter 설정
				contentData = content.makeDeleteDataString();
				//contentDml = content.makeDeleteDMLDataString();
				
				content.setInAfterData(contentData);
				//content.setInDMLData(contentDml);
				
				// 첨부파일 삭제
				List <HashMap<?,?>> fileList = (List<HashMap<?,?>>) contentDelMgrService.getAttachFileList(content);
				if(fileList.size() > 0){
					for (int j = 0; j < fileList.size(); j++) {
						try {
							
							// 파일이 저장된 서버측 전체경로
							String saveFilePath = "";
							saveFilePath = fileList.get(j).get("FILEPATH") + "" + fileList.get(j).get("SYSTEMFILENAME");
							
							File file = new File(saveFilePath);
							
							if(file.exists()){
								if(file.delete()){
									logger.debug("fileDelete success !!! ");
								}else{
									logger.debug("fileDelete fail !!! ");
								}
							}
							
						} catch (Exception e) {
							//logger.info(e);
				        	System.out.println("처리 중 오류가 발생했습니다.");
						}
					}
				}
				
				contentDelMgrService.updateObject(content);	
			}
		}
		
		//링크 정보		
		String strLink = request.getParameter("link");
			
		model.addAttribute("link", strLink);
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		rv.setUrl(request.getContextPath().concat("/mgr/contentDelMgr?").concat(strLink));
		
		return new ModelAndView(rv);
	}
	
}

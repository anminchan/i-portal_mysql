
package kr.plani.ccis.ips.controller.site;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentSetMgrService;

/*****************************************************************
* 콘첸츠관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2014. 8. 26. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2014. 8. 26.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/contentSetMgr")
public class ContentSetMgrController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ContentSetMgrController.class);
	
	 /** 콘텐츠관리 서비스   */
	@Resource
	private ContentSetMgrService contentSetMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 콘텐츠 설정트리 목록 조회
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute ContentSet contentSet, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);

		// 파라메타 세팅
		contentSet.setSiteId(request.getParameter("siteId"));

		if(!StringUtil.isNotBlank(contentSet.getSiteId())) contentSet.setSiteId(getSiteId());

		// 콘텐츠설정 조회
		List<?> list = (List<?>) contentSetMgrService.getObjectList(contentSet);
		
		//실행결과 로기 생성
		this.resultLog(contentSet);
		
		// View 설정
		model.addAttribute("result", list);
		model.addAttribute("resultSite", commonService.getSiteName(contentSet));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", contentSet.getParamMenuId());
		model.addAttribute("pSiteId", contentSet.getSiteId());
		model.addAttribute("pAction", request.getParameter("action"));
		model.addAttribute("pChkMenu", request.getParameter("chkMenu"));
		
		contentSet.setJsp("site/contentSetMgr/form");
		return new ModelAndView("ips.layout", "obj", contentSet);
	}

	/*****************************************************************
	* Form 콘텐츠설정 추가/수정 폼
	* @param contentSet
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute ContentSet contentSet, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		contentSet.setInParam(request);
		
		// view 기본값 셋팅
		//this.setCommon(commonService, request, model, contentSet);

		ContentSet rtnContentSet = new ContentSet();
		List<?> cList = null;
		List<?> mList = null;
		//List<?> bList = null;
		//List<?> rList = null;
		List<?> cuList = null;
		StringBuffer cDetail = new StringBuffer();
		/*StringBuffer mDetail1 = new StringBuffer();
		StringBuffer mDetail2 = new StringBuffer();
		StringBuffer mDetail3 = new StringBuffer();
		StringBuffer mDetail4 = new StringBuffer();*/
		//StringBuffer rDetail = new StringBuffer();
		StringBuffer cuDetail = new StringBuffer();
		
		//menuId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(contentSet.getParamMenuId())){
			
			contentSet.setMenuId(contentSet.getParamMenuId());
			// 메뉴 상세 조회
			rtnContentSet = (ContentSet)contentSetMgrService.getObject(contentSet);
					
			if(rtnContentSet != null){
				cList = contentSetMgrService.getCategoryList(contentSet); // 카테고리조회
				//mList = contentSetMgrService.getManageUserList(contentSet); // 경영공시담당자조회
				cuList = contentSetMgrService.getCustomizingList(contentSet); // 게시판목록정의조회
				
				// 카테고리 설정
				for(int i=0; i<cList.size(); i++){
					HashMap item = (HashMap) cList.get(i);

					String categoryId = (String)item.get("CATEGORYID");
					String categoryName = (String)item.get("CATEGORYNAME");
					String state = (String)item.get("STATE");
					
					if((cList.size()-1) > i){					
						cDetail.append(categoryId + "||"+ categoryName + "||" + state + "#");
						
					}else{
						cDetail.append(categoryId + "||"+ categoryName + "||" + state);
					}
				}
				
				rtnContentSet.setCategory(cDetail.toString());
				
				// 경영공시 User설정
				/*int confrimMTypeCnt = 0; 
				int chargeMTypeCnt = 0;
				int writeMTypeCnt = 0;
				int write2MTypeCnt = 0;
				
				mList = (List<?>) objRtn.getOutCursor2();
				for(int j=0; j<mList.size(); j++){
					HashMap item = (HashMap) mList.get(j);
					
					if(item.get("MANAGETYPE").equals("01")) confrimMTypeCnt++;
					else if(item.get("MANAGETYPE").equals("02")) chargeMTypeCnt++;
					else if(item.get("MANAGETYPE").equals("03")) writeMTypeCnt++;
					else if(item.get("MANAGETYPE").equals("04")) write2MTypeCnt++;
				}
				
				int num = 0;
				int num1 = 0;
				int num2 = 0;
				int num3 = 0;
				
				for(int j=0; j<mList.size(); j++){
					HashMap item = (HashMap) mList.get(j);

					String userName = (String)item.get("USERNAME");
					String userId = (String)item.get("USERID");
					
					if(item.get("MANAGETYPE").equals("01")){
						if((confrimMTypeCnt-1) > num) mDetail1.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId+",");
						else mDetail1.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId);
						
						num++;
					}else if(item.get("MANAGETYPE").equals("02")){
						if((chargeMTypeCnt-1) > num1) mDetail2.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId+",");
						else mDetail2.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId);

						num1++;
					}else if(item.get("MANAGETYPE").equals("03")){
						if((writeMTypeCnt-1) > num2) mDetail3.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId+",");
						else mDetail3.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId);

						num2++;
					}else if(item.get("MANAGETYPE").equals("04")){
						if((write2MTypeCnt-1) > num3) mDetail4.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId+",");
						else mDetail4.append("[직급/"+userName+"/"+userId+"/전화번호]#"+userId);

						num3++;
					}
				}
				
				String manageUser = mDetail1.toString()+"||"+mDetail2.toString()+"||"+mDetail3.toString()+"||"+mDetail4.toString();
				
				// 경영공시 data
				rtnContentSet.setManageUser(manageUser);*/
								
				// 참조형게시판 참조메뉴
				/*rList = (List<?>) objRtn.getOutCursor3();
				for(int r=0; r<rList.size(); r++){
					HashMap item = (HashMap) rList.get(r);
					
					if(r > 0) rDetail.append("||");
					rDetail.append(item.get("MENUID") + "#" +item.get("MENUNAME") + "#" + item.get("LOCATION"));
				}
				rtnContentSet.setReferenceMenus(rDetail.toString());*/
				
				// 게시판 목록 형태
				for(int r=0; r<cuList.size(); r++){
					HashMap item = (HashMap) cuList.get(r);
					
					if(r > 0) cuDetail.append("||");
					cuDetail.append(item.get("INFO"));
				}
				rtnContentSet.setCustomizingInfo(cuDetail.toString());
				
				//실행결과 로기 생성
				this.resultLog(rtnContentSet);
					
				// 변경전 데이타 저장(inBeforeData)	
				rtnContentSet.setInBeforeData(rtnContentSet.makeDataString());
			}
		}
		return rtnContentSet;
	}
	
	/*****************************************************************
	 * insert 콘텐츠설정 추가/수정/삭제
	 * @param menu
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute ContentSet contentSet, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		contentSet.setInParam(request);
		
		contentSet.setInWorkName("콘텐츠설정관리");
		if(StringUtil.isNotBlank(contentSet.getBoardId())){
			contentSet.setInCondition("수정");
		}else{
			contentSet.setInCondition("입력");
		}

		// 콘텐츠 상하위 설명 CLOB세팅
		//contentSet.setInCLOBData1(contentSet.getBoardHeaderKHtml());
		//contentSet.setInCLOBData2(contentSet.getBoardFooterKHtml());
		
		// 변경후 데이타 저장(inAfterData)
		contentSet.setInAfterData(contentSet.makeDataString());
		
		String refMenuIds = request.getParameter("refMenuIds");
				
		// 카테고리 파라메타 세팅 :: 카테고리갯수|(1)카테고리ID#(2)카테고리ID#...|(1)카테고리명#(2)카테고리명#...
		String categoryCount = request.getParameter("pCategoryCount");
		String categoryId = request.getParameter("pCategoryId");
		String categoryName = request.getParameter("pCategoryName");
		 
		String customizingCount = request.getParameter("pCustomizingCount");
		String customizingInfo = request.getParameter("pCustomizingInfo");
		
		/*String confirmUserCount = request.getParameter("pConfirmUserCount");
		String confirmUserId = request.getParameter("pConfirmUserId");
		String chargeUserCount = request.getParameter("pChargeUserCount");
		String chargeUserId = request.getParameter("pChargeUserId");
		String writeUserCount = request.getParameter("pWriteUserCount");
		String writeUserId = request.getParameter("pWriteUserId");
		String writeUser2Count = request.getParameter("pWriteUser2Count");
		String writeUser2Id = request.getParameter("pWriteUser2Id");*/
		
		
		//InDMLData ::  BoardID|MenuID|KName|KDesc|BoardKind|BoardListKind|PageCount|CommentYN|NoticeYN|SecretYN|RssYN|CategoryYN|FileMaxCount|FileMaxSize|AddField1|AddField2|AddField3|State
		//              |카테고리갯수|(1)카테고리ID#(2)카테고리ID#...|(1)카테고리명#(2)카테고리명#...|확인자명수|(1)확인자ID#(2)확인자ID|감독자명수|(1)감독자ID#(2)감독자ID|작성자명수|(1)작성자ID#(2)작성자ID
		//contentSet.setInDMLData(contentSet.makeDMLDataString(refMenuIds, categoryCount, categoryId, categoryName, customizingCount, customizingInfo));
		/*contentSet.setInDMLData(contentSet.makeDMLDataString(categoryCount, categoryId, categoryName, confirmUserCount, confirmUserId, chargeUserCount, chargeUserId, writeUserCount, writeUserId, writeUser2Count, writeUser2Id));*/

		contentSet.setCategoryId(categoryId);
		contentSet.setCategoryName(categoryName);
		contentSet.setCustomizingInfo(customizingInfo);
		
		// 저장
		ContentSet objRtn = (ContentSet)contentSetMgrService.insertObject(contentSet);
		
		//changLog
		contentSet.setDmlType(contentSet.getInCondition().equals("입력") ? "I" : contentSet.getInCondition().equals("수정") ? "U" : "D");
		contentSet.setDmlNotice("정상적으로 ("+contentSet.getInWorkName()+")"+contentSet.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(contentSet);
				
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
				
		if(!StringUtil.isNotBlank(contentSet.getParamMenuId())) contentSet.setParamMenuId(contentSet.getMenuId());
		else contentSet.setParamMenuId(contentSet.getParamMenuId());

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId()) +
				  "&paramMenuId=" + StringUtil.nullCheck(contentSet.getParamMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(contentSet.getSiteId()) +
				  "&action=" + StringUtil.nullCheck("act") +
				  "&chkMenu=" + StringUtil.nullCheck(request.getParameter("pChkMenu"));
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/contentSetMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/selectRefMenuPopup")
    public ModelAndView selectRefMenuPopup(@ModelAttribute ContentSet contentSet, HttpServletRequest request, Model model) throws Exception {
		
		// 파라메타 세팅
		contentSet.setSiteId(request.getParameter("siteId"));

		if(!StringUtil.isNotBlank(contentSet.getSiteId())) contentSet.setSiteId(getSiteId());
				
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentSetMgrService.getObjectList(contentSet);
				
		//실행결과 로기 생성
		this.resultLog(contentSet);
		
		// View 설정
		model.addAttribute("result", objRtn.getOutCursor());
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", contentSet.getParamMenuId());
		model.addAttribute("pSiteId", contentSet.getSiteId());

		contentSet.setJsp("site/contentSetMgr/selectRefMenuPopup");
		contentSet.setViewTitle("선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", contentSet);
    }
	
}

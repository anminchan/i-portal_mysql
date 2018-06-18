package kr.plani.ccis.ips.controller.system;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.ExcelDownload;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.system.Group;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.system.GroupMgrService;

/*****************************************************************
* 사용자 계정을 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
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
@RequestMapping(value="/mgr/groupMgr")
public class GroupMgrController extends BaseController {

	 /** 사이트관리 서비스   */
	@Resource
	private GroupMgrService groupMgrService;
	
	 /** 공통기능 서비스   */
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 그룹 목록 조회
	* @param group
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Group group, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		group.setInParam(request);
		
		if(group.getGroupType() != null || group.getGroupType() != "" ) {
			group.setInGroupType(group.getGroupType());			
		}		
		if(group.getSearchType() != null || group.getSearchType() != ""){
			group.setInSearchType(group.getSearchType());			
		}
		if(group.getSearchText() != null || group.getSearchText() != ""){
			group.setInSearchText(StringUtil.paramUnscript(group.getSearchText()));
		}
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, group);
		
		// 그룹 조회
		//Group objRtn = (Group)groupMgrService.getObjectList(group);
		List<?> list = groupMgrService.getObjectList(group);
		
		// View 설정
		model.addAttribute("result", list);
		
		//페이징 정보
		model.addAttribute("rowCnt", group.getRowCnt());		//페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT"))));	//전체 카운트
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(group.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(group.getPageNum()) +
				  "&groupType=" + StringUtil.nullCheck(group.getGroupType()) +
				  "&searchType=" + StringUtil.nullCheck(group.getSearchType()) +
				  "&searchText=" + StringUtil.nullCheck(group.getSearchText());
		
		model.addAttribute("link", strLink);		
		
		group.setJsp("system/groupMgr/list");
		return new ModelAndView("ips.layout", "obj", group);
	}
	
	/**
	 * form 그룹정보 상세
	 * @param group
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/form")
	public ModelAndView form(@ModelAttribute Group group, HttpServletRequest request, Model model) throws Exception{
		
		//파라미터 설정
		group.setInParam(request);		
		group.setGroupId(group.getGroupId());
		
		//기본셋팅
		this.setCommon(commonService, request, model, group);
		
		//Group rtnGroup = new Group();
		if(group.getGroupId() != null){
			//그룹 상세 조회
			//Group objRtn = (Group)groupMgrService.getObject(group);
			//rtnGroup = (Group)objRtn.getOutCursor();
			HashMap<?,?> rtnGroup = (HashMap<?, ?>)groupMgrService.getObject(group);
			List <?> rtnGroupUser = (List<?>)groupMgrService.getObjectUserList(group);
			
			//view 설정
			model.addAttribute("rtnGroup", rtnGroup);
			model.addAttribute("rtnUser", rtnGroupUser);
		}
		
		//링크 설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(group.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(group.getPageNum()) +
				  "&groupType=" + StringUtil.nullCheck(group.getGroupType()) +
				  "&siteId=" + StringUtil.nullCheck(group.getSiteId()) +
				  "&searchType=" + StringUtil.nullCheck(group.getSearchType()) +
				  "&searchText=" + StringUtil.nullCheck(group.getSearchText());
		
		model.addAttribute("link", strLink);
		group.setJsp("system/groupMgr/form");
		return new ModelAndView("ips.layout", "obj", group);
	}
	
	/*****************************************************************
	 * insert 그룹 추가/수정/삭제
	 * @param group
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act")
	public ModelAndView act(@ModelAttribute Group group, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		group.setInParam(request);	

		group.setInWorkName("그룹관리");
		if(StringUtil.isNotBlank(group.getGroupId())){
			group.setInCondition("수정");
		}else{
			group.setInCondition("입력");
		}
		
		// 변경후 데이타 저장(inAfterData)
		group.setInAfterData(group.makeDataString());

		//InDMLData ::  GroupID|GroupType|GroupTypeName|KName
		//group.setInDMLData(group.makeDMLDataString());

		// 저장
		Group objRtn = (Group)groupMgrService.actObject(group);

		//changLog
		group.setDmlType(group.getInCondition().equals("입력") ? "I" : group.getInCondition().equals("수정") ? "U" : "D");
		group.setDmlNotice("정상적으로 ("+group.getInWorkName()+")"+group.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(group);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);		
		
		//실행결과 메세지처리
		this.setMessage(request, objRtn); 
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(group.getMenuId())+
				  "&pageNum=" + StringUtil.nullCheck(group.getPageNum()) +
				  "&groupType=" + StringUtil.nullCheck(group.getGroupType()) +
				  "&searchType=" + StringUtil.nullCheck(group.getSearchType()) +
				  "&searchText=" + StringUtil.nullCheck(URLEncoder.encode(group.getSearchText(),"UTF-8"));
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/groupMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * insert 그룹 회원 추가
	 * @param group
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/actUser")
	public ModelAndView actUser(@ModelAttribute Group group, HttpServletRequest request, Model model) throws Exception {
		
		//기본 Parameter 설정
		group.setInParam(request);		
		
		String reason = request.getParameter("reason");
		String menuId = request.getParameter("menuId");
		String userId = request.getParameter("userId");
		String fileGubun = request.getParameter("fileGubun");
		
		group.setInWorkName("회원그룹관리");
		
		group.setInRECUserID(userId);
		group.setInExecMenuId(menuId); 
		group.setMessage(reason); 
		group.setUseComId(group.getGroupId());
		group.setFileGubun(fileGubun);

		if(group.getCondition().equals("ins")){
			group.setInCondition("입력");
			group.setInRECDesc( group.getKName() + ": 그룹권한 부여");
			group.setInGubun("I");
		} else {
			group.setInCondition("삭제");
			group.setInRECDesc( group.getKName() + ": 그룹권한 삭제");
			group.setInGubun("D");
		}
		
		//commonService.insertUserInfoLog(group);

		// 변경후 데이타 저장(inAfterData)
		group.setInAfterData(group.makeDataString1());
		
		//InDMLData ::  GroupID|UserID|State
		group.setInDMLData(group.makeDMLDataString1());

		// 저장
		Group objRtn = (Group)groupMgrService.actUserObject(group);
		
		//실행결과 로그 생성
		this.resultLog(group);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(request.getParameter("menuId")) +
				  "&groupId=" + StringUtil.nullCheck(request.getParameter("groupId"));		
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/groupMgr/form?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 그룹 삭제(상태값 변경)
	 * @param group
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete")
	public ModelAndView delete(@ModelAttribute Group group, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		group.setInParam(request);		

		group.setInWorkName("그룹관리");
		group.setInCondition("삭제");	

		// 저장
		Group objRtn = (Group)groupMgrService.deleteObject(group);
		
		//실행결과 로기 생성
		this.resultLog(group);
		
		String strLink = "";
		strLink = "menuId=" + StringUtil.nullCheck(request.getParameter("menuId"));
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/groupMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/ExcelDown")
	public void excelDown(@ModelAttribute Group group, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		// Parameter 설정
		group.setInParam(request);
		
		group.setRowCnt(1000);
		group.setExcelDownYn("Y");
		
		if(group.getGroupType() != null || group.getGroupType() != "" ) {
			group.setInGroupType(group.getGroupType());			
		}		
		if(group.getSearchType() != null || group.getSearchType() != ""){
			group.setInSearchType(group.getSearchType());			
		}
		if(group.getSearchText() != null || group.getSearchText() != ""){
			group.setInSearchText(group.getSearchText());
		}
		
		// 그룹 조회
		Group objRtn = (Group)groupMgrService.getObjectList(group);
		
		//실행결과 로기 생성
		this.resultLog(group);
		
		// View 설정
		List list = (List) objRtn.getOutCursor();
		
		// int -> String
		for(int i = 0; i < list.size(); i++){
			((Map)list.get(i)).put("CNT", String.valueOf(((Map)list.get(i)).get("CNT")));
		}

		String[] headerName = {"그룹유형", "그룹ID", "그룹명", "회원수"};
		String[] columnName = {"groupType_Name", "groupId", "KName", "cnt"};
		String sheetName = "그룹정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
	
}

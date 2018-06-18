package kr.plani.ccis.mps.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.base.controller.BaseCommonController;
import kr.plani.ccis.base.domain.MemberInfo;
import kr.plani.ccis.ips.domain.common.User;
import kr.plani.ccis.ips.domain.system.PersonUser;
import kr.plani.ccis.mps.mapper.MemberMapper;

@Service("memberService")
public class MemberService extends EgovAbstractServiceImpl {
	
	private static final Logger logger = LoggerFactory.getLogger(BaseCommonController.class);
	
	@Resource
	MemberMapper memberMapper;
	
	public Object getPersonObject(MemberInfo obj) throws Exception{
		return memberMapper.viewPerson(obj);
	}
	
	public Object getCompanyObject(MemberInfo obj) throws Exception{
		return memberMapper.viewCompany(obj);
	}

	public String getAdmCheckYn(MemberInfo obj) throws Exception{
		return memberMapper.getAdmCheckYn(obj);
	}
	
	/*****************************************************************
	* updateCompanyUser 기업회원 수정/탈퇴
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object updateCompanyUser(Object obj) throws Exception {
		return memberMapper.companyAction(obj);
	}
	
	/*****************************************************************
	* updatePersonUser ID통합  개인회원 수정/탈퇴
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Transactional
	public Object updatePersonUser(Object obj, HttpServletRequest request) throws Exception {
		
		PersonUser inObj = (PersonUser)obj;
		
		//개인회원 등록
		inObj = (PersonUser)memberMapper.personAction(inObj);
		
		return inObj;
	}
	
	//기존회원테이블 정보 조회
	public HashMap<String, String> getWithDrawPwChageYn(String obj) throws Exception {
		return memberMapper.getWithDrawPwChageYn(obj);
	}
	
	/*****************************************************************
	* getObject 사용자 ID 검색 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object getObject(Object obj) throws Exception {
		User inObj = (User)obj;
		memberMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);

		return inObj;
	}
	
	/*****************************************************************
	* getObject 사용자 임시비밀번호 생성
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/	
	public Object insertObject(Object obj) throws Exception {
		User inObj = (User)obj;
		memberMapper.insert(inObj);
		
		return inObj;
	}
	
	//사업자 등록번호 idSearch 확인
	public List<HashMap<String, String>> idSearchCompany(Object obj) throws Exception {
			
		return memberMapper.idSearchCompany(obj);
	}
	
	//사업자 등록번호 idSearch 확인
	public List<HashMap<String, String>> pwSearchCompany(Object obj) throws Exception {
			
		return memberMapper.pwSearchCompany(obj);
	}
	
}

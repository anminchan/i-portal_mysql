package kr.plani.ccis.ips.service.system;

import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.system.Member;
import kr.plani.ccis.ips.mapper.system.CompanyUserMgrMapper;
import kr.plani.ccis.ips.mapper.system.MemberMgrMapper;
import kr.plani.ccis.ips.mapper.system.PersonUserMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("memberMgrService")
public class MemberMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberMgrService.class);
	
	@Resource
	private MemberMgrMapper memberMgrMapper;
	
	@Resource
	private CompanyUserMgrMapper companyUserMgrMapper;
	
	@Resource
	private PersonUserMgrMapper personUserMgrMapper;

	
	/*****************************************************************
	* getObject 회원 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Member inObj = (Member)obj;
		return memberMgrMapper.view(inObj);
	}

	/*****************************************************************
	 * getObject 회원의 그룹목록 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getUserGroupList(Object obj) throws Exception {
		Member inObj = (Member)obj;
		return memberMgrMapper.getUserGroupList(obj);
	}
	
	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/*****************************************************************
	* updateObject 회원 수정(미완료)
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object updateObject(Object obj) throws Exception {
		return memberMgrMapper.action(obj);
	}


	@Override
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/*****************************************************************
	* getObjectList 회원 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		Member inObj = (Member)obj;
		return memberMgrMapper.list(inObj);
	}
	
	public int getObjectListCnt(Object obj) throws Exception {
		Member inObj = (Member)obj;
		return memberMgrMapper.listCnt(inObj);
	}
	
	/*****************************************************************
	 * getMemberPopupList 회원 목록(팝업) 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getMemberPopupList(Object obj) throws Exception
	{
		Member inObj = (Member)obj;
		return memberMgrMapper.memberPopupList(inObj);
	}
	
	/*****************************************************************
	* updateCompanyUser 기업회원 수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object updateCompanyUser(Object obj) throws Exception {
		return companyUserMgrMapper.action(obj);
	}
	
	
	/*****************************************************************
	* updatePersonUser 개인회원 수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object updatePersonUser(Object obj) throws Exception {
		return personUserMgrMapper.action(obj);
	}
	
	
	/*****************************************************************
	* insertTeamInfo 내부직원 부서정보 수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object insertTeamInfo(Object obj) throws Exception {
		return memberMgrMapper.action(obj);
	}
	
	/*****************************************************************
	* insertTeamInfo 내부직원 부서정보 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Transactional
	/*public Object deleteTeamInfo(Object obj) throws Exception {
		KhidiUser inObj = (KhidiUser)obj;
		String inputGRval = inObj.getInputGRVal();
		logger.info("inputGRval>>" + inputGRval);		
		StringTokenizer st1 = new StringTokenizer(inputGRval,",");
	    
		while(st1.hasMoreTokens()){
			String inDMLData = st1.nextToken();
			inObj.setInDMLData(inDMLData);
			memberMgrMapper.action(inObj);
		}
		return inObj;
	}*/
	
	/*****************************************************************
	 * getMemberTeamList 내부직원 부서조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object getMemberTeamList(Object obj) throws Exception {
		Member inObj = (Member)obj;
		memberMgrMapper.memberTeamList(inObj);
		return inObj;
	}

	/*****************************************************************
	 * getDeptList 부서조회
	 * @param 
	 * @return List
	 * @throws Exception
	 *******************************************************************/
	public List<HashMap<String, String>> getDeptList() throws Exception{
		return memberMgrMapper.deptList();
	}
	
	/*****************************************************************
	 * getDutyList 부서조회
	 * @param 
	 * @return List
	 * @throws Exception
	 *******************************************************************/
	public List<HashMap<String, String>> getDutyList() throws Exception{
		return memberMgrMapper.dutyList();
	}
	
	/*****************************************************************
	 * getPositionList 부서조회
	 * @param 
	 * @return List
	 * @throws Exception
	 *******************************************************************/
	public List<HashMap<String, String>> getPositionList() throws Exception{
		return memberMgrMapper.positionList();
	}
	
}

package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.PersonalInfo;
import kr.plani.ccis.ips.mapper.site.PersonalInfoMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("personalInfoMgrService")
public class PersonalInfoMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private PersonalInfoMgrMapper personalInfoMgrMapper;

	
	/*****************************************************************
	* getObjectList 개인정보처리방침 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<PersonalInfo> getObjectList(Object obj) throws Exception{
		PersonalInfo inObj = (PersonalInfo)obj;
		
		return personalInfoMgrMapper.list(inObj);
	}	
	
	public List<PersonalInfo> getObjectList2(Object obj) throws Exception{
		PersonalInfo inObj = (PersonalInfo)obj;
		
		return personalInfoMgrMapper.list2(inObj);
	}	
	
	public int getObjectListCnt(Object obj) throws Exception{
		PersonalInfo inObj = (PersonalInfo)obj;
		
		return personalInfoMgrMapper.listCnt(inObj);
	}
	
	public String getMaxId() throws Exception{
		
		return personalInfoMgrMapper.maxId();
	}	

	/*****************************************************************
	* getObjectList 개인정보처리방침 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		PersonalInfo inObj = (PersonalInfo)obj;
		
		/*List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);*/
		
		return personalInfoMgrMapper.view(inObj);
	}

	/*****************************************************************
	* insertObject 개인정보처리방침 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		PersonalInfo inObj = (PersonalInfo)obj;
		if(inObj.getInCondition().equals("입력")){
			personalInfoMgrMapper.insert(inObj);
		}else if(inObj.getInCondition().equals("수정")){
			personalInfoMgrMapper.update(inObj);
		}
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 개인정보처리방침 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		PersonalInfo inObj = (PersonalInfo)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkPersonalInfoIds() == null){
				personalInfoMgrMapper.delete(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkPersonalInfoIds().length; i++){
		    		PersonalInfo personalInfoData = new PersonalInfo();
		    		personalInfoData.setPersonalInfoId(inObj.getChkPersonalInfoIds()[i]);
		    		//personalInfoData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		//personalInfoData.setInDMLData(personalInfoData.makeDMLDataString());	//DML 생성
		    		personalInfoMgrMapper.delete(personalInfoData);
				}
			}
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return null;
	}

}

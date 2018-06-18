package kr.plani.ccis.ips.service.system;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.system.Group;
import kr.plani.ccis.ips.mapper.system.GroupMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("groupMgrService")
public class GroupMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private GroupMgrMapper groupMapper;
	

	/*****************************************************************
	* getObjectList 그룹 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Group inObj = (Group)obj;
		return groupMapper.list(inObj);
	}	
	
	/*****************************************************************
	* getObject 그룹 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Group inObj = (Group)obj;
		return groupMapper.view(inObj);
	}
	
	/*****************************************************************
	* getObject 그룹내 유저 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> getObjectUserList(Object obj) throws Exception {
		Group inObj = (Group)obj;
		return groupMapper.userList(inObj);
	}
	
	/*****************************************************************
	* insertObject 그룹 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object actObject(Object obj) throws Exception {
		Group inObj = (Group)obj;
		groupMapper.act(inObj);
		
		return inObj;
	}
	
	/*****************************************************************
	* insertObject 그룹회원추가
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/	
	public Object actUserObject(Object obj) throws Exception {
		Group inObj = (Group)obj;
		groupMapper.actUser(inObj);
		
		return inObj;
	}
	

	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		Group inObj = (Group)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkGroupIds() == null){
				groupMapper.act(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkGroupIds().length; i++){
		    		Group groupData = new Group();
		    		groupData.setGroupId(inObj.getChkGroupIds()[i]);

		    		groupData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		    		
		    		groupData.setInDMLData(groupData.makeDMLDataString());	//DML 생성
		    		
		    		groupMapper.act(groupData);
				}
			}
		}else{
			groupMapper.act(inObj);
		}
		
		return inObj;
	}

}

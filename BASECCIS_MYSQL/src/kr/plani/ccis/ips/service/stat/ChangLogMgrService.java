package kr.plani.ccis.ips.service.stat;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.stat.Stat;
import kr.plani.ccis.ips.mapper.stat.ChangLogMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("changLogMgrService")
public class ChangLogMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private ChangLogMgrMapper changLogMgrMapper;

	
	/*****************************************************************
	* getObjectList 변경현황 관리 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		Stat inObj = (Stat)obj;
		changLogMgrMapper.list(inObj);
		
		return inObj;
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
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
		Stat inObj = (Stat)obj;
		
		//삭제 - 한건삭제, 다중삭제 구분
		if(inObj.getInGubun().equals("ALL")){
			changLogMgrMapper.delete(inObj);
		}else{
			if(inObj.getChkIds() == null){
				changLogMgrMapper.delete(inObj);
				
			}else{
			   	for(int i=0; i<inObj.getChkIds().length; i++){
			   		Stat statData = new Stat();
			   		statData.setInGubun("PER");
			   		statData.setInNo(inObj.getChkIds()[i]);
		    		
			   		changLogMgrMapper.delete(statData);
				}
			}
		}
		return inObj;
	}

}

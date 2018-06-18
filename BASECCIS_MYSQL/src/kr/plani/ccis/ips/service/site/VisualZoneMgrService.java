package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.VisualZone;
import kr.plani.ccis.ips.mapper.site.VisualZoneMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("visualZoneMgrService")
public class VisualZoneMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private VisualZoneMgrMapper visualZoneMgrMapper;

	
	/*****************************************************************
	* getObjectList 베너 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		VisualZone inObj = (VisualZone)obj;
		visualZoneMgrMapper.list(inObj);
		
		return inObj;
	}	

	/*****************************************************************
	* getObjectList 베너 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		VisualZone inObj = (VisualZone)obj;
		visualZoneMgrMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 베너 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		VisualZone inObj = (VisualZone)obj;
		visualZoneMgrMapper.insert(inObj);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 베너 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		VisualZone inObj = (VisualZone)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkVisualZoneIds() == null){
				visualZoneMgrMapper.insert(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkVisualZoneIds().length; i++){
		    		VisualZone visualZoneData = new VisualZone();
		    		visualZoneData.setVisualZoneId(inObj.getChkVisualZoneIds()[i]);

		    		visualZoneData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		
		    		visualZoneData.setInDMLData(visualZoneData.makeDMLDataString());	//DML 생성
		    		
		    		visualZoneMgrMapper.insert(visualZoneData);
				}
			}
		}else{
			visualZoneMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return visualZoneMgrMapper.update(obj);
	}

}

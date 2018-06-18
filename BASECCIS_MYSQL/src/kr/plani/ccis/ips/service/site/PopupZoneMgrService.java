package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.PopupZone;
import kr.plani.ccis.ips.mapper.site.PopupZoneMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("popupZoneMgrService")
public class PopupZoneMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private PopupZoneMgrMapper popupZoneMgrMapper;

	
	/*****************************************************************
	* getObjectList 팝업존 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		PopupZone inObj = (PopupZone)obj;
		popupZoneMgrMapper.list(inObj);
		
		return inObj;
	}	

	/*****************************************************************
	* getObjectList 팝업존 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		PopupZone inObj = (PopupZone)obj;
		popupZoneMgrMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 팝업존 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		PopupZone inObj = (PopupZone)obj;
		popupZoneMgrMapper.insert(inObj);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 팝업존 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		PopupZone inObj = (PopupZone)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkPopupZoneIds() == null){
				popupZoneMgrMapper.insert(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkPopupZoneIds().length; i++){
		    		PopupZone popupZoneData = new PopupZone();
		    		popupZoneData.setPopupZoneId(inObj.getChkPopupZoneIds()[i]);

		    		popupZoneData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		
		    		popupZoneData.setInDMLData(popupZoneData.makeDMLDataString());	//DML 생성
		    		
		    		popupZoneMgrMapper.insert(popupZoneData);
				}
			}
		}else{
			popupZoneMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return popupZoneMgrMapper.update(obj);
	}

}

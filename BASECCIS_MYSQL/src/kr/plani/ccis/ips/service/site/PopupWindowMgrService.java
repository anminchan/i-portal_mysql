package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.PopupWindow;
import kr.plani.ccis.ips.mapper.site.PopupWindowMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("popupWindowMgrService")
public class PopupWindowMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private PopupWindowMgrMapper popupWindowMgrMapper;

	
	/*****************************************************************
	* getObjectList 팝업존 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		PopupWindow inObj = (PopupWindow)obj;
		popupWindowMgrMapper.list(inObj);
		
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
		PopupWindow inObj = (PopupWindow)obj;
		popupWindowMgrMapper.view(inObj);
		
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
		PopupWindow inObj = (PopupWindow)obj;
		popupWindowMgrMapper.insert(inObj);
		
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
		PopupWindow inObj = (PopupWindow)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkPopupIds() == null){
				popupWindowMgrMapper.insert(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkPopupIds().length; i++){
		    		PopupWindow popupWindowData = new PopupWindow();
		    		popupWindowData.setPopupId(inObj.getChkPopupIds()[i]);

		    		popupWindowData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		
		    		popupWindowData.setInDMLData(popupWindowData.makeDMLDataString());	//DML 생성
		    		
		    		popupWindowMgrMapper.insert(popupWindowData);
				}
			}
		}else{
			popupWindowMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return popupWindowMgrMapper.update(obj);
	}

}

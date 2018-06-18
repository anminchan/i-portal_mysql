package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.Doodles;
import kr.plani.ccis.ips.mapper.site.DoodlesMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("doodlesMgrService")
public class DoodlesMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private DoodlesMgrMapper doodlesMgrMapper;

	
	/*****************************************************************
	* getObjectList 팝업존 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<Doodles> getObjectList(Object obj) throws Exception{
		Doodles inObj = (Doodles)obj;
		
		return doodlesMgrMapper.list(inObj);
	}	
	
	public int getObjectListCnt(Object obj) throws Exception{
		Doodles inObj = (Doodles)obj;
		
		return doodlesMgrMapper.listCnt(inObj);
	}	

	/*****************************************************************
	* getObjectList 팝업존 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Doodles inObj = (Doodles)obj;
		
		/*List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);*/
		
		return doodlesMgrMapper.view(inObj);
	}

	/*****************************************************************
	* insertObject 팝업존 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		Doodles inObj = (Doodles)obj;
		if(inObj.getInCondition().equals("입력")){
			doodlesMgrMapper.insert(inObj);
		}else if(inObj.getInCondition().equals("수정")){
			doodlesMgrMapper.update(inObj);
		}
		
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
		Doodles inObj = (Doodles)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkDoodlesIds() == null){
				doodlesMgrMapper.delete(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkDoodlesIds().length; i++){
		    		Doodles doodlesData = new Doodles();
		    		doodlesData.setDoodlesId(inObj.getChkDoodlesIds()[i]);
		    		//doodlesData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		//doodlesData.setInDMLData(doodlesData.makeDMLDataString());	//DML 생성
		    		doodlesMgrMapper.delete(doodlesData);
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

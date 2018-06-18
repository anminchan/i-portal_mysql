package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.FamilySite;
import kr.plani.ccis.ips.mapper.site.FamilySiteMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("familySiteMgrService")
public class FamilySiteMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private FamilySiteMgrMapper familySiteMgrMapper;

	
	/*****************************************************************
	* getObjectList 추천사이트 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		FamilySite inObj = (FamilySite)obj;
		familySiteMgrMapper.list(inObj);
		
		return inObj;
	}	

	/*****************************************************************
	* getObjectList 추천사이트 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		FamilySite inObj = (FamilySite)obj;
		familySiteMgrMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 추천사이트 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		FamilySite inObj = (FamilySite)obj;
		familySiteMgrMapper.insert(inObj);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 추천사이트 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		FamilySite inObj = (FamilySite)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkSiteLinkIds() == null){
				familySiteMgrMapper.insert(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkSiteLinkIds().length; i++){
		    		FamilySite familySiteData = new FamilySite();
		    		familySiteData.setSiteLinkId(inObj.getChkSiteLinkIds()[i]);

		    		familySiteData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		
		    		familySiteData.setInDMLData(familySiteData.makeDMLDataString());	//DML 생성
		    		
		    		familySiteMgrMapper.insert(familySiteData);
				}
			}
		}else{
			familySiteMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return familySiteMgrMapper.update(obj);
	}

}

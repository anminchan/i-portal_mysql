package kr.plani.ccis.ips.service.system;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.system.Site;
import kr.plani.ccis.ips.mapper.system.SiteMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("siteMgrService")
public class SiteMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private SiteMgrMapper siteMapper;

	
	/*****************************************************************
	* getObjectList 사이트 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Site inObj = (Site)obj;
		return siteMapper.list(inObj);
	}	

	/*****************************************************************
	* getObject 사이트 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Site inObj = (Site)obj;
		return siteMapper.view(inObj);
	}
	
	/*****************************************************************
	* insertObject 사이트 추가/수정/삭제
	* @param obj
	* @return
	* @throws Exception
	* 
	* 차후 processObject로 일괄 변경 예정
	* 
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		Site inObj = (Site)obj;
		
		try{
			siteMapper.insert(inObj);
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();

			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
		return inObj;
	}

	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		Site inObj = (Site)obj;
		try{
			if(inObj.getInCondition().equals("삭제")){
				//삭제 - 한건삭제, 다중삭제 구분
				if(inObj.getChkSiteIds() == null){
					siteMapper.insert(inObj);
					
				}else{
			    	for(int i=0; i<inObj.getChkSiteIds().length; i++){
			    		Site siteData = new Site();
			    		siteData.setParamSiteId(inObj.getChkSiteIds()[i]);
			    		siteData.setCopyParam(inObj);							//workName, condition, 공통값 복사
			    		siteData.setState("F");									//상태 변경
			    		siteData.setInDMLData(siteData.makeDMLDataString());	//DML 생성
			    		
						siteMapper.insert(siteData);
					}
				}
			}else{
				siteMapper.insert(inObj);
			}
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();

			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return siteMapper.update(obj);
	}

}

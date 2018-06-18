package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.Banner;
import kr.plani.ccis.ips.mapper.site.BannerMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("bannerMgrService")
public class BannerMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private BannerMgrMapper bannerMgrMapper;

	
	/*****************************************************************
	* getObjectList 베너 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Banner inObj = (Banner)obj;
		return bannerMgrMapper.list(inObj);
	}	

	public int getObjectListCnt(Object obj) throws Exception{
		Banner inObj = (Banner)obj;
		
		return bannerMgrMapper.listCnt(inObj);
	}	
	
	/*****************************************************************
	* getObjectList 베너 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Banner inObj = (Banner)obj;
		bannerMgrMapper.view(inObj);
		
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
		Banner inObj = (Banner)obj;

		try{
			bannerMgrMapper.insert(inObj);
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();

			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
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
		Banner inObj = (Banner)obj;
		
		try{
			if(inObj.getInCondition().equals("삭제")){
				
				//삭제 - 한건삭제, 다중삭제 구분
				if(inObj.getChkBannerIds() == null){
					bannerMgrMapper.insert(inObj);
					
				}else{
					for(int i=0; i<inObj.getChkBannerIds().length; i++){
						Banner bannerData = new Banner();
						bannerData.setBannerId(inObj.getChkBannerIds()[i]);
						bannerData.setCopyParam(inObj);							//workName, condition, 공통값 복사
						bannerData.setInDMLData(bannerData.makeDMLDataString());	//DML 생성
						
						bannerMgrMapper.insert(bannerData);
					}
				}
			}else{
				bannerMgrMapper.insert(inObj);
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
		return bannerMgrMapper.update(obj);
	}

}

package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.mapper.site.ContentSetMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("contentSetMgrService")
public class ContentSetMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private ContentSetMgrMapper contentSetMapper;

	
	/*****************************************************************
	* getObjectList 콘텐츠트리 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		ContentSet inObj = (ContentSet)obj;
		return contentSetMapper.list(inObj);
	}	

	@Override
	public Object getObject(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		contentSetMapper.view(inObj);
		
		return contentSetMapper.view(inObj);
	}

	public List<?> getCategoryList(Object obj) throws Exception{
		ContentSet inObj = (ContentSet)obj;
		return contentSetMapper.listCategory(inObj);
	}	
	
	public List<?> getCustomizingList(Object obj) throws Exception{
		ContentSet inObj = (ContentSet)obj;
		return contentSetMapper.listCategory(inObj);
	}	

	public List<?> getManageUserList(Object obj) throws Exception{
		ContentSet inObj = (ContentSet)obj;
		return contentSetMapper.listCategory(inObj);
	}	

	/*****************************************************************
	* insertObject 콘텐츠설정 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		String[] arrayId;
		String[] arrayName;
		String[] arrayInfo;
		
		try{
			if(inObj.getInCondition().equals("입력")){
				contentSetMapper.insert(inObj); // 등록/수정
			}else if(inObj.getInCondition().equals("수정")){
				contentSetMapper.insert(inObj); // 등록/수정
			}else if(inObj.getInCondition().equals("삭제")){
				
			}
			
			ContentSet inParamObj = (ContentSet)obj;
			if(StringUtil.isNotBlank(inObj.getCategoryId())){
				contentSetMapper.deleteCategory(inParamObj);
				
				arrayId = inObj.getCategoryId().split("#");
				arrayName = inObj.getCategoryName().split("#");
				for(int i=0; i<arrayId.length; i++){
					inParamObj.setCategoryId(arrayId[i]);
					inParamObj.setCategoryName(arrayName[i]);
					contentSetMapper.insertCategory(inParamObj);
				}
			}
			
			if(StringUtil.isNotBlank(inObj.getCustomizingInfo())){
				contentSetMapper.deleteCustomizing(inParamObj);
				
				arrayInfo = inObj.getCustomizingInfo().split("#");
				for(int i=0; i<arrayInfo.length; i++){
					inParamObj.setCustomizingInfo(arrayInfo[i]);
					contentSetMapper.insertCustomizing(inParamObj);
				}
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
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}

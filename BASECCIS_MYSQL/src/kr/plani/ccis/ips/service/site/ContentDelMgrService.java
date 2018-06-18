package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.mapper.site.ContentDelMgrMapper;
import kr.plani.ccis.ips.mapper.site.ContentSetMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("contentDelMgrService")
public class ContentDelMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private ContentDelMgrMapper contentDelMgrMapper;

	@Resource
	private ContentSetMgrMapper contentSetMapper;

	/*****************************************************************
	* getObjectList 삭제 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception{
		Title inObj = (Title)obj;
		return (List<?>) contentDelMgrMapper.list(inObj);
	}	
	
	public int getDelBoardListCnt(Object obj) throws Exception {
		Title inObj = (Title)obj;
		return contentDelMgrMapper.listCnt(inObj);
	}
	
	@Override
	public Object getObject(Object obj) throws Exception {
		Link inObj = (Link)obj;
		/*contentDelMgrMapper.view(obj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));*/
		
		return contentDelMgrMapper.view(obj);
	}

	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		Content inObj = (Content)obj;
		try{
			if(inObj.getInCondition().equals("입력")){
			}else if(inObj.getInCondition().equals("수정")){
				
				/*if(inObj.getParamMenuId().equals(anObject)){
					contentDelMgrMapper.updateLink(inObj);
				}else{
					contentDelMgrMapper.updateLinks(inObj);
					contentDelMgrMapper.updateContents(inObj);
					contentDelMgrMapper.updateFiles(inObj);
					contentDelMgrMapper.updateTitle(inObj);
				}*/
			}else if(inObj.getInCondition().equals("삭제")){
				
				/*if(inObj.getParamMenuId().equals(anObject)){
					contentDelMgrMapper.deleteLink(inObj);
				}else{
					contentDelMgrMapper.deleteLinks(inObj);
					contentDelMgrMapper.deleteContents(inObj);
					contentDelMgrMapper.deleteFiles(inObj);
					contentDelMgrMapper.deleteTitle(inObj);
				}*/
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
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/***************************************************
	 * getContentSet 콘텐츠 설정 정보 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object getContentSet(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		
		/*List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);*/
		
		return contentSetMapper.view(inObj);
	}

	/***************************************************
	 * getAttachFileList 첨부파일 목록 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public List<?> getAttachFileList(Object obj) throws Exception {
		
		return contentDelMgrMapper.getAttachFileList(obj);
	}
	
}

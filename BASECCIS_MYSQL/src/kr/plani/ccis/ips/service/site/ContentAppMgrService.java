package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.mapper.site.ContentAppMgrMapper;
import kr.plani.ccis.ips.mapper.site.ContentSetMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("contentAppMgrService")
public class ContentAppMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private ContentAppMgrMapper contentAppMgrMapper;

	@Resource
	private ContentSetMgrMapper contentSetMapper;
	
	public int getAppBoardListCnt(Object obj) throws Exception {
		Title inObj = (Title)obj;
		return contentAppMgrMapper.listCnt(inObj);
	}
	
	public List<?> getAppBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		return contentAppMgrMapper.list(inObj);
	}
	@Override
	public Object getObjectList(Object obj) throws Exception{
		return null;
	}	
	
	@Override
	public Object getObject(Object obj) throws Exception {
		return contentAppMgrMapper.view(obj);
	}
	
	public List<?> getObjectFiles(Object obj) throws Exception {
		return contentAppMgrMapper.listFiles(obj);
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
			contentAppMgrMapper.update(inObj);
			
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
		contentSetMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}
	
}

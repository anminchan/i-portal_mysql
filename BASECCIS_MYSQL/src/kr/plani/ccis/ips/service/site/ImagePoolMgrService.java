package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.ImagePool;
import kr.plani.ccis.ips.mapper.site.ImagePoolMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("imagePoolMgrService")
public class ImagePoolMgrService extends EgovAbstractServiceImpl implements DefaultService {
	

	@Resource
	private ImagePoolMgrMapper imagePoolMgrMapper;

	
	/*****************************************************************
	* getObjectList 이미지풀 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		ImagePool inObj = (ImagePool)obj;
		imagePoolMgrMapper.list(inObj);
		
		return inObj;
	}	

	/*****************************************************************
	* getObject 이미지풀 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		ImagePool inObj = (ImagePool)obj;
		imagePoolMgrMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}

	/*****************************************************************
	* insertObject 이미지풀 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		ImagePool inObj = (ImagePool)obj;
		imagePoolMgrMapper.insert(inObj);
		
		return inObj;
	}

	/*****************************************************************
	* deleteObject 이미지풀 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		ImagePool inObj = (ImagePool)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			imagePoolMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return imagePoolMgrMapper.update(obj);
	}

}

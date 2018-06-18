package kr.plani.ccis.ips.service.stat;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.stat.Stat;
import kr.plani.ccis.ips.mapper.stat.MenuStatMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("menuStatService")
public class MenuStatService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private MenuStatMapper menuStatMapper;

	
	/*****************************************************************
	* getObjectList 사이트 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		Stat inObj = (Stat)obj;
		menuStatMapper.list(inObj);
		
		return inObj;
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
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

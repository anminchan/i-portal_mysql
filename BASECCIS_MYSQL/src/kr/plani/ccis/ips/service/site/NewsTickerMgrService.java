package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.mapper.site.NewsTickerMgrMapper;

@Service("newsTickerMgrService")
public class NewsTickerMgrService extends EgovAbstractServiceImpl {
	
	@Resource
	private NewsTickerMgrMapper newsTickerMgrMapper;

	/*****************************************************************
	* getObjectList 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> getObjectList(Object obj) throws Exception
	{
		return newsTickerMgrMapper.list(obj);
	}	

	/*****************************************************************
	* getObject 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object getObject(Object obj) throws Exception 
	{
		return newsTickerMgrMapper.view(obj);
	}
	
	/*****************************************************************
	* insertObject 추가
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void insertObject(Object obj) throws Exception 
	{
		newsTickerMgrMapper.insert(obj);
	}
	
	/*****************************************************************
	* insertObject 수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void updateObject(Object obj) throws Exception {
		newsTickerMgrMapper.update(obj);
	}

	/*****************************************************************
	* deleteObject 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void deleteObject(Object obj) throws Exception 
	{
		newsTickerMgrMapper.delete(obj);
	}

}

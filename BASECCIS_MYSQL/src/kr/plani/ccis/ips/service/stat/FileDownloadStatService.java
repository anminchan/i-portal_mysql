package kr.plani.ccis.ips.service.stat;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.mapper.stat.FileDownloadStatMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("fileDownloadStatService")
public class FileDownloadStatService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private FileDownloadStatMapper fileDownloadStatMapper;

	
	/*****************************************************************
	* getObjectList 콘텐츠이용현황 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		return fileDownloadStatMapper.list(obj);
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
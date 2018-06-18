package kr.plani.ccis.ips.service.common;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.mapper.common.SampleMgrMapper;

@Service("sampleMgrService")
public class SampleMgrService extends EgovAbstractServiceImpl {
	
	@Resource
	private SampleMgrMapper sampleMgrMapper;
	
	/*****************************************************************
	* getObjectList 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> getObjectList(Object obj) throws Exception
	{
		return sampleMgrMapper.list(obj);
	}	

	/*****************************************************************
	* getObject 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object getObject(Object obj) throws Exception 
	{
		return sampleMgrMapper.view(obj);
	}
	
	/*****************************************************************
	* getObjectFileList 첨부파일 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> getFileObjectList(Object obj) throws Exception 
	{
		return sampleMgrMapper.listFile(obj);
	}
	
	/*****************************************************************
	* insertObject 추가
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void insertObject(Object obj) throws Exception 
	{
		sampleMgrMapper.insert(obj);
	}
	
	/*****************************************************************
	* insertFileObject 추가
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void insertFileObject(Object obj) throws Exception 
	{
		sampleMgrMapper.insertFiles(obj);
	}
	
	/*****************************************************************
	* insertObject 수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void updateObject(Object obj) throws Exception {
		sampleMgrMapper.update(obj);
	}

	/*****************************************************************
	* deleteObject 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void deleteObject(Object obj) throws Exception 
	{
		sampleMgrMapper.delete(obj);
	}
	
	/*****************************************************************
	* deleteFileObject 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public void deleteFileObject(Object obj) throws Exception 
	{
		sampleMgrMapper.deleteFiles(obj);
	}

}

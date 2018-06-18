package kr.plani.ccis.ips.mapper.common;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("sampleMgrMapper")
public interface SampleMgrMapper {
	public List<?> list(Object obj);
	public Object view(Object obj);
	public List<?> listFile(Object obj);
	public void insert(Object obj);
	public void insertFiles(Object obj);
	public void update(Object obj);
	public void delete(Object obj);
	public void deleteFiles(Object obj);
	
}

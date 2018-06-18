package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("contentTransMgrMapper")
public interface ContentTransMgrMapper {

	public List<?> selectTransMenu(Object obj);
	public List<?> selectTransTargetMenu(Object obj);
	public void deleteTransMenu(Object obj);
	public void deleteTransTargetMenuId(Object obj);
	public void deleteTransMenuId(Object obj);
	public void insertTransMenu(Object obj);
	
	public String selectNextTransId(Object obj);
}

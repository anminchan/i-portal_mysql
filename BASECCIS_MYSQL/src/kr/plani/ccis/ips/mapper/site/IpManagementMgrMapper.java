package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ipManagementMgrMapper")
public interface IpManagementMgrMapper {
	public List<?> selectIpManagementList(Object obj);
	public List<?> selectIpManagementView(Object obj);
	public String selectIpAllYnCheck(Object obj);
	public void insertIpManagement(Object obj);
	public void updateIpManagement(Object obj);
	
}

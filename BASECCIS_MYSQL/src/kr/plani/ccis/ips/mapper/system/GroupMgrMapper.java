package kr.plani.ccis.ips.mapper.system;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("groupMgrMapper")
public interface GroupMgrMapper {
	public List<?> list(Object obj);
	public Object view(Object obj);		
	public List<?> userList(Object obj);
	public Object act(Object obj);	
	public Object actUser(Object obj);
}

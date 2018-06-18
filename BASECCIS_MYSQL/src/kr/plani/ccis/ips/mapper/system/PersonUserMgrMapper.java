package kr.plani.ccis.ips.mapper.system;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("personUserMgrMapper")
public interface PersonUserMgrMapper {
	public Object list(Object obj);
	public Object view(Object obj);
	public Object action(Object obj);

}

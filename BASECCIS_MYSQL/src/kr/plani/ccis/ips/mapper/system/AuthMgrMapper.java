package kr.plani.ccis.ips.mapper.system;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("authMgrMapper")
public interface AuthMgrMapper {
	public List<?> list(Object obj);
	public void action(Object obj);

}






package kr.plani.ccis.ips.mapper.system;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("comapnyUserMgrMapper")
public interface CompanyUserMgrMapper {
	public Object list(Object obj);
	public Object view(Object obj);
	public Object action(Object obj);

}

package kr.plani.ccis.ips.mapper.stat;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("changLogMgrMapper")
public interface ChangLogMgrMapper {
	
	public Object list(Object obj);
	public Object delete(Object obj);

}

package kr.plani.ccis.ips.mapper.stat;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("systemStatMapper")
public interface SystemStatMapper {
	
	public Object list(Object obj);

}

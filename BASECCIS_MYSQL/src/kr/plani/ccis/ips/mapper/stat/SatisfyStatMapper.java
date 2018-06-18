package kr.plani.ccis.ips.mapper.stat;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("satisfyStatMapper")
public interface SatisfyStatMapper {
	
	public Object list(Object obj);
	public Object listView(Object obj);
	
}

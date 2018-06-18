package kr.plani.ccis.ips.mapper.site;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("familySiteMgrMapper")
public interface FamilySiteMgrMapper {
	public Object list(Object obj);
	public Object view(Object obj);
	public Object insert(Object obj);
	
	public Object update(Object obj);
	public Object delete(Object obj);
}

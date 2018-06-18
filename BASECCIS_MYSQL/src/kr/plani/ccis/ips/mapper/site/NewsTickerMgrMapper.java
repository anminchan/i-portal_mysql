package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("newsTickerMgrMapper")
public interface NewsTickerMgrMapper {
	public List<?> list(Object obj);
	public Object view(Object obj);
	public void insert(Object obj);
	public void update(Object obj);
	public void delete(Object obj);
}

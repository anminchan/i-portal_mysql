package kr.plani.ccis.ips.mapper.system;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("siteMgrMapper")
public interface SiteMgrMapper {
	public List<?> list(Object obj);
	public Object view(Object obj);
	public void insert(Object obj);
	public Object update(Object obj);
	public Object delete(Object obj);
}

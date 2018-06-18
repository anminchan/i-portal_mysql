package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("contentSetMgrMapper")
public interface ContentSetMgrMapper {
	public List<?> list(Object obj);
	public List<?> listAdmin(Object obj);
	public Object view(Object obj);
	public List<?> listCategory(Object obj);
	public List<?> listCustomizing(Object obj);
	public List<?> listManageUser(Object obj);
	public void insert(Object obj);

	public void insertCategory(Object obj);
	public void deleteCategory(Object obj);
	
	public void insertCustomizing(Object obj);
	public void deleteCustomizing(Object obj);
	
	public Object update(Object obj);
	public Object delete(Object obj);
}

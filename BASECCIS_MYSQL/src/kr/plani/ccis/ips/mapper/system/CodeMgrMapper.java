package kr.plani.ccis.ips.mapper.system;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("codeMgrMapper")
public interface CodeMgrMapper {
	public List<?> comboList(Object obj); 
	public List<?> treeList(Object obj);
	public Object view(Object obj);
	public void insert(Object obj);
	public Object check(Object obj);

}

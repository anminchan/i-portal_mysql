package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("tabooWordMgrMapper")
public interface TabooWordMgrMapper {
	public List<?> selectTabooWordList(Object obj);
	public Object view(Object obj);
	public int insertTabooWord(Object obj);
	public int updateTabooWord(Object obj);
	public int deleteTabooWord(Object obj);
}

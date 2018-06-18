package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("contentAppMgrMapper")
public interface ContentAppMgrMapper {
	
	/* 승인대기 콘텐츠 */
	public List<?> list(Object obj);
	public int listCnt(Object obj);
	public Object view(Object obj);
	public List<?> listFiles(Object obj);
	public Object update(Object obj);
	
	
}

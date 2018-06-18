package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("contentDelMgrMapper")
public interface ContentDelMgrMapper {
	
	/* 삭제 콘텐츠 */
	public List<?> list(Object obj);
	public int listCnt(Object obj);
	public Object view(Object obj);
	public Object update(Object obj);
	public List<?> getAttachFileList(Object obj);
	
	
}

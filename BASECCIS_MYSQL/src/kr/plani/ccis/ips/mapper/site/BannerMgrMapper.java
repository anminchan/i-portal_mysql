package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("bannerMgrMapper")
public interface BannerMgrMapper {
	public List<?> list(Object obj);
	public int listCnt(Object obj);
	public Object view(Object obj);
	public void insert(Object obj);
	
	public Object update(Object obj);
	public Object delete(Object obj);
}

package kr.plani.ccis.ips.mapper.site;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("popupZoneMgrMapper")
public interface PopupZoneMgrMapper {
	public Object list(Object obj);
	public Object view(Object obj);
	public Object insert(Object obj);
	
	public Object update(Object obj);
	public Object delete(Object obj);
}

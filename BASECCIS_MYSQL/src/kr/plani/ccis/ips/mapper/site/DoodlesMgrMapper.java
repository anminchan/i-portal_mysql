package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.plani.ccis.ips.domain.site.Doodles;

@Mapper("doodlesMgrMapper")
public interface DoodlesMgrMapper {
	public List<Doodles> list(Object obj);
	public int listCnt(Object obj);
	public Object view(Object obj);
	public void insert(Object obj);
	
	public void update(Object obj);
	public void delete(Object obj);
}

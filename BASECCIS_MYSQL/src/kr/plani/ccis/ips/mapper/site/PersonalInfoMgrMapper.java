package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.plani.ccis.ips.domain.site.PersonalInfo;

@Mapper("personalInfoMgrMapper")
public interface PersonalInfoMgrMapper {
	public List<PersonalInfo> list(Object obj);
	public List<PersonalInfo> list2(Object obj);
	public int listCnt(Object obj);
	public String maxId();
	public Object view(Object obj);
	public void insert(Object obj);
	
	public void update(Object obj);
	public void delete(Object obj);
}

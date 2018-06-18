package kr.plani.ccis.ips.mapper.system;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMgrMapper")
public interface MemberMgrMapper {
	public List<?> list(Object obj);
	public int listCnt(Object obj);
	public Object view(Object obj);
	public List<?> getUserGroupList(Object obj);
	public Object action(Object obj);
	public Object companyUserAction(Object obj);
	public Object personUserAction(Object obj);
	public List<?> memberPopupList(Object obj);
	public Object memberTeamList(Object obj);
	public List<HashMap<String, String>> deptList();
	public List<HashMap<String, String>> dutyList();
	public List<HashMap<String, String>> positionList();
	
}

package kr.plani.ccis.mps.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {

	public Object viewPerson(Object obj);
	public Object viewCompany(Object obj);
	public String getUserKind(Object obj);
	public String getAdmCheckYn(Object obj);
	public Object companyAction(Object obj);
	public Object personAction(Object obj);
	public HashMap<String, String> getWithDrawPwChageYn(String obj);
	
	//아이디패스워트찾기
	public Object view(Object obj);
	public Object selectIdCheck(Object obj);
	public Object insert(Object obj);
	public List<HashMap<String, String>> idSearchCompany(Object obj);
	public List<HashMap<String, String>> pwSearchCompany(Object obj);
	
}

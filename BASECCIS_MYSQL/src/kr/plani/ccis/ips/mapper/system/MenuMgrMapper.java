package kr.plani.ccis.ips.mapper.system;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("menuMgrMapper")
public interface MenuMgrMapper {
	public List<?> list(Object obj);
	public Object view(Object obj);
	public void insert(Object obj);
	
	public int selectBoardCnt(Object obj);
	public List<?> selectMenuTreeList(Object obj);
	
	public Object update(Object obj);
	public Object delete(Object obj);
	
	public void insertRole1(Object obj);
	public void insertRole2(Object obj);
	public void insertRole3(Object obj);
	public void insertRole4(Object obj);
	public void insertRole5(Object obj);
	public void insertGroupRoleAuto(Object obj);
	public void upadteRoleState(Object obj);
	
	public void deleteMenu(Object obj);
	public void deleteBoard(Object obj);
	public void deleteTrans(Object obj);
	public void deleteRole(Object obj);
	public void deleteGroupRole(Object obj);
}

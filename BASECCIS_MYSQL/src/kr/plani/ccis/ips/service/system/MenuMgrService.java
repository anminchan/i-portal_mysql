package kr.plani.ccis.ips.service.system;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.system.Menu;
import kr.plani.ccis.ips.mapper.system.MenuMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("menuMgrService")
public class MenuMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private MenuMgrMapper menuMapper;
	
	/*****************************************************************
	* getObjectList 메뉴트리 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Menu inObj = (Menu)obj;
		return menuMapper.list(inObj);
	}	

	/*****************************************************************
	* getObject 메뉴 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Menu inObj = (Menu)obj;
		return menuMapper.view(inObj);
	}
	
	/*****************************************************************
	* insertObject 메뉴 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		Menu inObj = (Menu)obj;
		
		try{
			if(inObj.getInCondition().equals("입력")){
				menuMapper.insert(inObj); // 등록/수정
				menuMapper.insertRole1(inObj);
				menuMapper.insertRole2(inObj);
				menuMapper.insertRole3(inObj);
				menuMapper.insertRole4(inObj);
				menuMapper.insertRole5(inObj);
				menuMapper.insertGroupRoleAuto(inObj);
			}else if(inObj.getInCondition().equals("수정")){
				menuMapper.insert(inObj); // 등록/수정
				menuMapper.upadteRoleState(inObj);
			}else if(inObj.getInCondition().equals("삭제")){
				Menu inDelObj = new Menu();
				
				int boardCnt = menuMapper.selectBoardCnt(inObj);
				if(boardCnt > 0){
					inObj.setOutResult("SUCCESS");
					inObj.setOutNotice("메뉴를 삭제 할 수 없습니다.(메뉴에 게시글 존재)");
					return inObj;
				}else{
					List<?> menuTreeList = menuMapper.selectMenuTreeList(inObj);
					
					for(int i=0; i<menuTreeList.size(); i++){
						HashMap item = (HashMap) menuTreeList.get(i);
						inDelObj.setParamMenuId(item.get("MENUID").toString());
						if(item.get("MENUTYPE").toString().equals("C")){
							menuMapper.deleteTrans(inDelObj);
							menuMapper.deleteBoard(inDelObj);
						}
						
						menuMapper.deleteGroupRole(inDelObj);
						menuMapper.deleteRole(inDelObj);
						menuMapper.deleteMenu(inDelObj);
					}
				}
			}
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();

			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
		return inObj;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		return menuMapper.update(obj);
	}

	@Override
	public Object deleteObject(Object obj) throws Exception {
		return menuMapper.delete(obj);
	}


}

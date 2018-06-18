package kr.plani.ccis.ips.service.system;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.system.Code;
import kr.plani.ccis.ips.mapper.system.CodeMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("codeMgrService")
public class CodeMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	CodeMgrMapper codeMgrMapper;
	
	/*****************************************************************
	* getObjectList 코드트리 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Code inObj = (Code)obj;
		return codeMgrMapper.treeList(inObj);
	}		
	
	/*****************************************************************
	* getObject 코드 상세조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Code inObj = (Code)obj;
		return codeMgrMapper.view(inObj);
	}

	/*****************************************************************
	* insertObject 코드 추가/수정/삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		Code inObj = (Code)obj;
		try{
			codeMgrMapper.insert(inObj);
			
			inObj.setOutResult("SUCCESS");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 성공하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
	
			inObj.setOutResult("FAILURE");
			inObj.setOutNotice(inObj.getInWorkName()+inObj.getInCondition()+"에 실패하였습니다.");
		}
		
		return inObj;
	}

	/*****************************************************************
	* updateObject 코드 수정
	* @param obj
	* @return @Transactional
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object updateObject(Object obj) throws Exception {
		Code inObj = (Code)obj;
		
		try{
			String inputGRval = inObj.getInputGRVal();
			StringTokenizer st1 = new StringTokenizer(inputGRval,",");
		    
			while(st1.hasMoreTokens()){
				String inDMLData = st1.nextToken();
				inObj.setInCondition("수정");

				inObj.setCode(inDMLData.split("\\|")[0]);
				inObj.setHigherCode(inDMLData.split("\\|")[1]);
				inObj.setSiteId(inDMLData.split("\\|")[2]);
				inObj.setKName(inDMLData.split("\\|")[3]);
				inObj.setEName(inDMLData.split("\\|")[4]);
				inObj.setDepth(Integer.parseInt(inDMLData.split("\\|")[5]));
				inObj.setSort(Integer.parseInt(inDMLData.split("\\|")[6].toString()));
				inObj.setState(inDMLData.split("\\|")[7]);
				
				codeMgrMapper.insert(inObj);
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
	public Object deleteObject(Object obj) throws Exception {
		return null;
	}
	
	public List<?> getComboList(Object obj) throws Exception {
		Code inobj = (Code)obj;
		return codeMgrMapper.comboList(inobj);
	}

	/*****************************************************************
	* getObject 코드 중복체크
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object getCheckCode(Object obj) throws Exception {
		Code inObj = (Code)obj;
		return codeMgrMapper.check(inObj);
	}

}

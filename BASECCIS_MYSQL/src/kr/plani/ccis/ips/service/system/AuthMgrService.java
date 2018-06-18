package kr.plani.ccis.ips.service.system;

import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.system.Auth;
import kr.plani.ccis.ips.mapper.system.AuthMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("authMgrService")
public class AuthMgrService extends EgovAbstractServiceImpl implements DefaultService {

	private static final Logger logger = LoggerFactory.getLogger(AuthMgrService.class);
	@Resource
	private AuthMgrMapper authMapper;

	
	/*****************************************************************
	* getObjectList 권한 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public List<?> getObjectList(Object obj) throws Exception
	{
		Auth inObj = (Auth)obj;
		return authMapper.list(inObj);
	}	

	/*****************************************************************
	* getObject 권한 상세 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		
		return null;
	}

	
	/*****************************************************************
	* insertObject 권한 삭제/추가
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object insertObject(Object obj) throws Exception {
		Auth inObj = (Auth)obj;
		String inputGRval = inObj.getInputGRVal();
		
		try{
			logger.info("inputGRval>>" + inputGRval);
			StringTokenizer st1 = new StringTokenizer(inputGRval,",");
		    
			// 전체 삭제
			inObj.setInGroupID(inObj.getGroupid());
			inObj.setInCondition("삭제");
			authMapper.action(inObj);
			
			while(st1.hasMoreTokens()){
				String inDMLData = st1.nextToken();
				inObj.setInGroupID(inObj.getGroupid());
				inObj.setRoleid(inDMLData.split("\\|")[2]);
				inObj.setInCondition("입력");
				authMapper.action(inObj);
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
		
		
		return null;
	}

	@Override
	public Object deleteObject(Object obj) throws Exception {
		
		return null;
	}


}

package kr.plani.ccis.ips.service.common;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.common.User;
import kr.plani.ccis.ips.domain.system.Group;
import kr.plani.ccis.ips.mapper.common.CommonMapper;

@Service("commonService")
public class CommonService extends BaseService {
	
	@Resource
	CommonMapper commonMapper;

	/*****************************************************************
	* getSiteName 사이트명 받아오기
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public String getSiteName(Object obj) throws Exception {
		DefaultDomain inObj = (DefaultDomain)obj;
		return commonMapper.getSiteName(inObj);
	}
	
	/*****************************************************************
	* listGroup 그룹 목록 받아오기
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listGroup(Object obj) throws Exception {
		Group inObj = (Group)obj;
		return commonMapper.listGroup(inObj);
	}
	
	/*****************************************************************
	 * 사용자로그인
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object[] getLogin(Object obj) throws Exception {
		User inObj = (User)obj;
		User scUser = new User();
		//commonMapper.getLogin(inObj);
		
		int idCnt = commonMapper.getLoginIdCheck(inObj);
		
		if(idCnt <= 0){
			inObj.setOutResult("FAILURE");
			inObj.setOutNotice("FAILURE !!! 회원ID ["+inObj.getUserId()+"] 아이디 또는 비밀번호가 일치하지 않습니다.");
		}else if(idCnt > 1){
			inObj.setOutResult("FAILURE");
			inObj.setOutNotice("FAILURE !!! 회원ID ["+inObj.getUserId()+"] 복수의 회원정보가 존재합니다. 관리자에게 문의하십시요.");
		}else{
			scUser = (User) commonMapper.getLogin(inObj);
			if(scUser != null){
				inObj.setOutResult("SUCCESS");
				inObj.setOutNotice("SUCCESS !!! 회원ID ["+inObj.getUserId()+"] 정상적으로 로그인 하였습니다.");
			}else{
				inObj.setOutResult("FAILURE");
				inObj.setOutNotice("FAILURE !!! 회원ID ["+inObj.getUserId()+"] 아이디 또는 비밀번호가 일치하지 않습니다.");
			}
		}
		
		/*User tmpInObj = new User();
		tmpInObj.setCopyParam(inObj);
		tmpInObj.setOutResult(inObj.getOutResult());
		tmpInObj.setOutNotice(inObj.getOutNotice());
		tmpInObj.setOutCursor(inObj.getOutCursor());*/

		return new Object[] { inObj.getOutResult(), inObj.getOutNotice(), scUser};
	}
	
	/*****************************************************************
	 * 기업회원 정보 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> searchCompanyPop(Object obj) throws Exception {
		return commonMapper.searchCompanyPop(obj);
	}
	
	/*****************************************************************
	 * 개인회원 정보 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> searchMemberPop(Object obj) throws Exception {
		return commonMapper.searchMemberPop(obj);
	}
	
	/*****************************************************************
	 * 개인정보 조회 로그 저장
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void insertUserInfoLog(Object obj) throws Exception {
		commonMapper.insertUserInfoLog(obj);
	}
	
	/*****************************************************************
	 * 통합검색log
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void unifiedSearchLog(Object obj) throws Exception {
		commonMapper.unifiedSearchLog(obj);
	}
	
	/*****************************************************************
	 * 개인정보 로그인아웃 로그 저장
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void insertUserLogInOutLog(Object obj) throws Exception {
		commonMapper.insertUserLogInOutLog(obj);
	}
	
	/*****************************************************************
	 * 회원 로그인 목록  조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getLoginInfo(Object obj) throws Exception {
		return commonMapper.getLoginInfo(obj);
	}
	
	/*****************************************************************
	 * 다른기기 로그인 체크
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public String getLoignCheck(Object obj) throws Exception {
		return commonMapper.getLoignCheck(obj);
	}
	
	/************************************************************
	 * selectTableList 테이블조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> selectTableList(Object obj) throws Exception {
		return commonMapper.selectTableList(obj);
	}
	
	/************************************************************
	 * selectTableDetailList 테이블조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> selectTableDetailList(Object obj) throws Exception {
		return commonMapper.selectTableDetailList(obj);
	}
	
}

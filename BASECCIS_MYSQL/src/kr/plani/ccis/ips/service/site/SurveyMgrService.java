package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.Survey;
import kr.plani.ccis.ips.mapper.site.SurveyMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("surveyMgrService")
public class SurveyMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private SurveyMgrMapper surveyMgrMapper;

	
	/*****************************************************************
	* getObjectList 설문조사 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object getObjectList(Object obj) throws Exception
	{
		Survey inObj = (Survey)obj;
		surveyMgrMapper.list(inObj);
		
		return inObj;
	}

	/*****************************************************************
	 * getObject 설문조사 상세 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@Override
	public Object getObject(Object obj) throws Exception {
		Survey inObj = (Survey)obj;
		surveyMgrMapper.view(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}
	
	/*****************************************************************
	* insertObject 설문조사 추가/수정
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	public Object insertObject(Object obj) throws Exception {
		Survey inObj = (Survey)obj;
		surveyMgrMapper.insert(inObj);
		
		return inObj;
	}
	
	/*****************************************************************
	 * updateObject 설문조사 수정
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@Override
	public Object updateObject(Object obj) throws Exception {
		return surveyMgrMapper.update(obj);
	}

	/*****************************************************************
	* deleteObject 설문조사 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Override
	@Transactional
	public Object deleteObject(Object obj) throws Exception {
		Survey inObj = (Survey)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkSurveyIds() == null){
				surveyMgrMapper.insert(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkSurveyIds().length; i++){
		    		Survey surveyData = new Survey();
		    		surveyData.setSurveyId(inObj.getChkSurveyIds()[i]);

		    		surveyData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		
		    		surveyData.setInDMLData(surveyData.makeDMLDataString());	//DML 생성
		    		
		    		surveyMgrMapper.insert(surveyData);
				}
			}
		}else{
			surveyMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	/*****************************************************************
	* getQuestionList 문항 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> getQuestionList(Object obj) throws Exception {
		return surveyMgrMapper.questionList(obj);
	}
	
	/*****************************************************************
	 * getQuestion 문항 상세 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object getQuestion(Object obj) throws Exception {
		Survey inObj = (Survey)obj;
		surveyMgrMapper.questionView(inObj);
		
		// 설문
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);

		// 문항
		List<?> bList = null;
		bList = (List<?>)inObj.getOutCursor1();
		
		if(bList.size() > 0) inObj.setOutCursor1(bList.get(0));
		else inObj.setOutCursor1(null);
		
		// 답안
		List<?> cList = null;
		cList = (List<?>)inObj.getOutCursor2();
		
		if(cList.size() > 0) inObj.setOutCursor2(cList);
		else inObj.setOutCursor2(null);
		
		return inObj;
	}
	
	
	/*****************************************************************
	* insertObject 문항 데이터 삭제
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	@Transactional
	public Object deleteQuestion(Object obj) throws Exception {
		Survey inObj = (Survey)obj;
		
		if(inObj.getInCondition().equals("삭제")){
			
			//삭제 - 한건삭제, 다중삭제 구분
			if(inObj.getChkQuestionIds() == null){
				surveyMgrMapper.insert(inObj);
				
			}else{
		    	for(int i=0; i<inObj.getChkQuestionIds().length; i++){
		    		Survey surveyData = new Survey();
		    		surveyData.setSurveyId(inObj.getSurveyId());
		    		surveyData.setQuestionId(inObj.getChkQuestionIds()[i]);
		    		surveyData.setCopyParam(inObj);							//workName, condition, 공통값 복사
		    		surveyData.setInDMLData(surveyData.makeQuestionDMLDataString());	//DML 생성
		    		
		    		surveyMgrMapper.insert(surveyData);
				}
			}
		}else{
			surveyMgrMapper.insert(inObj);
		}
		
		return inObj;
	}

	public List<?> getAnswerFileList(Object obj) throws Exception {
		return surveyMgrMapper.getAnswerFileList(obj);
	}

	public List<?> getPreviewList(Object obj) throws Exception {
		return surveyMgrMapper.getPreviewList(obj);
	}

	/*****************************************************************
	* getSurveyList 설문목록 (사용자)
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> getSurveyList(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyList(obj);
	}

	/*****************************************************************
	* getSurveyTimeCheck 설문참여가능 기간여부 조회 (사용자)
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public String getSurveyTimeCheck(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyTimeCheck(obj);
	}

	/*****************************************************************
	 * getSurveyTimeCheck 설문참여 여부 조회 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object getSurveyParticipationCheck(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyParticipationCheck(obj);
	}

	/*****************************************************************
	 * insertSurveyParticipation 설문참여 등록 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public int insertSurveyParticipation(Object obj) throws Exception {
		return surveyMgrMapper.insertSurveyParticipation(obj);
	}
	
	/*****************************************************************
	 * getParticipationId 등록한 설문참여 아이디 조회 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public String getParticipationId() throws Exception {
		return surveyMgrMapper.getParticipationId();
	}

	/*****************************************************************
	 * insertSurveyReply 설문답안등록 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void insertSurveyReply(Object obj) throws Exception {
		surveyMgrMapper.insertSurveyReply(obj);
	}

	/*****************************************************************
	 * deletePartiReply 기존 참여정보, 답안 삭제 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void deletePartiReply(Object obj) throws Exception {
		
		// 기존 답안 삭제
		surveyMgrMapper.deleteSurveyReply(obj);
		
		// 기존 참여정보 삭제
		surveyMgrMapper.deleteSurveyParti(obj);
		
	}

	/*****************************************************************
	 * getSurveyParticipation 설문참여 정보 조회 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object getSurveyParticipation(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyParticipation(obj);
	}

	/*****************************************************************
	 * getSurveyReplyList 설문참여 답안 목록 조회 (사용자)
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getSurveyReplyList(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyReplyList(obj);
	}

	/*****************************************************************
	 * getSurveyStatList 설문통계 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getSurveyStatList(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyStatList(obj);
	}

	/*****************************************************************
	 * getTextAnswerList 주관식 답안 목록 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getTextAnswerList(Object obj) throws Exception {
		return surveyMgrMapper.getTextAnswerList(obj);
	}

	/*****************************************************************
	 * getSurveyStatExcelList 엑셀용 통계 목록
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> getSurveyStatExcelList(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyStatExcelList(obj);
	}

	/*****************************************************************
	 * getSurveyPartiCount 설문 참여자 수
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public int getSurveyPartiCount(Object obj) throws Exception {
		return surveyMgrMapper.getSurveyPartiCount(obj);
	}

	
}

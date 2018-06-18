package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("surveyMgrMapper")
public interface SurveyMgrMapper {
	public Object list(Object obj);
	public Object view(Object obj);
	public Object insert(Object obj);
	public Object update(Object obj);
	public Object delete(Object obj);
	public List<?> questionList(Object obj);
	public Object questionView(Object obj);
	public List<?> getAnswerFileList(Object obj);
	public List<?> getPreviewList(Object obj);
	public List<?> getSurveyList(Object obj);
	public String getSurveyTimeCheck(Object obj);
	public Object getSurveyParticipationCheck(Object obj);
	public int insertSurveyParticipation(Object obj);
	public void deleteSurveyReply(Object obj);
	public void insertSurveyReply(Object obj);
	public void deleteSurveyParti(Object obj);
	public String getParticipationId();
	public Object getSurveyParticipation(Object obj);
	public List<?> getSurveyReplyList(Object obj);
	public List<?> getSurveyStatList(Object obj);
	public List<?> getTextAnswerList(Object obj);
	public List<?> getSurveyStatExcelList(Object obj);
	public int getSurveyPartiCount(Object obj);
}

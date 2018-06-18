package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("survey")
public class Survey extends DefaultDomain {
	
	// 설문
	private String surveyId; // 설문조사ID
	private String site_Name; // 사이트명
	private String openYn; // 공개여부
	private String surveyStartTime; // 설문조사시작시각
	private String surveyEndTime; // 설문조사종료시각
	private String surveyTimeYn; // 설문조사기간상태
	private String surveyTarget; // 설문조사대상
	private String resultOpenForm; // 결과공개형태
	private String KHtml; // 설문개요
	public String[] chkSurveyIds = null; //체크 SiteId - 다중삭제용
	
	// 문항
	private String questionId; // 문항ID
	private String answerType; // 답안유형
	private String multipleChoiceType; // 객관식유형
	public String[] chkQuestionIds = null; //체크 SiteId - 다중삭제용
	private String chkQuestionId;
	
	// 답안
	private String answerId; // 답안ID
	private String answer; // 답안
	public String [] answers = null; // 답안배열
	private String answerCount; // 답안갯수
	
	// 첨부파일
	private String imageFileName;
	private String imageSFileName;
	private String filePath;
	
	// 설문조사 (사용자)
	private String questionName; // 문항명
	private String answerName; // 답안명
	
	// 설문조사 참여정보 (사용자)
	private String participationId; // 참여ID
	private String userName; // 참여자명
	private String dkey; // 고유키
	private String status;// 설문조사 참여상태
	
	// 설문조사 통계
	private String ratio;
	private String cnt;
	private String totalCount;
	
	// 설문
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SiteId        	: ").append(this.getSiteId())		    .append("\n")
			.append(">> SurveyId		: ").append(this.getSurveyId())		    .append("\n")
			.append(">> KName         	: ").append(this.getKName())		    .append("\n")
			.append(">> OpenYn         	: ").append(this.getOpenYn())	    	.append("\n")
			.append(">> SurveyStartTime : ").append(this.getSurveyStartTime())  .append("\n")
			.append(">> SurveyEndTime	: ").append(this.getSurveyEndTime()) 	.append("\n")
			.append(">> SurveyTarget    : ").append(this.getSurveyTarget())		.append("\n")
			.append(">> ResultOpenForm  : ").append(this.getResultOpenForm())	.append("\n")
			.append(">> State         	: ").append(this.getState())			.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SiteID|SurveyID|KName|KHtml|OpenYn|SurveyStartTime|SurveyEndTime|SurveyTarget|ResultOpenForm|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getSiteId(), "-"))	    	.append("|")
			.append(StringUtil.getString(this.getSurveyId(), ""))			.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
			.append(StringUtil.getString(this.getOpenYn(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSurveyStartTime(), "-"))	.append("|")
			.append(StringUtil.getString(this.getSurveyEndTime(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getSurveyTarget(), "-"))		.append("|")
			.append(StringUtil.getString(this.getResultOpenForm(), "-"))	.append("|")
			.append(StringUtil.getString(this.getState(), "-"));
		
		return sbData.toString();
	}
	
	// 문항
	public String makeQuestionDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SurveyId		: ").append(this.getSurveyId())		    .append("\n")
			.append(">> QuestionId     	: ").append(this.getQuestionId())	    .append("\n")
			.append(">> KName         	: ").append(this.getKName())		    .append("\n")
			.append(">> AnswerType     	: ").append(this.getAnswerType())    	.append("\n")
			.append(">> MultipleChoiceType : ").append(this.getMultipleChoiceType())  .append("\n")
			.append(">> AnswerCount 	: ").append(this.getAnswerCount()) 		.append("\n")
			.append(">> Answer 			: ").append(this.getAnswer())  			.append("\n");
		
		return sbData.toString();
	}
	
	public String makeQuestionDMLDataString(){
		//InDMLData :: SurveyID|QuestionID|KName|AnswerType|MultipleChoiceType|답압갯수|(1)답안#(2)답안#...#(3)답안#...(이미지일경우에는 ImageFileName@ImageFileSName@FilePath#ImageFileName@ImageFileSName@FilePath)...
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getSurveyId(), ""))			.append("|")
			.append(StringUtil.getString(this.getQuestionId(), ""))	    	.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
			.append(StringUtil.getString(this.getAnswerType(), "-"))		.append("|")
			.append(StringUtil.getString(this.getMultipleChoiceType(), "-")).append("|")
			.append(StringUtil.getString(this.getAnswerCount(), ""))		.append("|")
			.append(StringUtil.getString(this.getAnswer(), "-"));
		
		return sbData.toString();
	}

	public String getSurveyId() {
		return surveyId;
	}

	public void setSurveyId(String surveyId) {
		this.surveyId = surveyId;
	}

	public String getSite_Name() {
		return site_Name;
	}

	public void setSite_Name(String site_Name) {
		this.site_Name = site_Name;
	}

	public String getOpenYn() {
		return openYn;
	}

	public void setOpenYn(String openYn) {
		this.openYn = openYn;
	}

	public String getSurveyStartTime() {
		return surveyStartTime;
	}

	public void setSurveyStartTime(String surveyStartTime) {
		this.surveyStartTime = surveyStartTime;
	}

	public String getSurveyEndTime() {
		return surveyEndTime;
	}

	public void setSurveyEndTime(String surveyEndTime) {
		this.surveyEndTime = surveyEndTime;
	}

	public String getSurveyTarget() {
		return surveyTarget;
	}

	public void setSurveyTarget(String surveyTarget) {
		this.surveyTarget = surveyTarget;
	}

	public String getResultOpenForm() {
		return resultOpenForm;
	}

	public void setResultOpenForm(String resultOpenForm) {
		this.resultOpenForm = resultOpenForm;
	}

	public String getKHtml() {
		return KHtml;
	}

	public void setKHtml(String kHtml) {
		KHtml = kHtml;
	}

	public String[] getChkSurveyIds() {
		return chkSurveyIds;
	}

	public void setChkSurveyIds(String[] chkSurveyIds) {
		this.chkSurveyIds = chkSurveyIds;
	}

	public String getAnswerType() {
		return answerType;
	}

	public void setAnswerType(String answerType) {
		this.answerType = answerType;
	}

	public String getMultipleChoiceType() {
		return multipleChoiceType;
	}

	public void setMultipleChoiceType(String multipleChoiceType) {
		this.multipleChoiceType = multipleChoiceType;
	}

	public String[] getChkQuestionIds() {
		return chkQuestionIds;
	}

	public void setChkQuestionIds(String[] chkQuestionIds) {
		this.chkQuestionIds = chkQuestionIds;
	}

	public String getQuestionId() {
		return questionId;
	}

	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}

	public String getAnswerId() {
		return answerId;
	}

	public void setAnswerId(String answerId) {
		this.answerId = answerId;
	}

	public String getAnswerCount() {
		return answerCount;
	}

	public void setAnswerCount(String answerCount) {
		this.answerCount = answerCount;
	}

	public String getAnswer() {
		return answer;
	}
	
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public String[] getAnswers() {
		return answers;
	}

	public void setAnswers(String[] answers) {
		this.answers = answers;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageSFileName() {
		return imageSFileName;
	}

	public void setImageSFileName(String imageSFileName) {
		this.imageSFileName = imageSFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getChkQuestionId() {
		return chkQuestionId;
	}

	public void setChkQuestionId(String chkQuestionId) {
		this.chkQuestionId = chkQuestionId;
	}

	public String getQuestionName() {
		return questionName;
	}

	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}

	public String getAnswerName() {
		return answerName;
	}

	public void setAnswerName(String answerName) {
		this.answerName = answerName;
	}

	public String getSurveyTimeYn() {
		return surveyTimeYn;
	}

	public void setSurveyTimeYn(String surveyTimeYn) {
		this.surveyTimeYn = surveyTimeYn;
	}

	public String getParticipationId() {
		return participationId;
	}

	public void setParticipationId(String participationId) {
		this.participationId = participationId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDkey() {
		return dkey;
	}

	public void setDkey(String dkey) {
		this.dkey = dkey;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRatio() {
		return ratio;
	}

	public void setRatio(String ratio) {
		this.ratio = ratio;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	

}

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<link rel="stylesheet" href="/resources/css/common/survey.css" />

<spform:form id="insertForm" name="insertForm" action="${contextPath}/survey/act" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="siteId" name="siteId" value="${result.siteId}"/>
	<input type="hidden" id="state" name="state" value="T"/>
	<input type="hidden" id="surveyId" name="surveyId" value="${result.surveyId}"/>

	<!-- 콘텐츠영역 --> 
	<div class="question_info">
		<span class="bg"></span>
		<h2 class="subject">${result.KName}</h2>
		<p class="txt">${result.KHtml}</p>
	</div>
	<ul class="survey_info">
		<li>설문기간 : ${result.surveyStartTime} ~ ${result.surveyEndTime}</li>
	</ul>
	<div class="btn_area_center">
		<button type="button" class="btn_colorType01" id="btnParticipation">참여하기</button>
		<button type="button" class="btn_colorType01" id="btnStat">결과보기</button>
		<button type="button" class="btn_colorType02" id="btnList">목록</button>
	</div>
</spform:form>
							
<script type="text/javascript">
$(function() {

	// 참여
	$("#btnParticipation").click(function(){

		if("${surveyTimeYn}"=="N"){
			
			alert("참여가능 기간이 아닙니다.");
			return false;
			
		}else{
			
			if("${USER.userId}"==""){ 
				
				alert("로그인 후 참여가능한 서비스입니다. 로그인 후 이용해주세요.");
	    		
	    		if(!confirm("로그인 페이지로 이동하시겠습니까?")){
	    			return;
	    		}
	    		
	    		var rtnUrl = "/survey/view?surveyId=${result.surveyId}${link}";
	    		window.location.href="${contextPath}/mps/member/loginForm?menuId=MENU00427&rtnUrl="+rtnUrl.replace(/&/g, "%26").replace(/=/g, "%3D");
	    		return;
	    		
			}else{
				
				var kind = "";
				if("${USER.userId}"=="guest@khidi.or.kr"){ // 비회원
					kind = "N";
				}else{
					kind = "${USER.kind}";
				}
				
				// 설문대상 체크
				if("${result.surveyTarget}" == kind || "${result.surveyTarget}" == "A"){
					
					// 중복참여 체크
					$.ajax({
						url: "${contextPath}/survey/surveyParticipationCheck",
						data: {'surveyId' : '${result.surveyId}'}, 
						async: false,
						cash: false,
						type: 'POST',
						success:function(result, textStatus, jqXHR) {
							
							//console.log("jqXHR.status : "+jqXHR.status);						
							
							if(result != null){
								var participation = "";
								if(result.participationId != undefined){
									participation = "&participationId=" + result.participationId;									
								}
								//console.log("participation : "+participation);
								location.href="${contextPath}/survey/form?surveyId=${result.surveyId}" + participation + "${link}";
							}
						}
					});
				
				}else{
					
					alert("참여대상이 아닙니다.");
					
				}
			}
		}
	});

	// 결과
	$("#btnStat").click(function(){
		
		var kind = "";
		if("${USER.userId}"=="guest@khidi.or.kr"){ // 비회원
			kind = "N";
		}else{
			kind = "${USER.kind}";
		}
		
		// 결과공개대상 체크
		if("${result.resultOpenForm}" == kind || "${result.resultOpenForm}" == "A"){ 
			
			location.href="${contextPath}/survey/stat?surveyId=${result.surveyId}${link}";
			
		}else{
			
			alert("결과공개대상이 아닙니다.");
			
		}
	});
	
	// 목록
	$("#btnList").click(function(){
		location.href="${contextPath}/survey?${link}";
	});
	
});
</script>

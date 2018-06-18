<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<div class="float_wrap">
		<h2 class="depth2_title">답안복사</h2>
	</div>
	
	<!-- 문항목록 -->
	<form id="listForm" name="listForm" action="${ctxMgr }/surveyMgr/questionDelete" method="POST">
		<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
		<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
		<input type="hidden" name="schSiteId" value="${param.schSiteId}">
		<input type="hidden" name="schKName" value="${param.schKName}">
		<input type="hidden" name="surveyId" value="${obj.surveyId}">
		<input type="hidden" name="questionId" value="${obj.questionId}">
		<input type="hidden" name="KName" value="${obj.KName}">
		<input type="hidden" id="state" name="state" value="${empty rtnSurvey.state ? 'T' : rtnSurvey.state}"/>
		<table class="tstyle_list" summary="선택, 번호, 문항명">
			<caption>
				설문조사문항 목록
			</caption>		
			<colgroup>
				<col width="7%" span="2" />
				<col width="20%"/>
				<col />
			</colgroup>		
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">번호</th>
					<th scope="col">답안유형</th>
					<th scope="col">문항</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>			
					<c:when test="${!empty result }">
						<c:forEach items="${result }" var="data" varStatus="loop">
							<tr>
								<td><input type="radio" name="radioQuestionId" class="listCheck" value="${data.QUESTIONID }" title="선택" /></td>
								<td>${data.NO1 }</td>
								<td>
								<c:if test="${data.ANSWERTYPE eq '1'}">주관식</c:if>
								<c:if test="${data.ANSWERTYPE eq '2'}">객관식</c:if>
								<c:if test="${data.ANSWERTYPE eq '3'}">객관식(이미지)</c:if>
								</td>
								<td class="txt_left">${data.KNAME }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="3"> 조회된 데이터가 없습니다. </td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		<div class="btn_area_form">
			<span class="float_right">
				<button type="button" class="btn_colorType01 roleWRITE" id="btnCopy">복사</button>&nbsp;
				<button type="button" class="btn_colorType01 roleDELETE" id="btnClose">닫기</button>
			</span>
		</div>
		
	</form>
</div>
<script type="text/javascript">
$(function() {
	
	// 답안복사
	$('#btnCopy').click(function(){
		if($("input[name='radioQuestionId']:checked").length <= 0){
			alert("복사할 답안의 문항을 선택하세요.");
			return false;
		}else{
 			if(confirm("답안유형과 답안이 복사할 문항의 데이타로 변경됩니다.\n복사하시겠습니까?")) {
 				$(opener.location).attr("href", "javascript:fnAnswerCopy('"+$("input[name='radioQuestionId']:checked").val()+"');");
				self.close();
			}
		}
	});

	// 닫기
	$("#btnClose").click(function(){
		self.close();
	});
});
</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="/resources/css/common/survey.css" />

<!-- 콘텐츠영역 --> 
<div class="question_info">
	<span class="bg"></span>
	<h2 class="subject">${rtnSurvey.KName}</h2>
	<p class="txt">${rtnSurvey.KHtml}</p>
</div>

<form id="listForm" name="listForm" action="${ctxMgr }/surveyMgr/questionDelete" method="POST">
	<fieldset>
		<legend>설문조사 항목 체크</legend>
		<dl class="question_list">
		<c:if test="${!empty rtnQuestion }">
			<c:forEach items="${rtnQuestion }" var="data" varStatus="loop">
				<dt>
					<em class="num">${data.NO1}</em>
					<span class="txt">${data.KNAME}</span>		
				</dt>
				<dd>
					<c:if test="${!empty rtnPreview}">
					
						<!-- 태그시작 (객관식) -->
						<c:if test="${data.ANSWERTYPE == '2'}"><ul></c:if>
						<!-- 태그시작 (이미지) -->
						<c:if test="${data.ANSWERTYPE == '3'}"><ol class="thumb_question"></c:if>
						
						<c:forEach items="${rtnPreview}" var="data2" varStatus="loop2">
							<c:if test="${data.QUESTIONID == data2.QUESTIONID}">
								<!-- 주관식 -->
								<c:if test="${data.ANSWERTYPE == '1'}">
									<textarea name="answer" cols="45" rows="5" class="txtarea" title="주관식 답변 등록" style="height: 110px;" maxlength="1333"></textarea>
								</c:if>
								<!-- 객관식 -->
								<c:if test="${data.ANSWERTYPE == '2'}">
									<li>
										<c:if test="${data.MULTIPLECHOICETYPE == '1'}">
											<input type="radio" name="answer${loop.count}" title="객관식단일선택">
										</c:if>
										<c:if test="${data.MULTIPLECHOICETYPE == '2'}">
											<input type="checkbox" title="객관식선택">
										</c:if>
										<label for="">${data2.ANSWERNAME}</label>
									</li>
								</c:if>
								<!-- 이미지 -->
								<c:if test="${data.ANSWERTYPE == '3'}">
									<li>
										<c:if test="${data.MULTIPLECHOICETYPE == '1'}">
											<input type="radio" name="answer${loop.count}" title="이미지단일선택" />
										</c:if>
										<c:if test="${data.MULTIPLECHOICETYPE == '2'}">
											<input type="checkbox" title="이미지선택">
										</c:if>
										<label for=""><img alt="이미지답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${data2.IMAGEFILENAME}&systemFileName=${data2.IMAGESFILENAME}" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" style="max-width: 148px; max-height: 148px;"/></label>
									</li>
								</c:if>
							</c:if>
						</c:forEach>
						<!-- 태그종료 (객관식) -->
						<c:if test="${data.ANSWERTYPE == '2'}"></ul></c:if>
						<!-- 태그종료 (이미지) -->
						<c:if test="${data.ANSWERTYPE == '3'}"></ol></c:if>
					</c:if>
				</dd>
			</c:forEach>
		</c:if>
		</dl>
	</fieldset>
	
	<div class="btn_area">
		<button type="button" class="btn btn_type01 roleDELETE" id="btnClose">닫기</button>
	</div>

</form>

<script type="text/javascript">

	$(function() {
		// 닫기
		$("#btnClose").click(function(){
			self.close();
		});
	});
	
</script>

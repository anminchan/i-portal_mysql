<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="/includes/taglib.jsp" %>
<link rel="stylesheet" href="/resources/css/common/survey.css" />

<!-- 콘텐츠영역 --> 
<div class="question_info">
	<span class="bg"></span>
	<h2 class="subject">${rtnSurvey.KName}</h2>
	<p class="txt">${rtnSurvey.KHtml}</p>
</div>

<br />

<spform:form id="insertForm" name="insertForm" action="${contextPath}/survey/act" method="POST">
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<%-- <input type="hidden" name="pageNum" value="${param.pageNum}"> --%>
	<input type="hidden" name="schKName" value="${param.schKName}">
	<input type="hidden" id="status" name="status" value="">
	<input type="hidden" id="surveyId" name="surveyId" value="${rtnSurvey.surveyId}">
	<fieldset>
		<legend>설문조사 항목 체크</legend>
		<dl class="question_list">
		
			<c:if test="${!empty rtnQuestion}">
				<c:forEach items="${rtnQuestion}" var="data" varStatus="loop">
					<dt>
						<em class="num">${data.NO1}</em>
						<span class="txt">${data.KNAME}</span>		
					</dt>
					<dd>
						<c:if test="${!empty rtnAnswer}">
							
							<!-- 태그시작 (객관식) -->
							<c:if test="${data.ANSWERTYPE == '2'}"> <ul> </c:if>
							<!-- 태그시작 (이미지) -->
							<c:if test="${data.ANSWERTYPE == '3'}"> <ol class="thumb_question"> </c:if>
						
							<c:forEach items="${rtnAnswer}" var="data2" varStatus="loop2">
								<c:if test="${data.QUESTIONID == data2.QUESTIONID}">
									<c:if test="${!empty rtnReply}">
											
										<!-- 주관식 -->
										<c:if test="${data.ANSWERTYPE == '1'}">
											<c:forEach items="${rtnReply}" var="data3" varStatus="loop3">
												<c:if test="${data2.QUESTIONID == data3.QUESTIONID}">
													<textarea name="answer${loop.count}" cols="45" rows="5" class="txtarea" title="주관식 답변 등록" style="height: 110px;" maxlength="1333">${data3.ANSWER}</textarea>
												</c:if>
											</c:forEach>
											<input type="hidden" value="${data.QUESTIONID}" class="hiddenQuestionId">
										</c:if>
										
										<!-- 객관식 -->
										<c:if test="${data.ANSWERTYPE == '2'}">
											<li>
												<c:if test="${data.MULTIPLECHOICETYPE == '1'}">
													<c:forEach items="${rtnReply}" var="data3" varStatus="loop3">
														<c:if test="${data2.QUESTIONID == data3.QUESTIONID}">
															<input type="radio" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}" <c:if test="${data2.ANSWERID == data3.ANSWER}">checked="checked"</c:if> />
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${data.MULTIPLECHOICETYPE == '2'}">
													<input type="checkbox" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}" <c:forEach items="${rtnReply}" var="data3" varStatus="loop3"><c:if test="${data2.QUESTIONID == data3.QUESTIONID}"><c:if test="${data2.ANSWERID == data3.ANSWER}">checked="checked"</c:if></c:if></c:forEach>/>
												</c:if>
												<label for="">${data2.ANSWERNAME}</label>
											</li>
										</c:if>
										
										<!-- 이미지 -->
										<c:if test="${data.ANSWERTYPE == '3'}">
											<li>
												<c:if test="${data.MULTIPLECHOICETYPE == '1'}">
													<c:forEach items="${rtnReply}" var="data3" varStatus="loop3">
														<c:if test="${data2.QUESTIONID == data3.QUESTIONID}">
															<input type="radio" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}" title="이미지단일선택" <c:if test="${data2.ANSWERID == data3.ANSWER}">checked="checked"</c:if>/>
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${data.MULTIPLECHOICETYPE == '2'}">
													<input type="checkbox" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}" title="이미지선택" <c:forEach items="${rtnReply}" var="data3" varStatus="loop3"><c:if test="${data2.QUESTIONID == data3.QUESTIONID}"><c:if test="${data2.ANSWERID == data3.ANSWER}">checked="checked"</c:if></c:if></c:forEach>/>
												</c:if>
												<label for=""><img alt="이미지답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${data2.IMAGEFILENAME}&systemFileName=${data2.IMAGESFILENAME}" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" alt="이미지답안"/></label>
											</li>
										</c:if>
									</c:if>
									
									<c:if test="${empty rtnReply}">
									
										<!-- 주관식 -->
										<c:if test="${data.ANSWERTYPE == '1'}">
											<textarea name="answer${loop.count}" cols="45" rows="5" class="txtarea" title="주관식 답변 등록" style="height: 110px;" maxlength="1333"></textarea>
											<input type="hidden" value="${data.QUESTIONID}" class="hiddenQuestionId">
										</c:if>
										
										<!-- 객관식 -->
										<c:if test="${data.ANSWERTYPE == '2'}">
											<li>
												<c:if test="${data.MULTIPLECHOICETYPE == '1'}">
													<input type="radio" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}"/>
												</c:if>
												<c:if test="${data.MULTIPLECHOICETYPE == '2'}">
													<input type="checkbox" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}"/>
												</c:if>
												<label for="">${data2.ANSWERNAME}</label>
											</li>
										</c:if>
										
										<!-- 이미지 -->
										<c:if test="${data.ANSWERTYPE == '3'}">
											<li>
												<c:if test="${data.MULTIPLECHOICETYPE == '1'}">
													<input type="radio" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}" title="이미지단일선택">
												</c:if>
												<c:if test="${data.MULTIPLECHOICETYPE == '2'}">
													<input type="checkbox" name="answer${loop.count}" value="${data2.QUESTIONID}§${data2.ANSWERID}" title="이미지선택">
												</c:if>
												<label for=""><img alt="이미지답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${data2.IMAGEFILENAME}&systemFileName=${data2.IMAGESFILENAME}" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" alt="이미지답안"/></label>
											</li>
										</c:if>
										
									</c:if>
								</c:if>
							</c:forEach>
												
							<!-- 태그종료 (객관식) -->
							<c:if test="${data.ANSWERTYPE == '2'}"> </ul> </c:if>
							<!-- 태그종료 (이미지) -->
							<c:if test="${data.ANSWERTYPE == '3'}"> </ol> </c:if>
							
						</c:if>
					</dd>
				</c:forEach>
			</c:if>
		</dl>
	</fieldset>
	<div class="btn_area_center">
		<c:if test="${empty rtnParti}">
			<button type="button" class="btn_colorType01" id="btnSave">임시저장</button>
			<button type="button" class="btn_colorType01" id="btnFinish">설문완료</button>
		</c:if>
		<c:if test="${!empty rtnParti}">
			<c:if test="${rtnParti.status == 'F'}">
				<button type="button" class="btn_colorType01" id="btnSave">임시저장</button>
				<button type="button" class="btn_colorType01" id="btnFinish">설문완료</button>
			</c:if>
		</c:if>
		<button type="button" class="btn_colorType02" id="btnList">목록</button>
	</div>
</spform:form>
<!-- //콘텐츠영역-->

<script type="text/javascript">

	$(function(){
		
		<c:if test="${!empty rtnParti}">
			<c:if test="${rtnParti.status == 'T'}">
				$(".question_list").find("input").attr("disabled", "disabled");
				$(".question_list").find("textarea").attr("disabled", "disabled");
			</c:if>
		</c:if>
		
		// 목록
		$("#btnList").click(function(){
			location.href="${contextPath}/survey/view?surveyId=${rtnSurvey.surveyId}${link}";
		});
		
		// 저장
		$("#btnSave, #btnFinish").click(function(){
			
			// 검증
			var validCheck = true;
			$(".question_list > dd").each(function(){
				
				if(validCheck){
					if($(this).find("textarea").length > 0){ // 주관식
	
						if($(this).find("textarea").val().length < 1){
							alert("주관식 답안을 입력하세요");
							validCheck = false;
							$(this).find("textarea").focus();
							return;
						}
						
					}else{ // 객관식
						
						// 복수, 단수 구분
						var name = $(this).find("input").prop("name");
							
						if($(this).find("input[name='" + name + "']:checked").length < 1){
							
							alert("답안을 선택하세요");
							validCheck = false;
							$(this).find("input[name='" + name + "']").focus();
							return;
							
						}
					}
				}
				
			});
			
			if(validCheck){
				if(!confirm("저장하시겠습니까?")){
	    			return;
	    		}
				
				// 답안 셋팅
				$(".question_list > dd").each(function(){
					
					var value = "";
					
					// 주관식
					if($(this).find("textarea").length > 0){
						
						value = $(this).find(".hiddenQuestionId").val() + "§" + $(this).find("textarea").val();
						$(this).append("<textarea name='answers' style='display: none;'>"+value+"</textarea>");
						
					}else{
						// 복수, 단수 구분
						var name = $(this).find("input").prop("name");
						
						if($(this).find("input").prop("type") == "radio"){ // 단수
							
							value = $(this).find("input[name='" + name + "']:checked").val();
							
						}else{ // 복수
							
							$(this).find("input[name='" + name + "']:checked").each(function(i){
								
								value += $(this).val() + "-";
								
							});
						}
						
						$(this).append("<input type='hidden' name='answers' value='" + value + "'>");
						
					}
				});
				
				if($(this).prop("id")=="btnSave"){ // 임시저장
					$("#status").val("F");
				}else{ // 설문완료
					$("#status").val("T");
				}
				
				$("#insertForm").attr('action', '${contextPath}/survey/act');
				$("#insertForm").submit();
			}
		});
		
	});

</script>
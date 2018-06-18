<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="/includes/taglib.jsp" %>
<link rel="stylesheet" href="/resources/css/common/survey.css" />
<div id="contentArea">

	<!-- 콘텐츠영역 --> 
	<div class="question_info">
		<span class="bg"></span>
		<h2 class="subject">${rtnSurvey.KName}</h2>
		<p class="txt">${rtnSurvey.KHtml}</p>
	</div>

	<br />
	<ul class="survey_info">
		<li>설문기간 : ${rtnSurvey.surveyStartTime} ~ ${rtnSurvey.surveyEndTime}</li>
		<li>참여자 수 : ${partiCount} 명</li>
	</ul>
	<br />
	
	<spform:form id="searchForm" name="searchForm" action="${contextPath}/survey/act" method="POST">
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
							<c:if test="${data.ANSWERTYPE != '3'}"><ul></c:if>
							<c:if test="${data.ANSWERTYPE == '3'}"><ul class="survey_thumb"></c:if>
								<c:forEach items="${rtnStat}" var="data2" varStatus="loop2">
									<c:if test="${data.QUESTIONID == data2.QUESTIONID}">
										<li>
											<c:if test="${data2.ANSWERTYPE == '1'}">
												<button type="button" class="btn_colorType01 btn_textAnswer" value="${data2.QUESTIONID}">주관식답안목록</button>
											</c:if>							
											<c:if test="${data2.ANSWERTYPE != '1'}">
												<c:if test="${data2.ANSWERTYPE == '2'}">
													<strong class="graph_txt">${data2.ANSWERNAME}</strong> 
													<span class="graph_ba"><span class="graph" style="width: ${data2.RATIO}%">&nbsp;</span></span>
													<span class="graph_count">${data2.RATIO}% (${data2.CNT}건)</span>
												</c:if>
												<c:if test="${data2.ANSWERTYPE == '3'}">
													<span class="graph_thumb">
														<img src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${data2.ANSWERNAME}" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" alt="KHIDI" style="max-width: 90px; max-height: 90px;"/>
													</span>
													<div class="graph_area">
														<span class="graph_ba"><span class="graph" style="width: ${data2.RATIO}%">&nbsp;</span></span>
														<span class="graph_count">${data2.RATIO}% (${data2.CNT}건)</span>
													</div>
												</c:if>
											</c:if>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</dd>
					</c:forEach>
				</c:if>
			</dl>
		</fieldset>
		<div class="btn_area">
			<button type="button" class="btn btn_type01" id="btnList">목록</button>
			<button type="button" class="btn btn_type01" id="btnExcel">Excel</button>
			<button type="button" class="btn btn_type01" id="btnPrint" onclick="javascript:printIt('${contextPath }');">Print</button>
		</div>
	</spform:form>
</div>
<!-- //콘텐츠영역-->

<script type="text/javascript">

	$(function(){
		
		/* 주관식 답안 목록 팝업 */
		$(".btn_textAnswer").click(function(){
			var surveyId = "${rtnSurvey.surveyId}";
			var questionId = $(this).val();
			var link = "${link}";
			link = link.split("pageNum=")[0] + "pageNum=1";
			var url = "${ctxMgr}/surveyMgr/textAnswerList?surveyId=" + surveyId + "&questionId=" + questionId + link;
			gfnOpenWin(url, "주관식 답안 목록",'scrollbars=yes', 860, 700);
		});
		
		/* 목록 */
		$("#btnList").click(function(){
			location.href="${ctxMgr}/surveyMgr?${link}";
		});
		
		/* 엑실 다운 */
		$('#btnExcel').click(function(){
			$("#searchForm").attr('action', '${ctxMgr}/surveyMgr/excelDown');
			$('#searchForm').submit();
		});
		
	});

</script>
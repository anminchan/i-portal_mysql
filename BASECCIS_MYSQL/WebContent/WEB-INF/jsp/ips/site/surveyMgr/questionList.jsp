<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<form id="searchForm" name="searchForm" method="get">
		<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
		<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
	</form>
	
    <!-- 설문정보 -->
    <fieldset>
	    <legend>설문정보</legend>
	    <article class="news_view">
	        <dl class="info">
		        <dt>설문조사제목</dt>
				<dd><c:out value="${rtnSurvey.KName }" /></dd>
		        <dt>설문조사기간</dt>
				<dd>
					<fmt:parseDate value="${rtnSurvey.surveyStartTime}" pattern="yyyy-MM-dd" var="surveyStartTime"/>
					<fmt:formatDate value="${surveyStartTime}" pattern="yyyy-MM-dd"/> ~ 
					<fmt:parseDate value="${rtnSurvey.surveyEndTime}" pattern="yyyy-MM-dd" var="surveyEndTime"/>
					<fmt:formatDate value="${surveyEndTime}" pattern="yyyy-MM-dd"/>
				</dd>
	        </dl>
	        <dl class="info">
		        <dt>설문개요</dt>
				<dd>${rtnSurvey.KHtml}</dd>
	        </dl>
	    </article>
	</fieldset>
	<br />
	
	<!-- 문항목록 -->
	<form id="listForm" name="listForm" action="${ctxMgr }/surveyMgr/questionDelete" method="POST">
		<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
		<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
		<input type="hidden" name="schSiteId" value="${param.schSiteId}">
		<input type="hidden" name="schType" value="${param.schType}">
		<input type="hidden" name="schKName" value="${param.schKName}">
		<input type="hidden" name="surveyId" value="${obj.surveyId}">
		<br />
		<div class="float_wrap">	
			<c:if test="${partiCount > 0}">
				<p class="articles"><span class="txt_bold">설문조사 참여자가 존재할 경우 문항과 답안을 수정, 삭제하실 수 없습니다.</span></p>
			</c:if>
			<div class="float_right">
				<c:if test="${partiCount < 1}">
					<button type="button" class="btn btn_basic roleWRITE" id="btnAdd">문항등록</button>
					<button type="button" class="btn btn_basic roleDELETE" id="btnDelete">문항삭제</button>
				</c:if>
				<button type="button" class="btn btn_basic" id="btnList">목록</button>
			</div>
		</div>
		
   		<div class="table">
			<table class="tstyle_list">
				<caption>
					설문조사문항 목록
				</caption>		
				<colgroup>
					<c:if test="${partiCount <= 0}">
					<col class="allChk"/>
					</c:if>
					<col class="num"/>
		            <col class="name"/>
					<col />
				</colgroup>		
				<thead>
					<tr>
						<c:if test="${partiCount <= 0}">
						<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
						</c:if>
						<th scope="col">번호</th>
						<th scope="col">답안유형</th>
						<th scope="col">문항</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>			
						<c:when test="${!empty result}">
							<c:forEach items="${result}" var="data" varStatus="loop">
								<tr>
									<c:if test="${partiCount <= 0}">
									<td><input type="checkbox" id="chkQuestionIds" name="chkQuestionIds" class="listCheck" value="${data.QUESTIONID}" title="선택" /></td>
									</c:if>
									<td>${data.NO1}</td>
									<td>
									<c:if test="${data.ANSWERTYPE eq '1'}">주관식</c:if>
									<c:if test="${data.ANSWERTYPE eq '2'}">객관식</c:if>
									<c:if test="${data.ANSWERTYPE eq '3'}">객관식(이미지)</c:if>
									</td>
									<td>
										<c:if test="${partiCount < 1}">
											<a href="${ctxMgr}/surveyMgr/questionForm?surveyId=${data.SURVEYID}&questionId=${data.QUESTIONID}&pageNum=${obj.pageNum}${link}">${data.KNAME}</a>
										</c:if>
										<c:if test="${partiCount > 0}">
											${data.KNAME}
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4"> 조회된 데이터가 없습니다. </td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</form>
</div>
<script type="text/javascript">
$(function() {
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/surveyMgr/questionForm?surveyId=${obj.surveyId}${link}&pageNum=${obj.pageNum}";
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=chkQuestionIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/surveyMgr/questionDelete');
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/surveyMgr');
		$("#insertForm").submit(); */
		location.href="${contextPath}/mgr/surveyMgr?${link}";
	});
});
</script>

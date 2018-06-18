<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<form id="searchForm" name="searchForm" method="get">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
</form>

<form id="listForm" name="listForm" action="${contextPath}/survey/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
	<input type="hidden" name="surveyId" value="${obj.surveyId}">
	<input type="hidden" name="questionId" value="${obj.questionId}">
	
	<table class="tstyle_list" summary="번호, 주관식답안">
		<caption>
			주관식답안
		</caption>
		<colgroup>
			<col width="60" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">주관식답안</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>			
				<c:when test="${!empty result}">
					<c:forEach items="${result}" var="data" varStatus="loop">
						<tr>
							<td>${data.NO1}</td>
							<td class="txt_left">${data.ANSWER}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="2">조회된 데이터가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</form>
<c:if test="${!empty result && fn:length(result) > 0 }">
   <div class="board_pager">
       <paging:PageFooter totalCount="${totalCnt}" rowCount="${obj.rowCnt}" siteGubun="U">
           <Previous><AllPageLink><Next>
       </paging:PageFooter>
   </div>
</c:if>

<script type="text/javascript">
$(function() {
	
});
</script>

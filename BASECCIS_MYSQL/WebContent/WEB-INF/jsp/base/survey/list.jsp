<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="searchForm" name="searchForm" method="GET">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
	<div class="articles_search">
		<!-- //검색 결과 -->
	    <c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	    <p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>   
	    <!-- //검색 결과 -->
		<div class="basic_searchForm">
			<label>제목</label>
			<!-- <select name="schType" id="schType" title="검색구분">
				<option value="1">제목</option>
				<option value="2">내용</option>
				<option value="3">작성자</option>
			</select> -->
			<input type="text" name="schKName" id="schKName" value="${param.schKName}" title="검색어입력"/>
		    <input type="button" value="검색" class="input_smallBlack" id="btnSearch" />
		</div>
	</div>		
</form>

<form id="listForm" name="listForm" action="${ctxMgr}/surveyMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
	
	<table class="tstyle_list">
		<caption>
			${rtnMenuName} : 번호, 설문제목, 설문기간
		</caption>
		<colgroup>			
			<col class="col-sm-2"/>
			<col class="col-sm-6"/>
			<col class="col-sm-4"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">설문제목</th>
				<th scope="col">설문기간</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr>
							<td>${data.NO1 }</td>
							<td class="txt_left"><a href="${contextPath}/survey/view?pageNum=${obj.pageNum}&surveyId=${data.SURVEYID}${link}">${data.KNAME}</a></td>
							<td>${data.SURVEYSTARTTIME} ~ ${data.SURVEYENDTIME}</td>
							<%-- <td><fmt:formatDate value="${data.INSTIME}" pattern="yyyy-MM-dd"/></td> --%>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3">조회된 데이터가 없습니다.</td>
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
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#searchForm").attr('action', '/survey');
		$('#searchForm').submit();
	});
	
});
</script>

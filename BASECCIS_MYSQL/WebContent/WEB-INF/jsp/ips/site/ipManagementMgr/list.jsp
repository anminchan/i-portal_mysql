<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="listForm" name="listForm" action="${ctxMgr }/ipManagementMgr" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">	
	<div class="float_wrap">
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>	
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="float_right">
			<button type="button" class="btn btn_type01" id="btnAdd">등록</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				IP관리 목록
			</caption>		
			<colgroup>
				<col class="num"/>
				<col width="25%"/>
				<col />
				<col width="5%"/>
			</colgroup>		
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">IP</th>
					<th scope="col">비고</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
					<tr>
						<td>${totalCnt - data.RNUM+1}</td>
						<td class="txt_left"><a href="${ctxMgr }/ipManagementMgr/form?seq=${data.SEQ }${link}">${data.IP_1 }.${data.IP_2 }.${data.IP_3 }.${data.IP_4 }</a></td>
						<td>${data.REMK }</td>
						<td>
							<c:if test="${data.ALLWYN == 'Y'}">YES</c:if>
	                		<c:if test="${data.ALLWYN == 'N'}">NO</c:if>
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
<div class="board_pager">
	<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>
</div>

<script type="text/javascript">
$(function() {	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/ipManagementMgr/form?${link}";
	});
	
});
</script>

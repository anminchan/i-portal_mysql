<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<spform:form id="searchForm" name="searchForm" method="GET" action="${contextPath}/mgr/contentsUseStat" class="search_form">
		<input type="hidden" name="menuId" value="${param.menuId}">
		<input type="hidden" name="inGubun" id="inGubun" value="">
		<input type="hidden" name="statGubun" id="statGubun" value="${param.statGubun}">
	
		<fieldset>
			<legend>검색조건</legend>
			<div class="form_group">
				<div class="row">
					<label for="connectTime">기간</label>
					<input type="text" id="schStartDate" name="schStartDate" title="검색시작기간 선택" value="${obj.schStartDate }" readonly="readonly"/> ~
			        <input type="text" id="schEndDate" name="schEndDate" title="검색종료기간 선택" value="${obj.schEndDate }" readonly="readonly"/>
				</div>
				<span class="display_block txt_center">
					<input type="submit" id="btnSearch" class="btn btn_type02" value="검색">
				</span>
			</div>
		</fieldset>
	</spform:form>
	
	<c:if test="${empty first}">
	<br />
	<ul class="tab_menu">
		<li <c:if test="${statGubun == 'BOARD'}">class="on"</c:if>><a href="javascript:goList('BOARD')">게시판형</a></li>
		<li <c:if test="${statGubun == 'PROGRAM'}">class="on"</c:if>><a href="javascript:goList('PROGRAM')">프로그램형</a></li>
	</ul>
	
	<spform:form id="listForm" name="listForm" action="${contextPath}/mgr/contentsUseStats/delete" method="POST">
	    <input type="hidden" name="menuId" id="menuId" value="${obj.menuId}" />
	    <input type="hidden" name="siteId" value="${obj.siteId}" />
	    <input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	    <input type="hidden" name="schStartDate" value="${obj.schStartDate}">
		<input type="hidden" name="schEndDate" value="${obj.schEndDate}">
	
		<%-- <c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0)}"/>
		<div class="float_wrap">	
			<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		</div> --%>

		<table class="tstyle_list">
			<caption>콘텐츠이용현황 목록 / 사이트, 메뉴(구분), 제목, 조회수(스크랩)에 따른 콘텐츠이용현황 목록</caption>
			<colgroup>
				<col width="5%"/>
				<col />
				<col width="40%"/>
				<col width="5%"/>
			</colgroup>
			
			<c:if test="${statGubun == 'BOARD'}">			
				<thead>
					<tr>
						<th scope="col">순위</th>
						<th scope="col">파일명</th>
						<th scope="col">메뉴</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${!empty result}">
							<c:forEach items="${result}" var="data" varStatus="loop">
								<tr>
									<td>${data.RNUM}</td>
									<td>${data.USERFILENAME}</td>
									<td class="txt_left">${data.LOCATION}</td>
									<td>${data.HITCOUNT}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">조회된 데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</c:if>
			
			<c:if test="${statGubun == 'PROGRAM'}">			
				<thead>
					<tr>
						<th scope="col">순위</th>
						<th scope="col">파일명</th>
						<th scope="col">메뉴</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${!empty result}">
							<c:forEach items="${result}" var="data" varStatus="loop">
								<tr>
									<td>${data.RNUM}</td>
									<td>${data.USERFILENAME}</td>
									<td class="txt_left">${data.LOCATION}</td>
									<td>${data.HITCOUNT}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">조회된 데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</c:if>			
		</table>
		
	</spform:form>
	</c:if>
</div>

<script type="text/javascript">
$(function() {	
	gfnSiteComboList($("#siteId"), "", "전체 선택", "${param.siteId}");
	    
    $("#schStartDate, #schEndDate").datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
		onClose: function( selectedDate ) { 
			$('#schEndDate').datepicker("option","minDate", selectedDate); 
		} 
    });
    
	$('#btnSearch').click(function(){
		if($('#schStartDate').val() != null && $('#schStartDate').val() != ''){
    		if($('#schEndDate').val() == null || $('#schEndDate').val() == ''){
    			alert("검색 종료일을 입력하세요");
    			document.searchForm.schEndDate.focus();
    			return false;
    		}
    	}
    	
    	if($('#schEndDate').val() != null && $('#schEndDate').val() != ''){
    		if($('#schStartDate').val() == null || $('#schStartDate').val() == ''){
    			alert("검색 시작일을 입력하세요");
    			document.searchForm.schStartDate.focus();
    			return false;
    		}
    	}
    	
		$("#searchForm").attr('action', '${ctxMgr}/fileDownloadStat');
		$('#searchForm').submit();
	});
	
});

//탭 메뉴 이동
function goList(statGubun) {
	$("#statGubun").val(statGubun);
	
	$("#searchForm").attr('action', '${ctxMgr}/fileDownloadStat');
	$('#searchForm').submit();
}

</script>

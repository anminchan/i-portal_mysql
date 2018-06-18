<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	
	<form id="searchForm" name="searchForm" method="get" class="search_form">
		<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
		<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
		<fieldset>
			<legend>검색조건</legend>
			<div class="form_group">
				<div class="row">
					<label>제목</label>
					<input type="text" name="schKName" id="schKName" class="input_mid" value="${param.schKName}" title="검색어"/>
				</div>
				<span class="display_block txt_center">
					<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
				</span>
			</div>
		</fieldset>
	</form>
	
	<form id="listForm" name="listForm" action="${ctxMgr }/personalInfoMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
	<input type="hidden" name="schState" value="${param.schState}">
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<br />
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<button type="button" class="btn btn_basic roleWRITE" id="btnAdd">등록</button>
			<button type="button" class="btn btn_basic roleDELETE" id="btnDelete">삭제</button>
			<!-- <button type="button" class="btn_colorType01" id="btnExcel">Excel</button> -->
			<button type="button" class="btn btn_basic" id="btnPrint" onclick="javascript:printIt('${contextPath }');">Print</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list" summary="전체, 순번, 사이트명, 제목, 게시시작일, 게시종료일, 순서, 사용여부">
			<caption>
				개인정보처리방침관리 목록
			</caption>		
			<colgroup>
				<col width="60" />
				<col width="100" />
				<col />
				<col width="300" />
			</colgroup>		
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">순번</th>
					<th scope="col">제목</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
	
					<tr>
						<td><input type="checkbox" id="chkPersonalInfoIds" name="chkPersonalInfoIds" class="listCheck" value="${data.personalInfoId }" title="선택" /></td>
						<td>${data.no1 }</td>
						<td><a href="${ctxMgr }/personalInfoMgr/form?pageNum=${ obj.pageNum }&personalInfoId=${data.personalInfoId }${link}">${data.KName }</a></td>
						<td>${data.insTime }</td>
					</tr>
				
					</c:forEach>
				</c:when>
				<c:otherwise>
			
				<tr>
					<td colspan="6"> 조회된 데이터가 없습니다. </td>
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
</div>
<script type="text/javascript">
$(function() {
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#searchForm").attr('action', '${ctxMgr }/personalInfoMgr');
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	$('#btnExcel').click(function(){
		$("#searchForm").attr('action', '${ctxMgr }/personalInfoMgr/excelDown');
		$('#searchForm').submit();
	});
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/personalInfoMgr/form?${link}&pageNum=${ obj.pageNum }";
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=chkPersonalInfoIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/personalInfoMgr/delete');
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	//클릭이벤트
	
});
</script>

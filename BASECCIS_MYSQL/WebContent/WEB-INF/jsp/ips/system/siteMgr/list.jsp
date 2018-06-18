<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="searchForm" name="searchForm" method="GET" class="search_form">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="schType">검색구분</label>
				<select name="schType" id="schType" title="검색구분">
					<option value="0">전체</option>
					<option value="1">사이트명</option>
					<option value="2">사이트URL</option>
				</select>
				<input type="text" name="schText" id="schText" class="input_mid" value="${param.schText}" title="검색어"/>		
			</div>
			<span class="display_block txt_center">
				<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
			</span>
		</div>
	</fieldset>
</form>


<form id="listForm" name="listForm" action="${ctxMgr }/siteMgr/delete" method="POST">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schType" value="${empty param.schType ? 0 : param.schType}">
	<input type="hidden" name="schText" value="${param.schText}">	
	
	<div class="float_wrap">	
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="float_right">
			<button type="button" id="btnPrint" class="btn btn_basic"><i class="xi-print"></i> Print</button>
			<button type="button" id="btnExcel" class="btn btn_basic"><i class="xi-file-text-o"></i> Excel</button>
			<button type="button" class="btn btn_basic" id="btnAdd">등록</button>
			<button type="button" class="btn btn_basic roleDELETE" id="btnDelete">삭제</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				사이트관리 목록 - 번호, 사이트ID, 사이트명, 사이트 URL에 따른 사이트관리 목록
			</caption>
			<colgroup>
				<col class="allChk" />
				<col class="num" />
				<col class="category"/>
				<col class="col-sm-4"/>
				<col class="col-sm-5"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">사이트ID</th>
					<th scope="col">사이트명</th>
					<th scope="col">사이트 URL</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">		
					<tr>
						<td><input type="checkbox" id="chkSiteIds" name="chkSiteIds" class="listCheck" value="${data.SITEID }" title="선택" /></td>
						<td>${data.NO1 }</td>
						<td>${data.SITEID }</td>
						<td class="txt_left"><a href="${ctxMgr }/siteMgr/form?pageNum=${ obj.pageNum }&paramSiteId=${data.SITEID }${link}">${data.KNAME }</a></td>
						<td class="txt_left">${data.URL }</td>
					</tr>			
					</c:forEach>
				</c:when>
				<c:otherwise>		
				<tr>
					<td colspan="5"> 조회된 데이터가 없습니다. </td>
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
//$(document).ready(function() {
$(function() {
	$('#schType').val('${empty param.schType ? 0 : param.schType}');

	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/siteMgr/form?${link}&pageNum=${ obj.pageNum }";
	});

	$("#btnList").on("click", function() {
		$("#masterForm").attr({action:"${ctxMgr }/siteMgr"});
		$("#masterForm").submit();
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=chkSiteIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	
	//엑셀다운로드
	$("#btnExcel").click(function(){
		var url = "${contextPath}/mgr/siteMgr/ExcelDown";
		document.searchForm.action = url;
		document.searchForm.submit();
	});
	
	// 인쇄
	$('#btnPrint').click(function(){
		printIt("${contextPath}");
	});
	
});

</script>

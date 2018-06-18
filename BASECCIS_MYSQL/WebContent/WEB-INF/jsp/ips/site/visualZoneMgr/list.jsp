<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="searchForm" name="searchForm" method="get" class="search_form">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="siteIdSel">사이트</label>
				<select name="siteIdSel" id="siteIdSel"></select>
			</div>
			<div class="row">
				<label for="schKName">제목</label>
				<input type="text" name="schKName" id="schKName" class="input_mid" value="${param.schKName}" title="검색어"/>
			</div>
			<span class="display_block txt_center">
				<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
			</span>
		</div>
	</fieldset>
</form>
	
<form id="listForm" name="listForm" action="${ctxMgr }/visualZoneMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
		
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<div class="float_wrap">	
		<p class="articles ">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="float_right">
			<button type="button" id="btnPrint" class="btn btn_basic"><i class="xi-print"></i> Print</button>
			<button type="button" id="btnExcel" class="btn btn_basic"><i class="xi-file-text-o"></i> Excel</button>			
			<button type="button" id="btnAdd" class="btn btn_basic">등록</button>
			<button type="button" id="btnDelete" class="btn btn_basic" >삭제</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				비주얼존관리 목록-선택여부, 번호, 사이트명, 이미지, 비주얼존명, 순서, 사용여부 안내
			</caption>
			<colgroup>
				<col class="allChk"/>
				<col class="num" />
				<col class="site_Name" />
				<col class="thumb" />
				<col class="" />
				<col class="sort"/>
				<col class="date"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">사이트명</th>
					<th scope="col">이미지</th>
					<th scope="col">비주얼존명</th>
					<th scope="col">순서</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">	
					<tr>
						<td><input type="checkbox" id="chkVisualZoneIds" name="chkVisualZoneIds" class="listCheck" value="${data.visualZoneId }" title="선택" /></td>
						<td>${data.no1 }</td>
						<td>${data.site_Name }</td>
						<td><a href="${ctxMgr }/visualZoneMgr/form?pageNum=${ obj.pageNum }&visualZoneId=${data.visualZoneId }${link}">
								<img alt="${data.imageFileName }" src="${contextPath}/fileDownload?fileGubun=common&menuId=visualZoneMgr&userFileName=${data.imageFileName }&systemFileName=${data.imageSFileName }" style="width:150px; " />
							</a>
						</td>
						<td><a href="${ctxMgr }/visualZoneMgr/form?pageNum=${ obj.pageNum }&visualZoneId=${data.visualZoneId }${link}">${data.KName }</a></td>
						<td>${data.sort }</td>
						<td>
							<c:if test="${data.state == 'T'}">YES</c:if>
		                	<c:if test="${data.state == 'F'}">NO</c:if>
						</td>
					</tr>				
					</c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
					<td colspan="7"> 조회된 데이터가 없습니다. </td>
				</tr>				
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
	<div class="board_pager">
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<Previous><AllPageLink><Next>
		</paging:PageFooter>
	</div>
</form>
<script type="text/javascript">

$(function() {

	gfnSiteAdminComboList($("#siteIdSel"), "", <c:if test="${ADMUSER.totalAuth ne 'Y'}">""</c:if><c:if test="${ADMUSER.totalAuth eq 'Y'}">"전체"</c:if>, "${param.schSiteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#schSiteId").val($(this).val());
	});
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#schSiteId").val($("#siteIdSel").val());
		$("#searchForm").attr('action', '${ctxMgr }/visualZoneMgr');
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	$('#btnExcel').click(function(){
		$("#searchForm").attr('action', '${ctxMgr }/visualZoneMgr/excelDown');
		$('#searchForm').submit();
	});
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/visualZoneMgr/form?${link}&pageNum=${ obj.pageNum }";
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=chkVisualZoneIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/visualZoneMgr/delete');
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	//클릭이벤트
	
	// 인쇄
	$('#btnPrint').click(function(){
		printIt("${contextPath}");
	});
	
});
</script>

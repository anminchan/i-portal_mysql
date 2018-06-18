<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
	
<spform:form id="searchForm" name="searchForm" action="${contextPath }/mgr/sampleMgr" method="GET" class="search_form">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="schType">검색구분</label>
				<select name="schType" id="schType" title="검색구분">
					<option value="0" ${obj.schType == '0' ? 'selected="selected"' : ''}>전체</option>
					<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
					<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
				</select>
				<input type="text" name="schText" id="schText" class="input_mid" value="${param.schText}" title="검색어"/>
			</div>
			<span class="display_block txt_center">
				<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
			</span>
		</div>
	</fieldset>
</spform:form>

<spform:form id="listForm" name="listForm" action="${ctxMgr }/sampleMgr/act" method="POST">
	<input type="hidden" name="menuId" value="${obj.menuId}">
	<input type="hidden" name="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schType" value="${obj.schType}">
	<input type="hidden" name="schText" value="${obj.schText}">	
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<div class="float_wrap">	
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
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
				사이트관리 목록 - 번호, 제목, 작성자, 등록일 기능관리 목록
			</caption>
			<colgroup>
				<col class="allChk"/>
				<col class="num" />
				<col class="subject" />
				<col class="name" />
				<col class="date"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr>
							<td><input type="checkbox" id="sampleIds" name="sampleIds" class="listCheck" value="${data.SAMPLEID }" title="선택" /></td>
							<td>${totalCnt - data.RNUM+1}</td>
							<td class="txt_left"><a href="${ctxMgr }/sampleMgr/view?sampleId=${data.SAMPLEID }${link}">${data.SAMPLETITLE }</a></td>
							<td>${data.INSUSERID }</td>
							<td><fmt:formatDate value="${data.INSTIME}" pattern="yyyy-MM-dd"/></td>
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
	<div class="board_pager">
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<Previous><AllPageLink><Next>
		</paging:PageFooter>
	</div>
</spform:form>

<script type="text/javascript">
$(function() {
	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/sampleMgr/form?${link}";
	});

	$("#btnList").on("click", function() {
		$("#masterForm").attr({action:"${ctxMgr }/sampleMgr"});
		$("#masterForm").submit();
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {
		$nCnt = $("input:checkbox[name=sampleIds]:checked").length;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr({action:"${ctxMgr }/sampleMgr/delete"});
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	
});

//엑셀다운로드
function doExcelDownload(){
	var url = "${contextPath}/mgr/sampleMgr/ExcelDown";
	document.searchForm.action = url;
	document.searchForm.submit();
}

</script>

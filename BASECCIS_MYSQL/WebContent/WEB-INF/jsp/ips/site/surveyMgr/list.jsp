<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="searchForm" name="searchForm" method="get" class="search_form">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="schType">주관사이트</label>
				<select name="siteIdSel" id="siteIdSel" title="검색구분">
				</select>
			</div>
			<div class="row">
				<label for="schType">검색조건</label>
				<select name="schType" id="schType">
					<option value="0" <c:if test="${obj.schType == '0' }">selected</c:if> >전체</option>
					<option value="1" <c:if test="${obj.schType == '1' }">selected</c:if> >제목</option>
					<option value="2" <c:if test="${obj.schType == '2' }">selected</c:if> >설문개요</option>
					<%-- <option value="3" <c:if test="${obj.schType == '3' }">selected</c:if> >등록자</option> --%>
				</select>
				<input type="text" name="schKName" id="schKName" class="input_mid" value="${param.schKName}" title="검색어"/>
			</div>
			<span class="display_block txt_center">
				<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
			</span>
		</div>
	</fieldset>
</form>

<form id="listForm" name="listForm" action="${ctxMgr }/surveyMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>	
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<!-- <button type="button" id="btnPrint" class="btn btn_basic"><i class="xi-print"></i> Print</button>
			<button type="button" id="btnExcel" class="btn btn_basic"><i class="xi-file-text-o"></i> Excel</button> -->
			
			<button type="button" class="btn btn_basic" id="btnAdd">등록</button>
			<button type="button" class="btn btn_basic" id="btnDelete">삭제</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption> 
				설문조사관리 목록 - 전체, 번호, 주관사이트, 설문제목, 설문조사기간, 문항관리, 미리보기, 통계
			</caption>		
			<colgroup>
				<col width="5%"/>
				<col width="5%" />
				<col />
				<col width="20%" />
				<col width="10%" />
				<col width="15%" />
				<col width="5%" />
				<col width="5%" />
				<col width="5%" />
			</colgroup>		
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">주관사이트</th>
					<th scope="col">제목</th>
					<th scope="col">등록일</th>
					<th scope="col">설문조사기간</th>
					<th scope="col">문항관리</th>
					<th scope="col">미리보기</th>
					<th scope="col">통계</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>			
					<c:when test="${!empty result }">
						<c:forEach items="${result }" var="data" varStatus="loop">
							<tr>
								<td><input type="checkbox" id="chkSurveyIds" name="chkSurveyIds" class="listCheck" value="${data.surveyId }" title="선택" /></td>
								<td>${data.no1 }</td>
								<td>${data.site_Name }</td>
								<td class="txt_left"><a href="${ctxMgr}/surveyMgr/form?pageNum=${obj.pageNum}&surveyId=${data.surveyId}${link}">${data.KName}</a></td>
								<td>
									<fmt:parseDate value="${data.insTime }" pattern="yyyy-MM-dd" var="insTime"/>
									<fmt:formatDate value="${insTime }" pattern="yyyy-MM-dd"/> 
								</td>
								<td>
									<fmt:parseDate value="${data.surveyStartTime }" pattern="yyyy-MM-dd" var="surveyStartTime"/>
									<fmt:formatDate value="${surveyStartTime }" pattern="yyyy-MM-dd"/> ~ 
									<fmt:parseDate value="${data.surveyEndTime }" pattern="yyyy-MM-dd" var="surveyEndTime"/>
									<fmt:formatDate value="${surveyEndTime }" pattern="yyyy-MM-dd"/>
								</td>
								<td><button class="btn_graySmall" onclick="javascript:fnQuestion('${data.surveyId }');" type="button">문항관리</button></td>
								<td><button class="btn_graySmall" onclick="javascript:fnPreview('${data.surveyId }');" type="button">미리보기</button></td>
								<%-- <td><a class="btn_graySmall" href="javascript:fnCopy('${data.surveyId }');">주소복사</a></td> --%>
								<td><button class="btn_graySmall" onclick="javascript:fnStat('${data.surveyId }');" type="button">통계</button></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="9"> 조회된 데이터가 없습니다. </td>
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
	
	/* 사이트목록 */
	gfnSiteAdminComboList($("#siteIdSel"), "", <c:if test="${ADMUSER.totalAuth ne 'Y'}">""</c:if><c:if test="${ADMUSER.totalAuth eq 'Y'}">"전체"</c:if>, "${param.schSiteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#schSiteId").val($(this).val());
	});
	
	/* 검색 */
	$('#btnSearch').click(function(){
		$("#schSiteId").val($("#siteIdSel").val());
		$("#searchForm").attr('action', '${ctxMgr}/surveyMgr');
		$('#searchForm').submit();
	}); 

	/* 전체선택 */
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	/* 엑셀다운 */
	$('#btnExcel').click(function(){
		$("#searchForm").attr('action', '${ctxMgr}/surveyMgr/excelDown');
		$('#searchForm').submit();
	});
	
	/* 등록 */
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr}/surveyMgr/form?${link}&pageNum=${obj.pageNum}";
	});
	
	/* 삭제 */
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=chkSurveyIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr}/surveyMgr/delete');
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	
	
});


/* 문항관리 */
function fnQuestion(surveyId){
	location.href='${ctxMgr}/surveyMgr/questionList?surveyId=' + surveyId + "&pageNum=${obj.pageNum}${link}";
}

/* 미리보기 */
function fnPreview(surveyId){
	try{win.focus();}catch(e){}
	win = window.open('${ctxMgr}/surveyMgr/preview?surveyId=' + surveyId, 'preview_pop', 'width=870px,height=800px,scrollbars=yes,status=no');
}

/* URL복사 */
/* function fnCopy(surveyId){
	var strUrl = '${currentUrl}${contextPath}/mgr/surveyMgr/preview?surveyId=' + surveyId;
	var IE=(document.all)?true:false;
	if (IE) {
		if (!confirm("주소를 복사하시겠습니까?")) {
			return;
		}
		window.clipboardData.setData("Text", strUrl);
		alert ( "주소가 복사되었습니다. \'Ctrl+V\'를 눌러 붙여넣기 해주세요." );
	} else {
		temp = prompt("설문조사 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", strUrl);
	}
} */

/* 통계 */
function fnStat(surveyId){
	location.href='${currentUrl}${contextPath}/mgr/surveyMgr/stat?surveyId=' + surveyId + '&pageNum=${obj.pageNum}${link}';
}

</script>

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
					<label for="siteIdSel">사이트</label>
					<select name="siteIdSel" id="siteIdSel"></select>
				</div>
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
	
	<form id="listForm" name="listForm" action="${ctxMgr }/newsTickerMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<br />
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<button type="button" class="btn btn_basic roleWRITE" id="btnAdd">등록</button>
			<button type="button" class="btn btn_basic roleDELETE" id="btnDelete">삭제</button>
			<button type="button" class="btn btn_basic" id="btnPrint" onclick="javascript:printIt('${contextPath }');">Print</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				뉴스티커관리 목록
			</caption>		
			<colgroup>
				<col width="60" span="2" />
				<col width="300" />
				<col />
				<col width="150" span="2"/>
				<col width="80"/>
			</colgroup>		
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">순번</th>
					<th scope="col">사이트명</th>
					<th scope="col">제목</th>
					<th scope="col">게시시작일</th>
					<th scope="col">게시종료일</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr>
							<td><input type="checkbox" id="newsTickerIds" name="newsTickerIds" class="listCheck" value="${data.NEWSTICKERID }" title="선택" /></td>
							<td>${totalCnt - data.RNUM+1}</td>
							<td>${data.SITE_NAME }</td>
							<td class="txt_left"><a href="${ctxMgr }/newsTickerMgr/form?pageNum=${obj.pageNum }&newsTickerId=${data.NEWSTICKERID }${link}">${data.KNAME }</a></td>
							<td>
							<fmt:parseDate value="${data.STARTTIME }" pattern="yyyy-MM-dd HH" var="startTime"/>
							<fmt:formatDate value="${startTime }" pattern="yyyy-MM-dd HH"/>
							</td>
							<td>
							<fmt:parseDate value="${data.ENDTIME }" pattern="yyyy-MM-dd HH" var="endTime"/>
							<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd HH"/>
							</td>
							<td>
								<c:if test="${data.STATE == 'T'}"><img src="/resources/images/ips/bbs/img_yes.gif" alt="예" /></c:if>
		                		<c:if test="${data.STATE == 'F'}"><img src="/resources/images/ips/bbs/img_no.gif" alt="아니오" /></c:if>
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
	</form>
	<div class="board_pager">
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<Previous><AllPageLink><Next>
		</paging:PageFooter>
	</div>
</div>
<script type="text/javascript">
$(function() {
	gfnSiteAdminComboList($("#siteIdSel"), "", <c:if test="${ADMUSER.totalAuth ne 'Y'}">""</c:if><c:if test="${ADMUSER.totalAuth eq 'Y'}">"전체"</c:if>, "${param.schSiteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#schSiteId").val($(this).val());
	});
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#schSiteId").val($("#siteIdSel").val());
		$("#searchForm").attr('action', '${ctxMgr }/newsTickerMgr');
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	/* $('#btnExcel').click(function(){
		$("#searchForm").attr('action', '${ctxMgr }/newsTickerMgr/excelDown');
		$('#searchForm').submit();
	}); */
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/newsTickerMgr/form?${link}&pageNum=${ obj.pageNum }";
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=newsTickerIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/newsTickerMgr/delete');
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

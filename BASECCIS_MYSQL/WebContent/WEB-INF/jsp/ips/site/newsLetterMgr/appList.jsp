<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<form id="searchForm" name="searchForm" method="get">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="siteId" id="siteId" value="${param.siteId}">

		<fieldset>
			<legend>검색조건</legend>
			<table class="tstyle_view">
				<caption>
					신청기간
				</caption>
				<colgroup>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
				</colgroup>
				<tr>
					<th scope="row"><label>신청기간</label></th>
					<td colspan="3">
                        <input type="text" size="8" name="schStartDate" id="schStartDate" value="${param.schStartDate}" readonly="readonly"/>~<input type="text" size="8" name="schEndDate" id="schEndDate" value="${param.schEndDate }" readonly="readonly"/>
                        <span class="float_right">
							<input type="button" id="btnSearch" class="btn_black" value="검색">
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label>이메일</label></th>
					<td>
                        <input type="text" name="appEmail" id="appEmail" value="${param.appEmail}"/>
					</td>
					<th scope="row"><label>수신여부</label></th>
					<td>
                        <select id="rcvYn" name="rcvYn">
                        	<option value="" <c:if test="${empty param.rcvYn or param.rcvYn eq '' }">selected</c:if>>전체</option>
                        	<option value="Y" <c:if test="${param.rcvYn eq 'Y' }">selected</c:if>>수신허용</option>
                        	<option value="N" <c:if test="${param.rcvYn eq 'N' }">selected</c:if>>수신거부</option>
                        </select>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
	
	<form id="listForm" name="listForm" action="${ctxMgr }/popupZoneMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="siteId" value="${param.siteId}">
	<input type="hidden" name="schKName" value="${param.schKName}">
	
	<br />
	<div class="float_wrap">
		<div class="basic_searchForm float_right">
			<button type="button" class="btn_colorType01" id="btnExcel" onclick="javascript:doExcelDownload();">Excel</button>
		</div>
	</div>
	<table class="tstyle_list" summary="전체, 순선, 사이트명, 제목, 게시시작일, 게시종료일, 순서, 사용여부">
		<caption>
			팝업존관리 목록
		</caption>
		<colgroup>
			<col style="width:80px" />
			<col style="width:*" />
			<col style="width:120px" />
			<col style="width:120px" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">이메일</th>
				<th scope="col">신청일</th>
				<th scope="col">수신여부</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>			
			<c:when test="${!empty result }">
				<c:forEach items="${result }" var="data" varStatus="loop">
				<tr>
					<td>${totalCnt - data.RNUM+1}</td>
					<td>${data.APPEMAIL }</td>
					<td>
						<fmt:formatDate value="${data.APPTIME }" var="appDate" pattern="yyyy-MM-dd" />
						${appDate }
					</td>
					<td>
						${data.RCV_YN eq 'Y' ? '수신허용' : '수신거부' }
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
	</form>
	
	<div class="board_pager">
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<Previous><AllPageLink><Next>
		</paging:PageFooter>
	</div>
</div>

<script type="text/javascript">

$(function(){
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#searchForm").attr('action', '${ctxMgr}/newsLetterMgr/mailAppList');
		$('#searchForm').submit();
	}); 
    
    //달력 세팅
    $( "#schStartDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
		buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
    
    $( "#schEndDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
		buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
});

//엑셀다운로드
function doExcelDownload(){
  var url = "${contextPath}/mgr/newsLetterMgr/mailAppListExcelDown";
  document.searchForm.action = url;
  document.searchForm.submit();
}

</script>
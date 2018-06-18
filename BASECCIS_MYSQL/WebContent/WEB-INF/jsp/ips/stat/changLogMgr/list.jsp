<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<spform:form id="searchForm" name="searchForm" method="GET" action="${contextPath }/mgr/changLogMgr">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<input type="hidden" name="inGubun" id="inGubun"  value="">
	
		<fieldset>
			<legend>검색조건</legend>
			<table class="tstyle_view" summary="사이트, 기간 검색">
				<caption>
					검색 조건 / 사이트, 기간 검색
				</caption>
				<colgroup>
					<col width="150" />
					<col />
					<col width="150" />
					<col />
				</colgroup>
				<tr>
					<th scope="row"><label for="siteId">사이트</label></th>
					<td>
						<select name="siteId" id="siteId" title="사이트">
						</select>
					</td>
					<th scope="row"><label for="connectTime">기간</label></th>
				    <td>
				        <input type="text" id="schStartDate" name="schStartDate" title="신청기간 입력" value="${obj.schStartDate }" readonly="readonly"/> ~
				        <input type="text" id="schEndDate" name="schEndDate" title="신청기간 입력" value="${obj.schEndDate }" readonly="readonly"/>
				        <span class="float_right">
							<input type="button" id="btnSearch" class="btn_black" value="검색">
						</span>
				    </td>
			</table>
			<!-- <div class="btn_area_right btn_margin"><input type="button" id="btnSearch" class="btn_black roleREAD" value="검색" /></div> -->
		</fieldset>
	</spform:form>
	
	<c:if test="${empty first}">
	<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/changLogMgr/delete" method="POST">
    <input type="hidden" name="menuId" id="menuId" value="${obj.menuId }" />
    <input type="hidden" name="siteId" value="${obj.siteId }" />
    <input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
    <input type="hidden" name="schStartDate" value="${obj.schStartDate}">
	<input type="hidden" name="schEndDate" value="${obj.schEndDate}">
	<input type="hidden" name="inGubun" id="inGubun"  value="">
	
	<input type="hidden" name="dmlTime" id="dmlTime" value="">
	<input type="hidden" name="dmlUserName" id="dmlUserName" value="">
	<input type="hidden" name="siteName" id="siteName"  value="">
	<input type="hidden" name="namePath" id="namePath"  value="">
	<input type="hidden" name="dmlTypeName" id="dmlTypeName"  value="">
	<input type="hidden" name="dmlIp" id="dmlIp"  value="">
	<input type="hidden" name="beforeData" id="beforeData"  value="">
	<input type="hidden" name="afterData" id="afterData"  value="">
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<br />
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<!-- <button type="button" class="btn_colorType01 roleREAD" id="btnExcel" onclick="javascript:doExcelDownload();">Excel</button> -->
			<%--<button type="button" class="btn_colorType01 roleDELETE" id="btnPeriodDel">선택기간 삭제</button>
            <button type="button" class="btn_colorType01 roleDELETE" id="btnDelete">삭제</button>--%>
            <button type="button" class="btn_colorType01" id="btnExcel" onclick="javascript:doExcelDownload();">Excel</button>
            <button type="button" class="btn_colorType01" id="btnPrint" onclick="javascript:printIt('${contextPath }');">Print</button>
		</div>
	</div>

	<table class="tstyle_list">
		<caption>변경현황관리 목록 / 처리일실, 처리자, 사잍, 메뉴, 기능, 접속 IP에 따른 변경현황관리
			목록</caption>
		<colgroup>
			<col style="width: 50px" />
			<!-- <col style="width: 50px" /> -->
			<col style="width: *" />
			<col style="width: 170px" />
			<col style="width: 210px" />
			<col style="width: 170px" />
			<col style="width: 110px" />
			<col style="width: 170px" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><input id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
				<!-- <th scope="col">번호</th> -->
				<th scope="col">처리일시</th>
				<th scope="col">처리자</th>
				<th scope="col">사이트</th>
				<th scope="col">메뉴</th>
				<th scope="col">기능</th>
				<th scope="col">접속IP</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">

						<tr>
							<td><input type="checkbox" id="chkIds" name="chkIds" class="listCheck" value="${data.NO }" title="선택" /></td>
							<td>
							<a href="javascript:fnLogView('${data.DMLTIME }','${data.DMLUSERNAME }','${data.SITENAME }','${data.NAMEPATH }','${data.DMLTYPENAME }','${data.DMLIP }','${data.BEFOREDATA }','${data.AFTERDATA }');">${data.DMLTIME }</a>
							</td>
							<td>${data.DMLUSERNAME }</td>
							<td>${data.SITENAME }</td>
							<td>${data.MENUNAME }</td>
							<td>${data.DMLTYPENAME }</td>
							<td>${data.DMLIP }</td>
						</tr>

					</c:forEach>
				</c:when>
				<c:otherwise>

					<tr>
						<td colspan="7">조회된 데이터가 없습니다.</td>
					</tr>

				</c:otherwise>

			</c:choose>

		</tbody>
	</table>
	</spform:form>
	<div class="board_pager">
	<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>
	</div>
	</c:if>
</div>
<script type="text/javascript">
$(function() {	
	gfnSiteComboList($("#siteId"), "", "사이트 선택", "${obj.siteId}");
	    
	//달력 세팅
    /* $( "#schStartDate" ).datepicker({
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
    }); */
    
    $( "#schStartDate, #schEndDate" ).datepicker({
	    showOtherMonths:true,
	    selectOtherMonths:true,
	    showButtonPanel: true,
	    changeYear:true,
	    changeMonth:true,
        dateFormat: 'yy-mm-dd',
	    showOn: 'both',
	    buttonImageOnly: true,
		buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif",
		onClose: function( selectedDate ) { 
			$('#schEndDate').datepicker("option","minDate", selectedDate); 
		} 
    });
    
    $('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
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
    	
		$("#searchForm").attr('action', '${ctxMgr }/changLogMgr');
		$('#searchForm').submit();
	});
	
	$('#btnPeriodDel').click(function(){
		$('#allChk').prop("checked", false);
		$(".listCheck").prop("checked", false);
		
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
    	
    	if(confirm("삭제하시겠습니까?")) {
    		document.searchForm.inGubun.value = "ALL";
    		$("#searchForm").attr('action', '${ctxMgr }/changLogMgr/delete');
    		$('#searchForm').submit();
		}

	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {
	
		$nCnt = $("input:checkbox[name=chkIds]:checked").length;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				
				document.listForm.inGubun.value = "PER";
				$("#listForm").attr('action', '${ctxMgr }/changLogMgr/delete');
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}
	
		return false;
	});
});

//상세보기
function fnLogView(dmlTime, dmlUserName, siteName, namePath, dmlTypeName, dmlIp, beforeData, afterData){
	$("#dmlTime").val(dmlTime);
	$("#dmlUserName").val(dmlUserName);
	$("#siteName").val(siteName);
	$("#namePath").val(namePath);
	$("#dmlTypeName").val(dmlTypeName);
	$("#dmlIp").val(dmlIp);
	$("#beforeData").val(beforeData);
	$("#afterData").val(afterData);
	
	$("#listForm").attr('action', '${ctxMgr }/changLogMgr/form');
	$("#listForm").submit();
}

//엑셀다운로드
function doExcelDownload(){
    var url = "${contextPath}/mgr/changLogMgr/ExcelDown";
    document.searchForm.action = url;
    document.searchForm.submit();
}
</script>

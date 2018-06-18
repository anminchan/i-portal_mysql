<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="sform" name="sform" action="${ctxMgr }/groupMgr" method="GET" class="search_form">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId }" />
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="groupType">그룹유형</label>
				<select name="groupType" id="groupType"></select>			
				<label for="searchType">검색구분</label>
				<select name="searchType" id="searchType" title="검색구분">
					<option value="0">전체</option>
					<option value="1">그룹명</option>
					<option value="2">그룹ID</option>
				</select>
				<input type="text" name="searchText" id="searchText" class="input_mid" value="${param.searchText}" title="검색어"/>
			</div>
			<span class="display_block txt_center"><input type="submit" id="btnSearch" class="btn btn_type02" value="검색"></span>
		</div>
	</fieldset>
</spform:form>

<spform:form id="listForm" name="listForm" action="${ctxMgr }/groupMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId }" />
	<div class="float_wrap">		
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="float_right">	    
		    <button type="button" id="btnPrint" class="btn btn_basic"><i class="xi-print"></i> Print</button>
		    <button type="button" id="btnExcel" class="btn btn_basic"><i class="xi-file-text-o"></i> Excel</button>
			<button type="button" id="btnAdd" class="btn btn_basic">추가</button>
		    <button type="button" id="btnDel" class="btn btn_basic">삭제</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
			 그룹관리 목록 - 번호, 그룹유형, 사이트, 그룹ID, 그룹명, 회원수
			</caption>
			<colgroup>
				<col class="allChk"/>
				<col class="num"/>
				<col class="category" span="3"/>
				<col class="num"/>
			</colgroup>
			<thead>
				<tr>				
					<th scope="col"><input id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">그룹유형</th>
					<th scope="col">그룹ID</th>
					<th scope="col">그룹명</th>
					<th scope="col">회원수</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr>					
							<td><input type="checkbox" id="chkGroupIds" name="chkGroupIds" class="listCheck" title="선택" value="${data.GROUPID}|${data.CNT}"/></td>
							<td>${data.RNUM2}</td>
							<td>${data.GROUPTYPE_NAME}</td>
							<td>${data.GROUPID }</td>
							<td><a href="${ctxMgr }/groupMgr/form?groupId=${data.GROUPID }&${link}&pageNum=${obj.pageNum}">${data.KNAME }</a></td>
							<td>${data.CNT}</td>				
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
</spform:form>
<div class="board_pager">
	<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>
</div>

<script type="text/javascript">
//$(document).ready(function() {
$(function() {
	$('#btnSearch').click(function(){
		$('#sform').submit();
	});
	
	gfnCodeComboList($("#groupType"), "GroupType", "", "전체", "${param.groupType}");
	
	if("${param.searchType}" == '1' || "${param.searchType}" == '2') {
		$('#searchType').val("${param.searchType}");	
	}
		
	$('#groupType').val("${param.groupType}");
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr}/groupMgr/form?${link}";
	});
		
	$("#btnDel").click(function() {
		//선택 개수 체크	
		var chkCnt = $("input[name='chkGroupIds']:checked").length;	
		if( chkCnt > 0 ){
		
			var dataForm = "";
			var chkMemberCnt = "";

			if(!confirm("선택된 그룹을 삭제하시겠습니까?")) {
				return false;
			}
			
			$("input[name='chkGroupIds']:checked").each(function () {
				dataForm = $(this).val().split("|");
				if (dataForm[1] != 0){
					chkMemberCnt++;					
				}
			});
			if (chkMemberCnt != 0) {
				alert("회원이 등록된 그룹은 삭제가 되지않습니다.\n회원 삭제후 실행하시기 바랍니다.");				
			} else {							
				$("#listForm").submit();			
			}
			
		}else{
			alert('삭제 할 그룹을 선택하세요.');
		}

		return false;
	});	
	
	$('#allChk').click(function(){
		var tbl = $(".tstyle_list");
		
		if($(this).is(":checked")) $(":checkbox", tbl).prop("checked", true);
        else $(":checkbox", tbl).prop("checked", false);
	});	
	
	//엑셀다운로드
	$("#btnExcel").click(function(){
	    var url = "${contextPath}/mgr/groupMgr/ExcelDown";
	    document.sform.action = url;
	    document.sform.submit();
	});
	
	// 인쇄
	$('#btnPrint').click(function(){
		printIt("${contextPath}");
	});
	
});

</script>

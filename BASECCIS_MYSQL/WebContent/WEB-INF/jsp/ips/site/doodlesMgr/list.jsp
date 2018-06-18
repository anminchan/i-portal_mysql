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
				<div class="row">
					<label>사용여부</label>
					<select name="schState" id="schState">
						<option value="all">전체</option>
						<option value="T" <c:if test="${param.schState == 'T' }">selected</c:if> >사용</option>
						<option value="F" <c:if test="${param.schState == 'F' }">selected</c:if> >미사용</option>
						<option value="N" <c:if test="${param.schState == 'N' }">selected</c:if> >기간만료</option>
					</select>
				</div>
				<span class="display_block txt_center">
					<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
				</span>
			</div>
		</fieldset>
	</form>
	
	<form id="listForm" name="listForm" action="${ctxMgr }/doodlesMgr/delete" method="POST">
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
				두들관리 목록
			</caption>		
			<colgroup>
				<col width="60" span="2" />
				<col width="300" />
				<col width="150" />
				<col />
				<col width="150" span="2"/>
				<col width="80" span="2" />
			</colgroup>		
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">순번</th>
					<th scope="col">사이트명</th>
					<th scope="col">이미지</th>
					<th scope="col">제목</th>
					<th scope="col">게시시작일</th>
					<th scope="col">게시종료일</th>
					<th scope="col">순서</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
	
					<tr>
						<td><input type="checkbox" id="chkDoodlesIds" name="chkDoodlesIds" class="listCheck" value="${data.doodlesId }" title="선택" /></td>
						<td>${data.no1 }</td>
						<td>${data.site_Name }</td>
						<td><a href="${ctxMgr }/doodlesMgr/form?pageNum=${ obj.pageNum }&doodlesId=${data.doodlesId }${link}">
								<img alt="${data.imageFileName }" src="${contextPath}/fileDownload?fileGubun=common&menuId=doodlesMgr&userFileName=${data.imageFileName }&systemFileName=${data.imageSFileName }" style="width:80px; " />
							</a>
						</td>
						<td class="txt_left"><a href="${ctxMgr }/doodlesMgr/form?pageNum=${ obj.pageNum }&doodlesId=${data.doodlesId }${link}">${data.KName }</a></td>
						<td>
						<fmt:parseDate value="${data.startTime }" pattern="yyyy-MM-dd HH" var="startTime"/>
						<fmt:formatDate value="${startTime }" pattern="yyyy-MM-dd HH"/>
						</td>
						<td>
						<fmt:parseDate value="${data.endTime }" pattern="yyyy-MM-dd HH" var="endTime"/>
						<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd HH"/>
						</td>
						<td>${data.sort }</td>
						<td>
							<c:if test="${data.state == 'T'}"><img src="/resources/images/ips/bbs/img_yes.gif" alt="예" /></c:if>
	                		<c:if test="${data.state == 'F'}"><img src="/resources/images/ips/bbs/img_no.gif" alt="아니오" /></c:if>
	               			<c:if test="${data.state == 'N'}">기간만료</c:if>
						</td>
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
		$("#searchForm").attr('action', '${ctxMgr }/doodlesMgr');
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	$('#btnExcel').click(function(){
		$("#searchForm").attr('action', '${ctxMgr }/doodlesMgr/excelDown');
		$('#searchForm').submit();
	});
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/doodlesMgr/form?${link}&pageNum=${ obj.pageNum }";
	});
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnDelete").on("click", function() {

		$nCnt = $("input:checkbox[name=chkDoodlesIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/doodlesMgr/delete');
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

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<form id="searchForm" name="searchForm" method="get">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="boardStyle" value="Gallery">

		<fieldset>
			<legend>검색조건</legend>
			<div class="table">
				<table class="tstyle_view">
					<caption>
						사이트, 제목검색
					</caption>
					<colgroup>
		                <col class="col-sm-2"/>
						<col class="col-sm-10"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label>검색조건</label></th>
							<td>
								<select name="schType" id="schType" title="검색구분">
									<option value="0" ${obj.schType == '0' ? 'selected="selected"' : ''}>전체</option>
									<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
									<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>키워드</option>
								</select>
								<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력" class="input_long02" <%-- class="${(rtnSetting.countryYN == 'N' && rtnSetting.categoryYN == 'N') ? 'input_long02': 'input_mid03' }" --%>/>
								<span class="float_right">
									<input type="button" id="btnSearch" class="btn_black" value="검색">
								</span>											
							</td>	
						</tr>
					</tbody>
				</table>
			</div>
			<!-- <div class="btn_area_right btn_margin"><input type="button" id="btnSearch" class="btn_black roleREAD" value="검색" /></div> -->
		</fieldset>
	</form>
	
	
	<form id="listForm" name="listForm" action="${ctxMgr }/imagePoolMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="schSiteId" value="${param.schSiteId}">
	<input type="hidden" name="schType" value="${param.schType}">
	<input type="hidden" name="schText" value="${param.schText}">
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<br />
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<button type="button" class="btn_colorType01 roleWRITE" id="btnAdd">등록</button>
		</div>
	</div>
	
	<ul class="photo_list album_type">
		<c:choose>          
			<c:when test="${!empty result && fn:length(result) > 0 }">
				<c:forEach items="${result }" var="data" varStatus="loop">
					<c:set var="url" value="${ctxMgr }/imagePoolMgr/form?pageNum=${ obj.pageNum }&imagePoolId=${data.imagePoolId }${link}"/>
					<li>
						<a href="${url }" class="thumb">
						<c:if test="${!empty data.imageFileName }">
							<img alt="${data.KName }" src="${contextPath}/fileDownload?fileGubun=common&menuId=imagePoolMgr&userFileName=${data.imageFileName }&systemFileName=${data.imageSFileName }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'"/>
						</c:if>
						<c:if test="${empty data.imageFileName }">
							<img src="${contextPath}/resources/images/ips/bbs/noimage.gif" alt="${data.KName }"/>
						</c:if>
						</a>
						<strong><a href="${url }">${data.KName }</a></strong>
						<a href="${url }" class="desc"><text:splitText value="${data.KDesc}" tail="..." textSize="55" /></a>
					</li>
				 </c:forEach>
			</c:when>
			<c:otherwise>
				<li style="height: 20px;">조회된 데이터가 없습니다.</li>
			</c:otherwise>
		</c:choose>
	</ul>

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
		$("#schSiteId").val($("#siteIdSel").val());
		$("#searchForm").attr('action', '${ctxMgr }/imagePoolMgr');
		$('#searchForm').submit();
	}); 
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/imagePoolMgr/form?${link}&pageNum=${ obj.pageNum }";
	});
	
	
});
</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
<spform:form id="searchForm" name="searchForm" method="get">
<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
<input type="hidden" name="schSiteId" id="schSiteId" value="${param.schSiteId}">
<input type="hidden" name="boardStyle" value="Gallery">
<div class="articles_search">
	<div class="search_form">
		<label for="" class="txt_bold">키워드명</label>
		<select name="schType" id="schType" title="검색구분">
			<option value="0" ${obj.schType == '0' ? 'selected="selected"' : ''}>전체</option>
			<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
			<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>키워드</option>
		</select>
		<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력" class="input_long02" <%-- class="${(rtnSetting.countryYN == 'N' && rtnSetting.categoryYN == 'N') ? 'input_long02': 'input_mid03' }" --%>/>
		<input type="button" id="btnSearch" class="btn_black" value="검색">
	</div>
</div>
</spform:form>
<br/>
<br/>
	
<spform:form id="listForm" name="listForm" method="POST" action="${ctxMgr }/imagePoolMgr/delete">
<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
<input type="hidden" name="schSiteId" value="${param.schSiteId}">
<input type="hidden" name="schKName" value="${param.schKName}">

<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
<ul class="photo_list imgPool_type">
	<c:choose>          
		<c:when test="${!empty result && fn:length(result) > 0 }">
			<c:forEach items="${result }" var="data" varStatus="loop">
				<li>
					<a href="javascript:selectSubmit('${data.imageFileName}|${data.imageSFileName}|${data.filePath}');" class="thumb">
					<c:if test="${!empty data.imageFileName }">
						<img alt="${data.KName }" src="${contextPath}/fileDownload?fileGubun=common&menuId=imagePoolMgr&userFileName=${data.imageFileName }&systemFileName=${data.imageSFileName }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'"/>
					</c:if>
					<c:if test="${empty data.imageFileName }">
						<img src="${contextPath}/resources/images/ips/bbs/noimage.gif" alt="${data.KName }"/>
					</c:if>
					</a>
				</li>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<li style="height: 20px;">조회된 데이터가 없습니다.</li>
		</c:otherwise>
	</c:choose>
</ul>

</spform:form>

<c:if test="${!empty result && fn:length(result) > 0 }">	
	<div class="board_pager">
		<paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }">
	           <Previous><AllPageLink><Next>
	       </paging:PageFooter>
	</div>
</c:if>
</div>

<script type="text/javascript">
function selectSubmit(data){
    //kind|kind_Name|userId|KName|joinDate
	var inData = data;
	var pOutDataForm = "${pOutDataForm}"; // 전달받을 데이터 형태 파라메타
	var pParentInputId = "${pParentInputId}"; // 전달받을 데이터 갯수타입 파라메타
	
    var sDataForm = "";
    var outputImage = new Array();

   	outputImage.push(inData);

   	$(opener).find('#data').val(outputImage);
    
    if(pParentInputId == ""){
		// 호출한 부모에 값전달
		$(opener.location).attr("href", "javascript:setImageList('"+outputImage+"');");
	}else{
		// 호출한 부모에 값전달
		$(opener.location).attr("href", "javascript:setImageList('"+outputImage+"','"+pParentInputId+"');");
	}
    
	self.close();
}
$(function() {
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#schSiteId").val($("#siteIdSel").val());
		$("#searchForm").attr('action', '${ctxMgr }/listImagePoolPopup');
		$('#searchForm').submit();
	}); 
	
});

</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>

    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
    <input type="hidden" name="boardStyle" value="Gallery02">
	<div class="multi_searchForm single_search">
		<c:if test="${rtnSetting.categoryYN == 'Y' }">
		<select name="categoryId" id="categoryId" title="카테고리">
			<option value="0">Category</option>
		</select>
		</c:if>
		<i class="fa"></i>
		<select name="schType" id="schType" title="Search Type">
			<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>Title</option>
			<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>Writer</option>
			<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>Content</option>
		</select>
		<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력" class="${(rtnSetting.countryYN == 'N' && rtnSetting.categoryYN == 'N') ? 'input_mid': 'input_mid02' }" />
		<input type="button" value="Search" class="input_smallBlack" id="btnSearch" />
	</div>
    </spform:form>
    
	<!-- //검색 결과 -->
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<div class="articles_search">
		<p class="articles">All pages <span class="point03"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/></span>, This Page <span class="total">${obj.pageNum }</span> / <fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/></p>	
		<div class="photo_type">
			<button type="button" id="btnTextStyle" class="list${obj.boardStyle == 'Text02' ? '_on' : '' }">List</button> 
			<button type="button" id="btnImageStyle" class="multi${obj.boardStyle == 'Image02' ? '_on' : '' }">Thumbnail List</button> 
			<button type="button" id="btnGalleryStyle" class="album${obj.boardStyle == 'Gallery02' ? '_on' : '' }">Photo LIst</button>
		</div>
	</div>
	<ul class="photo_list thesis_type">
		<c:choose>
			<c:when test="${!empty (result) && fn:length(result) > 0 }">
				<c:forEach items="${result }" var="data" varStatus="loop">
					<c:set var="url" value="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}"/>
					<c:if test="${!empty data.IMAGEFILENAME }">
						<li>
							<a href="${url }" class="thumb">
								<img alt="${data.KNAME }" src="${contextPath}/fileDownload?titleId=${data.TITLEID }" onerror="this.src='${contextPath}/resources/images/common/content/noimg02.gif'"/>
							</a>
							<span class="date"><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></span>
							<c:if test="${data.CONTENTS2 ne '-'}">
								<a href="${data.CONTENTS2 }" class="golink">바로가기</a>
							</c:if>
						</li>
					</c:if>
					<c:if test="${empty data.IMAGEFILENAME }">
						<li>
							<a href="${url }" class="txt">
								<p class="cover_txt"><text:splitText value="${data.KNAME }" tail="..." textSize="65" /></p>
								<span class="name"><text:splitText value="${data.CONTENTS1 }" tail="..." textSize="20"/></span>
							</a>
							<span class="date"><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></span>
							<c:if test="${data.CONTENTS2 ne '-'}">
								<a href="${data.CONTENTS2 }" class="golink">바로가기</a>
							</c:if>
						</li>							
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<span>No Data.</span>
			</c:otherwise>
		</c:choose>	
	</ul>
    
	<div class="btn_area_right">	
		<c:if test="${ADMIN eq 'T' or WRITE eq 'T'}"><%//관리권한, 쓰기권한%>
		<button type="button" class="btn_type01" id="btnAdd">Add</button>
		</c:if>
	</div>
    
    <c:if test="${!empty result && fn:length(result) > 0 }">
    <div class="board_pager">
        <paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }" siteGubun="U">
            <Previous><AllPageLink><Next>
        </paging:PageFooter>
    </div>
	</c:if>
	
<%@ include file="/includes/bbsContentsFooter.jsp" %>

<script type="text/javascript">
$(function() {
    //텍스트 스타일
    $('#btnTextStyle').click(function(){
    	<c:if test="${rtnSetting.categoryTabYN == 'Y' }">
    		document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Text02&categoryId="+$("#categoryId").val();
    	</c:if>
    	<c:if test="${rtnSetting.categoryTabYN != 'Y' }">
        	document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Text02";
		</c:if>    	
    });
    //텍스트 + 이미지 스타일
    $('#btnImageStyle').click(function(){
    	<c:if test="${rtnSetting.categoryTabYN == 'Y' }">
    	document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Image02&categoryId="+$("#categoryId").val();
		</c:if>
		<c:if test="${rtnSetting.categoryTabYN != 'Y' }">
			document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Image02";
		</c:if>    	
    });
    // 갤러리 스타일
    $('#btnGalleryStyle').click(function(){
    	<c:if test="${rtnSetting.categoryTabYN == 'Y' }">
    	document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Gallery02&categoryId="+$("#categoryId").val();
		</c:if>
		<c:if test="${rtnSetting.categoryTabYN != 'Y' }">
			document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Gallery02";
		</c:if>    	
    });
    
    gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리 선택', '${param.categoryId}');

    gfnCateTabList($('#categoryTab'), '${obj.menuId}', '', '전체', '${param.categoryId}');
    
    gfnCodeComboList($("#continent"), "country", "", "대륙 선택", "${param.continent}", ""); // 새창여부 코드조회
	$('#continent').on("change", function() { // 새창여부 이벤트
		if($("#continent").val() != ""){
			gfnCodeComboList($("#country"), $("#continent").val(), "", "국가 선택", "", ""); // 새창여부 코드조회
		}else{
			$("#country").find('option').remove();
			$("#country").append("<option value=''>국가 선택</option>");
		}
	});
    
    <c:if test="${!empty param.continent}">
	    gfnCodeComboList($("#country"), "${param.continent}", "", "국가 선택", "${!empty param.country ? param.country : ''}", ""); // 새창여부 코드조회
    </c:if>
	
    $('#btnSearch').click(function(){
        $('#searchForm').submit();
    }); 
    
    //등록
    $('#btnAdd').click(function(){
        document.location.href="${contextPath}/board/form?menuId=${obj.menuId}";
    });
    
});

function goList(area) {
	$("#categoryId").val(area);
    $('#searchForm').submit();
}

</script>

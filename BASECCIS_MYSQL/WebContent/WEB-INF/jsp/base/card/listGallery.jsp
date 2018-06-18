<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>
		
<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
<div class="articles_search">
	<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/></p>	
	<div class="basic_searchForm">
		<spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
		    <input type="hidden" name="menuId" value="${obj.menuId}">
		    <input type="hidden" name="boardStyle" value="Gallery">
			<select name="schType" id="schType" title="검색구분">
				<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
				<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
				<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>작성자</option>
			</select>
			<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력"  />
			<input type="button" value="검색" class="input_smallBlack" id="btnSearch" />			
		</spform:form>
	</div>
</div>
<ul class="photo_list card_type">
	<c:choose>          
		<c:when test="${!empty result && fn:length(result) > 0 }">
			<c:forEach items="${result }" var="data" varStatus="loop">
				<c:set var="url" value="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}"/>
				<li>
				<a href="${url }" class="thumb">
				<c:if test="${!empty data.IMAGEFILENAME }">
					<img alt="${data.KNAME }" src="${contextPath}/fileDownload?titleId=${data.TITLEID }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'"/>
				</c:if>
				<c:if test="${empty data.IMAGEFILENAME }">
					<img src="${contextPath}/resources/images/ips/bbs/noimage.gif" alt="${data.KNAME }"/>
				</c:if>
				</a>
				<c:if test="${rtnSetting.newYN eq 'Y'}">
					<c:if test="${data.NEWCHECK eq 'Y'}">
						<img src="${contextPath}/resources/images/common/icon/img_new.gif" alt="답글"/>
					</c:if>
                   </c:if><strong><a href="${url }">${data.KNAME }</a></strong>
				<a href="${url }" class="desc"><text:splitText value="${data.KHTML }" tail="..." textSize="55" /></a>
			 </c:forEach>
		</c:when>
		<c:otherwise>
			<li style="height: 20px;">조회된 데이터가 없습니다.</li>
		</c:otherwise>
	</c:choose>
</ul>
   
<div class="btn_area_right">	
	<c:if test="${ADMIN eq 'T' or WRITE eq 'T'}"><%//관리권한, 쓰기권한%>
	<button type="button" class="btn_colorType01" id="btnAdd">등록</button>
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
	
	$("#schText").css("ime-mode", "active"); // input 한글우선입력
	
    //텍스트 스타일
    $('#btnTextStyle').click(function(){
        document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Text";
    });
    
    //텍스트 + 이미지 스타일
    $('#btnImageStyle').click(function(){
        document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Image";
    });
    
    // 갤러리 스타일
    $('#btnGalleryStyle').click(function(){
        document.location.href="${contextPath}/board?menuId=${obj.menuId}&boardStyle=Gallery";
    });
    
    gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '전체', '${param.categoryId}');

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

</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>
                   
    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
    <input type="hidden" name="boardStyle" value="Image">
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
		<p class="articles">All Pages <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/></span>, This Page <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/></p>	
		<div class="photo_type">
			<button type="button" id="btnTextStyle" class="list${obj.boardStyle == 'Text' ? '_on' : '' }">List</button> 
			<button type="button" id="btnImageStyle" class="multi${obj.boardStyle == 'Image' ? '_on' : '' }">Thumbnail List</button> 
			<button type="button" id="btnGalleryStyle" class="album${obj.boardStyle == 'Gallery' ? '_on' : '' }">Photo List</button>
		</div>
	</div>
	
	<ul class="photo_list thumb_type">
		<c:choose>          
			<c:when test="${!empty result && fn:length(result) > 0 }">
				<c:forEach items="${result }" var="data" varStatus="loop">
					<c:set var="url" value="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}"/>
					<li><a href="${url }" class="thumb">
							<c:if test="${!empty data.IMAGEFILENAME }">
							<img alt="${data.KNAME }'/>" src="${contextPath}/fileDownload?titleId=${data.TITLEID }" onerror="this.src='${contextPath}/resources/images/common/content/noimg.gif'"/>
							</c:if>
							<c:if test="${empty data.IMAGEFILENAME }">
								<img src="${contextPath}/resources/images/common/content/noimg.gif" alt="${data.KNAME }"/>
							</c:if>
						</a>
						<div class="headline">
							<a href="${url }">
								<strong>${data.KNAME }</strong>
								<span class="desc"><text:splitText value="${data.KHTML }" tail="..." textSize="95" /></span>
							</a>
							<span class="date"><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></span>
						</div>
					</li>
				 </c:forEach>
			</c:when>
			<c:otherwise>
				<li>No Data.</li>
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
    
    gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리 선택', '${param.categoryId}');

    $('#btnSearch').click(function(){
        $('#searchForm').submit();
    }); 
    
    //등록
    $('#btnAdd').click(function(){
        document.location.href="${contextPath}/board/form?menuId=${obj.menuId}";
    });
    
    //첨부파일 보기
    $('.viewFiles').click(function(){
		
    	//첨부파일 펄쳐져 있을경우 닫기
		if($(this).parent().children(".attach_file").length > 0){
			$('.attach_file').remove();
		}else{
			$('.attach_file').remove();
	    	
	    	var linkId = $(this).attr("linkId");
	    	var menuId = "${obj.menuId}";
	    	var str = "";	
	    	var strFileName = "";
	        $.ajax({
	            url: gContextPath+"/board/fileListJson",
	            async:false,
	            data: {linkId : linkId, menuId : menuId },
	            success:function(data, textStatus, jqXHR) {
	                if(data != null) {

	             		str = str + "<dl class='attach_file'>";
	            		str = str + "	<dt>첨부파일</dt>";
	            		str = str + "	<dd>";
	            		str = str + "		<ul>";
	            		
	                    $.each(data, function(i, item) {
	                    	strFileName = item.USERFILENAME;
	                    	if(strFileName.indexOf(".") > 0){
		            			var ext_pos = strFileName.lastIndexOf(".");
		            			if(ext_pos > 13){
		            				strFileName = strFileName.substring(0, 13) + "~." + item.FILEEXTENSION;
		            			}
	                    	}
	                    	str = str + "			<li><a href="+gContextPath+"'/fileDownload?titleId="+item.TITLEID+"&fileId="+item.FILEID+"' title='"+item.USERFILENAME+"'><img src='/resources/images/common/icon/"+item.FILEEXTENSION+".png' alt='"+item.FILEEXTENSION+" 파일'/>"+strFileName+"<span>내려받기</span></a></li>";
	                    });
	                    
	            		str = str + "		</ul>";
	            		str = str + "	</dd>";
	            		str = str + "</dl>";
	                }
	            }
	        });  
	        $(this).after(str);

		}
    });
    
});
</script>

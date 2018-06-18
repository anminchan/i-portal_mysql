<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>

    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
    
	<div class="articles_search">
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/></p>
		<div class="basic_searchForm">
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
			<select name="categoryId" id="categoryId" title="카테고리">
				<option value="0">카테고리</option>
			</select>
			 </c:if>
			<select name="schType" id="schType" title="검색구분">
				<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>Title</option>
				<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>Writer</option>
				<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>Content</option>
			</select>
			<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력"/>
			<input type="button" value="검색" class="input_smallBlack" id="btnSearch" />
		</div>
	</div>		
    </spform:form>
	
	<c:if test="${rtnSetting.boardKind ne 'LINK' }"><%//공지, 자유형게시판%>
	<c:forEach items="${rtnUserMenu }" var="userMenu">
		<c:if test="${userMenu.MENUID == obj.menuId }">
			<c:set var="parentMenuId" value="${userMenu.PARENTMENUID }" />
        	<c:set var="parentMenuName" value="${userMenu.PARENTMENUNAME }" />
			<c:set var="higherId" value="${userMenu.HIGHERID }" />
			<c:set var="idPath" value="${userMenu.IDPATH}" />
		</c:if>
	</c:forEach>
	<!-- //검색 결과 -->
	<table class="tstyle_list">
		<caption>
			번호, 제목, 작성자, 등록일, 조회수, 첨부에 따른 게시글 목록
		</caption>
		<colgroup>
			<col width="70" />
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
			<col width="150" />
			</c:if>
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">NO</th>
            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
            	<th scope="col">Category</th>
            	</c:if>
				<th scope="col">Title</th>
			</tr>
		</thead>
		<tbody>

        <c:choose>          
            <c:when test="${!empty result && fn:length(result) > 0 }">
                <c:forEach items="${result }" var="data" varStatus="loop">
            <tr>
                <td>
                	<c:if test="${data.NUM1 > 9000000000}">
                		<span class="btn_redSmall">Announcement</span>
                	</c:if>
                	<c:if test="${data.NUM1 < 9000000000}">
                		${data.NUM1}
                	</c:if>
                </td>
            <c:if test="${rtnSetting.categoryYN == 'Y' }">
                <td class="ellipsis" title="${data.CATEGORYNAME}">${data.CATEGORYNAME }</td>
            </c:if>
                <td class="ellipsis">
                   <c:if test="${data.DEPTH > 1 }">
                   <img src="${contextPath}/resources/images/common/icon/icon_replay.gif" alt="답글"/>
                   </c:if>
                   <c:if test="${data.SECRETTITLEYN  == 'Y'}"><img src="/resources/images/common/icon/icon_secret.gif" alt="비밀글" /></c:if>
                   <a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}" title="${data.KNAME}">
						<c:out value="${data.KNAME}"/>
                   </a>
                   <c:if test="${rtnSetting.secretYN  == 'Y'}">
                   </c:if>
                </td>
            </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
            <tr>
                <td colspan="${rtnSetting.categoryYN == 'Y' ? 3 : 2}">No Data.</td>
            </tr>
            </c:otherwise>
        </c:choose>
		</tbody>
	</table>
    </c:if>

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
	    	var strFileExt = "";
	        $.ajax({
	            url: gContextPath+"/board/fileListJson",
	            async:false,
	            data: {linkId : linkId, menuId : menuId },
	            success:function(data, textStatus, jqXHR) {
	                if(data != null) {

	             		str = str + "<div class='attach_file download_list'>";
	             		str = str + "	<dl>";
	            		str = str + "		<dt>AttachFile</dt>";
	            		str = str + "		<dd>";
	            		str = str + "			<ul>";
	            		
	                    $.each(data, function(i, item) {
	                    	strFileName = item.USERFILENAME;
	                    	
	                    	strFileExt = item.FILEEXTENSION;
	                    	
	                    	str = str + "				<li><a href="+gContextPath+"'/fileDownload?titleId="+item.TITLEID+"&fileId="+item.FILEID+"' >";
	                    	
	                    	if( strFileExt == 'pdf' || strFileExt == 'PDF'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_pdf.gif' alt='PDF파일'/>";
	                    	}else if(strFileExt == 'doc' || strFileExt == 'docx' || strFileExt == 'DOC' || strFileExt == 'DOCX'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_doc.gif' alt='DOC파일'/>";
	                    	}else if(strFileExt == 'ppt' || strFileExt == 'pptx' || strFileExt == 'PPT' || strFileExt == 'PPTX'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_ppt.gif' alt='PPT파일'/>";
	                    	}else if(strFileExt == 'xls' || strFileExt == 'xlsx' || strFileExt == 'XLS' || strFileExt == 'XLSX'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_xls.gif' alt='XLS파일'/>";
	                    	}else if(strFileExt == 'hwp' || strFileExt == 'HWP'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_hwp.gif' alt='HWP파일'/>";
	                    	}else if(strFileExt == 'txt' || strFileExt == 'TXT'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_txt.gif' alt='TXT파일'/>";
	                    	}else if(strFileExt == 'zip' || strFileExt == 'ZIP'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_zip.gif' alt='ZIP파일'/>";
	                    	}else if(strFileExt == 'jpg' || strFileExt == 'JPG' || strFileExt == 'jpeg' || strFileExt == 'JPEG' || strFileExt == 'gif' || strFileExt == 'GIF' || strFileExt == 'png' || strFileExt == 'PNG' || strFileExt == 'bmp' || strFileExt == 'BMP'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_img.gif' alt='IMG파일'/>";
	                    	}
	                    	
	                    	str = str + strFileName+"<span>내려받기</span></a></li>";
	                    });
	                    
	            		str = str + "			</ul>";
	            		str = str + "		</dd>";
	            		str = str + "	</dl>";
	            		str = str + "	<p class='file_close'><button type='button'>Close</button></p>";
	            		str = str + "</div>";
	                }
	            }
	        });  
	        $(this).after(str);
		}
    });

    //첨부파일 닫기
	$(document).on('click', '.file_close', function(){
		$(this).parent().parent().children(".viewFiles").focus();
		$(".attach_file").remove();
	});
    
});
</script>

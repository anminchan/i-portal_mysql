<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>

    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
	
	<div class="articles_search">
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">All <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/></span>, This Page <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/></p>
		<div class="basic_searchForm">
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
			<select name="categoryId" id="categoryId" title="카테고리">
				<option value="0">Category</option>
			</select>
			 </c:if>
			<select name="schType" id="schType" title="SearchType">
				<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>Title</option>
				<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>Writer</option>
				<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>Content</option>
			</select>
			<input type="text" name="schText" id="schText" value="${obj.schText }" title="InputSearchKeyWord"/>
			<input type="button" value="Search" class="input_smallBlack" id="btnSearch" />
		</div>
	</div>		
    </spform:form>
	<div class="table">
	<c:if test="${rtnSetting.boardKind ne 'LINK' }"><%//Announcement%>
	<!-- //Result Search -->
		<table class="tstyle_list">
			<caption>
				No., <c:if test="${rtnSetting.categoryYN == 'Y' }">Category,</c:if>, Title, Writer, Date, Views, Attached File
			</caption>
			<colgroup>
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
				<col width="7%" />
				<col width="15%" />
				<col width="30%" />
				<col width="15%" />
				<col width="13%" />
				<col width="10%" />
				<col width="10%" />
			</c:if>
			<c:if test="${rtnSetting.categoryYN != 'Y' }">
				<col width="7%" />
				<col width="45%" />
				<col width="15%" />
				<col width="13%" />
				<col width="10%" />
				<col width="10%" />
			</c:if>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">No.</th>
	            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
	            	<th scope="col">Category</th>
	            	</c:if>
					<th scope="col">Title</th>
					<th scope="col">Writer</th>
					<th scope="col">Date</th>
					<th scope="col">Views</th>
					<th scope="col">Attached<br/> File</th>
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
	                <td>${data.CATEGORYNAME }</td>
	            </c:if>
	                <td class="ellipsis">
	                   <c:if test="${data.DEPTH > 1 }">
	                   <img src="${contextPath}/resources/images/common/icon/icon_replay.gif" alt="reply"/>
	                   </c:if>
	                   <a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}" ><text:splitText value="${data.KNAME}" tail="..." textSize="${titleSize }" /></a>
	                </td>
	                <td><c:out value="${data.USERNAME }" /></td>
	                <td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
	                <td><fmt:formatNumber value='${data.HITCOUNT }' pattern='#,###'/></td>
	                <td class="file">
	                    <c:if test="${data.FILEYN == 'Y'}">
	                    <a href="#" onClick="return false;" class="viewFiles" linkId="${data.LINKID}"><img src="${contextPath}/resources/images/common/bbs/icon_file.png" alt="Attached File"/></a>
	                    </c:if>
	                    <c:if test="${data.FILEYN != 'Y'}">
			            	&nbsp;
			            </c:if>
	                </td>
	            </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	            <tr>
	                <td colspan="${rtnSetting.categoryYN == 'Y' ? 6 : 7}">No Data.</td>
	            </tr>
	            </c:otherwise>
	        </c:choose>
			</tbody>
		</table>
	    </c:if>
	
		<c:if test="${rtnSetting.boardKind eq 'LINK' }"><%//링크형게시판%>
		<table class="tstyle_list">
			<caption>
				No., Category, Title, Writer
			</caption>
			<thead>
				<tr>
					<th scope="col" class="num">No.</th>
	            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
	            	<th scope="col" style="width:70px;">Category</th>
	            	</c:if>
					<th scope="col">Title</th>
					<th scope="col" class="num">Link to a new window</th>
					<th scope="col" class="date">Writer</th>
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
	                <td>${data.CATEGORYNAME }</td>
	            </c:if>
	                <td class="ellipsis">
	                   <a href="${data.LINKURL }" ><text:splitText value="${data.KNAME}" tail="..." textSize="${titleSize }" /></a>
	                </td>
	                <td><a href="${data.LINKURL }" title="Link to a new window" target="_blank"><img src="/resources/images/common/bbs/btn_url.gif" alt="url Link to a new window"/></a></td></td>
	                <td><c:out value="${data.USERNAME }" /></td>
	            </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	            <tr>
	                <td colspan="${rtnSetting.categoryYN == 'Y' ? 4 : 5}">No Data.</td>
	            </tr>
	            </c:otherwise>
	        </c:choose>
			</tbody>
		</table>
	    </c:if>	
	</div>
	
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
    
    gfnCateComboList($('#categoryId'), '${obj.menuId}', '', 'Select Category', '${param.categoryId}');

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

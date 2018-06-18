<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>
                   
    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
    <input type="hidden" name="boardStyle" value="Text">
	<div class="multi_searchForm single_search">
		<c:if test="${rtnSetting.categoryYN == 'Y' }">
		<select name="categoryId" id="categoryId" title="카테고리">
			<option value="0">Category</option>
		</select>
		 </c:if>
		 
		<select name="schType" id="schType" title="Search Type">
			<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>Title</option>
			<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>Writer</option>
			<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>Content</option>
		</select>
		<input type="text" name="schText" id="schText" value="${obj.schText }" title="Input Search KeyWord"/>
		
		<input type="button" value="Search" class="input_smallBlack" id="btnSearch" />
	</div>
    </spform:form>

    <spform:form id="listForm" name="listForm" action="${contextPath }/mgr/contentMgr/actNoticeBoard" method="POST">
	<!-- //검색 결과 -->
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<div class="articles_search">
		<p class="articles">All <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/></span>, This Page <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/></p>	
		<div class="photo_type">
			<button type="button" id="btnTextStyle" class="list${obj.boardStyle == 'Text' ? '_on' : '' }" alt="목록형">List</button> 
			<button type="button" id="btnImageStyle" class="multi${obj.boardStyle == 'Image' ? '_on' : '' }" alt="썸네일 목록">Thumbnail List</button> 
			<button type="button" id="btnGalleryStyle" class="album${obj.boardStyle == 'Gallery' ? '_on' : '' }" alt="포토형 목록">Photo List</button>
		</div>
	</div>	
		
	<!-- //검색 결과 -->
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
				<th scope="col" class="num">No.</th>
            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
            	<th scope="col" style="width:100px;">Category</th>
            	</c:if>
				<th scope="col">Title</th>
				<th scope="col" class="date">Writer</th>
				<th scope="col" class="date">Date</th>
				<th scope="col" class="num">Views</th>
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
                   <img src="${contextPath}/resources/images/common/icon/icon_replay.gif" alt="답글"/>
                   </c:if>
                   <a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}" ><text:splitText value="${data.KNAME}" tail="..." textSize="${titleSize }" /></a>
                </td>
                <td><c:out value="${data.USERNAME }" /></td>
                <td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
                <td><fmt:formatNumber value='${data.HITCOUNT }' pattern='#,###'/></td>
                <td class="file">
                    <c:if test="${data.FILEYN == 'Y'}">
                    <img src="${contextPath}/resources/images/ips/common/icon_file.gif" alt="파일첨부" class="viewFiles" linkId="${data.LINKID}"/>
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
    </spform:form>
    
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
	                    	str = str + "			<li><a href="+gContextPath+"'/fileDownload?titleId="+item.TITLEID+"&fileId="+item.FILEID+"' ><img src='/resources/images/common/icon/"+item.FILEEXTENSION+".png' alt='"+item.FILEEXTENSION+" 파일'/>"+strFileName+"<span>내려받기</span></a></li>";
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

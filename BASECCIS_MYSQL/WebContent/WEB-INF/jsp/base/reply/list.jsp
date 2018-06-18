<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>

    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
    
	<div class="search_form">
		<i></i>
		<c:if test="${rtnSetting.categoryYN == 'Y' }">
		<select name="categoryId" id="categoryId" title="카테고리">
			<option value="0">카테고리</option>
		</select>
		 </c:if>
		<select name="schType" id="schType" title="검색구분">
			<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
			<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
			<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>작성자</option>
		</select>
		<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력"/>
		<input type="button" value="검색" class="btn_type01" id="btnSearch" />
	</div>
    </spform:form>
    
    <c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<p class="articles">
		전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 
		현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/>
	</p>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				${rtnMenuName } : 번호, <c:if test="${rtnSetting.categoryYN == 'Y' }">분류,</c:if> 제목, 작성자, 등록일, 처리상황에 따른 게시글 목록
			</caption>
			<colgroup>
				<col width="7%" />
				<c:if test="${rtnSetting.categoryYN == 'Y' }">
				<col width="15%" />
				</c:if>
				<col />
				<col width="7%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
	            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
	            	<th scope="col">분류</th>
	            	</c:if>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">처리상황</th>
				</tr>
			</thead>
			<tbody>
	
	        <c:choose>          
	            <c:when test="${!empty result && fn:length(result) > 0 }">
	                <c:forEach items="${result }" var="data" varStatus="loop">
		            <tr>
		                <td>
		                	<c:if test="${data.NUM1 > 9000000000}">
		                		<span class="btn_redSmall">공지</span>
		                	</c:if>
		                	<c:if test="${data.NUM1 < 9000000000}">
		                		${data.NUM1}
		                	</c:if>
		                </td>
			            <c:if test="${rtnSetting.categoryYN == 'Y' }">
			                <td>${data.CATEGORYNAME }</td>
			            </c:if>
		                <td class="ellipsis">
		                	<c:if test="${data.SECRETTITLEYN  == 'Y'}"><img src="/resources/images/common/icon/icon_secret.gif" alt="비밀글" /></c:if>
		                 	<a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}" title="${data.KNAME}">
		                 		<c:out value="${data.KNAME}" escapeXml="false"/>
		                 	</a>
		                </td>
		                <td><c:out value="${data.USERNAME }" /></td>
		                <td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
		                <td>
			                <c:if test="${data.PROCESS == '접수' }">
			                	<span class="btn_blueSmall"><c:out value="${data.PROCESS }" /></span>
			                </c:if>
			                <c:if test="${data.PROCESS == '처리중' }">
			                	<span class="btn_redSmall"><c:out value="${data.PROCESS }" /></span>
			                </c:if>
			                <c:if test="${data.PROCESS == '답변완료' }">
			                	<span class="btn_greenSmall"><c:out value="${data.PROCESS }" /></span>
			                </c:if>
		                </td>
		            </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	            <tr>
	                <td colspan="${rtnSetting.categoryYN == 'Y' ? 6 : 5}">조회된 데이터가 없습니다.</td>
	            </tr>
	            </c:otherwise>
	        </c:choose>
			</tbody>
		</table>
	 </div>   
	<div class="btn_area_right">	
		<c:if test="${ADMIN eq 'T' or WRITE eq 'T'}"><%//관리권한, 쓰기권한%>
		<button type="button" class="btn_type01" id="btnAdd">등록</button>
		</c:if>
	</div>
    
    <c:if test="${!empty result && fn:length(result) > 0 }">
    <div class="board_pager">
        <paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }" siteGubun="U">
            <Previous><AllPageLink><Next>
        </paging:PageFooter>
    </div>
	</c:if>

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
	            		str = str + "		<dt>첨부파일</dt>";
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
	            		str = str + "	<p class='file_close'><button type='button'>첨부파일 닫기</button></p>";
	            		str = str + "</div>";
	                }
	            }
	        });  
	        $(this).after(str);
		}
    });

    //첨부파일 닫기
	$(document).on('click', '.file_close', function(){
		$(".attach_file").remove();
	});
    
});
</script>

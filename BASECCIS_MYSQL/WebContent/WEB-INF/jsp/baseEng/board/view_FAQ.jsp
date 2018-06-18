<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<article class="news_view">
	<h1  class="newsTitle">${rtnContent.KNAME }</h1>
	<table class="tstyle_view">
		<caption>
		작성자, 카테고리, <c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }"><c:out value="${rtnSetting.addField1}" />,</c:if><c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }"><c:out value="${rtnSetting.addField2}" />,</c:if><c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }"><c:out value="${rtnSetting.addField3}" />,</c:if><c:if test="${!empty(rtnSetting.addField4) && fn:length(rtnSetting.addField4) > 0 && rtnSetting.addField4 != '-' }"><c:out value="${rtnSetting.addField4}" />,</c:if><c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }"><c:out value="${rtnSetting.addField5}" />,</c:if><c:if test="${rtnSetting.imageYN eq 'Y' }">대표이미지,</c:if><c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }"> 첨부파일</c:if> 정보 제공
		</caption>
		<colgroup>
			<c:if test="${rtnSetting.categoryYN != 'Y' }">
			<col width="15%" />
            <col width="85%" />
            </c:if>
            <c:if test="${rtnSetting.categoryYN == 'Y' }">
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
            </c:if>
		</colgroup>	
		<tbody>
			<tr>
			    <th scope="row">Writer</th>
			    <td <c:if test="${rtnSetting.categoryYN != 'Y' }">colspan="3"</c:if>>
			        <c:out value="${rtnContent.USERNAME }" />
			    </td>
			    <c:if test="${rtnSetting.categoryYN == 'Y' }">
			    <th scope="row">Category</th>
			    <td>${rtnContent.CATEGORYNAME }</td>
			    </c:if>
			</tr>
			 
			<!-- ▼ 추가 필드가 있을 시 -->
			<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField1}" /></th>
			    <td colspan="3" id="addField1">${rtnContent.CONTENTS1 }</td>
			</tr>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField2}" /></th>
			    <td colspan="3" id="addField2">${rtnContent.CONTENTS2 }</td>
			</tr>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField3}" /></th>
			    <td colspan="3" id="addField3">${rtnContent.CONTENTS3 }</td>
			</tr>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField4) && fn:length(rtnSetting.addField4) > 0 && rtnSetting.addField4 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField4}" /></th>
			    <td colspan="3"><fmt:formatDate value="${rtnContent.CONTENTS4 }" pattern="yyyy-MM-dd"/>
					<c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }">
						<c:if test="${rtnSetting.addField4 eq rtnSetting.addField5}">
							~ <fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/>
						</c:if>
					</c:if>
			    </td>
			</tr>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }">
				<c:if test="${rtnSetting.addField4 ne rtnSetting.addField5}">
				<tr>
				    <th scope="row"><c:out value="${rtnSetting.addField5}" /></th>
				    <td colspan="3"><fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/></td>
				</tr>
				</c:if>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField6) && fn:length(rtnSetting.addField6) > 0 && rtnSetting.addField6 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField6}" /></th>
			    <td colspan="3"><fmt:formatDate value="${rtnContent.CONTENTS6 }" pattern="yyyy-MM-dd"/></td>
			</tr>
			</c:if>
                <c:if test="${rtnSetting.imageYN eq 'Y' }">
                <tr>
                    <th scope="row"><label for="viewtxt">대표이미지</label></th>
                    <td colspan="3">
                    	<a href="${contextPath}/fileDownload?titleId=${rtnContent.TITLEID }" alt="${rtnContent.ALTINFO }"><c:out value="${rtnContent.IMAGEFILENAME }" /></a>
                    </td>
                </tr> 
                </c:if>
			<!-- ▲ 추가 필드가 있을 시 -->  
			<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
			<tr>
				<th scope="row">AttachFile</th>
				<td colspan="3">
					<ul class="download_list">
				        <c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
				        	<c:set var="fileGubun" value="MB" />
				        	<c:set var="fileSize" value="${fileList.FILESIZE/1024/1024 }" />
				        	<c:if test="${fileSize < 1 }">
				        		<c:set var="fileSize" value="${fileList.FILESIZE/1024 }" />
				        		<c:set var="fileGubun" value="KB" />
				        	</c:if>
				        	<c:if test="${fileSize < 1 }">
				        		<c:set var="fileSize" value="${fileList.FILESIZE }" />
				        		<c:set var="fileGubun" value="B" />
				        	</c:if>
				        	<li><a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" title="${fileList.USERFILENAME }">${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> <span>내려받기</span></a></li>
				        </c:forEach>
					</ul>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<div class="viewContent">
		${rtnContent.KHTML }
	</div>
</article>	
<c:if test="${empty(obj.no1) || obj.no1 < 9000000000}"><%//공지글은 이전 이후 제외 %>
<c:set var="frevText" value="F" />
<c:set var="nextText" value="F" />
<ul class="nextPrev_list">
	<li>
	<strong class='prev_list'>Previous</strong>
	<c:forEach items="${rtnFrevNext}" var="FrevNext"><%// begin="1" end="8" %>
		<c:if test="${FrevNext.TEXT eq 'F'}">
			<a href="${contextPath}/board/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
			<c:set var="frevText" value="T" />
		</c:if>
	</c:forEach>
	<c:if test="${frevText eq 'F' }">No Previous Data.</c:if>
	</li>
	<li>
	<strong class='next_list'>Next</strong>
	<c:forEach items="${rtnFrevNext}" var="FrevNext"><%// begin="1" end="8" %>
		<c:if test="${FrevNext.TEXT eq 'N'}">
			<a href="${contextPath}/board/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
			<c:set var="nextText" value="T" />
		</c:if>
	</c:forEach>
	<c:if test="${nextText eq 'F' }">No Next Data.</c:if>
	</li>
</ul>
</c:if>

<div class="btn_area_right">	
	<c:if test="${ADMIN eq 'T' or MODIFY eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 수정권한, 본인글 %>
		<button type="button" class="btn_type01" id="btnEdit">Modify</button>
	</c:if>
	<c:if test="${ADMIN eq 'T' or DELETE eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
		<button type="button" class="btn_type01" id="btnDelete">Delete</button>
	</c:if>
	<c:if test="${rtnSetting.boardKind eq 'FREE' and (ADMIN eq 'T' or WRITE eq 'T') }"><%//자유형게시판이면서 관리권한, 등록권한 %>
		<button type="button" class="btn_type01" id="btnResponse">Reply</button>
	</c:if>
	<button type="button" class="btn_type01" id="btnList">List</button>
</div>

<form id="insertForm" name="insertForm" action="${contextPath }/board/actBoard" method="POST">
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }" />
	
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnContent.boardId) ? rtnContent.boardId : '-' }" />
	
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
</form>
    
<!-- ▼ 댓글 -->
<c:if test="${rtnSetting.commentYN eq 'Y'}">    
<!-- 댓글 -->
<ul id="reply" class="recmt_list"></ul>
<!-- 댓글 -->
</c:if>

<script type="text/javascript">
$(function() {
    var content_width = $('.viewContent').width();

    if($('.viewContent img').size() > 0) {
        $('.viewContent img').each(function() {
            var imgObj = new Image();
            imgObj.src = $(this).attr("src");
            
            if(imgObj.width > content_width) {
                $(this).width(content_width);
                
                //높이 조절
                var tempSize1=imgObj.height*(content_width/imgObj.width);
                //$(this).width(content_width);
                $(this).height(tempSize1);
            }
        });
    }
    
	/* 추가 필드 링크 있을 시 */
	if($('#addField1').length > 0){
		var txt = $('#addField1').text();
		
		if(txt.indexOf('http://') != -1){
			$('#addField1').empty();
			$('#addField1').html('<a href="'+txt+'" target="_blank"/>');
		    $('#addField1 > a').append(txt);
		}
	}
	if($('#addField2').length > 0){
		
		var txt = $('#addField2').text();
		
		if(txt.indexOf('http://') != -1){
		    $('#addField2').empty();
		    $('#addField2').html('<a href="'+txt+'" target="_blank"/>');
		    $('#addField2 > a').append(txt);
		}
	}
	if($('#addField3').length > 0){
		
		var txt = $('#addField3').text();
		
		if(txt.indexOf('http://') != -1){
		    $('#addField3').empty();
		    $('#addField3').html('<a href="'+txt+'" target="_blank"/>');
		    $('#addField3 > a').append(txt);
		}
	}
	
	/* 리플 리스트 */
	if( "${rtnSetting.commentYN}" == 'Y' ){
		gfnReplyList($('#reply'), '${obj.linkId}');
	}

	//이미지에 마우스 업로드시 화면 변경
	$('img[name=downImage]').mouseover(function(){
		$('#viewPort').attr("src", $(this).attr('src'));
        $('#viewPort').attr("style", "width:90%;");
	});

	//체크 버튼 클릭
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//수정
	$('#btnEdit').click(function(){
		document.location.href="${contextPath}/board/form?${link}&linkId=${obj.linkId}";
	});
	
	// 삭제
    $("#btnDelete").click(function(){
    	
    	if(!confirm("삭제하시겠습니까?")){
    		return;
    	}
    	
        $("#inCondition").val("삭제");
        
        $('#insertForm').submit();
    });

	//목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/board?${link}";
	});
    
	//답글
	$('#btnResponse').click(function(){
		document.location.href="${contextPath}/board/form?${link}&parentLinkId=${obj.linkId}";
	});
	
});
</script>

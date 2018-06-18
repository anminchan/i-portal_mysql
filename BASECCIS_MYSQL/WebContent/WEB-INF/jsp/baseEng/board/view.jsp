<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<article class="news_view">
	<h1  class="newsTitle"><c:out value="${rtnContent.KNAME }" /></h1>
	<table class="tstyle_view">
		<caption>
		제목, 작성자, 키워드, 내용에 따른 게시물상세 안내
		</caption>
		<colgroup>
			<col width="15%" />
			<col width="40%" />
			<col width="15%" />
			<col width="40%" />
		</colgroup>	
		<tbody>
			<tr>
			    <th scope="row">Writer</th>
			    <td>
			        <c:out value="${rtnContent.USERNAME }" />
			    </td>
			    <th scope="row">KeyWord</th>
			    <td>
			        <c:if test="${!empty(rtnContent.KEYWORD1) and  rtnContent.KEYWORD1 ne '-'}">${rtnContent.KEYWORD1}
			         <c:if test="${!empty(rtnContent.KEYWORD2) and  rtnContent.KEYWORD2 ne '-' }">,${rtnContent.KEYWORD2}
			             <c:if test="${!empty(rtnContent.KEYWORD3) and  rtnContent.KEYWORD3 ne '-' }">,${rtnContent.KEYWORD3}
			             </c:if>
			         </c:if>
			        </c:if>
			    </td>
			</tr>
			<tr>
			    <th scope="row">Date</th>
			    <td><dateFormat:dateFormat addPattern="-" value="${rtnContent.INSTIME}" /></td>
			    <th scope="row">Views</th>
			    <td><fmt:formatNumber value='${rtnContent.HITCOUNT }' pattern='#,###'/></td>
			</tr>
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
			<tr>
			    <th scope="row">Category</th>
			    <td colspan="3">${rtnContent.CATEGORYNAME }</td>
			</tr>
			</c:if>
			<!-- 
			<tr>
			    <th scope="row">공개여부</th>
			    <td colspan="3">${rtnContent.secretYN == 'Y' ? '공개' : '비공개' }</td>
			</tr>
			 -->
			 
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
			<!-- ▲ 추가 필드가 있을 시 -->  
			<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
			<tr>
				<th scope="row">Attached File</th>
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
				        	<li><img src="/resources/images/common/icon/${fileList.FILEEXTENSION }.png" alt="${fileList.FILEEXTENSION} 파일"/>${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> <span><a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }">내려받기</a></span></li>
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
	<%-- <c:if test="${rtnSetting.boardKind eq 'FREE' and (ADMIN eq 'T' or WRITE eq 'T') }"><%//자유형게시판이면서 관리권한, 등록권한 %>
		<button type="button" class="btn_type01" id="btnResponse">Reply</button>
	</c:if> --%>
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

<!-- 댓글 -->
<ul id="reply" class="recmt_list"></ul>
<!-- 댓글 -->

<script type="text/javascript">
$(function() {
	
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
	gfnReplyList($('#reply'), '${obj.linkId}');

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

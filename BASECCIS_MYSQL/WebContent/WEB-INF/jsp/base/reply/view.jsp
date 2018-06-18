<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<article class="news_view">
	<h1  class="newsTitle">${rtnContent.KNAME }</h1>
	<dl class="info">
		<dt>작성자</dt>
		<dd><c:out value="${rtnContent.USERNAME }" /></dd>
		  <c:if test="${rtnSetting.categoryYN == 'Y' }">
			<dt>카테고리</dt>
			<dd>${rtnContent.CATEGORYNAME }</dd>
		 </c:if>
		<dt>작성일</dt>
		<dd><dateFormat:dateFormat addPattern="-" value="${rtnContent.INSTIME}" /></dd>
		<dt>조회수</dt>
		<dd><fmt:formatNumber value='${rtnContent.HITCOUNT }' pattern='#,###'/></dd>
		<!-- ▼ 국가필드유무 -->
		<c:if test="${rtnSetting.countryYN == 'Y' }">
			<dt>국가정보</dt>
			<dd >${rtnContent.CONTINENTNAME } ${!empty rtnContent.COUNTRYNAME ? '>' : ''} ${!empty rtnContent.COUNTRYNAME ? rtnContent.COUNTRYNAME : ''}</dd> 
		</c:if>
		 
		<!-- ▼ 추가 필드가 있을 시 -->
		<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
			<dt><c:out value="${rtnSetting.addField1}"/></dt>
			<dd  id="addField1"><c:if test="${rtnContent.CONTENTS1 ne '-'}">${rtnContent.CONTENTS1}</c:if></dd> 
		</c:if>
		<c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
			<dt><c:out value="${rtnSetting.addField2}"/></dt>
			<dd  id="addField2"><c:if test="${rtnContent.CONTENTS2 ne '-'}">${rtnContent.CONTENTS2}</c:if></dd>
		</c:if>
		<c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }">
			<dt><c:out value="${rtnSetting.addField3}"/></dt>
			<dd  id="addField3"><c:if test="${rtnContent.CONTENTS3 ne '-'}">${rtnContent.CONTENTS3}</c:if></dd> 
		</c:if>
		<c:if test="${!empty(rtnSetting.addField4) && fn:length(rtnSetting.addField4) > 0 && rtnSetting.addField4 != '-' }">
			<dt><c:out value="${rtnSetting.addField4}" /></dt>
			<dd ><fmt:formatDate value="${rtnContent.CONTENTS4 }" pattern="yyyy-MM-dd"/>
				<c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }">
					<c:if test="${rtnSetting.addField4 eq rtnSetting.addField5}">
						~ <fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/>
					</c:if>
				</c:if>
			</dd> 
		</c:if>
		<c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }">
			<c:if test="${rtnSetting.addField4 ne rtnSetting.addField5}">
				<dt><c:out value="${rtnSetting.addField5}" /></dt>
				<dd ><fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/></dd> 
			</c:if>
		</c:if>
		<c:if test="${!empty(rtnSetting.addField6) && fn:length(rtnSetting.addField6) > 0 && rtnSetting.addField6 != '-' }">
			<dt><c:out value="${rtnSetting.addField6}" /></dt>
			<dd ><fmt:formatDate value="${rtnContent.CONTENTS6 }" pattern="yyyy-MM-dd"/></dd> 
		</c:if>
		<c:if test="${rtnSetting.imageYN eq 'Y' }">
			<dt><label for="viewtxt">대표이미지</label></dt>
			<dd >
				<a href="${contextPath}/fileDownload?titleId=${rtnContent.TITLEID }&fileDownType=C&paramMenuId=${obj.menuId}"><c:out value="${rtnContent.IMAGEFILENAME }" /></a>
			</dd> 
		</c:if>
		<!-- ▲ 추가 필드가 있을 시 -->  
	</dl>
	<div class="viewContent">
		${rtnContent.KHTML }
	</div>	
	<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
	<!-- 파일다운로드 -->	
	<div class="download_list">
		<h2 class="tit">첨부파일</h2>
		<ul>
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
				<li><a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }&fileDownType=C&paramMenuId=${obj.menuId}">
					${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> <i class="xi-attachment"><span class="hidden">파일다운로드</span></i></a>
					<%-- <c:if test="${fn:indexOf(imgAllowFilterExclude, fileList.FILEEXTENSION) < 0 }">
						<a href="#" onclick="javascript:gfnFileViewer('/fileViewer?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }');"><i class="xi-eye"><span class="hidden">미리보기</span></i></a>
					</c:if> --%>
					</li>
			</c:forEach>
		</ul>		
	</div>
	<!-- //파일다운로드 -->	
	</c:if>
</article>	

<c:if test="${fn:length(rtnComment) > 0 }">
<article class="news_view">
    <!-- ▼ 답글 -->
	<table class="tstyle_view">
		<caption>
		답변자, 답변일, 내용에 따른 답변 상세
		</caption>
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="*" />
		</colgroup>	
		<tbody>
			<tr>
			    <th scope="row">답변자</th>
			    <td>
			        <c:out value="${rtnComment.USERNAME }" />
			    </td>
			    <th scope="row">답변일</th>
			    <td>
			    	<dateFormat:dateFormat addPattern="-" value="${rtnComment.DMLTIME}" />
			    </td>
			</tr>
			<tr>
			    <th scope="row">답변</th>
			    <td colspan="3">
			        ${rtnComment.KHTML }
			    </td>
			</tr>
		</tbody>
	</table>
</article>
</c:if>

<div class="btn_area">	
	<c:if test="${rtnContent.PROCESS eq '-' and USER.userId eq rtnContent.USERID}"><%//관리권한, 수정권한, 본인글 %>
		<button type="button" class="btn_type02" id="btnEdit">수정</button>
	</c:if>
	<c:if test="${rtnContent.PROCESS eq '-' and USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
		<button type="button" class="btn_type02" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn_type01" id="btnList">목록</button>
</div>

<!-- ▼ 이전글/다음글 -->
<c:if test="${!empty(obj.no1) && obj.no1 < 9000000000 }">    
    <ul class="nextPrev_list">
        <c:forEach items="${rtnFrevNext}" var="FrevNext">
            <c:if test="${!empty(FrevNext)}">
		         <li>
		             <strong><c:out value="${FrevNext.TEXT eq 'F' ? '이전글' : '다음글' }" /></strong>
		             <a href="${contextPath}/board/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
		         </li>
            </c:if>
        </c:forEach>
    </ul>
</c:if>
<!-- ▲ 이전글/다음글 -->

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
<%@ include file="/includes/bbsReply.jsp" %>
<!-- ▲ 댓글 -->

<script type="text/javascript">
$(function() {
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
    //목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/board?${link}";
	});
	// 삭제
    $("#btnDelete").click(function(){
    	$("#inCondition").val("삭제");
        
        $('#insertForm').submit();
    });
	
});
</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="viewForm" name="viewForm" action="${contextPath }/mgr/sampleMgr">
	<%-- 페이지 이동방식에 따라 (폼 submit, location) --%>
	<%-- <input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/> --%>
	<%-- <input type="hidden" id="sampleId" name="sampleId" value="${result.SAMPLEID}"/> --%>
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<%-- <input type="hidden" name="pageNum" value="${obj.pageNum }">
	<input type="hidden" name="schType" value="${obj.schType}">
	<input type="hidden" name="schText" value="${obj.schText}"> --%>
	
    <!-- ▼ 상세페이지  -->
    <fieldset>
        <legend>상세등록</legend>
        <div class="table">
	        <table class="tstyle_view">
	            <caption>
	               	게시물상세 안내 - 제목, 작성일, 내용 <c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">, 첨부파일</c:if>
	            </caption>
	            <colgroup>
	                <col class="col-sm-3"/>
	                <col />
	            </colgroup>
	            <tbody>
		            <tr>
		                <th scope="row">제목</th>
		                <td><c:out value="${result.SAMPLETITLE}"/></td>
		            </tr>
		            <tr>
		                <th scope="row">작성일</th>
		                <td><fmt:formatDate value="${result.INSTIME}" pattern="yyyy-MM-dd"/></td>
		            </tr>            
		            <tr>
		                <th scope="row">내용</th>
		                <td><c:out value="${result.SAMPLECONTENT}" escapeXml="false"/></td>
		            </tr>
		            <c:if test="${!empty(resultFile) && fn:length(resultFile) > 0 }">
		                <tr>
		                    <th scope="row">첨부파일</th>
		                    <td>
								<ul class="download_list">
							        <c:forEach items="${resultFile }" var="fileList" varStatus="status">
							        	<li><a href="${contextPath}/fileDownload?fileGubun=function&menuId=sampleMgr&userFileName=${fileList.USERFILENAME }&systemFileName=${fileList.SYSTEMFILENAME }">${fileList.USERFILENAME }<span>내려받기</span></a></li>
							        </c:forEach>
								</ul>
		                    </td>
		                </tr>
		            </c:if>
	            </tbody>
	        </table>
        </div>
    </fieldset>
    <!-- ▲ 상세페이지  -->    
    <!-- ▼ 버튼 -->
    <div class="btn_area">
		<button type="button" class="btn btn_type02" id="btnEdit">수정</button>
	    <button type="button" class="btn btn_type01" id="btnList">목록</button>
    </div>
    <!-- ▲ 버튼 -->

	<!-- ▼ 이전글/다음글 -->
<c:if test="${!empty(obj.no1) && obj.no1 < 9000000000 }">    
    <ul class="nextPrev_list">
        <c:forEach items="${rtnFrevNext}" var="FrevNext">
            <c:if test="${!empty(FrevNext)}">
		         <li>
		             <strong><c:out value="${FrevNext.TEXT eq 'F' ? '이전글' : '다음글' }" /></strong>
		             <a href="${contextPath}/mgr/contentMgr/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
		         </li>
            </c:if>
        </c:forEach>
    </ul>
</c:if>
<!-- ▲ 이전글/다음글 -->    
</spform:form>
<script type="text/javascript">
$(function() {
    //목록
	$("#btnList").click(function(){
		/* $("#viewForm").attr('action', '${ctxMgr }/sampleMgr');
		$("#viewForm").submit(); */
		document.location.href="${ctxMgr}/sampleMgr?${link}";
	});    
    //수정폼
	$("#btnEdit").click(function(){
		/* $("#viewForm").attr('action', '${ctxMgr}/sampleMgr/form');
		$('#viewForm').submit(); */
		document.location.href="${ctxMgr}/sampleMgr/form?sampleId=${result.SAMPLEID}${link}";
	});    
});
</script>
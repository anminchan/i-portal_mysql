<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/attachFileMgr" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	
	<c:if test="${!empty result.ATTACHFILEID}">
		<input type="hidden" id="attachFileId" name="attachFileId" value="${result.ATTACHFILEID}"/>
	</c:if>
	
	<!--  파일 hidden -->
	<input type="hidden" name="fileLen" id="fileLen" value="${fn:length(resultFile)}"/>
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schType" value="${param.schType == '' || param.schType == null ? '0' : param.schType}">
	<input type="hidden" name="schText" value="${param.schText}">
	
    <!-- ▼ 상세페이지  -->
    <fieldset>
        <legend>상세등록</legend>
        <table class="tstyle_view">
            <caption>
               제목, 작성자, 작성일, 내용, 첨부파일, 첨부파일 주소 상세 안내
            </caption>
            <colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
            </colgroup>
            <tr>
                <th scope="row"><label for="title">제목</label></th>
                <td colspan="2"><c:out value="${result.KNAME}"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="contents">작성자</label></th>
                <td colspan="2"><c:out value="${result.USERNAME}"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="contents">작성일</label></th>
                <td colspan="2"><fmt:formatDate value="${result.INSTIME}" pattern="yyyy-MM-dd"/></td>
            </tr>            
            <tr>
                <th scope="row"><label for="contents">내용</label></th>
                <td colspan="2">${result.KHTML}</td>
            </tr>
            <tr>
		       <th scope="row"><label for="contents">첨부파일</label></th>
		       <td>
					<c:choose>   
						<c:when test="${fn:length(resultFile) > 0 }">
							<c:forEach items="${resultFile }" var="list" varStatus="loop">
					             <span class="txt">${loop.count}. <a href="${contextPath}/fileDownload?fileGubun=common&menuId=attachFileMgr&userFileName=${list.USERFILENAME }&systemFileName=${list.SYSTEMFILENAME }"><c:out value="${list.USERFILENAME }" /></a> : 
					             /fileDownload?fileGubun=common&menuId=attachFileMgr&userFileName=${list.USERFILENAME }&systemFileName=${list.SYSTEMFILENAME }
					             <a href="javascript:fnCopy('${contextPath}/fileDownload?fileGubun=common&menuId=attachFileMgr&userFileName=${list.USERFILENAME }&systemFileName=${list.SYSTEMFILENAME }');"><span class="btn_graySmall">URL복사</span></a>
					             </span><br/>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<span class="txt">첨부파일이 없습니다.</span>
						</c:otherwise>
					</c:choose>
				</td>
           </tr>
           
        </table>
    </fieldset>
    <!-- ▲ 상세페이지  -->
    
    <!-- ▼ 버튼 -->
    <div class="btn_area">
        <span class="float_right">
       		<button type="button" class="btn btn_type02" id="btnEdit">수정</button>
            <button type="button" class="btn btn_type01" id="btnList">목록</button>
        </span>
    </div>
    <!-- ▲ 버튼 -->
</spform:form>

<script type="text/javascript">

$(function() {
	
    //목록
	$("#btnList").click(function(){
		$("#listForm").attr('action', '${ctxMgr }/attachFileMgr');
		$("#listForm").submit();
	});
    
    //수정폼
	$("#btnEdit").click(function(){
		$("#listForm").attr('action', '${ctxMgr}/attachFileMgr/form');
		$('#listForm').submit();
	});
    
});

function fnCopy(strUrl){
	var IE=(document.all)?true:false;
	if (IE) {
		if (!confirm("주소를 복사하시겠습니까?")) {
			return;
		}
		window.clipboardData.setData("Text", strUrl);
		alert ( "주소가 복사되었습니다. \'Ctrl+V\'를 눌러 붙여넣기 해주세요." );
	} else {
		temp = prompt("복사할 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", strUrl);
	}
}

</script>
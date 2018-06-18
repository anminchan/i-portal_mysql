<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="searchForm" name="searchForm" method="get" action="${contextPath }/mgr/attachFileMgr" class="search_form">
 	<input type="hidden" name="menuId" value="${obj.menuId}" />
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label>검색조건</label>				
		        <select name="schType" id="schType" title="검색구분">
		            <option value="0" ${obj.schType == '0' ? 'selected="selected"' : ''}>제목</option>
                    <option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>내용</option>
		        </select>
			    <input type="text" name="schText" id="schText" class="input_mid" value="${obj.schText }" title="검색어"/>                 			        
			</div>
			<span class="display_block txt_center">
				<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
			</span>
		</div>
	</fieldset>
</spform:form>
	
<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/attachFileMgr/" method="POST">
    <input type="hidden" name="link" value="pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt}${link }&cate=${cate }" />
    <input type="hidden" name="menuId" id="menuId" value="${obj.menuId }" />    
    <input type="hidden" id="attchFileId" name="attchFileId" value="0"/>
    <input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<div class="float_wrap">	
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="float_right">
			<button type="button" class="btn btn_basic" id="btnAdd">등록</button>
			<button type="button" class="btn btn_basic" id="btnDel">삭제</button>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				첨부파일 관리 - 번호, 제목, 첨부, 작성자, 작성일
			</caption>
			<colgroup>
	            <col class="num">
	            <col class="num">
				<col class="subject"/>
	            <col class="file" />
	            <col class="name" />
	            <col class="date" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">첨부</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
				</tr>
			</thead>
			<tbody>		
			<c:choose>			
				<c:when test="${!empty result && fn:length(result) > 0 }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr ${data.RNUM > 9000000000 ? 'style="background:#eee;"' : ''}>
							<td>
							    <c:if test="${data.RNUM < 9000000000 }">
							    <input type="checkbox" id="attachFileIds" name="attachFileIds" class="listCheck" value="${data.ATTACHFILEID }" title="선택" />
							    </c:if>
						    </td>
							<td>${totalCnt - data.RNUM+1}</td>
							<td class="txt_left">
							   <a href="${contextPath}/mgr/attachFileMgr/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&attachFileId=${data.ATTACHFILEID }${link}">${data.KNAME }</a>
			                </td>
			                <td class="file">
			                	<c:if test="${data.FILEYN == 'Y'}">
			                    	<i class="xi-save"></i>
			                    	<span class="hidden">첨부파일</span>
			                    </c:if>
			                    <c:if test="${data.FILEYN != 'Y'}">
			                     &nbsp;
			                    </c:if>
		                    </td>
			                <td><c:out value="${data.USERNAME }" /></td>
							<td><fmt:parseDate var="dateString" value="${data.INSTIME}" pattern="yyyy-MM-dd" /> <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6">조회된 데이터가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>	
	</div>
	<div class="board_pager">
        <paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }" siteGubun="U">
            <Previous><AllPageLink><Next>
        </paging:PageFooter>
    </div>
</spform:form>
	
<script type="text/javascript">

$(function() {
	
	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//등록
	$('#btnAdd').click(function(){
		document.location.href="${contextPath}/mgr/attachFileMgr/form?pageNum=${obj.pageNum}${link}";
	});
	
	//삭제
	$nCnt = 0;
	$("#btnDel").on("click", function() {

		$nCnt = $("input:checkbox[name=attachFileIds]:checked").length;;
		
		if( $nCnt > 0 ){
			if(confirm("삭제하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/attachFileMgr/delete');
				$("#listForm").submit();
			}
		}else{
			alert('삭제 할 데이타를 선택하세요.');
		}

		return false;
	});
	
});
</script>

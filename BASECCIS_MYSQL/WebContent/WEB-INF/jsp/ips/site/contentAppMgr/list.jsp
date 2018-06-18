<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="searchForm" name="searchForm" method="get" action="${contextPath }/mgr/contentAppMgr" class="search_form">
	<input type="hidden" name="menuId" value="${obj.menuId}" />
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="schType">검색조건</label>
		        <select name="schType" id="schType" title="검색구분">
		            <option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
                       <option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>작성자</option>
                       <option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
		        </select>
		        <input type="text" name="schText" id="schText" class="input_mid" value="${obj.schText }" title="검색어"/>
			 </div>
		     <span class="display_block txt_center"><input type="button" id="btnSearch" class="btn btn_type02" value="검색"></span>
		</div>
	</fieldset>
</spform:form>

<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/contentAppMgr/act" method="POST">
	<input type="hidden" name="link" value="pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt}${link }" />
	<input type="hidden" name="inCondition" value="삭제">
	<input type="hidden" name="menuId" value="${obj.menuId }" />
	<input type="hidden" name="fileYN" id="fileYN" value="Y"/>
	
	<div class="float_wrap">	
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="float_right">
		    <button type="button" class="btn btn_basic" id="btnRestore">승인</button>
		</div>
	</div>
			
	<div class="table">
		<table class="tstyle_list">
			<caption>
				사이트관리 목록
			</caption>
			<colgroup>
		           <col width="5%" />
		           <col width="5%" />
				   <col />
		           <col width="10%" />
		           <col width="10%" />
		           <col width="7%" />
		           <col width="7%" />
		           <col width="7%" />
		           <col width="9%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">공개여부</th>
					<th scope="col">첨부</th>
					<th scope="col">조회</th>
					<th scope="col">승인단계</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result && fn:length(result) > 0 }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr>
							<td>
							    <c:if test="${data.NUM1 < 9000000000 }">
							    	<input type="checkbox" id="linkId" name="linkId" class="listCheck" value="${data.LINKID }§§${data.MENUID }" title="선택" />
							    </c:if>
						    </td>
							<td><fmt:parseNumber value="${data.NUM1}" /></td>
							<td class="txt_left">
							   <c:if test="${data.DEPTH > 1 }">
							   <c:forEach var="depth" begin="2" end="${data.DEPTH }">
							   &nbsp;    
							   </c:forEach>
							   </c:if>
							   <a href="${contextPath}/mgr/contentAppMgr/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&linkId=${data.LINKID }&paramMenuId=${data.MENUID }${link}">${data.KNAME }</a>
							   <c:if test="${data.SECRETTITLEYN  == 'Y'}">
							   		<i class="xi-lock-o"></i>
									<span class="hidden">비밀글</span>
								</c:if>
					        </td>
					        <td><c:out value="${data.USERNAME }" /></td>
							<td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
							<td>
				              	<c:if test="${data.OPENYN == 'Y'}">
									<i class="xi-unlock"></i>
									<span class="hidden">공개</span>
								</c:if>
								<c:if test="${data.OPENYN == 'N'}">
									<i class="xi-lock-o"></i>
									<span class="hidden">비공개</span>
								</c:if>
			              	</td>
							<td>
							    <c:if test="${data.FILEYN == 'Y'}">
									<i class="xi-diskette"></i>
									<span class="hidden">파일첨부</span>
								</c:if>
							</td>
							<td>${data.HITCOUNT }</td>
							<td>
								<c:if test="${data.STATEYN eq 'N' }">1차승인대기</c:if>
								<c:if test="${data.STATEYN eq 'FN' }">2차승인대기</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9">조회된 데이터가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</spform:form>

<div class="board_pager">
	<paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>
</div>

<script type="text/javascript">
$(function() {
	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 
	
	$('#allChk').click(function(){
        $(".listCheck").prop("checked", this.checked);
    }); 
	
	//선택 개수 체크
	$nCnt = 0;
	$("#btnRestore").on("click", function() {
		$nCnt = $("input:checkbox[name=linkId]:checked").length;;
		if( $nCnt > 0 ){
			if(confirm("승인하시겠습니까?")) {
				$("#listForm").attr('action', '${ctxMgr }/contentAppMgr/act');
				$("#listForm").submit();
			}
		}else{
			alert('승인 할 데이타를 선택하세요.');
		}
		return false;
	});
	
});

</script>

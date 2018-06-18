<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

	<spform:form id="searchForm" name="searchForm" method="get" action="${contextPath }/mgr/contentMgr" class="search_form">
	<input type="hidden" name="menuId" value="${obj.menuId}">
	<input type="hidden" name="boardKind" value="${obj.boardKind}">
	
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
					<input type="text" name="schText" id="schText" value="${obj.schText }" class="input_mid" title="검색어"/>
				</div>
				<c:if test="${rtnSetting.categoryYN == 'Y' }">			
					<div class="row">
						<label for="categoryId">분류</label>
					    <select name="categoryId" id="categoryId" title="카테고리">
					        <option value="0">카테고리</option>
					    </select>
					</div>
				</c:if>	
				<span class="display_block txt_center">
		        	<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
				</span>
			</div>
		</fieldset>
	</spform:form>

	<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/contentMgr/actReplyBoard" method="POST">
	<input type="hidden" name="inCondition" value="삭제">
	<input type="hidden" name="menuId" value="${obj.menuId }" />
	<input type="hidden" name="boardId" value="${obj.boardId }" />
	<input type="hidden" name="startTime" value="11111111" />
	<input type="hidden" name="endTime" value="11111111" />
	<div class="float_wrap">	
		<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
	    <div class="txt_right">
		    <!-- 콘텐츠 이관 target으로 참조되는 메뉴가 아닐 경우 -->
			<button type="button" class="btn btn_basic" id="btnAdd">등록</button>
	    </div>
	</div>  
	<div class="table">
		<table class="tstyle_list">
			<caption>
				 관리자답변형 게시판으로 번호, <c:if test="${rtnSetting.categoryYN == 'Y' }">질의분야,</c:if> 제목, 작성자, 작성일, 출처, 보도일, 공개여부 목록으로 제공
			</caption>
			<colgroup>
				<col width="10%" />
	        	<c:if test="${rtnSetting.categoryYN == 'Y' }">
	            	<col width="10%" />
	        	</c:if>
	            <col />
	            <col width="10%" />
	            <col width="10%" />
	            <col width="8%" />
	            <col width="5%" />
	            <col width="10%" />
	            <col width="8%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
		            <c:if test="${rtnSetting.categoryYN == 'Y' }">
						<th scope="col">질의분야</th>
					</c:if>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">공개여부</th>
					<th scope="col">첨부</th>
					<th scope="col">처리상황</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result && fn:length(result) > 0 }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr ${data.NUM1 > 9000000000 ? 'style="background:#eee;"' : ''}>
							<td>
			                	<c:if test="${data.NUM1 > 9000000000}">공지</c:if>
			                	<c:if test="${data.NUM1 < 9000000000}"><fmt:parseNumber value="${data.NUM1}" /></c:if>
		                	</td>
							<c:if test="${rtnSetting.categoryYN == 'Y' }">
								<td>${data.CATEGORYNAME }</td>
							</c:if>
							<td class="txt_left">
					            <c:choose>
					                <c:when test="${ADMIN == 'T' && data.PROCESS != '답변완료' }">
					                    <!-- 관리자일 경우 -->
					                    <a href="${contextPath}/mgr/contentMgr/form?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&linkId=${data.LINKID }${link}">${data.KNAME }</a>
					                    <c:if test="${data.SECRETTITLEYN  == 'Y'}"><img src="/resources/images/common/icon/icon_secret.gif" alt="비밀글" /></c:if>
					                </c:when>
					                <c:otherwise>
					                    <c:set var="linkPath" value="${contextPath}/mgr/contentMgr/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&linkId=${data.LINKID }${link}"  />
					                    <c:if test="${data.OPENYN == 'N' && data.USERID != obj.myId || data.APPEALUSERID != null && !empty(data.APPEALUSERID) && data.APPEALUSERID != obj.myId  }">
					                        <c:set var="linkPath" value="javascript:noAuthority();"/>
					                    </c:if>
					                    <!-- 사용자나 답변자일 경우 -->
					                    <a href="${linkPath }">${data.KNAME }</a>
					                    <c:if test="${data.SECRETTITLEYN  == 'Y'}"><img src="/resources/images/common/icon/icon_secret.gif" alt="비밀글" /></c:if>
					                </c:otherwise>
					            </c:choose>
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
							<td>${data.HITCOUNT }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="${rtnSetting.categoryYN == 'Y' ? 9 : 8}">조회된 데이터가 없습니다.</td>
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
function noAuthority(){
	alert("작성자만 조회할 수 있습니다");
}

$(function() {
	
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리 선택', '${obj.categoryId}');

	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//등록
	$('#btnAdd').click(function(){
		document.location.href="${contextPath}/mgr/contentMgr/form?pageNum=${obj.pageNum}${link}";
	});
	
	//달력 세팅
    $( "#schStartDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/common/calendar/calendar.png"
    });
    
    $( "#schEndDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/common/calendar/calendar.png"
    });
	
});
</script>

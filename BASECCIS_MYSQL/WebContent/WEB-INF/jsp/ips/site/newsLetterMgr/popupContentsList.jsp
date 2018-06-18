<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath}/mgr/contentMgr/actContent" method="post">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="titleId" name="titleId" value="${rtnContent.titleId}"/>
	<input type="hidden" id="KHtml" name="KHtml" value="<c:out value='${rtnContent.KHtml}' escapeXml='true'/>"/>
	<input type="hidden" id="boardId" name="boardId" value="${rtnContent.boardId}"/>
	<input type="hidden" id="linkId" name="linkId" value="${rtnContent.linkId}"/>
	<input type="hidden" id="kName" name="kName" value="${rtnContent.boardName}"/>

	<table class="tstyle_list" style="width: 520px;">
		<thead>
		<tr>
			<th scope="col" class="num">번호</th>
			<th scope="col">제목</th>
			<th scope="col" class="date">작성일</th>
			<th scope="col" class="num">선택</th>
		</thead>
		<c:choose>
			<c:when test="${!empty result && fn:length(result) > 0 }">
				<c:forEach items="${result }" var="data" varStatus="loop">
					<tr>
						<td>${data.NUM1 > 9000000000 ? '공지' : data.NUM1}</td>
						<td class="txt_left">
							<c:choose>
								<c:when test="${fn:length(data.KNAME) > 25}">
									<c:out value="${fn:substring(data.KNAME, 0, 25)}"/>...
								</c:when>
								<c:otherwise>
									${data.KNAME}
								</c:otherwise>
							</c:choose>
						</td>
						<td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}"/></td>
						<td>
							<input type="radio" name="selectedContents" id="selectedContents" class="listCheck" title="선택" onclick="setSelectedContents('${data.KNAME}','${currentUrl}${contextPath}/board/view?pageNum=${obj.pageNum}&rowCnt=${obj.rowCnt}&no1=${data.NUM1}&linkId=${data.LINKID}&menuId=${data.MENUID}')">
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="4">조회된 데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</spform:form>

<div class="board_pager" style="float: left; margin-left: 100px;">
	<paging:PageFooter totalCount="${totalCnt}" rowCount="${obj.rowCnt}">
		<Previous>
		<AllPageLink>
		<Next>
	</paging:PageFooter>
</div>

<script type="text/javascript">
	function setSelectedContents(subject, link){
		$("#subject", parent.document).val(subject);
		$("#link", parent.document).val(link);

		$(parent.location).attr("href", "javascript:setSelectedContents();");
	}
</script>
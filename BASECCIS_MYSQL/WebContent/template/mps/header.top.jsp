<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<div class="top_service">
	<nav class="tsidemenu">
		<ul>
			<c:choose>
				<c:when test="${empty USER.userId || (USER.userId eq 'guest' && USER.kind ne 'N' )}">
					<li><a href="${contextPath }/menu?menuId=${loginMenu}">로그인</a></li>
					<li><a href="${contextPath }/menu?menuId=${joinMenu}&siteId=${obj.mySiteId}">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<c:if test="${!empty USER.userId || (USER.userId eq 'guest' && USER.kind eq 'N')}">
					<li><a href="#">로그아웃</a></li>
					</c:if>
				</c:otherwise>
			</c:choose>
		</ul> 
	</nav>
</div>
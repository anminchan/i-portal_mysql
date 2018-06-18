<%@ page contentType="text/html; charset=utf-8" %>

<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"  %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"  %>
<%@ taglib prefix="sql" uri="/WEB-INF/tld/sql.tld"  %>
<%@ taglib prefix="x" uri="/WEB-INF/tld/x.tld"  %>
<%@ taglib prefix="tiles" uri="/WEB-INF/tld/tiles-jsp.tld" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tld/paging.tld"%>
<%@ taglib prefix="dateFormat" uri="/WEB-INF/tld/dateFormat.tld"%>
<%@ taglib prefix="text" uri="/WEB-INF/tld/text.tld"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="spform" uri="http://www.springframework.org/tags/form" %>

<% pageContext.setAttribute("newLine", "\n"); %> 
<% pageContext.setAttribute("newLineChar", "\r\n"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="contextUri" value="${pageContext.request.requestURI }" />
<c:set var="currentUrl">${pageContext.request.scheme}://${pageContext.request.serverName}<c:if test="${pageContext.request.serverPort != '80'}">:${pageContext.request.serverPort}</c:if></c:set>

<c:set var="editorImgPath" value="${contextPath}/resources/component/crosseditor/binary/images" />
<c:set var="editorUploadFileExePath" value="${contextPath}/resources/component/crosseditor/websource/jsp/ImageUpload.jsp" />

<%//관리자용 contextpath %>
<c:set var="ctxMgr" value="${contextPath}/mgr" />

<%//첨부파일 제한 확장자 // ExtFilterExclude %>
<c:set var="extFilterExclude" value="*.exe; *.jsp; *.java; *.sh; *.bat; *.java; *.php; *.asp; *.bin; *.cgi; *.dll; *.zip; *.rar; *.ace; *.cab; *.tar; *.zipx; *.7z; *.lzh; *.alz; *.agg" />

<% //업로드 허용 %>
<c:set var="imgAllowFilterExclude" value="jpg;jpeg;png;gif;bmp" />
<c:set var="vodAllowFilterExclude" value="mkv;mp4;wmv;avi;mov" />

<jsp:useBean id="DATE" class="java.util.Date"/>
<fmt:formatDate value="${DATE }" var="TODAY" pattern="yyyy/MM/dd" />
<fmt:formatDate value="${DATE }" var="TODAY_DAYWEEK" pattern="yyyy.MM.dd E요일" />
<fmt:formatDate value="${DATE }" var="TODAY_YEAR" pattern="yyyy" />
<fmt:formatDate value="${DATE }" var="TODAY_MONTH" pattern="MM" />
<fmt:formatDate value="${DATE }" var="TODAY_DAY" pattern="dd" />

<c:set var="ADMIN" value="F"/>
<c:set var="WRITE" value="F"/>
<c:set var="MODIFY" value="F"/>
<c:set var="DELETE1" value="F"/>
<c:set var="READ" value="F"/>

<c:forEach items="${rtnUserMenu }" var="menu">
    <c:if test="${menu.MENUID eq param.menuId }">
		<c:set var="ADMIN" value="${!empty menu.ROLETYPE_1 ? 'T' : 'F'}"/>
		<c:set var="WRITE" value="${!empty menu.ROLETYPE_2 ? 'T' : 'F'}"/>
		<c:set var="MODIFY" value="${!empty menu.ROLETYPE_3 ? 'T' : 'F'}"/>
		<c:set var="DELETE" value="${!empty menu.ROLETYPE_4 ? 'T' : 'F'}"/>
		<c:set var="READ" value="${!empty menu.ROLETYPE_5 ? 'T' : 'F'}"/>
		
		<c:if test="${ADMIN eq 'T'}">
			<c:set var="WRITE" value="T"/>
			<c:set var="MODIFY" value="T"/>
			<c:set var="DELETE" value="T"/>
			<c:set var="READ" value="T"/>
		</c:if>	
    </c:if>
</c:forEach>

<%//CMS관리 %>
<c:set var="systemMgrMenu" value="MENU00001"/>		<%//시스템관리 메뉴ID %>		<!-- 운영메뉴ID : MENU00001 -->
<c:set var="contentSetMgrMenu" value="MENU00008"/>	<%//콘텐츠설정관리 메뉴ID %>	<!-- 운영메뉴ID : MENU00008 -->
<c:set var="siteMgrMenu" value="MENU00100"/>		<%//사이트관리 메뉴ID %>		<!-- 운영메뉴ID : MENU00100 -->
<c:set var="contentMgrMenu" value="MENU00101"/>		<%//콘텐츠등록관리 메뉴ID %>	<!-- 운영메뉴ID : MENU00101 -->

<%//포탈 %>
<c:set var="loginMenu" value="MENU00407"/>		<%//콘텐츠등록관리 메뉴ID %><!-- 개발메뉴ID : MENU00407 -->
<c:set var="joinMenu" value="MENU00322"/>		<%//콘텐츠등록관리 메뉴ID %><!-- 개발메뉴ID : MENU00322 -->

<%//리턴URL 예외처리 %>
<c:set var="baseUrl" value="/mps" />

<%//에디터 선택 %>
<c:set var="editor" value="Daum" /><%//Daum, Namo 입력 %>

<%//파일업로드 선택 %>
<%-- <c:set var="fileUploadType" value="Uploadify" /> --%><%//Uploadify, Namo 입력 %>

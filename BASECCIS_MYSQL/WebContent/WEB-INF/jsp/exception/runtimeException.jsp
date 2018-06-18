<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<div class="error_txt">
	<span class="display_block"><img src="${contextPath}/resources/images/common/content/error.gif" alt="error 이용에 불편을 드려서 죄송합니다. 빠른시일 내에 현 페이지의 콘텐츠를 이용하실 수 있도록 노력하겠습니다." /></span>
	<button type="button" class="btn_colorType01" onclick="history.back(-1);">뒤로</button>
</div>

<!-- 운영시 삭제(태그로 보기로도 안보이도록 주석처리) -->
<div class="container">
	<div class="panel panel-danger">
	
		<div class="panel-heading">
			<div class="panel-title">
			<font color ="white"> ${url } -  ${exception.message}</font>
			</div>
		</div>
		
		<div class="panel-body">
        	<c:forEach items="${exception.stackTrace}" var="ste">    
        		<font color ="white">${ste}</font>
    		</c:forEach>
		</div>		
	</div>
</div>
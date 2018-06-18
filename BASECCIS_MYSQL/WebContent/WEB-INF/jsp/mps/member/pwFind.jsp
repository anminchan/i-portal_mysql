<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<div class="member_box">
	<i class="pw_creation"></i>
	<p class="point02">회원님의 임시비밀번호가 생성되었습니다.</p>
	<p class="user_pw"><strong><c:out value='${rtnUser.kName}'/></strong>님의 임시비밀번호는 <span class="point01_bold"><c:out value='${rtnUser.userPw}'/></span> 입니다.</p>
	<div class="btn_area">
		<a href="/" class="btn_type01">홈으로</a>
		<a href="${contextPath}/menu?menuId=${loginMenu }" class="btn_type02">로그인 페이지</a>
	</div>
</div>
<!-- //콘텐츠영역-->
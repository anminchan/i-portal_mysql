<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<div class="member_box">
	<i class="id_creation"></i>
	<p class="first_txt">회원님의 아이디를 알려드립니다.</p>
	<p>입력하신 정보와 일치하는 아이디는 아래와 같습니다.</p>
	<p class="user_id"><strong><c:out value='${rtnUser.kName}'/></strong>님의 아이디는 <span class="point01_bold"><c:out value='${rtnUser.userId}'/></span> 입니다.</p>
	<div class="btn_area">
		<a href="${contextPath}/menu?menuId=${loginMenu }" class="btn_type02">로그인</a>
		<a href="${contextPath}/menu?menuId=${pwSearchMenu }" class="btn_type01">비밀번호 찾기</a>
	</div>
</div>
<!-- //콘텐츠영역-->

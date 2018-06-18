<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 -->
<c:if test="${outNotice ne 'SUCCESS' and outNotice ne 'DELETE'}"> 
<div class="completion">
	<i class="congratulate"></i>
	<p> 통합사이트 회원가입을 축하드립니다.</p>
	<p>회원가입이 성공적으로 완료되었습니다.<br/>등록한 아이디로 로그인이 가능합니다.</p>
	<p>대표홈페이지 이외 서비스의 경우 회원정보수정 메뉴로 이동해 추가정보를 입력해 주시기 바랍니다.</p>
	<div class="btn_area">
		<a href="javascript:fnGoLoninForm();" class="btn_type02">로그인페이지 바로가기</a>
	</div>
</div>
</c:if>

<form id="loginGoForm" name="loginGoForm"  method="post" action="${contextPath }/mps/member/loginForm" method="post" >
	<input type="hidden" id="menuId" name="menuId" value="${loginMenu}" />
	<input type="hidden" id="idSynthUrl" name="userId" value="${userId}" />
	<input type="hidden" id="rtnUrl" name="rtnUrl" value="${contextPath}/mps" />
	<input type="hidden" name="siteKey" id="siteKey" value="${siteInfo.SITEKEY}" />
</form>	

<script type="text/javascript"> 

$(function() {
	
	if("${outNotice}" == "SUCESS" )
	{
		alert("이미 메일인증처리되어 있는 상태입니다. 로그인 페이지로 이동합니다. ");
		window.location.href="${contextPath}/mps/member/loginForm?menuId=${loginMenu }";

	}else if("${outNotice}" == "DELETE" ){

		alert("삭제된 인증메일입니다. 회원가입 혹은 ID통합을 다시 진행한 상태입니다.");
		window.location.href="${contextPath}/mps";
	}
	
});


function fnGoLoninForm()
{
	document.loginGoForm.submit();
}


</script>
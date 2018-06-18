<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<title>관리자 로그인</title>
<link type="image/x-icon" rel="shortcut icon" href="/images/favorite.ico" />
<link rel="stylesheet" href="${contextPath }/resources/css/ips/login.css"/>

<!-- 공통 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${contextPath }/resources/js/tooltipsy/tooltipsy.source.js"></script>
<script type="text/javascript" src="${contextPath }/resources/js/common.ccis.js" ></script>

<script type="text/javascript">
var gContextPath = "${contextPath }";
  
$(function() {
	<c:if test="${msgFlag eq 'Y'}">
		alert('${message}');
	</c:if>

	$('#btn_login').click(function() {
		if($('#userId').val() == ""){			
			alert('아이디를 입력하세요.');
			$("#userId").focus();
			return false;
		}
		if($('#userPwd').val() == ""){			
			alert('비밀번호를 입력하세요.');
			$("#userPwd").focus();
			return false;
		}
		
		//로그인 정보 저장한다고 선택할 경우
		if($('input[name=userId_cookie]').is(":checked")){
			saveLogin($("#userId").val());
		}else{
			saveLogin("");
		}
		
		$('#loginForm').submit();
	});
	
	getLogin(); // 로그인쿠키정보
	
});

// 로그인 정보 저장
function saveLogin(id){
	if(id != ""){
		//usrIde 쿠키에 id 값을 7일간 저장
		setCookie("cookieUserId",id,7);
	}else{
		//usrIde 쿠키 삭제
		setCookie("cookieUserId",id,-1);
	}
}

function getLogin(){
	//usrIde 쿠키에서 id값을 가져온다.
	var id = getCookie("cookieUserId");

	//가져온 쿠키값이 있으면
	if(id != ""){
		$("#userId").val(id);
		$("input[name=userId_cookie]").attr("checked", true); 
	}
	
	$("#userId").focus();
}

</script>
</head>
<body>
<div id="wrap">
	<h1 class="logo">ADMINISTRATOR <span>ACCOUNT</span></h1>
	<form action="${contextPath }/mgr/login" method="post" id="loginForm">
		<input name="rtnUrl" type="hidden" value="${rtnUrl }" />
		<p class="input_id">
			<label for="userId">USERNAME</label>
			<input type="text" name="userId" id="userId" placeholder="USERNAME" value="ccisadmin" />
		</p>
		<p class="input_pw">
			<label for="userPwd">PASSWORD</label>
			<input type="password" name="userPwd" id="userPwd" placeholder="Password" value="qwe123!@#"/>
		</p>
		<p class="btn_login">
			<input type="button" id="btn_login" name="btn_login" value="LOGIN"/>
		</p>
	</form>
	<footer>Copyright ⓒ 2017 by AROPA All right reserved.</footer>
</div>
</body>

</html>


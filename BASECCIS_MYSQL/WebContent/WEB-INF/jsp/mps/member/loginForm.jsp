<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 -->
<div class="member_box">
	<p class="member_info"><strong class="point02">포탈 홈페이지를 방문해 주셔서 감사합니다.</strong>
		서비스 이용을 위해 회원로그인 또는 임시본인인증을 해주시기 바랍니다.</p>	 
	<div class="tabMenu_area memberTab_area">
		<h2 class="tabmenu tab_individual"><a href="javascript:fnLoginTab('USER');" id="memberUser">회원로그인</a></h2>	 
		<div id="tabcontent01" class="tabcontent">
			<form action="${contextPath}/mps/member/login" method="post" id="loginForm" name="loginForm">
				<input name="menuId" id="menuId" type="hidden" value="${obj.menuId }" />
				<input name="siteId" id="siteId" type="hidden" value="${mySiteId }" />
				<input name="mySiteId" id="mySiteId" type="hidden" value="${mySiteId }" />
				<input name="rtnUrl" type="hidden" value="<c:out value='${rtnUrl }'/>" />
				<input name="kind" type="hidden" value="P" />	
				<!-- 비회원 인증 필요 param -->
				<input name="kName" id="kName" type="hidden" value="" />
				<div class="login_area">
					<div class="login_input">
						<p class="id"><input type="text" name="userId" id="userId" value="" placeholder="아이디" onblur="fnChangeFocus()"/></p>
						<p><input type="password" name="password" id="password" value="" placeholder="비밀번호" autocomplete="off"/></p>
					</div>
					<div class="btn_login"><input name="" id="btnLogin" type="button" value="로그인"></div>
				</div>
				<div class="graybox">
					<p>아이디 또는 비밀번호를 분실하셨을 경우 아래 링크를 통해 아이디와 비밀번호를 확인 하실 수 있습니다.</p>
					<p class="btn_area">
						<a href="${contextPath}/menu?menuId=${idSearchMenu }" class="btn_type02">아이디 찾기</a> <a href="${contextPath}/menu?menuId=${pwSearchMenu }" class="btn_type02">비밀번호 찾기</a>
					</p>					
				</div>
			</form>
		</div>
		<h2 class="tabmenu tab_company"><a href="javascript:fnLoginTab('GUEST');" id="memberGuest">임시본인인증</a></h2>	
		<div id="tabcontent02" class="tabcontent">
			<!-- 아이핀 인증Form -->
			<form name="reqCBAForm"  method="post">	
				<input type="hidden" name="menuId" value="${obj.menuId}"/>
				<input type="hidden" name="siteId" value="${obj.siteId}"/>
				<input type="hidden" name="reqInfo" value = "${reqInfoIpin }" />
    			<input type="hidden" name="retUrl" value = "${retUrlIpin }" />
			</form>			
			<!-- 휴대폰 인증Form -->
			<form name="reqPCCForm" method="post" action = "">	
				<input type="hidden" name="menuId" value="${obj.menuId}"/>
				<input type="hidden" name="siteId" value="${obj.siteId}"/>
				<input type="hidden" name="reqInfo" value = "${reqInfo }" />
			    <input type="hidden" name="retUrl" value = "${retUrl }" />
			</form>			
			<form action="${contextPath}/mps/member/loginNoUser" method="post" name="guestloginForm" id="guestloginForm">
				<input type="hidden" name="loginType" id="loginType" value="${loginType}">
				<input name="rtnUrl" id="rtnUrl" type="hidden" value="${rtnUrl}" />
				<input name="kind" type="hidden" value="P" />		
				<!-- 비회원 인증 필요 param -->
				<input type="hidden" id="certification" name="certification" value=""/>
				<input type="hidden" id="dkey" name="dkey" value="" />	
				<input type="hidden" id="birthDate" name="birthDate" value="" />
				<input type="hidden" id="gender" name="gender" value="" />
				<input type="hidden" id="kName" name="kName" value="" />		
			</form>			
			<!-- 비회원로그인 -->
			<!-- <ul class="certify_area">
				<li><strong>휴대폰 본인인증</strong>
					<p class="txt">본인명의로 가입된 이동전화(휴대폰)를 통해 본인임을<br/> 확인할 수 있는 인증수단입니다.</p>
					<p class="tel">콜센터 : 1577-1006</p>
					<a href="javascript:fnChkCertifyOpen('H');" class="btn_type02">인증하기</a>
					<i class="fa"></i>
				</li>
				<li><strong>공공아이핀(I-PIN) 인증</strong> 
					<p class="txt">인터넷상의 개인식별번호를 의미하며,<br/> 주민등록번호 없이 본인임을 확인할 수 있는 수단입니다.</p>
					<p class="tel">콜센터 : 1577-1006</p>
					<a href="javascript:fnChkCertifyOpen('G');" class="btn_type02">인증하기</a>
					<i class="fa"></i>
				</li>	
			</ul> -->
			<!-- //비회원로그인 -->
		</div>
	</div>	
	<%-- <p class="join_txt">포탈홈페이지의 <span class="txt_bold">회원으로 가입</span>하시면 다양한 서비스를 편리하게 이용하실 수 있습니다. <a href="/mps/member/confirm?menuId=${joinMenu }" class="btn_type02">회원가입</a></p> --%>	
	<p class="join_txt">포탈홈페이지의 <span class="txt_bold">회원으로 가입</span>하시면 다양한 서비스를 편리하게 이용하실 수 있습니다. <a href="/mps/member/joinForm?menuId=${joinMenu }" class="btn_type02">회원가입</a></p>
	<div id ="dialog" class="selector" style="display: none;"></div>
</div>
<!-- //콘텐츠영역-->

<script type="text/javascript">
$(function() {
	$("#memberUser").prop('class', 'on');

	$('#btnLogin').click(function(){
		$("#loginForm").submit();
	});
	
	$("#password").on("keyup", function(event){
		if(event.keyCode == 13){
			$("#loginForm").submit();
		}
	});
	
	$('#loginForm').submit(function() {		
		if($('#dkey').val() == ""){
			if($('#userId').val() == ""){			
				alert('아이디를 입력하세요.');
				$("#userId").focus();
				return false;
			}
	
			if($('#password').val() == ""){			
				alert('비밀번호를 입력하세요.');
				$("#password").focus();
				return false;
			}
		}
	});	
	
	getLogin();
});

function fnLoginTab(gubun){
	if(gubun == 'USER'){
		$("#memberGuest").removeClass('on');
		$("#memberUser").prop('class', 'on');
		
		$("#tabcontent02").hide();
		$("#tabcontent01").show(); 

	}else{
		$("#memberUser").removeClass('on');
		$("#memberGuest").prop('class', 'on');
		
		$("#tabcontent02").show();
		$("#tabcontent01").hide();
	}
}

function fnChangeFocus(){
	$("#password").focus();
}

function fnChkCertifyOpen(mode){
	
	if(mode == 'G') {
		// 아이핀 팝업페이지를 띄웁니다.
		 CBA_window = window.open('', 'IPINWindow', 'width=450, height=500, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

	        if(CBA_window == null){ 
				alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
	        }

			document.reqCBAForm.action = 'https://ipin.siren24.com/i-PIN/jsp/ipin_j10.jsp';
	        document.reqCBAForm.target = 'IPINWindow';
			document.reqCBAForm.submit(); 
			
	}else if(mode == 'H'){
		//alert("휴대폰 본인인증 준비중입니다.");
		var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

        if(PCC_window == null){ 
			 alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
        }

        document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
        document.reqPCCForm.target = 'PCCV3Window';
        document.reqPCCForm.submit();
	}
}

// 본인인증 결과 값 세팅 및 다음단계 이동
function fnSetCertifyCheck(KName, dkey, birthDate, certification, gender){
	
	document.guestloginForm.certification.value = certification;
	document.guestloginForm.dkey.value = dkey;
	document.guestloginForm.birthDate.value = birthDate;
	document.guestloginForm.gender.value = gender;
	document.guestloginForm.kName.value = KName;
	document.guestloginForm.submit();
}

//인증 실패시
function fnSetCertifyFail(message){
	alert("인증 실패::Code::"+errorCode+"::"+message);
}

</script>
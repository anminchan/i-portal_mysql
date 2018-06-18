<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- 아이핀 인증Form -->
<form name="reqCBAForm"  method="post"action = "">		
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

<form name="confirmForm"  method="post" action="${contextPath }/mps/member/joinForm" method="post" >	
	<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
	<input type="hidden" id="siteId" name="siteId" value="${obj.siteId}"/>
	<input type="hidden" id="kind" name="kind" value="P" />
	
	<input type="hidden" id="certification" name="certification" value=""/>
	<input type="hidden" id="dkey" name="dkey" value="" />	
	<input type="hidden" id="birthDate" name="birthDate" value="" />
	<input type="hidden" id="gender" name="gender" value="" />
	<input type="hidden" id="KName" name="KName" value="" />
	<input type="hidden" id="foreignerCd" name="foreignerCd" value="${obj.foreignerCd}" />
	<input type="hidden" id="fourteenType" name="fourteenType" value="${obj.fourteenType}" />
	<input type="hidden" name="siteKey" id="siteKey" value="${siteInfo.SITEKEY}" />
</form>
<input type="hidden" id="dupinfo" name="dupinfo" />

<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
<input type="hidden" id="kind" name="kind" value="P" />

<p class="member_info"><strong> 홈페이지를 방문해 주셔서 감사합니다.</strong>
회원님이 더욱 편리하게 이용하실 수 있도록 의 각 홈페이지가 새롭게 개편되었습니다</p>
<p class="graybox reorganize_info"><strong>개편된 사이트를 대상으로 회원 여러분의 보다 편리한 이용을 위하여 회원정보를 통합하였습니다.</strong>
	각 사이트를 방문할 때마다 매번 로그인을 해야하던 불편함 대신 한번의 로그인으로 개편된 모든 사이트와 서비스를 간편하게 이용하실 수 있습니다.<br/>
	은 앞으로도 회원님의 개인정보를 안전하게 보호할 것을 약속 드립니다.</p>

<h2 class="depth1_title02">본인확인</h2>
<p>아래 아이핀인증 또는 휴대폰 본인인증을 통해 회원가입을 하실 수 있습니다.</p>
<ul class="certify_area border_box">
	<li><strong>휴대폰 본인인증</strong>
		<p class="txt">본인명의로 가입된 이동전화(휴대폰)를 통해 본인임을<br/> 확인할 수 있는 인증수단입니다.</p>
		<p class="tel">콜센터 : 1577-1006</p>
		<a href="javascript:fnChkCertifyOpen('H');" class="btn_type01">인증하기</a>
		<i class="fa"></i>
	</li>
	<li><strong>공공아이핀(I-PIN) 인증</strong> 
		<p class="txt">인터넷상의 개인식별번호를 의미하며,<br/> 주민등록번호 없이 본인임을 확인할 수 있는 수단입니다.</p>
		<p class="tel">콜센터 : 02-818-3050</p>
		<a href="javascript:fnChkCertifyOpen('G');" class="btn_type01">인증하기</a>
		<i class="fa"></i>
	</li>	
</ul>

<script type="text/javascript">
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
		
		//fnSetCertifyCheck('김팔공','MC0GCCqGSIb3DQIJAyEAkhquYY7+/B/ckDDLNfLS42S+nqdGxIR7DZQa6Hv+G36','731204','G', 'M');  // 테스트
		
	}else if(mode == 'H'){
		//alert("휴대폰 본인인증 준비중입니다.");
 		var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

        if(PCC_window == null){ 
			 alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
        }

        document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
        document.reqPCCForm.target = 'PCCV3Window';
        document.reqPCCForm.submit(); 
        
		//fnSetCertifyCheck('김팔공','MC0GCCqGSIb3DQIJAyEAkhquYY7+/B/ckDDLNfLS42S+nqdGxIR7DZQa6Hv+G37','731204','G', 'M');  // 테스트
	}
}

// 본인인증 결과 값 세팅 및 다음단계 이동
function fnSetCertifyCheck(KName, dkey, birthDate, certification, gender){

	var rtn = fnDkeyCheck();
 	if(rtn == 'Fail')
 	{
 		alert(KName+"님은 이미 개인회원으로 가입되어 있습니다.");
 		$(location).attr('href','${contextPath}/menu?menuId=${loginMenu}');//로그인 페이지 이동
 	}else{
 		
 		document.confirmForm.certification.value = certification;
 		//document.confirmForm.dkey.value = dkey;
 		document.confirmForm.birthDate.value = birthDate;
 		document.confirmForm.gender.value = gender;
 		document.confirmForm.KName.value = KName;
 		
 		document.confirmForm.submit();
 	}
}

function fnDkeyCheck(){
	var returnV = "";		
	$.ajax({
 		url: gContextPath+"/mps/memberSearch/idSearch",
 		data: {'dkey' : '', 'kind' : 'P', 'schType' : '0'}, //schType : 0(Dkey 체크)
 		async: false,
 		cache: false,
 		success:function(data, textStatus, jqXHR) {
			if(data != ""){
					returnV = "Fail"; 
			}else{
				returnV = "Sucess";
			}
 		}
 	});
	
	return returnV;
}

//인증 실패시
function fnSetCertifyFail(message){
	alert("인증 실패::Code::"+errorCode+"::"+message);
}

</script>

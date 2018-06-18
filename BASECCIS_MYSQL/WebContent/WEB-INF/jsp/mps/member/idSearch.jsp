<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- 휴대폰 인증Form -->
<form name="reqPCCForm" method="post" action = "">	
	<input type="hidden" name="menuId" value="${obj.menuId}"/>
	<input type="hidden" name="siteId" value="${obj.siteId}"/>
	<input type="hidden" name="reqInfo" value = "${reqInfo }" />
    <input type="hidden" name="retUrl" value = "${retUrl }" />
</form>

<!-- 아이핀 인증Form -->
<form name="reqCBAForm"  method="post"action = "">		
	<input type="hidden" name="menuId" value="${obj.menuId}"/>
	<input type="hidden" name="siteId" value="${obj.siteId}"/>
	<input type="hidden" name="reqInfo" value = "${reqInfoIpin }" />
    <input type="hidden" name="retUrl" value = "${retUrlIpin }" />
</form>

<form action="${contextPath}/mps/memberSearch/idFind" id="memberIdFindForm" name="memberIdFindForm">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="userId" name="userId" value="" />
	<input type="hidden" id="kName" name="kName" value="" />
	<input type="hidden" id="email" name="email" value="" />
</form>

<div class="member_box">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="kind" name="kind" value="P" />
	<p class="member_info"><strong class="point02">아이디가 생각나지 않으세요?</strong>
		공공I-Pin인증 또는 실명인증(휴대폰인증)을 통해 본인 확인 후 아이디를 안내해드립니다. </p>
	<ul class="certify_area">
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
	</ul>
</div>
<div id ="dialog" class="selector" style="display: none;"></div>
<script type="text/javascript">


// 인증 팝업
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
		
		//fnSetCertifyCheck('김팔공','MC0GCCqGSIb3DQIJAyEAkhquYY7+/B/ckDDLNfLS42S+nqdGxIR7DZQa6Hv+G37','731204','G', 'M');  // 테스트

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

// 인증 완료시 처리
function fnSetCertifyCheck(KName, dkey, birthDate, certification, gender){
	$.ajax({
 		url: gContextPath+"/mps/memberSearch/idSearch",
 		data: {'dkey' : dkey, 'kind' : 'P', 'schType' : '1'}, //schType : 1(ID찾기)
 		async: false,
 		cache: false,
 		success:function(data, textStatus, jqXHR) {
			if(data != ""){			
				document.memberIdFindForm.userId.value = data.userId;
				document.memberIdFindForm.kName.value = data.kName;
				$("#memberIdFindForm").submit();
			}else{
				alert("입력하신 정보로 일치하는 아이디가 존재하지 않습니다.");
			}
 		}
 	});	
}

//인증 실패시
function fnSetCertifyFail(message){
	alert("인증 실패::"+message);
}


//input 숫자 입력 체크
function fnNumCheck(id){
	$("#"+id).keyup(function(e){
		if($("#"+id).val().match(/[^0-9]/g) != null){
			alert("숫자만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
	});
}


</script>
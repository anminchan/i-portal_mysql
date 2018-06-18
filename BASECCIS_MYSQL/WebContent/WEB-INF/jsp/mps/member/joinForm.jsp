<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<div class="member_info txt_left">
	<strong class="black_txt"> 홈페이지를 방문해 주셔서 감사합니다.</strong>
	<ul class="line_lstyle">
		<li>홈페이지 회원이 되시면 다양한 서비스를 편리하게 이용하실 수 있습니다.</li>
		<li>입력하신 개인정보는 "개인정보보호법"에 따라 보호됩니다.</li>
	</ul>
</div>
<form id="insertPersonForm" name="insertPersonForm" action="${contextPath }/mps/member/personAction" method="post" >	
	<input type="hidden" id="kind" name="kind" value="P"/>	
	<input type="hidden" id="certification" name="certification" value="<c:out value='${certification}'/>"/>
	<input type="hidden" id="dkey" name="dkey" value="<c:out value='${dkey}'/>" />	
	<input type="hidden" id="birthDate" name="birthDate" value="<c:out value='${birthDate}'/>" />
	<%-- <input type="hidden" id="KName" name="KName" value="<c:out value='${KName}'/>" /> --%>
	<input type="hidden" id="inCondition" name="inCondition" value="입력"/>
	<input type="hidden" id="passwordTime" name="passwordTime" value=""  />
	<input type="hidden" id="withDrawTime" name="withDrawTime" value=""  />
	<input type="hidden" id="joinSiteID" name="joinSiteID" value="${obj.siteId}"/>
	<input type="hidden" id="joinDate" name="joinDate" value=""/>
	<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
	<input type="hidden" id="state" name="state" value="T"/>
	<input type="hidden" id="doubleChk" name="doubleChk" value="N"/>
	<input type="hidden" name="siteKey" id="siteKey" value="${siteInfo.SITEKEY}" />
	<input type="hidden" id="message" name="message" value="${message}" />
	<input type="hidden" id="reJoinYn" name="reJoinYn" value="Y" />
	
	<fieldset>
		<legend>회원정보 기본정보 입력</legend>
		<div class="float_wrap02">
			<h2 class="depth1_title float_left">기본정보</h2> 
			<p class="float_right"><span class="point01">*</span> 필수 항목 입니다.</p>
		</div>
		<table class="tstyle_view linenone_table">
			<caption>
			사용자 ID, 비밀번호, 비밀번호 확인, 생년원일, 성별, 휴대폰, 소속에 대한 정보입력
			</caption>
			<colgroup>
				<col width="140">
				<col width="140">
				<col width="140">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="point01">*</span> 이름</th>
					<td colspan="3"><input type="text" id="KName" name="KName" value="<c:out value='${KName}'/>" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="userId">ID</label></th>
					<td colspan="3">
					<input type="text" id="userId" name="userId" class="input_small" value="" onkeyup="fnIdkeyup();"/>
					<button type="button" id="btnIdcheck" class="input_smallBlack" >중복확인</button>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="password">비밀번호</label></th>
					<td colspan="3"><p class="block_smallTxt">비밀번호는 9~32자의 영문, 숫자, 특수문자를 혼합해서 사용하실 수 있습니다.</p>
						<input type="password" name="password" id="password" class="input_small" autocomplete="off" onkeyup="javascript:fnCheckPw()"/>
						<button type="button" id="input_pwcheck" class="input_smallBlack">비밀번호 생성규칙 자세히 보기</button>
						<p id="checkPwMsg" id="checkPwMsg" class="point_smallTxt"></p>
						</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span>
						<label for="password_ok">비밀번호 확인</label></th>
					<td colspan="3"><p class="block_smallTxt">재확인을 위해서 입력하신 비밀번호를 다시 한번 입력해 주세요.</p>
						<input type="password" name="passwd2" id="password_ok" class="input_small" autocomplete="off" onkeyup="javascript:fnCheckConf()" />
						<p id="checkconfMsg" id="checkconfMsg" class="point_smallTxt"></p>
					</td>						
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="hp1">휴대폰</label></th>
					<td colspan="3">
					<input type="hidden" id="cellPhone" name="cellPhone" value="" />
						<select name="cellPhone1" id="cellPhone1" title="국번">
							<option value="" >선택</option>
							<option value="010" >010</option>
							<option value="011" >011</option>
							<option value="016" >016</option>
							<option value="017" >017</option>
							<option value="018" >018</option>
							<option value="019" >019</option>
						</select> - 
						<input type="text" name="cellPhone2" value="" size="4" maxlength="4" id="cellPhone2" title="휴대폰번호 가운데 3~4자리 입력" onkeyup="validateOnlyNumber(this)" style="ime-mode:disabled"/> -
						<input type="text" name="cellPhone3" value="" size="4" maxlength="4" id="cellPhone3" title="휴대폰번호 마지막 4자리 입력" onkeyup="validateOnlyNumber(this)" style="ime-mode:disabled"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span>
						<label for="email">이메일</label></th>
					<td colspan="3"><input type="hidden" id="email" name="email" />
						<input type="text" name="email_id" id="email_id" value="" onkeyup="validateCheckSpecialChar(this)" title="기본 이메일 주소"  />
						@
						<input type="text" name="mail_dom" id="mail_dom" value="" onkeyup="validateCheckSpecialChar(this)" title="끝 이메일 주소" />
						<select name="mail_select" id="mail_select" title="도메인 선택" onchange="fnMailSelect()">
							<option value="">직접입력</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="empal.com">empal.com</option>
							<option value="naver.com">naver.com</option>
							<option value="dreamwiz.com">dreamwiz.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="daum.net">daum.net</option>
							<option value="freechal.com">freechal.com</option>
							<option value="paran.com">paran.com</option>
							<option value="hitel.net">hitel.net</option>
							<option value="hanmir.com">hanmir.com</option>
							<option value="netian.com">netian.com</option>
							<option value="lycos.co.kr">lycos.co.kr</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="chillian.net">chillian.net</option>
							<option value="korea.com">korea.com</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="unitel.co.kr">unitel.co.kr</option>
							<option value="nownuri.net">nownuri.net</option>
							<option value="hanafos.com">hanafos.com</option>
							<option value="kornet.net">kornet.net</option>
							
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>
	
</form>
<div id ="dialog" class="selector" style="display: none;"></div>
<div class="btn_area_center ">
	<c:set var="siteUrl" value="mps"/>
	<a href="${contextPath}/mps" class="btn_type01">취소</a>
	<button type="button" id="btnSave" class="btn_type02">다음</button> 
</div>
<!-- //콘텐츠영역-->

<script type="text/javascript">        
$(function() {
	$('#btnSave').click(function(){
		var chlen1 = $("input:radio[name='agree1']:checked").val();
		var chlen2 = $("input:radio[name='agree2']:checked").val();
		
		/* if (chlen1 != 'Y'){
			alert("이용약관에 동의해 주세요 ");
			return;
		}
		if (chlen2 != 'Y'){
			alert("개인정보 수집·이용 안내에 동의해 주세요");
			return;
		} */
 		if($("#userId").val().length <= 0) {
	      	 alert("ID를 입력하세요");
	       	$("#userId").focus();
	       	return false;
	    }
		/* if($("#doubleChk").val()=='N'){
			 alert("아이디 중복체크를 확인하세요!");
			 return false;
		} */
		
		var pwv = $("#password").val();
		var pw_ok = $("#password_ok").val();
		
		if(!pwv){
            alert("비밀번호를 입력하세요!");
            $("#password").focus();
           return;
        }
		if(!pw_ok){
            alert("비밀번호 확인번호를 입력하세요!");
            $("#password_ok").focus();
           return;
        }
		if(pwv != pw_ok){
			alert("입력하신 비밀번호와 비밀번호 확인번호와  일치하지 않습니다.\n 다시 확인하시고 입력하여 주십시오.");
			$("#password_ok").val("");
			$("#password_ok").focus();
			return;
		}	
		
		if(!checkPass(pw_ok)){
    		alert("비밀번호는 영문/숫자/특수문자 혼합 9~32자의 조합된 문자열이어야 합니다!");
    		$("#password").focus();
    		return;
    	} 				
 		if($.trim($("#cellPhone1").val()).length < 3 || $.trim($("#cellPhone2").val()).length < 3 || $.trim($("#cellPhone3").val()).length < 4) {
			alert("휴대폰 번호를 입력하지 않았거나 자리수가 틀립니다.휴대폰번호를 입력하세요");
			$("#cellPhone1").focus();
			return false;
		}
		
   		//휴대폰 처리
   	    $("#cellPhone").val($.trim($("#cellPhone1").val())+"-"+$.trim($("#cellPhone2").val())+"-"+$.trim($("#cellPhone3").val()));

   		if($.trim($("#email_id").val()).length < 3 || $.trim($("#mail_dom").val()).length < 3) {
			alert("이메일을 입력하세요.");
			$("#email_id").focus();
			return false;
		}   		
   		
   		//이메일 처리
		$("#email").val( $.trim($("#email_id").val())+"@"+$.trim($("#mail_dom").val()) );
   		
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		  
		if(regex.test($("#email").val()) === false) {  
		    alert("잘못된 이메일 형식입니다."); 
		    $("#mail_dom").focus();
		    return false;  
		}
   		
   	    if(!confirm("ID를 ["+$("#userId").val()+"]로 등록하시겠습니까?")) {
 			return false;
 		}
   	    
    	$('#insertPersonForm').submit();
	});
   	
	//현재일셋팅
   	$('#joinDate').val($.datepicker.formatDate('yymmdd', new Date()));
   	$('#passwordTime').val($.datepicker.formatDate('yymmdd', new Date()));
   	$('#withDrawTime').val($.datepicker.formatDate('yymmdd', new Date()));
    	
	$("#input_pwcheck").click(function(){
		window.open("/includes/password.jsp","pop","width=850,height=390,scrollbars=no,resizable=no");
	});
	
	$("#btnIdcheck").click(function(){
		if($.trim($("#userId").val()).length <= 0) {
			alert("ID를 입력하세요");
			$("#userId").focus();
			return false;
		}   		   		
   		
		$.ajax({
	 		url: gContextPath+"/mps/member/idSearch",
	 		data: {'userId' : $("#userId").val(), 'kind' : 'P', 'schType' : '3'}, //schType : 3(ID찾기)
	 		async: false,
	 		success:function(data, textStatus, jqXHR) {
				if(data != ""){
					if(data.userCnt == 0){
						alert("입력하신  아이디로 등록할 수 있습니다.");
						$("#doubleChk").val('Y');
					}else{
						alert("입력하신 아이디와 중복되는 아이디가 존재합니다.");
						$("#doubleChk").val('N');
					}
				}
	 		}
	 	});
	});
	
 });

//이메일(아이디)입력창에서 onkeyup이 발생했을때 중복체크 플래그를 초기화한다.
function fnIdkeyup(){
	$("#doubleChk").val("N");
}

//아이디 메일 선택이  기타일 경우 기타텍스트박스 활성화
function fnMailSelect()
{
	
	var selectV = $("#mail_select").val();
	if(selectV == '')
	{
		$('#mail_dom').removeAttr("disabled");
		$("#mail_dom").val(selectV);
		$("#mail_dom").focus();
		 
	}else if(selectV == ' '){
		
	}else{
		
		$("#mail_dom").attr("disabled", "disabled");
		$("#mail_dom").val(selectV);
	}
}

function checkPass(pwv){
	var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var number = "1234567890";
	var sChar = "-_=+\|()*&^%$#@!~`?></;,.:'";	

	var sChar_Count = 0;
	var alphaCheck = false;
	var numberCheck = false;

	var returnBoolean = false;

	for(var i=0; i<pwv.length; i++){
		if(sChar.indexOf(pwv.charAt(i)) != -1){
			sChar_Count++;
		}
		if(alpha.indexOf(pwv.charAt(i)) != -1){
			alphaCheck = true;
		}
		if(number.indexOf(pwv.charAt(i)) != -1){
			numberCheck = true;
		}
	}

	if(sChar_Count > 0 && alphaCheck && numberCheck){
		if ( pwv.length < 9 ){
			returnBoolean = false;
		}else if(pwv.length > 32){
			returnBoolean = false;
		}else{
			returnBoolean = true;
		}
	}
	
	return returnBoolean;
}

function fnCheckPw(){
	var pwv = $("#password").val();
	var massage = "";
	
	if(!checkPass(pwv)){
		massage ="9~32자의 영문/숫자/특수문자가 조합된 문자열이어야 합니다." ;
	}else{
		massage ="사용가능한 비밀번호입니다";
	}

	$('#checkPwMsg').text(massage);
}	
	
function fnCheckConf(){
	var pwv = $("#password").val();
	var pw_ok = $("#password_ok").val();
	var massage = "비밀번호와 비밀번호 확인번호가 일치합니다.";

	if(pwv != pw_ok){
		massage ="비밀번호와 비밀번호 확인번호가 일치하지 않습니다.";
	}		
	
	$('#checkconfMsg').text(massage);
}	

</script>

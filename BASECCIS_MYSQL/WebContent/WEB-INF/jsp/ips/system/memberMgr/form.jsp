<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/memberMgr/userAction" method="post" role="form">	
<input type="hidden" id="menuId" name="menuId" value="${obj.menuId }"/>
<input type="hidden" id="kind" name="kind" value="${obj.kind }"/>
<input type="hidden" id="state" name="state" value="T"/>
<input type="hidden" id="certification" name="certification" value=""/>
<input type="hidden" id="joinSiteID" name="joinSiteID" value="SITE00001"/>
<input type="hidden" id="joinDate" name="joinDate" value=""/>
<input type="hidden" id="mailReceive" name="mailReceive" value=""/> 
<input type="hidden" id="interest" name="interest" value=""/>
<input type="hidden" id="doubleChk" name="doubleChk" value="N"/>
<input type="hidden" id="passwordTime" name="passwordTime" value=""  />
<input type="hidden" id="withDrawTime" name="withDrawTime" value=""  />
<input type="hidden" id="inCondition" name="inCondition" value="입력"/>
<input type="hidden" id="mailCertiYn" name="mailCertiYn" value="Y" />

<input type="hidden" id="mailing" name="mailing" value="N"/>

<input type="hidden" id="newsLetter" name="newsLetter" value="N"/>
<input type="hidden" id="newsLetterGubun" name="newsLetterGubun" value=""/>
<input type="hidden" id="httYn" name="httYn" value="N"/>

<input type="hidden" name="ZIPGUBUN" id="ZIPGUBUN" value="" />	

<!-- 검색파라메타 -->
<input type="hidden" id="siteId" name="siteId" value="${obj.siteId}"/>
<input type="hidden" id="schStartDate" name="schStartDate" value="${obj.schStartDate}"/>
<input type="hidden" id="schEndDate" name="schEndDate" value="${obj.schEndDate}"/>
<input type="hidden" id="schText" name="schText" value="${obj.schText}"/>
<input type="hidden" id="schType" name="schType" value="${obj.schType}"/>

<fieldset>
	<legend>회원정보 입력</legend>
	<h2 class="depth2_title">기본정보</h2>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	
	<div class="table">
	<c:if test="${obj.kind == 'P' or obj.kind == 'K' }">
	<table class="tstyle_view">
		<caption>
		사용자 이메일(ID), 비밀번호, 비밀번호 확인, 생년원일, 성별, 휴대폰, 소속에 대한 정보입력
		</caption>
		<colgroup>
			<col width="140">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="point01">*</span> 이름</th>
				<td><input type="text" id="KName" name="KName" maxlength="30" value=""/></td>
			</tr>
				<tr>
				<th scope="row"><span class="point01">*</span> <label for="email_id2">이메일(ID)</label></th>
				<td><p class="block_smallTxt">이메일 인증을 위해 정확한 이메일 주소를 입력해주세요</p>
					<input type="hidden" id="userId" name="userId" value=""/>
					<input type="text" name="email_id" id="email_id" title="기본 이메일 주소" maxlength="30" onkeyup="fnIdkeyup();" /> @
					<input type="text" name="mail_dom" id="mail_dom" title="끝 이메일 주소" maxlength="30" onkeyup="fnIdkeyup();" />
					<select name="mail_select" id="mail_select" title="도메인 선택" onchange="fnMailSelect()">
						<option value="" selected="selected">직접입력</option>
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
					<button type="button" id="btnIdcheck" class="btn btn_basic" >중복확인</button>
			</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="password">비밀번호</label></th>
				<td><p class="block_smallTxt">비밀번호는 8~32자의 영문, 숫자, 특수문자를 혼합해서 사용하실 수 있습니다.</p>
					<input type="password" name="password" id="password" class="input_small"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span>
					<label for="password_ok">비밀번호 확인</label></th>
				<td><p class="block_smallTxt">재확인을 위해서 입력하신 비밀번호를 다시 한번 입력해 주세요.</p>
					<input type="password" name="passwd2" id="password_ok" class="input_small"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span>
					<label for="birth_year2">생년월일</label></th>
				<td>
					<input type="text" id="birthDate" value=""  name="birthDate" title="생년월일" />
					<input type="radio" id="solarY" name="solarYn" value="Y" checked>
					<label for="Y">양력</label> 
					<input type="radio" id="solarN" name="solarYn" value="N">
					<label for="N">음력</label>
				</td>
			</tr>
			<tr>
				<th scope="row">성별</th>
				<td>
					<input type="radio" id="genderY" name="gender" value="M" checked>
					<label for="genderY">남성</label> 
					<input type="radio" id="genderN" name="gender" value="F">
					<label for="genderN">여성</label>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="hp1">휴대폰</label></th>
				<td>
				<input type="hidden" id="cellPhone" name="cellPhone" value="" />
					<input type="tel" name="cellPhone1" size="4" maxlength="3" id="cellPhone1" title="휴대폰번호 앞 3자리 입력" onkeyup="validateOnlyNumber(this)"/>  -
					<input type="tel" name="cellPhone2" size="4" maxlength="4" id="cellPhone2" title="휴대폰번호 가운데 3~4자리 입력" onkeyup="validateOnlyNumber(this)" /> -
					<input type="tel" name="cellPhone3" size="4" maxlength="4" id="cellPhone3" title="휴대폰번호 마지막 4자리 입력" onkeyup="validateOnlyNumber(this)"/>
				</td>
			</tr>
			<tr>
				<th scope="row">소속</th>
				<td>
					<select id="belong" name="belong" onchange="fnBelongSelect()">
                  		<option>선택</option>
               		</select>              		    
           		    <input id="etcBelong" name="etcBelong" type="text" value="" title="소속기관명 입력" maxlength="50">			
				</td>
			</tr>
		</tbody>
	</table>
	</c:if>
	
	<c:if test="${obj.kind == 'C' }">
	<table class="tstyle_view">
		<caption>
		사용자 이메일(ID), 비밀번호, 비밀번호 확인, 생년원일, 성별, 휴대폰, 소속에 대한 정보입력
		</caption>
		<colgroup>
			<col width="140">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="point01">*</span> 사업자등록번호</th>
				<td>
				<input type="hidden" id="corpRegno" name="corpRegno" />
				<input type="number" id="regno1" value="" title="사업자번호 앞자리" size="1" maxlength="3" onkeyup="validateOnlyNumber(this)"/>-
				<input type="number" id="regno2" value="" title="사업자번호 가운데자리" size="1"  maxlength="2" onkeyup="validateOnlyNumber(this)"/>-
				<input type="number" id="regno3" value="" title="사업자번호 마지막자리" size="3" maxlength="5" onkeyup="validateOnlyNumber(this)"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="email_id">대표이메일(ID)</label></th>
				<td><p class="block_smallTxt">이메일 인증을 위해 정확한 이메일 주소를 입력해주세요</p>
					<input type="hidden" id="userId" name="userId" value=""/>
					<input type="text" name="email_id" id="email_id" maxlength="30" title="기본 이메일 주소" onkeyup="fnIdkeyup();" /> @
					<input type="text" name="mail_dom" id="mail_dom" maxlength="30" title="도메인 주소" onkeyup="fnIdkeyup();" />
					<select name="mail_select" id="mail_select" title="도메인 선택" onchange="fnMailSelect()">
						<option value="" selected="selected">직접입력</option>
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
					<button type="button" id="btnIdcheck" class="btn btn_type02" >중복확인</button>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="">회사명</label></th>
				<td><input type="text" name="KName" id="KName" value="" class="input_small" maxlength="50" title="대표자명 입력"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="password">비밀번호</label></th>
				<td><p class="block_smallTxt">비밀번호는 8~32자의 영문, 숫자, 특수문자를 혼합해서 사용하실 수 있습니다.</p>
				<input type="password" name="password" id="password" class="input_small"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span>
					<label for="password_ok">비밀번호 확인</label></th>
				<td><p class="block_smallTxt">재확인을 위해서 입력하신 비밀번호를 다시 한번 입력해 주세요.</p>
					<input type="password" name="passwd2" id="password_ok" class="input_small"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="">대표자명</label></th>
				<td><input type="text" name="ceoName" id="ceoName" value="" maxlength="30" title="대표자명 입력"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="">사업자형태</label></th>
				<td>
					<input type="radio" id="corpTypeY" name="corpType" value="C" checked >
					<label for="C">법인사업자</label> 
					<input type="radio" id="corpTypeN" name="corpType" value="P">
					<label for="P">개인사업자</label>
				</td>
			</tr>				
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="">전화번호</label></th>
				<td>
					<input type="hidden" id="corpPhone" name="corpPhone" value="" />
	               	<select id="areaCode1">
    	               	<option>선택</option>
                	</select>
           	    	<input type="text" id="phone1" value="" disabled="disabled" style="width:50px; " />-
               		<input type="text" id="phone2" value="" style="width:50px;" maxlength="4" />-
               		<input type="text" id="phone3" value="" style="width:50px;" maxlength="4" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="">팩스</label></th>
				<td>
				<input type="hidden" id="corpFax" name="corpFax" />
					<select id="areaCode2">
		       			<option>선택</option>
		        	</select>
		              
	               <input type="text" id="fax1" value="" disabled="disabled" style="width:50px; " />-
	                <input type="text" id="fax2" value="" style="width:50px;" maxlength="4" />-
	                <input type="text" id="fax3" value="" style="width:50px;" maxlength="4" />
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="">주소</label></th>
				<td>
					<input type="hidden" id="corpZipCode" name="corpZipCode" />
					<input type="hidden" id="corpAddress1" name="corpAddress1" />
					<input type="hidden" id="corpAddress2" name="corpAddress2" />
               		<input type="text" id="zipcode1" value="" title="우편번호1" style="width:60px;" />
               		<button type="button" id="btnIdcheck" class="btn btn_type02" onclick="javascript:fnPostSearch('zipCode1','zipCode2','newAddr1','newAddr2');">주소찾기</button>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="newAddr1">기본주소</label></th>
				<td colspan="3"><input type="text" id="newAddr1" name="newAddr1" value="" class="input_long" title="기본주소" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="newAddr2">상세주소</label></th>
				<td colspan="3"><input type="text" id="newAddr2" name="newAddr2" value="" class="input_long" title="상세주소" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="">홈페이지</label></th>
				<td>http:// <input type="text" id="homepageTail" name="homepageTail" value=""  title="홈페이지 URL 입력" class="input_long"/>
				<input type="hidden" id="homepage" name="homepage"/></td>
			</tr>
		</tbody>
	</table>
	
	<h2 class="depth2_title">담당자정보</h2>
	<table class="tstyle_view">
		<caption>
		담당자 이름, 이메일, 전화번호, 휴대폰, 부서명 입력
		</caption>			
		<colgroup>
			<col width="140">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="">이름</label></th>
				<td><input type="text" name="chargeName" maxlength="30" id="chargeName" value="" title="담당자 이름 입력"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="email_id2">이메일</label></th>
				<td>
				    <input type="hidden" id="chargeEmail" name="chargeEmail" />
					<input type="text" name="email_id2" id="email_id2" value="" title="기본 이메일 주소"  /> @
					<input type="text" name="mail_dom2" id="mail_dom2" value="" title="끝 이메일 주소" />
					<select name="mail_select2" id="mail_select2" title="도메인 선택" onchange="fnMailSelect2()">
						<option value=" " selected="selected">선택</option>
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
						<option value="">직접입력</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="">전화번호</label></th>
				<td>
					<input type="hidden" id="chargePhone" name="chargePhone" value="" />
	             	<select id="areaCode3">
    	               	<option>선택</option>
                	</select>
           	    	<input type="text" id="charPhone1" value="" disabled="disabled" style="width:50px; " />-
               		<input type="text" id="charPhone2" value="" style="width:50px;" maxlength="4" />-
               		<input type="text" id="charPhone3" value="" style="width:50px;" maxlength="4" />
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="hp1">휴대폰</label></th>
				<td>
					<input type="hidden" id="chargeCellPhone" name="chargeCellPhone" value="${rtnContent.chargeCellPhone }" />
					<input type="number" name="chargeCellPhone1" size="4" maxlength="3" id="chargeCellPhone1" value="" title="휴대폰번호 앞 3자리 입력"/> -
					<input type="number" name="chargeCellPhone2" size="4" maxlength="4" id="chargeCellPhone2" value="" title="휴대폰번호 가운데 3~4자리 입력"/> -
					<input type="number" name="chargeCellPhone3" size="4" maxlength="4" id="chargeCellPhone3" value="" title="휴대폰번호 마지막 4자리 입력"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="">부서명</label></th>
				<td><input type="text" name="chargeDeptName" id="chargeDeptName" value="" title="부서명 입력" class="input_mid02"/></td>
			</tr>
			</tbody>
	</table>	
	</c:if>
	</div>
</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>	
							
<script type="text/javascript">
$(function() {
	
 	//뉴스레터 수신구분
    //var mailCheck = fnStrSplit("${rtnMember.MAILRECEIVE}", "#");
    gfnCodeCheckList($('#tdMailReceive'), "NewsLetterGubun", "mailCheck", "");
    
    //관심분야
    //var interCheck = fnStrSplit("${rtnMember.INTEREST}", "#");
    gfnCodeCheckList($('#tdInterest'), "Interest", "interCheck", "");
    
  	//소속
	gfnCodeComboList($('#belong'), "Belong", "", "선택", "");
  
	$('#btnSave').click(function(){
		<c:if test="${obj.kind == 'C' }">
			if($.trim($("#regno1").val()).length < 3 || $.trim($("#regno2").val()).length < 2 || $.trim($("#regno3").val()).length < 5 ){
	            alert("사업자번호의 자리수를 올바르게 입력하세요");
	            $("regno1").focus();
	            return false;
	        }
			
			$("#corpRegno").val($.trim($("#regno1").val())+"-"+$.trim($("#regno2").val())+"-"+$.trim($("#regno3").val()));
			$("#business").val($("#corpRegno").val());
			
			var corpRegno = $.trim($("#regno1").val())+$.trim($("#regno2").val())+$.trim($("#regno3").val());
			
			if(!chk_vend(corpRegno)){
				alert("사업자번호 오류, 입력하신 사업자등록번호를 확인해 주시기 바랍니다.");
				return false;
			}	
			
			var rtn = fnCorpRegnoCheck();
			var rtnvalu = $("#mailCertiYn").val();
			
	    	if(rtn == 'Fail')
	     	{
	     		if(rtnvalu == 'N'){
	         		alert($("#KNameCert").val()+"는(은) ["+$("#userIdCert").val()+"]를 아이디로 사용하여 기업회원으로 가입한 후 메일 인증을 하지 않은 상태입니다.기존 가입정보를 삭제한 후 가입 절차를 진행하시기바랍니다.");
	         		return;
	     		}
	     	}   	
	    	
			if($.trim($("#KName").val()).length <= 0 ){
				alert("회사명을 입력하세요");
				$("#KName").focus();
				return false;
			}	
			
			if($("#email_id").val().length <= 0) {
	       	 alert("대표이메일(ID)을 입력하세요");
	        	$("#email_id").focus();
	        	return false;
	    	}
	    
	    	if($("#mail_dom").val().length <= 0) {
	       	 alert("대표이메일(ID)을 입력하세요");
	        	$("#mail_dom").focus();
	        	return false;
	    	}		
			
			//대표이메일(ID) 처리
	   	    $("#userId").val($.trim($("#email_id").val())+"@"+$.trim($("#mail_dom").val()));
			
			if($("#doubleChk").val()=='N'){
				 alert("아이디 중복체크를 확인하세요!");
				 return;
			}
			
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
	    		alert("비밀번호는 영문/숫자/특수문자 혼합 8~32자의 조합된 문자열이어야 합니다!");
	    		$("#password").focus();
	    		return;
	    	} 	
			
			if($.trim($("#ceoName").val()).length <= 0 ){
				alert("대표자명을 입력하세요");
				$("#ceoName").focus();
				return false;
			}
			
			//전화번호 처리
			$("#corpPhone").val($.trim($("#phone1").val())+"-"+$.trim($("#phone2").val())+"-"+$.trim($("#phone3").val()));
			
			if($.trim($("#corpPhone").val()).length < 9 || $.trim($("#phone2").val()).length < 3 || $.trim($("#phone3").val()).length < 4) {
				alert("전화 번호를 입력하지 않았거나 자리수가 틀립니다.전화 번호를 입력하세요");
				$("#phone2").focus();
				return false;
			}
			
			if($("#zipcode1").val().length <= 0) {
				alert("우편번호를을 입력하세요");
	        	return false;
		    }		
			
			if($("#newAddr1").val().length <= 0) {
				alert("기본주소을 입력하세요");
		        $("#newAddr1").focus();
		        return false;
		    }
			
			//주소처리
			$("#corpAddress1").val($.trim($("#newAddr1").val()));
			$("#corpAddress2").val($.trim($("#newAddr2").val()));
			
			if($.trim($("#chargeName").val()).length <= 0 ){
				alert("담당자명을 입력하세요");
				$("#chargeName").focus();
				return false;
			}
	
			if($("#email_id2").val().length <= 0) {
				alert("담당자이메일을 입력하세요");
	        	$("#email_id2").focus();
	        	return false;
	    	}
		    
	    	if($("#mail_dom2").val().length <= 0) {
				alert("담당자이메일을 입력하세요");
	        	$("#mail_dom2").focus();
	        	return false;
	    	}
	    	
	      	//담당자 메일 처리
			$("#chargeEmail").val( $.trim($("#email_id2").val())+"@"+$.trim($("#mail_dom2").val()) );
			
			if($.trim($("#chargeCellPhone1").val()).length < 3 || $.trim($("#chargeCellPhone2").val()).length < 3 || $.trim($("#chargeCellPhone3").val()).length < 4) {
				alert("담당자 휴대폰 번호를 입력하지 않았거나 자리수가 틀립니다.휴대폰번호를 입력하세요");
				$("#chargeCellPhone1").focus();
				return false;
			}
			
			//팩스번호 처리
			$("#corpFax").val($.trim($("#fax1").val())+"-"+$.trim($("#fax2").val())+"-"+$.trim($("#fax3").val()));
			//우편번호 처리
			$("#corpZipCode").val($.trim($("#zipcode1").val()));
			
		    //관심분야 체크패턴
	        $("#interest").val(gfnRtSelectCheck("interCheck", "#"));
	        //메일수신구분 체크패턴
	        $("#mailReceive").val(gfnRtSelectCheck("mailCheck", "#"));
	        
			//담당자 전화번호 처리
			$("#chargePhone").val($.trim($("#charPhone1").val())+"-"+$.trim($("#charPhone2").val())+"-"+$.trim($("#charPhone1").val()));
	      	
			//담당자 휴대폰 처리
			$("#chargeCellPhone").val($.trim($("#chargeCellPhone1").val())+"-"+$.trim($("#chargeCellPhone2").val())+"-"+$.trim($("#chargeCellPhone3").val()));
			
			//홈페이지 처리
			$("#homepage").val("http://"+$.trim($("#homepageTail").val()));		
			
	   	    if(!confirm("ID로 사용할 이메일 주소를 ["+$("#userId").val()+"]로 등록하시겠습니까? 이메일 주소가 유효하지 않으면 이메일 인증을 할 수 없습니다.")) {
	 			return false;
	 		}
		</c:if>
		
		<c:if test="${obj.kind eq 'P' or obj.kind eq 'K' }">
			if($.trim($("#KName").val()).length <= 0 ){
				alert("성명을 입력하세요");
				$("#KName").focus();
				return false;
			}
			
			if($.trim($("#email_id").val()).length <= 0 || $.trim($("#mail_dom").val()).length <= 0 ) {
				alert("이메일(ID)를 입력하세요");
				$("#email_id").focus();
				return false;
			}   		   		
	   		
			//이메일(ID) 처리
	   	    $("#userId").val($.trim($("#email_id").val())+"@"+$.trim($("#mail_dom").val()));
			
			if($("#doubleChk").val()=='N'){
				
				 alert("아이디 중복체크를 확인하세요!");
				 return;
			}
			
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
	    		alert("비밀번호는 영문/숫자/특수문자 혼합 8~32자의 조합된 문자열이어야 합니다!");
	    		$("#password").focus();
	    		return;
	    	} 				
			
	  		
			if($.trim($("#cellPhone1").val()).length < 3 || $.trim($("#cellPhone2").val()).length < 3 || $.trim($("#cellPhone3").val()).length < 4) {
				alert("휴대폰 번호를 입력하지 않았거나 자리수가 틀립니다.휴대폰번호를 입력하세요");
				$("#cellPhone1").focus();
				return false;
			}
			
	   		//전화번호 처리
	   	    $("#cellPhone").val($.trim($("#cellPhone1").val())+"-"+$.trim($("#cellPhone2").val())+"-"+$.trim($("#cellPhone3").val()));
	   	        
	   	    //생년월일처리
	   	    $("#birthDate").val($("#birthDate").val().replace(/\-/g,''));
	   	        
	   	    if($("#birthDate").val().length <= 0) {
				alert("생년월일을 입력하세요");
				$("#birthDate").focus();
				return false;
			}
	
		
	   	        
	   	    if(!confirm("ID로 사용할 이메일 주소를 ["+$("#userId").val()+"]로 등록하시겠습니까? 이메일 주소가 유효하지 않으면 이메일 인증을 할 수 없습니다.")) {
	 			return;
	 		}
		</c:if>

   	 	var vall = $("input[name=mailingYn]:checked").val();

   	 	var chlen = $("input[name='interCheck']:checkbox:checked", "form[name=insertForm]").length;
   	 	
   	 	if(vall == 'Y' && chlen < 1){
	   	 		
   	 		alert("메일링서비스 수신구분을 선택하세요");
   	 		return false;
   	 	}   
   	 	
   	 	if(vall == 'Y')
	 	{
	 		$("#mailing").val("Y");
	 	}else{
	 		$("#mailing").val("N");
	 		$("#interest").val("#######");
	 	}
   	 	
		var vallN = $("input[name=newsLetterCheck]:checked").val();
   	 	
   	 	var chlenN = $("input[name='mailCheck']:checkbox:checked", "form[name=insertForm]").length;
   	 	
   	 	if(vallN == 'Y' && chlenN < 1){
	   	 		
   	 		alert("뉴스레터 수신구분을 선택하세요");
   	 		return false;
   	 	}
   	 	
   	 	if(vallN == 'Y')
   	 	{
   	 		$("#newsLetter").val("Y");
   	 	}else{
   	 		$("#newsLetter").val("N");
   	 		$("#newsLetterGubun").val("###");
   	 	}
		
   	 	//관심분야 체크패턴
   	    $("#interest").val(gfnRtSelectCheck("interCheck", "#"));
   	 	
   	    //메일수신구분 체크패턴
   	    $("#newsLetterGubun").val(gfnRtSelectCheck("mailCheck", "#"));
			    
		$("#insertForm").attr('action', '${ctxMgr }/memberMgr/userAction');
		$('#insertForm').submit();
	});
	
	//현재일셋팅
	$('#joinDate').val($.datepicker.formatDate('yymmdd', new Date()));
		
	$('#passwordTime').val($.datepicker.formatDate('yymmdd', new Date()));
	$('#withDrawTime').val($.datepicker.formatDate('yymmdd', new Date()));
		
	$("#btnList").click(function(){
		location.href="${contextPath}/mgr/memberMgr?${link}";
	});


	$("#btnIdcheck").click(function(){
		if($.trim($("#email_id").val()).length <= 0 || $.trim($("#mail_dom").val()).length <= 0 ) {
			alert("이메일(ID)를 입력하세요");
			$("#email_id").focus();
			return false;
		}   		   		
   		
		//이메일(ID) 처리
   	    $("#userId").val($.trim($("#email_id").val())+"@"+$.trim($("#mail_dom").val()));
		
		$.ajax({
	 		url: gContextPath+"/mps/memberSearch/idSearch",
	 		data: {'userId' : $("#userId").val(), 'kind' : '${obj.kind}', 'schType' : '3'}, //schType : 3(ID찾기)
	 		async: false,
	 		success:function(data, textStatus, jqXHR) {
				if(data != ""){
					if(data.userCnt == 0){
						alert("입력하신  이메일(아이디)로 등록할 수 있습니다.");
						$("#doubleChk").val('Y');
					}else{
						alert("입력하신 이메일(아이디)과 중복되는 이메일(아이디)이 존재합니다.");
						$("#doubleChk").val('N');
					}
				}
	 		}
	 	});		
	});
	
	$("input[name=mailingYn]").click(function(){

		var vall = $("input[name=mailingYn]:checked").val();
		
		if(vall == 'Y'){
			$(".mailingInfo").show();
		}else{
			$(".mailingInfo").hide();
		}
	
	});   	
	
	$("input[name=newsLetterCheck]").click(function(){
		
		var vall = $("input[name=newsLetterCheck]:checked").val();

		if(vall == 'Y'){
			$(".newsLetterInfo").show();
		}else{
			$(".newsLetterInfo").hide();
		}
	
	});
	
	$("input[name=httInfoYn]").click(function(){
		
		var vall = $("input[name=httInfoYn]:checked").val();
		
		if(vall == 'on'){
			$(".addHttInfo").show();
		}else{
			$(".addHttInfo").hide();
		}
	});	
	
	//지역번호_전화번호
	gfnCodeComboList($('#areaCode1'), "AreaCode", "", "선택", "");
	
	//지역번호_팩스
	gfnCodeComboList($('#areaCode2'), "AreaCode", "", "선택", "");
	
	//지역번호_담당자전화번호
	gfnCodeComboList($('#areaCode3'), "AreaCode", "", "선택", "");
	    
    //지역번호 자동입력(전화번호)
	$("#areaCode1").change(function(){
		if($("#areaCode1").val() != "etc"){
		    $("#phone1").attr("disabled", "disabled");
		    $("#phone1").val($("#areaCode1").val());
		} else {
		    $("#phone1").removeAttr("disabled");
		    $("#phone1").val("");
		    $("#phone1").focus();
		}
	});
	
	//지역번호 자동입력(팩스번호)
	$("#areaCode2").change(function(){
		if($("#areaCode2").val() != "etc"){
		    $("#fax1").attr("disabled", "disabled");
			$("#fax1").val($("#areaCode2").val());
		} else {
	        $("#fax1").removeAttr("disabled");
	        $("#fax1").val("");
	        $("#fax1").focus();
        }
	});
	
	//지역번호 자동입력(담당자전화번호)
	$("#areaCode3").change(function(){
		if($("#areaCode3").val() != "etc"){
		    $("#charPhone1").attr("disabled", "disabled");
			$("#charPhone1").val($("#areaCode3").val());
		} else {
	        $("#charPhone1").removeAttr("disabled");
	        $("#charPhone1").val("");
	        $("#charPhone1").focus();
        }
	});
	
	//달력 세팅
    $( "#birthDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
	  
    $("input:radio[name='solarYn']:radio[value='${rtnMember.SOLARYN}']").attr("checked",true);
    $("input:radio[name='gender']:radio[value='${rtnMember.GENDER}']").attr("checked",true);
    
	$(".mailingInfo").hide();
	$(".newsLetterInfo").hide();
    
});

//아이디 메일 선택이  기타일 경우 기타텍스트박스 활성화
function fnMailSelect2()
{
	
	var selectV = $("#mail_select2").val();
	if(selectV == '')
	{
		$('#mail_dom2').removeAttr("disabled");
		$("#mail_dom2").val(selectV);
		$("#mail_dom2").focus();
		 
	}else if(selectV == ' '){
		
	}else{
		
		$("#mail_dom2").attr("disabled", "disabled");
		$("#mail_dom2").val(selectV);
	}
}

//기본정보 주소찾기 
function fnPostSearch(){
	$("#ZIPGUBUN").val("basic");
	window.open("/resources/newzip/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
} 
 
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	var gubun = $("#ZIPGUBUN").val();
	
	var zipno =  zipNo;

	$("#zipcode").val(zipno);
	$("#newAddr1").val(roadAddrPart1);
	$("#newAddr2").val(addrDetail+" "+roadAddrPart2);
	
}

//소속이 기타일 경우 기타텍스트박스 활성화
function fnBelongSelect()
{
	var selectV = $("#belong").val();
	if(selectV == '09')
	{
		$('#etcBelong').removeAttr("disabled"); 
		$("#etcBelong").focus();
		 
	}else{
		$("#etcBelong").attr("disabled", "disabled");
	}
	
}

//아이디 메일 선택이  기타일 경우 기타텍스트박스 활성화
function fnMailSelect()
{
	$("#doubleChk").val("N");
	
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
		if ( pwv.length < 8 ){
			returnBoolean = false;
		}else if(pwv.length > 32){
			returnBoolean = false;
		}else{
			returnBoolean = true;
		}
	}

	
	return returnBoolean;
}

//이메일(아이디)입력창에서 onkeyup이 발생했을때 중복체크 플래그를 초기화한다.
function fnIdkeyup(){
	
	$("#doubleChk").val("N");
}

function fnCorpRegnoCheck(){
	var returnV = "";		
	$.ajax({
 		url: gContextPath+"/mps/memberinfo/checkCorpRegno",
 		data: {'corpRegno' : $("#corpRegno").val()}, 
 		async: false,
 		success:function(data) {
 			if(data.length != 0) {
				$.each(data, function(i, item) {
    	 			if( item.MAILCERTIYN == 'N') //메일인증이 안된 상태일경우
    				{
    	 				$("#KName").val(item.KNAME); //중복으로 검색된 업체명
    					$("#userId").val(item.USERID); //중복으로 검색된 id
    					$("#KNameCert").val(item.KNAME); //중복으로 검색된 업체명
    					$("#userIdCert").val(item.USERID); //중복으로 검색된 id
    	 				$("#mailCertiYn").val("N"); 
    					returnV = "Fail";    						
    				}else{
    					$("#KName").val(item.KNAME); //중복으로 검색된 업체명
    					$("#userId").val(item.USERID); //중복으로 검색된 id
    					returnV = "Fail"; 
    				}	
					i++;
 				});
 			}else{
				returnV = "Sucess";
			}  
 		}
 	});
	return returnV;
}

//사업자번호 유효성 체크
function chk_vend(strNumb)
{
	if(strNumb.length != 10){
		return false;
	}
	
	sumMod = 0;
	sumMod += parseInt(strNumb.substring(0,1));
	sumMod += parseInt(strNumb.substring(1,2)) * 3 % 10;
	sumMod += parseInt(strNumb.substring(2,3)) * 7 % 10;
	sumMod += parseInt(strNumb.substring(3,4)) * 1 % 10;
	sumMod += parseInt(strNumb.substring(4,5)) * 3 % 10;
	sumMod += parseInt(strNumb.substring(5,6)) * 7 % 10;
	sumMod += parseInt(strNumb.substring(6,7)) * 1 % 10;
	sumMod += parseInt(strNumb.substring(7,8)) * 3 % 10;
	sumMod += Math.floor(parseInt(strNumb.substring(8,9)) * 5 / 10);
	sumMod += parseInt(strNumb.substring(8,9)) * 5 % 10;
	sumMod += parseInt(strNumb.substring(9,10));
	
	if (sumMod % 10  !=  0){
		return false;
	}
	
	return true;
}

</script>

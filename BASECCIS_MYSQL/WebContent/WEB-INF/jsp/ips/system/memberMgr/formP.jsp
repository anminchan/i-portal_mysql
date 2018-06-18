<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" class="indentCont" name="insertForm" action="${contextPath }/mgr/memberMgr/personAction" method="post" role="form">

<input type="hidden" id="userId" name="userId" value="${rtnMember.USERID}"/>
<input type="hidden" id="KName" name="KName" value="${rtnMember.KNAME}"/>

<input type="hidden" id="certification" name="certification" value="${rtnMember.CERTIFICATION}"/>
<input type="hidden" id="key1" name="key1" value="${rtnMember.KEY1}"/>
<input type="hidden" id="key2" name="key2" value="${rtnMember.KEY2}"/>
<input type="hidden" id="key3" name="key3" value="${rtnMember.KEY3}"/>
<input type="hidden" id="dkey" name="dkey" value="${rtnMember.DKEY}"/>

<input type="hidden" id="kind" name="kind" value="${rtnMember.KIND}"/>

<input type="hidden" id="passwordTime" name="passwordTime" value="<fmt:formatDate value="${rtnMember.PASSWORDTIME}" pattern="yyyyMMddHHmmss"/>" />
<input type="hidden" id="withDrawTime" name="withDrawTime" value="<fmt:formatDate value="${rtnMember.WITHDRAWTIME}" pattern="yyyyMMddHHmmss"/>" />

<input type="hidden" id="joinSiteID" name="joinSiteID" value="${rtnMember.JOINSITEID}"/>
<input type="hidden" id="joinDate" name="joinDate" value="${rtnMember.JOINDATE}"/>
<input type="hidden" id="outDate" name="outDate" value="${rtnMember.OUTDATE}"/>

<input type="hidden" id="homePhone" name="homePhone" value="${rtnMember.HOMEPHONE}"/>

<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
<input type="hidden" id="state" name="state" value="T"/>
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnMember.inBeforeData}"/>

<input type="hidden" id="mailing" name="mailing" value="N"/>

<input type="hidden" id="prePassword" name="prePassword" value="${rtnMember.PASSWORD}"/>

<input type="hidden" id="message" name="message" />

<!-- 검색파라메타 -->
<input type="hidden" id="siteId" name="siteId" value="${obj.siteId}"/>
<input type="hidden" id="schStartDate" name="schStartDate" value="${obj.schStartDate}"/>
<input type="hidden" id="schEndDate" name="schEndDate" value="${obj.schEndDate}"/>
<input type="hidden" id="schType" name="schType" value="${obj.schType}"/>
<input type="hidden" id="schText" name="schText" value="${obj.schText}"/>

<fieldset>
	<legend>회원정보 수정</legend>
	<h2 class="depth2_title">기본정보</h2>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<div class="table">
		<table class="tstyle_view">
			<caption>
				사이트 상세 정보 입력 - 아이디, 회원구분, 이름, 비밀번호, 가입일, 비밀번호 확인, 가입경로, 인증구분, 회원가입 메인인증여부
			</caption>
			<colgroup>
				<col class="col-sm-2"/>
				<col class="col-sm-3"/>
				<col class="col-sm-2"/>
				<col class="col-sm-3"/>
			</colgroup>
			<tr>
				<th scope="row"><label for="siteId">아이디</label></th>
				<td><c:out value="${rtnMember.USERID }" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="kind_Name">회원구분</label></th>
				<td><c:out value="${rtnMember.KIND_NAME }" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="KName">이름</label></th>
				<td><c:out value="${rtnMember.KNAME }"></c:out> </td>
			</tr>
			<tr>
				<th scope="row"> <label for="password">비밀번호</label></th>
				<td><input type="password" id="password" name="password" value="" required="required" title="비밀번호"/></td>
			</tr>
			<tr>
				<th scope="row"><label for="joinDate">가입일</label></th>
				<td><c:out value="${fn:substring(rtnMember.JOINDATE, 0, 4)}-${fn:substring(rtnMember.JOINDATE, 4, 6)}-${fn:substring(rtnMember.JOINDATE, 6, 8)}" /></td>
			</tr>
			<tr>
				<th scope="row"> <label for="repassword">비밀번호확인</label></th>
				<td><input type="password" id="repassword" name="repassword" value="" required="required" title="비밀번호확인" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="joinSiteId_Name">가입경로</label></th>
				<td><c:out value="${rtnMember.JOINSITEID_NAME}" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="joinSiteId_Name">인증구분</label></th>
				<td><c:out value="${rtnMember.CERTIFICATION_NAME }" /></td>
			</tr>
			<tr>
				<th scope="row"><label for="joinsitedId_Name">회원가입메일인증여부</label></th>
				<td>
					<c:choose>
						<c:when test="${rtnMember.MAILCERTIYN eq 'Y' }">
							예
						</c:when>
						<c:otherwise>
							아니오
						</c:otherwise>			
					</c:choose>
				</td>
			</tr>
		</table>
	</div>	
	<h2 class="depth2_title02">추가정보</h2>
	<div class="table">
		<table class="tstyle_view">  
			<caption>
				개인회원 추가정보 수정
			</caption>
			<colgroup>
				<col width="170px" />
				<col />
			</colgroup>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="cellPhone">휴대폰</label></th>
				<td>
					<input type="hidden" id="cellPhone" name="cellPhone" value="${rtnMember.CELLPHONE }" />
					<input type="text" id="phone1" value="${fn:split(rtnMember.CELLPHONE, '-')[0]}" title="휴대폰번호" size="3" maxlength="3" onkeyup="validateOnlyNumber(this)" style="ime-mode:disabled" />-
					<input type="text" id="phone2" value="${fn:split(rtnMember.CELLPHONE, '-')[1]}" title="휴대폰번호" size="4"  maxlength="4" onkeyup="validateOnlyNumber(this)" style="ime-mode:disabled" />-
					<input type="text" id="phone3" value="${fn:split(rtnMember.CELLPHONE, '-')[2]}" title="휴대폰번호" size="4" maxlength="4" onkeyup="validateOnlyNumber(this)" style="ime-mode:disabled" />
				</td>
			</tr>		
			<tr>
				<th scope="row"><span class="point01">*</span><label for=birthDate>생년월일</label></th>
				<td>
					<input type="text" id="birthDate" value="<dateFormat:dateFormat addPattern="-" value="${rtnMember.BIRTHDATE }" />"  name="birthDate" style="width: 70px;" title="생년월일" readOnly="readOnly" />
					<input type="radio" id="solarY" name="solarYn" value="Y">
					<label for="solarY">양력</label> 
					<input type="radio" id="solarN" name="solarYn" value="N">
					<label for="solarN">음력</label>			
	            </td>
			</tr>		
			<tr>
				<th scope="row"><label for=gender>성별</label></th>
				<td>
					<input type="radio" id="genderY" name="gender" value="M">
					<label for="genderY">남성</label> 
					<input type="radio" id="genderN" name="gender" value="F">
					<label for="genderN">여성</label>
				</td>
			</tr>	
		</table>
	</div>
    <div id ="dialog" class="selector" style="display: none;"> 
		<table class="tstyle_list">
			<caption>
			변경사유
			</caption>
			<tbody class="txt_left">
				<tr>
					<th scope="col">변경사유</th>
				</tr>
				<tr>
					<td id="codeNameTr">
						<textarea id="reason" name="reason" class="input_long">
						</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>    
</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>					
		
<script type="text/javascript">
$(function() {
	$("#btnSave").click(function(){
		if($("#phone1").val().length <= 0 || $("#phone2").val().length <= 0 || $("#phone2").val().length <= 0) {
			alert("휴대전화를 정확하게 입력하세요");
			$("#phone1").focus();
			return false;
		}	
		
		if($("#birthDate").val().length <= 0) {
			alert("생년월일을 입력하세요");
			$("#birthDate").focus();
			return false;
		}
		
		if($("#password").val().length > 0) {
			if($("#repassword").val().length <= 0) {
				alert("비밀번호확인을 입력하세요");
				$("#repassword").focus();
				return false;
			}
				if($.trim($("#repassword").val()) != $.trim($("#password").val())) {
				alert("비밀번호와 비밀번호확인이 다릅니다");
				$("#repassword").focus();
				return false;
			}
				
			$("#dialog").dialog({
				width: 300,
				height: 260,
				resizable: false,
				modal: true,
				title: "비밀번호변경사유입력",
				buttons:{
					"저장": function(){
						saveUserInfoPw();	
					},
					"취소": function(){
						$(this).dialog("close");
					}
				}
			});
				
		}else{	
		 
			saveUserInfo();
		}
	});
	
	$("#btnList").click(function(){
		location.href="${contextPath}/mgr/memberMgr?${link}";
	});

    //달력 세팅
    $( "#birthDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath }/resources/images/mps/aside/icon_carlendar.png"
    });
	  
    $("input:radio[name='solarYn']:radio[value='${rtnMember.SOLARYN}']").attr("checked",true);
    $("input:radio[name='gender']:radio[value='${rtnMember.GENDER}']").attr("checked",true);
	
});

function saveUserInfoPw(){
	
	var reason = $('#reason').val().trim();
	
	if(reason == "" || reason == null){
		
		alert("비밀번호 변경 사유를 입력하세요");
		return;
		
	}else{
		
		$('#message').val(reason);
		
		saveUserInfo();
	}
}

function saveUserInfo(){
	
    //전화번호 처리
    $("#cellPhone").val($.trim($("#phone1").val())+"-"+$.trim($("#phone2").val())+"-"+$.trim($("#phone3").val()));
    
    //우편번호 처리
    $("#homeZipCode").val($.trim($("#zipcode1").val())+"-"+$.trim($("#zipcode2").val()));
    
    //생년월일처리
    $("#birthDate").val($("#birthDate").val().replace(/\-/g,''));
    
    //관심분야 체크패턴
    $("#interest").val(gfnRtSelectCheck("interCheck", "#"));
    
    //메일수신구분 체크패턴
    $("#mailReceive").val(gfnRtSelectCheck("mailCheck", "#"));
	
	if(!confirm("수정하시겠습니까?")) {
		return false;
	}
	
	$("#insertForm").submit();
	
}

</script>

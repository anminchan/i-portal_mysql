<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/memberMgr/companyAction" method="post" role="form">

<input type="hidden" id="userId" name="userId" value="${rtnMember.USERID}"/>
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
<input type="hidden" id="chargePhone" name="chargePhone" value="${rtnMember.CHARGEPHONE}"/>

<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
<input type="hidden" id="state" name="state" value="T"/>
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnMember.inBeforeData}"/>
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
				사이트 상세 정보 입력
			</caption>
			<colgroup>
				<col class="col-sm-2"/>
				<col class="col-sm-4"/>
				<col class="col-sm-2"/>
				<col class="col-sm-4"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">아이디</th>
					<td><c:out value="${rtnMember.USERID }" /></td>
					<th scope="row"> 회원구분</th>
					<td><c:out value="${rtnMember.KIND_NAME }" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="KName">회사명</label></th>
					<td><input type="text" id="KName" name="KName" value="${rtnMember.KNAME }" /></td>
					<th scope="row"><span class="point01">*</span>  사업자번호</th>
					<td>
		                <input type="hidden" id="corpRegno" name="corpRegno" />
		                <input type="number" id="regno1" value="${fn:substring(rtnMember.CORPREGNO, 0, 3)}" title="사업자번호" size="1" maxlength="3" onkeyup="validateOnlyNumber(this)"/> -
		                <input type="number" id="regno2" value="${fn:substring(rtnMember.CORPREGNO, 4, 6)}" title="사업자번호" size="1"  maxlength="2" onkeyup="validateOnlyNumber(this)" /> -
		                <input type="number" id="regno3" value="${fn:substring(rtnMember.CORPREGNO, 7, 12)}" title="사업자번호" size="3" maxlength="5" onkeyup="validateOnlyNumber(this)" />
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="ceoName">대표자명</label></th>
					<td><input type="text" id="ceoName" name="ceoName" value="${rtnMember.CEONAME }" /></td>
					<th scope="row"><label for="password">비밀번호</label></th>
					<td><input type="password" id="password" name="password" value="" title="비밀번호" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="chargeName">담당자</label></th>
					<td><input type="text" id="chargeName" name="chargeName" value="${rtnMember.CHARGENAME }" /></td>
					<th scope="row"><label for="repassword">비밀번호확인</label></th>
					<td><input type="password" id="repassword" value="" title="비밀번호확인" /></td>
				</tr>
				<tr>
					<th scope="row">가입일</th>
					<td>
		                <c:out value="${fn:substring(rtnMember.JOINDATE, 0, 4) }-${fn:substring(rtnMember.JOINDATE, 4, 6) }-${fn:substring(rtnMember.JOINDATE, 6, 8) }" />
					</td>		
					<th scope="row"><span class="point01">*</span> 사업자형태</th>
					<td>
		                <input type="radio" id="corpTypeY" name="corpType" value="C">
						<label for="corpTypeY">법인사업자</label> 
						<input type="radio" id="corpTypeN" name="corpType" value="P">
						<label for="corpTypeN">개인사업자</label>
					</td>
				</tr>
				<tr>
					<th scope="row">가입경로</th>
					<td ><c:out value="${rtnMember.JOINSITEID_NAME}" /></td>
					<th scope="row">회원가입메일인증여부</th>
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
			</tbody>
		</table>
	</div>
    <h2 class="depth2_title">추가정보</h2>
    <div class="table">
		<table class="tstyle_view">
			<caption>
	            기업회원 추가정보
	        </caption>
	        <colgroup>
	            <col class="col-sm-2" />
	            <col class="col-sm-4" />
	            <col class="col-sm-2" />
	            <col class="col-sm-4" />
	        </colgroup>
	        <tbody>
		        <tr>
		            <th scope="row"><span class="point01">*</span> <label for="areaCode1">전화번호</label></th>
		            <td>
		                <input type="hidden" id="corpPhone" name="corpPhone" value="" />
		                <select id="areaCode1">
		                    <option>선택</option>
		                </select>		                
		                <input type="tel" id="phone1" value="${fn:split(rtnMember.CORPPHONE, '-')[0]}" disabled="disabled"/>-
		                <input type="tel" id="phone2" value="${fn:split(rtnMember.CORPPHONE, '-')[1]}" onkeyup="validateOnlyNumber(this)" maxlength="4" />-
		                <input type="tel" id="phone3" value="${fn:split(rtnMember.CORPPHONE, '-')[2]}" onkeyup="validateOnlyNumber(this)" maxlength="4" />
		            </td>
		            <th scope="row"><label for="areaCode2">팩스</label></th>
		            <td>
		                <input type="hidden" id="corpFax" name="corpFax" />
		                <select id="areaCode2">
		                    <option>선택</option>
		                </select>		                
		                <input type="tel" id="fax1" value="${fn:split(rtnMember.CORPFAX, '-')[0]}" disabled="disabled" />-
		                <input type="tel" id="fax2" value="${fn:split(rtnMember.CORPFAX, '-')[1]}" onkeyup="validateOnlyNumber(this)" maxlength="4" />-
		                <input type="tel" id="fax3" value="${fn:split(rtnMember.CORPFAX, '-')[2]}" onkeyup="validateOnlyNumber(this)"  maxlength="4" />
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="homepage">홈페이지</label></th>
		            <td colspan="3"><input type="url" id="homepage" name="homepage" class="input_long" value="${rtnMember.HOMEPAGE }" /></td>
		        </tr>
		        <tr>
		            <th scope="row"><span class="point01">*</span> <label for="zipcode1">법인 우편번호</label></th>
		            <td colspan="3">
		                <input type="hidden" id="corpZipCode" name="corpZipCode" />
		                <input type="hidden" id="corpAddress1" name="corpAddress1" />
						<input type="hidden" id="corpAddress2" name="corpAddress2" />
		                <input type="text" id="zipcode1" name ="zipcode1"  value="${rtnMember.CORPZIPCODE }" title="우편번호" disabled="disabled" />
		                <%-- <input type="text" id="zipcode2" name ="zipcode2"  value="${fn:substring(rtnMember.CORPZIPCODE, 4, 7) }" title="우편번호2" disabled="disabled" style="width:50px;" /> --%>
		                <input type="button" id="zipOverlap" class="btn btn_basic" value="검색">
		            </td>
		        </tr>
		        <tr>
		            <th scope="row"><span class="point01">*</span> <label for="newAddr1">법인 기본주소</label></th>
		            <td colspan="3"><input type="text" id="newAddr1" name="newAddr1" value="${rtnMember.CORPADDRESS1 }" class="input_long" title="법인 기본주소 입력" /></td>
		        </tr>
		        <tr>
		            <th scope="row"><label for="newAddr2">법인 상세주소</label></th>
		            <td colspan="3"><input type="text" id="newAddr2" name="newAddr2" value="${rtnMember.CORPADDRESS2 }" class="input_long" title="법인 상세주소 입력" /></td>
		        </tr>
		        
		        <tr>
		            <th scope="row"><label for="chargePhone">담당자 전화번호</label></th>
		            <td>
		                <select id="areaCode3">
		                    <option>선택</option>
		                </select>
		                
		                <input type="tel" id="chargephone1" value="${fn:split(rtnMember.CHARGEPHONE, '-')[0]}" disabled="disabled"/>-
		                <input type="tel" id="chargephone2" value="${fn:split(rtnMember.CHARGEPHONE, '-')[1]}" onkeyup="validateOnlyNumber(this);" maxlength="4" />-
		                <input type="tel" id="chargephone3" value="${fn:split(rtnMember.CHARGEPHONE, '-')[2]}" onkeyup="validateOnlyNumber(this);" maxlength="4" />
		            </td>
		            <th scope="row"><span class="point01">*</span><label for="chargeCellPhone">담당자 휴대폰</label></th>
		            <td>
		                <input type="hidden" id="chargeCellPhone" name="chargeCellPhone" value="${rtnMember.CHARGECELLPHONE}"/>		                
		                <input type="tel" id="chargeCellPhone1" value="${fn:split(rtnMember.CHARGECELLPHONE, '-')[0]}" onkeyup="validateOnlyNumber(this);" maxlength="3"/>-
		                <input type="tel" id="chargeCellPhone2" value="${fn:split(rtnMember.CHARGECELLPHONE, '-')[1]}" onkeyup="validateOnlyNumber(this);" maxlength="4" />-
		                <input type="tel" id="chargeCellPhone3" value="${fn:split(rtnMember.CHARGECELLPHONE, '-')[2]}" onkeyup="validateOnlyNumber(this);" maxlength="4" />
		            </td>
		        </tr>        
		        
				<tr>
		            <th scope="row"><span class="point01">*</span> 담당자 이메일</th>
		            <td  colspan="3">
						<input type="hidden" id="chargeEmail" name="chargeEmail" value="${rtnMember.CHARGEEMAIL}" />
						<input type="text" name="email_id" id="email_id" value="${fn:split(rtnMember.CHARGEEMAIL, '@')[0]}" title="기본 이메일 주소"  /> @
						<input type="text" name="mail_dom" id="mail_dom" value="${fn:split(rtnMember.CHARGEEMAIL, '@')[1]}" title="끝 이메일 주소" />
						<select name="mail_select" id="mail_select" title="도메인 선택" onchange="fnMailSelect()">
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
		            <th scope="row"><label for="chargeDeptName">담당자 부서명</label></th>
		            <td  colspan="3">
		                <input type="text" name="chargeDeptName" id="chargeDeptName" value="${rtnMember.CHARGEDEPTNAME }" title="부서명 입력" class="input_mid"/>
		            </td>
		        </tr>
	        </tbody>  
	    </table>
	 </div>

	<h2 class="depth2_title">그룹정보</h2>
	<div class="table">
	    <table class="tstyle_list">
	        <caption>
	            그룹정보목록
	        </caption>
	        <colgroup>
	            <col width="80" />
	            <col width="*" span="2"/>
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">순번</th>
	                <th scope="col">그룹유형</th>
	                <th scope="col">그룹이름</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:choose>
	                <c:when test="${fn:length(rtnGroupList) > 0 }">
	                    <c:forEach items="${rtnGroupList }" var="groupList" varStatus="status">
			            <tr>
			                <td><c:out value="${status.count }" /></td>
			                <td><c:out value="${groupList.groupType_Name }" /></td>
			                <td><c:out value="${groupList.KName }" /></td>
			            </tr>
	                    </c:forEach>
	                </c:when>
	                <c:otherwise>
			            <tr>
			                <td colspan="3">등록된 그룹이 없습니다.</td>
			            </tr>
	                </c:otherwise>
	            </c:choose>
	        </tbody>
	    </table>
    </div>
    
	<div id ="dialog" class="selector" style="display: none;"> 
		<div class="table">
			<table class="tstyle_list">
				<caption>
				변경사유
				</caption>
				<colgroup>
					<col />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">변경사유</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td id="codeNameTr" align="left">
							<textarea id="reason" name="reason" class="">
							</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>    
</fieldset>
</spform:form>
<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>
				
<script type="text/javascript">
$(function() {
	
	getKHCategory('', 1);
	//업종
	gfnCodeComboList($('#business'), "Business", "", "선택", "${rtnMember.BUSINESS}");

	//지역번호_전화번호
	gfnCodeComboList($('#areaCode1'), "AreaCode", "", "선택","${fn:split(rtnMember.CORPPHONE, '-')[0] }");
	
	//지역번호_팩스
	gfnCodeComboList($('#areaCode2'), "AreaCode", "", "선택", "${fn:split(rtnMember.CORPFAX, '-')[0] }"); 
	
	//지역번호_담당자전화번호
	gfnCodeComboList($('#areaCode3'), "AreaCode", "", "선택", "${fn:split(rtnMember.CHARGEPHONE, '-')[0] }");
	
	//뉴스레터수신구분
    var mailCheck = fnStrSplit("${rtnMember.NEWSLETTERGUBUN}", "#");
    gfnCodeCheckList($('#tdMailReceive'), "NewsLetterGubun", "mailCheck", mailCheck);
    
    //관심분야
    var interCheck = fnStrSplit("${rtnMember.INTEREST}", "#");
    gfnCodeCheckList($('#tdInterest'), "Interest", "interCheck", interCheck);
    
    //사업자형태
    $("input:radio[name='corpType']:radio[value='${rtnMember.CORPTYPE}']").attr("checked",true);
    
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
	
	
	//지역번호 자동입력(당단자 전화번호)
	$("#areaCode3").change(function(){
		if($("#areaCode3").val() != "etc"){
		    $("#chargephone1").attr("disabled", "disabled");
			$("#chargephone1").val($("#areaCode3").val());
		} else {
	        $("#chargephone1").removeAttr("disabled");
	        $("#chargephone1").val("");
	        $("#chargephone1").focus();
        }
	});
	
	//우편번호 검색 버튼 클릭
    $("#btnSearch").click(function(){
        //gfnOpenWin(href,name,strStyle,width,height)
        gfnOpenWin("${contextPath}/listZipcodePopup", "우편번호 검색", "", 625, 400);
    });
	
	//저장 버튼 클릭
	$("#btnSave").click(function(){

		
		if($.trim($("#KName").val()).length <= 0 ){
	        alert("회사명을 입력하세요");
	        $("#KName").focus();
	        return false;
	    }
		if($.trim($("#regno1").val()).length < 3 || $.trim($("#regno2").val()).length < 2 || $.trim($("#regno3").val()).length < 5 ){
	        alert("사업자번호를 올바르게 입력하세요");
	        $("regno1").focus();
	        return false;
	    }
		if($.trim($("#ceoName").val()).length <= 0 ){
	        alert("대표자명을 입력하세요");
	        $("#ceoName").focus();
	        return false;
	    }
		if($.trim($("#chargeName").val()).length <= 0 ){
	        alert("담당자명을 입력하세요");
	        $("#chargeName").focus();
	        return false;
	    }

	    if($("#phone1").val().length <= 0 || $("#phone2").val().length <= 0 || $("#phone3").val().length <= 0) {
	        alert("전화번호를 정확히 입력하세요");
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

	    if($("#email_id").val().length <= 0) {
	        alert("이메일을 입력하세요");
	        $("#email_id").focus();
	        return false;
	    }
	    
	    if($("#mail_dom").val().length <= 0) {
	        alert("이메일을 입력하세요");
	        $("#mail_dom").focus();
	        return false;
	    }

	    if($("#chargeCellPhone1").val().length <= 0 || $("#chargeCellPhone2").val().length <= 0 || $("#chargeCellPhone3").val().length <= 0) {
	        alert("담당자 휴대전화를 정확히 입력하세요");
	        $("#chargeCellPhone1").focus();
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
	
	$("#zipOverlap").click(function(){
		//window.open('/resources/newzip/road.jsp?zipCode1=zipcode1&zipCode2=zipcode2&address1=newAddr1&address2=newAddr2', 'newzipPopup', 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=yes,resizable=no,width=430,height=380');
		$("#ZIPGUBUN").val("basic");
		window.open("/resources/newzip/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	});
	 
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
	
	//사업자등록번호 처리
	$("#corpRegno").val($.trim($("#regno1").val())+"-"+$.trim($("#regno2").val())+"-"+$.trim($("#regno3").val()));
	//전화번호 처리
	$("#corpPhone").val($.trim($("#phone1").val())+"-"+$.trim($("#phone2").val())+"-"+$.trim($("#phone3").val()));
	//팩스번호 처리
	$("#corpFax").val($.trim($("#fax1").val())+"-"+$.trim($("#fax2").val())+"-"+$.trim($("#fax3").val()));
	//우편번호 처리
	$("#corpZipCode").val($.trim($("#zipcode1").val()));
	
    //관심분야 체크패턴
    $("#interest").val(gfnRtSelectCheck("interCheck", "#"));
    //메일수신구분 체크패턴
    $("#mailReceive").val(gfnRtSelectCheck("mailCheck", "#"));
    
  	//담당자 메일 처리
	$("#chargeEmail").val( $.trim($("#email_id").val())+"@"+$.trim($("#mail_dom").val()) );
	
  	
	//담당자 전화번호 처리
	$("#chargePhone").val($.trim($("#chargephone1").val())+"-"+$.trim($("#chargephone2").val())+"-"+$.trim($("#chargephone3").val()));
  	
	//담당자 휴대폰 처리
	$("#chargeCellPhone").val($.trim($("#chargeCellPhone1").val())+"-"+$.trim($("#chargeCellPhone2").val())+"-"+$.trim($("#chargeCellPhone3").val()));
	
  	
	if(!confirm("수정하시겠습니까?")) {
		return false;
	}
	
	$("#insertForm").submit();
	
}

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	
	var gubun = $("#ZIPGUBUN").val();
	
	var zipno =  zipNo;

	if(gubun == 'fa'){  
		$("#fa_zipcode1").val(zipno);
		$("#fa_newAddr1").val(roadAddrPart1);
		$("#fa_newAddr2").val(addrDetail+" "+roadAddrPart2);
	}else if(gubun == 'sc'){
		$("#sc_zipcode1").val(zipno);
		$("#sc_newAddr1").val(roadAddrPart1);
		$("#sc_newAddr2").val(addrDetail+" "+roadAddrPart2);
	}else{
		$("#zipcode1").val(zipno);
		$("#newAddr1").val(roadAddrPart1);
		$("#newAddr2").val(addrDetail+" "+roadAddrPart2);
	}
}


//소속이 기타일 경우 기타텍스트박스 활성화
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


</script>

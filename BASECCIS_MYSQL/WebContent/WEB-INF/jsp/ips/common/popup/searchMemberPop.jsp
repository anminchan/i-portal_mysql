<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<script type="text/javascript">

$(function() {
	// 검색 이벤트
	$('#btnSearch').click(function(){
		$('#sform').submit();
	});
	
});

function selectSubmit(KNAME, HOMEPHONE, CELLPHONE, EMAIL, HOMEZIPCODE, HOMEADDRESS1, HOMEADDRESS2){

	try {
		
		/* var zipcodeArr = HOMEZIPCODE.split("-"); */
		opener.document.getElementById("devZipCode1").value = HOMEZIPCODE;
		/* if(zipcodeArr[0] != '') opener.document.getElementById("devZipCode2").value = zipcodeArr[1]; */
		
		opener.document.getElementById("devAddress1").value = HOMEADDRESS1;
		opener.document.getElementById("devAddress2").value = HOMEADDRESS2;
		opener.document.getElementById("devName").value = KNAME;
		
		
		var phoneArr = HOMEPHONE.split("-");
		if(phoneArr[0] != '') opener.document.getElementById("tel1").value = phoneArr[0];
		else opener.document.getElementById("tel1").value = "";
		
		if(phoneArr[1] != '') opener.document.getElementById("tel2").value = phoneArr[1];
		else opener.document.getElementById("tel2").value = "";
		
		if(phoneArr[1] != '') opener.document.getElementById("tel3").value = phoneArr[2];
		else opener.document.getElementById("tel3").value = "";
		
		
		
		var cellPhoneArr = CELLPHONE.split("-");
		if(cellPhoneArr[0] != '') opener.document.getElementById("hp1").value = cellPhoneArr[0];
		else opener.document.getElementById("hp1").value = "";
		
		if(cellPhoneArr[1] != '') opener.document.getElementById("hp2").value = cellPhoneArr[1];
		else opener.document.getElementById("hp2").value = "";
		
		if(cellPhoneArr[2] != '') opener.document.getElementById("hp3").value = cellPhoneArr[2];
		else opener.document.getElementById("hp3").value = "";
		
		var emailArr = EMAIL.split("@");
		if(emailArr[0] != '') opener.document.getElementById("email1").value = emailArr[0];
		if(emailArr[1] != '') opener.document.getElementById("email2").value = emailArr[1];
		
		
		opener.document.getElementById("fax1").value = "";
		opener.document.getElementById("fax2").value = "";
		opener.document.getElementById("fax3").value = "";
		
	}catch(e) {}
	window.close();
}

</script>

<form id="sform" name="sform" method="get" action="${contextPath}/mgr/searchMemberPop">
<div class="articles_search">
	<div class="search_form">
		<label for="" class="txt_bold">사용자명</label>
		<input type="text" name="schText" id="schText" value="${param.schText}" title="검색어"/>
		<input type="button" id="btnSearch" class="btn_black" value="검색">
	</div>
</div>
</form>
<br/>
<table class="tstyle_list">
	<caption>
		회원 목록
	</caption>
	<colgroup>
		<col style="width:100px" />
		<col style="width:150px" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">회원 아이디</th>
			<th scope="col">성명</th>
		</tr>
	</thead>
	<tbody>
	
	<c:choose>			
		<c:when test="${!empty result }">
			<c:forEach items="${result }" var="data" varStatus="loop">
			
			<tr id="tr">
				<td><a href="javascript:selectSubmit('${data.KNAME}', '${data.HOMEPHONE}', '${data.CELLPHONE}', '${data.EMAIL}', '${data.HOMEZIPCODE}', '${data.HOMEADDRESS1}', '${data.HOMEADDRESS2}');">${data.USERID}</a></td>
				<td><a href="javascript:selectSubmit('${data.KNAME}', '${data.HOMEPHONE}', '${data.CELLPHONE}', '${data.EMAIL}', '${data.HOMEZIPCODE}', '${data.HOMEADDRESS1}', '${data.HOMEADDRESS2}');">${data.KNAME}</a></td>
			</tr>
			
			</c:forEach>
		</c:when>
		<c:otherwise>
		
			<tr>
				<td colspan="5"> 조회된 데이터가 없습니다. </td>
			</tr>
			
		</c:otherwise>
	</c:choose>
	
	</tbody>
</table>

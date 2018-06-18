<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<script type="text/javascript">

$(function() {
	// 검색 이벤트
	$('#btnSearch').click(function(){
		$('#sform').submit();
	});
	
});

function selectSubmit(userId, kName, corpRegNo, ceoName, corpZipCode, corpAddress1, corpAddress2, chargeName, ChargeEmail, chargeCellPhone, chargePhone){

	var no = corpRegNo.split("-");
	opener.document.getElementById("company_num1").value = no[0];
	opener.document.getElementById("company_num2").value = no[1];
	opener.document.getElementById("company_num3").value = no[2];
	opener.document.getElementById("companyName").value = kName;
	try {
		opener.document.getElementById("repName").value = ceoName;
		
		opener.document.getElementById("com_zip1").value = corpZipCode;
		opener.document.getElementById("address1").value = corpAddress1;
		opener.document.getElementById("address2").value = corpAddress2;
		
	}catch(e) {}
	window.close();
}

</script>

<form id="sform" name="sform" method="get" action="${contextPath}/mgr/searchCompanyPop">
	<div class="articles_search">
		<div class="search_form">
			<label for="" class="txt_bold">회사명</label>
			<input type="text" name="schText" id="schText" value="${param.schText}" title="검색어"/>
			<input type="button" id="btnSearch" class="btn_black" value="검색">
		</div>
	</div>
</form>
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
			<th scope="col">사업자등록번호</th>
			<th scope="col">회사명</th>
		</tr>
	</thead>
	<tbody>	
	<c:choose>			
		<c:when test="${!empty result }">
			<c:forEach items="${result }" var="data" varStatus="loop">
			
			<tr id="tr">
				<td><a href="javascript:selectSubmit('${data.userId}', '${data.KName}', '${data.corpRegno}', '${data.ceoName}', '${data.corpZipCode}', '${data.corpAddress1}', '${data.corpAddress2}', '${data.chargeName}', '${data.chargeEmail}', '${data.chargeCellPhone}', '${data.chargePhone}');">${data.corpRegno}</a></td>
				<td><a href="javascript:selectSubmit('${data.userId}', '${data.KName}', '${data.corpRegno}', '${data.ceoName}', '${data.corpZipCode}', '${data.corpAddress1}', '${data.corpAddress2}', '${data.chargeName}', '${data.chargeEmail}', '${data.chargeCellPhone}', '${data.chargePhone}');">${data.KName}</a></td>
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

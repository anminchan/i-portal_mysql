<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

${result.KDesc }
<p class="btnRight">
	<select id="psinfoList" onchange="personalInfoList();">
		<option value="">선택</option> 
	<c:forEach var="list" items="${resultList }" varStatus="status">
		<option value="${list.personalInfoId }">${list.KName }</option> 
	</c:forEach>
	</select>
</p>
<script type="text/javascript">
	$(document).ready(function(){
		$("#psinfoList").change(function(){
			location.href = "${contextPath}/personalInfo?menuId=${param.menuId}&personalInfoId=" + $(this).val();
		});
	});
</script>
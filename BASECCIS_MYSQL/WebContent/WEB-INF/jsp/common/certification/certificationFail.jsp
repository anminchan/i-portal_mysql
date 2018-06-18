<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- 컴포넌트 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script type="text/javascript">

$(function() {
	var sMessage =  "${sMessage}";

	$(opener.location).attr("href", "javascript:fnSetCertifyFail('"+sMessage+"');");
	self.close();
	
});

</script>






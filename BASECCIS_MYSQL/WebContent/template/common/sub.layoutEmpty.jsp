<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title></title>
<!-- 시스템css -->
<link rel="stylesheet" href="${contextPath }/resources/css/ips/basic.css" />

<!-- 시스템 js -->
<script src="${contextPath }/resources/js/common.ccis.js" ></script>

<!-- 컴포넌트 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>

<!--[if IE]>
<script src="${contextPath }/resources/js/html5.js" ></script> 
<script type="text/javascript" src="${contextPath }/resources/js/selectivizr-min.js" ></script>
<![endif]-->

<script type="text/javascript">
var gContextPath = "${contextPath }";
$(function() {
});
</script>
</head>
<body <c:if test="${!empty USER }">id="user"</c:if>>
<!-- skipNavigation-->
<dl id="accessibility">
	<dt>바로가기 및 건너띄기 링크</dt>
	<dd><a href="#body">본문 바로가기</a></dd>
</dl>
<!-- //skipNavigation -->
<hr />
<!-- wrap -->
<div id="wrap">
	<tiles:insertAttribute name="common.body" />
</div>
<!-- //wrap -->
</body>
</html>
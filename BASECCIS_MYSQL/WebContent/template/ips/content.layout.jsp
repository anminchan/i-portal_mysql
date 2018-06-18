<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<!-- crosseditor -->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title><tiles:insertAttribute name="jsp.title" /></title>

<!-- 시스템css -->
<link rel="stylesheet" href="${contextPath }/resources/css/ips/basic.css" />

<!-- 컴포넌트 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${contextPath }/resources/js/flipclock/flipclock.min.js"></script>
<script src="${contextPath }/resources/js/tooltipsy/tooltipsy.source.js"></script>
<script src="${contextPath }/resources/js/dtree.js" ></script>

<!-- crosseditor -->
<c:if test="${editor eq 'Namo'}">
<script src="${contextPath }/resources/component/crosseditor/js/namo_scripteditor.js" ></script>
</c:if>

<!-- daumditor -->
<c:if test="${editor eq 'Daum'}">
<link rel="stylesheet" href="${contextPath }/resources/component/daumeditor-7.4.27/css/editor.css" type="text/css"/>
<script src="${contextPath }/resources/component/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript"></script>
</c:if>

<!-- 시스템 js -->
<script src="${contextPath }/resources/js/common.ccis.js" ></script>

<!--[if IE]>
<script src="${contextPath}/resources/js/html5.js" ></script> 
<script src="${contextPath}/resources/js/css3-mediaqueries.js" ></script> 
<script type="text/javascript" src="${contextPath }/resources/js/selectivizr-min.js" ></script>
<![endif]-->

<script type="text/javascript">
var gContextPath = "${contextPath }";

$(function() {
	<c:if test="${WRITE eq 'F'}">
		$('.roleWRITE').hide();
	</c:if>

	<c:if test="${MODIFY eq 'F'}">
		$('.roleMODIFY').hide();
	</c:if>

	<c:if test="${DELETE eq 'F'}">
		$('.roleDELETE').hide();
	</c:if>

	<c:if test="${READ eq 'F'}">
		$('.roleREAD').hide();
	</c:if>
});
</script>

</head>
<body id="frameLayout">

<!-- detail content -->
<tiles:insertAttribute name="jsp.body" />
<!-- //detail content -->

<script type="text/javascript">
/* $(window).load(function() {
    // 모두 로딩되었을때
	$('body').oLoader('hide');
}); */
</script>
</body>
</html>
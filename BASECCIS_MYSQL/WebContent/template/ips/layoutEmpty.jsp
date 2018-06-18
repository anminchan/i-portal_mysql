<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<title><tiles:insertAttribute name="jsp.title" /></title>

<!-- 시스템css -->
<link rel="stylesheet" href="${contextPath }/resources/css/ips/basic.css" />

<!-- 컴포넌트 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${contextPath }/resources/js/flipclock/flipclock.min.js"></script>
<script src="${contextPath }/resources/js/tooltipsy/tooltipsy.source.js"></script>
<script src="${contextPath }/resources/js/dtree.js" ></script>

<!-- 시스템 js -->
<script src="${contextPath }/resources/js/common.ccis.js" ></script>

<!-- crosseditor -->
<c:if test="${editor eq 'Namo'}">
<script src="${contextPath }/resources/component/crosseditor/js/namo_scripteditor.js" ></script>
</c:if>

<!-- daumditor -->
<c:if test="${editor eq 'Daum'}">
<link rel="stylesheet" href="${contextPath }/resources/component/daumeditor-7.4.27/css/editor.css" type="text/css"/>
<script src="${contextPath }/resources/component/daumeditor-7.4.27/js/editor_loader.js?environment=development" type="text/javascript"></script>
</c:if>
                
<script type="text/javascript">
var gContextPath = "${contextPath }";

$(function() {

});
</script>

</head>
<body>
<div id="accessibility"><a href="#content">콘텐츠 바로가기</a></div>
<div id="wrap">
	<tiles:insertAttribute name="jsp.body" />
	
	<div id="footer">
		<address>
			copyright 2014 by Korea Health Industry Development Institute. <span class="txt_bold">tel: 000-0000-0000</span>
		</address>
	</div>
</div>

<script type="text/javascript">
	$(function() {
	});	
</script>

</body>
</html>
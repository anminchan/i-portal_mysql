<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title><tiles:insertAttribute name="jsp.title" /></title>

<!-- 시스템css -->
<link rel="stylesheet" href="${contextPath }/resources/css/ips/popup.css" />

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

<script type="text/javascript">
  var toRoot = "/";
  var devsite = false;
  var gContextPath = "${contextPath }";
</script>

</head>
<body>
<div id="popup_wrap">
	<h1 class="h1_title">${obj.viewTitle }</h1>
	<div id="popup_body">
		<div id="content">
			<tiles:insertAttribute name="jsp.body" />
		</div>
	</div>	
</div>
</body>
</html>

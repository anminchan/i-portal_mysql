<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="/WEB-INF/tld/tiles-jsp.tld" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<title><tiles:insertAttribute name="jsp.title" /></title>
<meta name="description" content="통합관리시스템" />
<meta name="copyright" content="통합관리시스템" />
<meta name="author" content="000-0000-0000" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>

<!-- 시스템css -->
<link rel="stylesheet" href="${contextPath }/resources/css/ips/basic.css" />

<!-- 컴포넌트/js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${contextPath }/resources/js/tooltipsy/tooltipsy.source.js"></script>
<%-- <script src="${contextPath }/resources/js/flipclock/flipclock.min.js"></script>
<script src="${contextPath }/resources/js/dtree.js" ></script> --%>

<!-- 시스템 js -->
<script src="${contextPath }/resources/js/common.ccis.js" ></script>

<!-- 차트 -->
<script src="${contextPath }/resources/js/amcharts/amcharts.js"></script>
<!-- 차트종류 -->
<script src="${contextPath}/resources/js/amcharts/serial.js"></script>
<script src="${contextPath}/resources/js/amcharts/plugins/export/export.min.js"></script>
<!-- 차트언어 -->
<script src="${contextPath}/resources/js/amcharts/lang/ko.js"></script>
<!-- 차트색상 -->
<script src="${contextPath}/resources/js/amcharts/themes/light.js"></script>
<script src="${contextPath}/resources/js/amcharts/themes/black.js"></script>
<script src="${contextPath}/resources/js/amcharts/themes/dark.js"></script>
<script src="${contextPath}/resources/js/amcharts/themes/chalk.js"></script>

<!--[if IE]>
<script src="${contextPath}/resources/js/html5.js" ></script> 
<script src="${contextPath}/resources/js/css3-mediaqueries.js" ></script> 
<script type="text/javascript" src="${contextPath }/resources/js/selectivizr-min.js" ></script>
<![endif]-->

<!-- <style> 
img.ui-datepicker-trigger{vertical-align:middle;}
</style> -->
                
<script type="text/javascript">
var gContextPath = "${contextPath }";

$(function() {

});
</script>

</head>
<body id="mgr">
<div id="accessibility"><a href="#content">콘텐츠 바로가기</a></div>
<div id="wrap">
	<header id="header">
		<h1 class="logo"><a href="${contextPath }/mgr/main"><img src="${contextPath}/resources/images/common/layout/logo.png" alt="Plani"></a></h1>
		<button type="button" class="toggle_nav"><i class="xi-bars"></i><span>메뉴관리</span></button>
		<nav class="nav">
			<%-- <h2 class="hidden">개별사이트 관리</h2>
			<ul id="gnavigation">
				<c:forEach items="${rtnUserMenu }" var="siteMenu">
			    <c:if test="${siteMenu.DEPTH == 1 and siteMenu.MENUKIND ne 'C'}">
					<li><a href="${contextPath }/${siteMenu.MENUID}">${siteMenu.KNAME}</a></li>
				</c:if>
				</c:forEach>
			</ul> --%>
			<ul class="util">
				<li><a href="${contextPath }/mgr/logout">로그아웃</a></li>
			</ul>	
		</nav>
	</header>
	<!-- body area -->
  	<aside id="side" role="navigation">
		<ul id="snavigation">
		<c:set var="strUrl" value=""/>
		<c:forEach items="${rtnUserMenu }" var="cmsMenu">
			<c:if test="${cmsMenu.DEPTH == 1 and cmsMenu.MENUKIND eq 'C' }">
				<li>
					<a href="${contextPath }/${cmsMenu.MENUID}"><i class="${cmsMenu.IMGKIND }"></i><span>${cmsMenu.KNAME}</span><i class="toggle xi-angle-down"></i></a>
				</li>
			</c:if>
		</c:forEach>
		</ul>
	</aside>
    <!-- content area -->
	<main id="content" role="main" class="animated">
		<!-- detail content -->
        <div id="content_detail">            
			<tiles:insertAttribute name="jsp.body" />
        </div>
		<!-- //detail content -->
	</main>
</div>
<p class="site_info">i-Portal Platform v2.0</p>
</body>
</html>
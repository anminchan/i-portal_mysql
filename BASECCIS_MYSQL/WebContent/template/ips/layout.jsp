<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

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

<!-- 차트 js -->
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
	<c:if test="${msgFlag eq 'Y'}">
		alert('${message}');
	</c:if>
	
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
<body id="mgr">
<div id="accessibility"><a href="#content">콘텐츠 바로가기</a></div>
<div id="wrap">
	<header id="header">
		<h1 class="logo"><a href="${contextPath }/mgr/main"><img src="${contextPath}/resources/images/common/layout/logo.png" alt="Plani"></a></h1>
		<button type="button" class="toggle_nav"><i class="xi-bars"></i><span>메뉴관리</span></button>
		<nav class="nav">
			<h2 class="hidden">개별사이트 관리</h2>
			<ul id="gnavigation">
				<c:set var="parentMenuId" value="" />
				<c:set var="parentMenuKind" value="" />
				<c:forEach items="${rtnUserMenu }" var="siteMenu">
		    		<c:if test="${siteMenu.MENUID == obj.menuId }">
						<c:set var="parentMenuId" value="${siteMenu.PARENTMENUID }" />
						<c:set var="parentMenuKind" value="${siteMenu.MENUKIND }" />
					</c:if>
				</c:forEach>
				<li class="${systemMgrMenu eq parentMenuId ? 'on' : ''  }"><a href="/${systemMgrMenu }">i-PortalPlateform관리</a></li>
		    	<c:forEach items="${rtnUserMenu }" var="siteMenu">
				    <c:if test="${siteMenu.DEPTH == 1 and siteMenu.MENUKIND ne 'C'}">
						<li class="${siteMenu.MENUID eq parentMenuId ? 'on' : ''  }"><a href="${contextPath }/${siteMenu.MENUID}">${siteMenu.KNAME}</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<ul class="util">
				<li><a href="${contextPath }/mgr/logout">로그아웃</a></li>
			</ul>	
		</nav>
	</header>
	<!-- body area -->
    <!-- left menu start -->
  	<aside id="side" role="navigation">
		<ul id="snavigation">
			<c:set var="menuDepth" />
			<c:set var="strUrl" value=""/>
			<c:forEach items="${rtnUserMenu }" var="menu">
			<c:if test="${menu.DISPLAYYN eq 'Y'}">
				<c:if test="${parentMenuKind ne 'C' }">
					<c:if test="${menu.MENUKIND ne 'C' and parentMenuId eq menu.PARENTMENUID }">
						<c:set var="strTarget" value=""/>
		                <c:set var="strUrl" value="${contextPath }${menu.PROGRAMURL}"/>
						<c:if test="${menu.PROGRAMURL eq '' || menu.PROGRAMURL eq '-' || empty menu.PROGRAMURL}">
							<c:set var="strUrl" value="javascript:alert('URL 정보가 없습니다. 메뉴관리에서 설정하세요.');"/>
						</c:if>
		            	<c:if test="${menu.DEPTH == 1 }">
		            		<c:set var="nCnt" value="${nCnt+1 }"/>
							<c:set var="strUrl" value="${contextPath }/${menu.MENUID}"/>
		            	</c:if>
		                <c:if test="${menu.DEPTH != 1 }">
							<%-- <c:if test="${menu.MENUTYPE eq 'L' and fn:indexOf(menu.PROGRAMURL, 'http') > -1 }">
								<c:set var="strUrl" value="${menu.PROGRAMURL}"/>
								<c:set var="strTarget" value="target='_blank'"/>
							</c:if> --%>
						</c:if>
						<c:if test="${menu.DEPTH == 2 and menuDepth == 3 }">
										</li>
									</ul>
								</li>
							</ul>
						</c:if>
						<c:if test="${menu.DEPTH == 1 and menuDepth == 3 }">
											</li>
										</ul>
									</li>
								</ul>
							</li>
						</c:if>
						<c:if test="${menu.DEPTH == 1 and menuDepth == 2 }">
								</li>
							</ul>
						</c:if>
						<c:if test="${menu.DEPTH == 2 and menu.DEPTH != menuDepth }">
							<ul class="depth2">
						</c:if>
						<c:if test="${menu.DEPTH == 3 and menu.DEPTH != menuDepth }">
							<ul class="depth3">
						</c:if>
						<li class="${(menu.MENUID eq parentMenuId or menu.MENUID eq obj.menuId)? 'active' : ''} ${menu.DEPTH != 1 ? 'tooltipsy' : ''}" title="${menu.KDESC }">
						<a href="${strUrl}" ${strTarget }><i class="${menu.IMGKIND }"></i><span>${menu.KNAME}</span><i class="toggle xi-angle-down"></i></a>
						<c:set var="menuDepth" value="${menu.DEPTH}"/>
					</c:if>
				</c:if>
				<c:if test="${parentMenuKind eq 'C' }">
					<c:if test="${menu.MENUKIND eq 'C' }">
		            	<c:set var="strTarget" value=""/>
		                <c:set var="strUrl" value="${contextPath }${menu.PROGRAMURL}"/>
						<c:if test="${menu.PROGRAMURL eq '' || menu.PROGRAMURL eq '-' || empty menu.PROGRAMURL}">
							<c:set var="strUrl" value="javascript:alert('URL 정보가 없습니다. 메뉴관리에서 설정하세요.');"/>
						</c:if>
		            	<c:if test="${menu.DEPTH == 1 }">
		            		<c:set var="nCnt" value="${nCnt+1 }"/>
							<c:set var="strUrl" value="${contextPath }/${menu.MENUID}"/>
		            	</c:if>
		                <c:if test="${menu.DEPTH != 1 }">
							<%-- <c:if test="${menu.MENUTYPE eq 'L' and fn:indexOf(menu.PROGRAMURL, 'http') > -1 }">
								<c:set var="strUrl" value="${menu.PROGRAMURL}"/>
								<c:set var="strTarget" value="target='_blank'"/>
							</c:if> --%>
						</c:if>
						<c:if test="${menu.DEPTH == 2 and menuDepth == 3 }">
										</li>
									</ul>
								</li>
							</ul>
						</c:if>
						<c:if test="${menu.DEPTH == 1 and menuDepth == 3 }">
											</li>
										</ul>
									</li>
								</ul>
							</li>
						</c:if>
						<c:if test="${menu.DEPTH == 1 and menuDepth == 2 }">
								</li>
							</ul>
						</c:if>
						<c:if test="${menu.DEPTH == 2 and menu.DEPTH != menuDepth }">
							<ul class="depth2">
						</c:if>
						<c:if test="${menu.DEPTH == 3 and menu.DEPTH != menuDepth }">
							<ul class="depth3">
						</c:if>
						<li class="${(menu.MENUID eq parentMenuId or menu.MENUID eq obj.menuId)? 'active' : ''} ${menu.DEPTH != 1 ? 'tooltipsy' : ''}" title="${menu.KDESC }">
						<a href="${strUrl}" ${strTarget }><i class="${menu.IMGKIND }"></i><span>${menu.KNAME}</span><i class="toggle xi-angle-down"></i></a>
						<c:set var="menuDepth" value="${menu.DEPTH}"/>
					</c:if>
				</c:if>
			</c:if>
			</c:forEach>
		</ul>
	</aside>
    <!-- //left menu// -->
    <!-- content area -->
    <main id="content" role="main" class="animated">
       	<div class="title_wrap">
			<h1 class="title">${rtnMenuName}<!-- ${obj.menuId } --></h1>				
			<p class="location">
				<c:forEach var="location" items="${ fn:split(rtnLoction, '>') }" varStatus="statusNum">
				<c:if test="${statusNum.index > 0 }">
				&gt; 
				</c:if>
					${location}
				</c:forEach>
			</p>
		</div>
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
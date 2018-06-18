<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<c:set var="pageTitle" value="" /> 
<c:set var="spTitle" value="${ fn:split(rtnLoction, '>') }" />

<c:forEach var="i" begin="1" end="${fn:length(spTitle) }" step="1" varStatus="loop">
	<c:set var="pageTitle">${pageTitle} ${spTitle[fn:length(spTitle) - i] } ${fn:length(spTitle) ne i ? ((fn:length(spTitle)-1) ne i ? '&lt;' : '-') : '' }</c:set> 
</c:forEach>
				
<title><c:if test="${ menuInfo.MENUTYPE eq 'C' }"> <c:if test="${ rtnContent.KNAME ne null }"> ${ rtnContent.KNAME} &lt; </c:if> </c:if> ${pageTitle }</title>
<meta name="viewport" content="width=1280,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="keywords" content="통합포털" />
<meta name="description" content="통합포털" />
<meta name="copyright" content="통합포털" />
<meta name="author" content="000-0000-0000" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>

<!-- 사이트별 css -->
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/common/basic.css" />

<!-- 컴포넌트 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${contextPath }/resources/js/tooltipsy/tooltipsy.source.js"></script>

<!-- 시스템 js -->
<script src="${contextPath }/resources/js/common.ccis.js"></script>

<!-- crosseditor -->
<script src="${contextPath }/resources/component/crosseditor/js/namo_scripteditor.js"></script>

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
	
	var rtnUrl = location.href;
	
	<c:if test="${msgFlag eq 'Y'}">
		alert('${message}');
	</c:if>

	// 마우스 오른쪽 클릭 방지  
    //document.oncontextmenu = new Function('return false');
	
    // 마우스 드래그 방지  
    //document.ondragstart = new Function('return false');
    
});

</script>
</head>
<body>

<!-- skipNavigation-->
<dl id="accessibility">
	<dt>바로가기 및 건너띄기 링크</dt>
	<dd><a href="#content">본문 바로가기</a></dd>
	<dd><a href="#gnavigation">주메뉴 바로가기</a></dd>
</dl>
<!-- //skipNavigation -->
<hr />
<!-- wrap -->
<div id="wrap">
	<header id="header">
		<tiles:insertAttribute name="common.header.top" />
		<tiles:insertAttribute name="common.header.nav" />
	</header>
    <c:set var="parentMenuId" value="" />
    <c:set var="higherId" value="" />
    <c:set var="parentMenuName" value="" />
    <c:set var="higherIdName" value="" />
    <c:set var="menuDepth" value="" />
	<c:forEach items="${rtnUserMenu }" var="userMenu">
		<c:if test="${userMenu.MENUID == obj.menuId }">
			<c:set var="parentMenuId" value="${userMenu.PARENTMENUID }" />
	        <c:set var="parentMenuName" value="${userMenu.PARENTMENUNAME }" />
			<c:set var="higherId" value="${userMenu.HIGHERID }" />
			<c:set var="higherIdName" value="${userMenu.HIGHERIDNAME }" />
			<c:set var="idPath" value="${userMenu.IDPATH}" />
			<c:set var="menuDepth" value="${userMenu.DEPTH}" />
		</c:if>
	</c:forEach>
	
	<c:choose>
	<c:when test="${parentMenuId eq kpsParentMenuId1 }">
		<c:set var="menuBgCnt" value="1" />
	</c:when>
	<c:when test="${parentMenuId eq kpsParentMenuId2 }">
		<c:set var="menuBgCnt" value="2" />
	</c:when>
	<c:when test="${parentMenuId eq kpsParentMenuId3 }">
		<c:set var="menuBgCnt" value="3" />
	</c:when>
	<c:when test="${parentMenuId eq kpsParentMenuId4 }">
		<c:set var="menuBgCnt" value="4" />
	</c:when>
	<c:when test="${parentMenuId eq kpsParentMenuId5 }">
		<c:set var="menuBgCnt" value="5" />
	</c:when>
	<c:otherwise>
		<c:set var="menuBgCnt" value="1" />
	</c:otherwise>
	</c:choose>
	
	<div id="visual">
		<strong class="eng"><img src="${contextPath}/resources/images/common/layout/visual_txt.png" alt="The Bridge to  Change"></strong>
		<span class="kor">비전과 가능성을 연결하는 사람들</span>
	</div>
	<!-- Body -->
	<div id="body">
        <aside id="snavigation">
        	<h2 class="hidden"></h2>
            <ul id="snb">
				<!-- 메뉴 출력 -->
				<c:set var="strUrl" value=""/>
				<c:if test="${ !empty rtnUserMenu }">
				<%//2depth 메뉴 출력 - 3차 메뉴는 밑에 스트립트에서 지정함 %>
			    <c:forEach items="${rtnUserMenu }" var="subMenu">
                    <c:if test="${subMenu.DEPTH == 2 and parentMenuId eq subMenu.PARENTMENUID and subMenu.DISPLAYYN eq 'Y'}">
						<c:set var="strTarget" value=""/>
						<c:if test="${subMenu.MENUTYPE eq 'L' or subMenu.MENUTYPE eq 'P'}"><%//링크타입일경우 - http 여부에 따라서 새창 추가 %>
							<c:set var="strUrl" value="${contextPath }${subMenu.PROGRAMURL}"/>
							<c:if test="${fn:indexOf(subMenu.PROGRAMURL, 'menuId=') eq -1 }">
								<c:set var="strUrl" value="${strUrl}?menuId=${subMenu.MENUID}"/>
							</c:if>
							<c:if test="${subMenu.MENUTYPE eq 'L' and fn:indexOf(subMenu.PROGRAMURL, 'http') > -1 }">
								<c:set var="strUrl" value="${subMenu.PROGRAMURL}"/>
								<c:set var="strTarget" value="target='_blank'"/>
							</c:if>
							<c:if test="${subMenu.MENUTYPE eq 'P' and (subMenu.PROGRAMURL eq '-' or subMenu.PROGRAMURL eq '')}">
								<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
							</c:if>
						</c:if>
						<c:if test="${subMenu.MENUTYPE ne 'L' and subMenu.MENUTYPE ne 'P'}">
							<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
						</c:if>
	                    <li id="leftNavi_${subMenu.MENUID}"><a href="${strUrl}" ${strTarget }><c:if test="${subMenu.NEWMENUYN == 'Y' }"><img src="/resources/images/common/icon/img_new.gif" /></c:if> ${subMenu.KNAME}</a></li>
                    </c:if>
                </c:forEach>
				</c:if>
				<c:if test="${ empty rtnUserMenu }">
					<li><a>조회결과 없음</a></li>
				</c:if>
            </ul>
        </aside>
		<!-- content area -->
		<section id="content">
			<p class="page_location">
				<c:forEach var="location" items="${ fn:split(rtnLoction, '>') }" varStatus="statusNum">
					<c:if test="${statusNum.count ne 1 }">
						<c:if test="${statusNum.index ne 1 }">
							<span class="arrow">&gt;</span>
						</c:if>
						${location}
					</c:if>  
				</c:forEach>
			</p>
			<h1 class="stitle">${rtnMenuName}<c:if test="${menuDepth >= 3 }"><span>${higherIdName}</span></c:if></h1>
			
			<c:set value="N" var="tabMenuYn"/>
			<c:forEach items="${rtnUserMenu }" var="subMenu">
		    <c:if test="${higherId eq subMenu.HIGHERID and subMenu.TABYN eq 'Y'}">
		    <c:set value="Y" var="tabMenuYn"/>
		    </c:if>
		    </c:forEach>

			<c:set var="tabMenuTot" value="0" />
			<c:forEach items="${rtnUserMenu }" var="subMenu">
			<c:if test="${higherId eq subMenu.HIGHERID and subMenu.TABYN eq 'Y'}">
				<c:set var="tabMenuTot" value="${tabMenuTot + 1 }" />
			</c:if>
			</c:forEach>
			
			<c:if test="${tabMenuTot > 1}">		        
				<ul class="tab_menu" id="subTabMenu">
				<c:set var="nTabMenuCnt" value="0" />
				<c:forEach items="${rtnUserMenu }" var="subMenu">
	                <c:if test="${higherId eq subMenu.HIGHERID and subMenu.TABYN eq 'Y'}">
						<c:set var="strTarget" value=""/>
						<c:if test="${subMenu.MENUTYPE eq 'L' || subMenu.MENUTYPE eq 'P'}"><%//링크타입일경우 - http 여부에 따라서 새창 추가 %>
							<c:set var="strUrl" value="${contextPath }${subMenu.PROGRAMURL}"/>
							<c:if test="${fn:indexOf(subMenu.PROGRAMURL, 'menuId=') eq -1 }">
								<c:set var="strUrl" value="${strUrl}?menuId=${subMenu.MENUID}"/>
							</c:if>
							<c:if test="${subMenu.MENUTYPE eq 'L' && fn:indexOf(subMenu.PROGRAMURL, 'http') > -1 }">
								<c:set var="strUrl" value="${subMenu.PROGRAMURL}"/>
								<c:set var="strTarget" value="target='_blank'"/>
							</c:if>
							<c:if test="${subMenu.MENUTYPE eq 'P' && (subMenu.PROGRAMURL eq '-' or subMenu.PROGRAMURL eq '')}">
								<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
							</c:if>
						</c:if>
						<c:if test="${subMenu.MENUTYPE ne 'L' && subMenu.MENUTYPE ne 'P'}">
							<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
						</c:if>
	
						<li ${subMenu.MENUID == obj.menuId ? 'class="on"' : ''}><a href="${strUrl }">${subMenu.KNAME }</a></li>
						<c:set var="nTabMenuCnt" value="${nTabMenuCnt + 1 }" />
					</c:if>
				</c:forEach>
				</ul>
			</c:if>
			
			<!-- detail content -->
			<div id="detail_content">
				<tiles:insertAttribute name="common.body" />    
			</div>
			<!-- //detail content -->		 	
		</section>	
		<!-- //content area -->
	</div>	
	<!-- //Body -->
    <hr/>    
    <!-- footer Area -->
    <tiles:insertAttribute name="common.footer" />
    <!-- //footer Area -->
</div>
<!-- //wrap -->
</body>
<script type="text/javascript">
	$(function() {
		var nMenuCnt = 0;
	    <c:forEach items="${rtnUserMenu }" var="subMenu">
		    //3차메뉴 지정
		    <c:if test="${subMenu.DEPTH eq 3 and subMenu.DISPLAYYN eq 'Y'}">
				<c:set var="strTarget" value=""/>
				<c:if test="${subMenu.MENUTYPE eq 'L' or subMenu.MENUTYPE eq 'P'}"><%//링크타입일경우 - http 여부에 따라서 새창 추가 %>
					<c:set var="strUrl" value="${contextPath }${subMenu.PROGRAMURL}"/>
					<c:if test="${fn:indexOf(subMenu.PROGRAMURL, 'menuId=') eq -1 }">
						<c:set var="strUrl" value="${strUrl}?menuId=${subMenu.MENUID}"/>
					</c:if>
					<c:if test="${subMenu.MENUTYPE eq 'L' and fn:indexOf(subMenu.PROGRAMURL, 'http') > -1 }">
						<c:set var="strUrl" value="${subMenu.PROGRAMURL}"/>
						<c:set var="strTarget" value="target='_blank'"/>
					</c:if>
					<c:if test="${subMenu.MENUTYPE eq 'P' and (subMenu.PROGRAMURL eq '-' or subMenu.PROGRAMURL eq '')}">
						<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
					</c:if>
				</c:if>
				<c:if test="${subMenu.MENUTYPE ne 'L' and subMenu.MENUTYPE ne 'P'}">
					<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
				</c:if>
	           	
				//좌측멘 3차지정
		    	if($("#leftNavi_${subMenu.HIGHERID} > ul").length < 1){
			    	$("#leftNavi_${subMenu.HIGHERID}").append("<ul class='depth3'></ul>");
		    	}
		    	$("#leftNavi_${subMenu.HIGHERID} > ul").append("<li id='left2Navi_${subMenu.MENUID}'><a href='${strUrl}' ${strTarget}>${subMenu.KNAME}</a></li>");

			</c:if>
	    </c:forEach>

		//메뉴 온 셋팅
		<c:forEach var="location" items="${ fn:split(idPath, '>') }" varStatus="statusNum">
			<c:if test="${statusNum.count eq 2 }">
				$('#leftNavi_${location }').attr("class", "on");
			</c:if>  

			<c:if test="${statusNum.count eq 3 }">
				nMenuCnt = nMenuCnt + 1;
				$('#left2Navi_${location }').attr("class", "on");
			</c:if> 
		</c:forEach>

		//3차 메뉴 없거나, 1차메뉴가 경영공시일경우 3메뉴 영역 조절
		if(nMenuCnt < 1){
			$('#section_subject').css('height', 150 );
		}
		
		<c:if test="${fn:indexOf(rtnLoction, '경영공시') > -1}">
			$('#section_subject').css('height', 150 );
		</c:if>
		
		<c:if test="${nTabMenuCnt eq 0}">
			$('#subTabMenu').hide();
		</c:if>
	});
</script>
</html>
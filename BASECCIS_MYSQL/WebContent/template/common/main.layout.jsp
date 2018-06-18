<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<title><tiles:insertAttribute name="common.title" /></title>
<meta name="description" content="통합포털" />
<meta name="copyright" content="통합포털" />
<meta name="author" content="000-0000-0000" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>

<!-- 사이트별 css -->
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/${siteInfo.SITEKEY }/main.css" />

<!-- 컴포넌트 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${contextPath }/resources/js/tooltipsy/tooltipsy.source.js"></script>
<script src="${contextPath }/resources/js/plani.popup_zone.js"></script>

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
	
	var nPopupWindowCnt = 0;
	<c:forEach var="popupWindowList" items="${rtnPopupWindowList }" varStatus="loop">
		if ( getCookie( "mainPopupId${popupWindowList.POPUPID }" ) != "done" ){
			$("#layerPop${popupWindowList.POPUPID }").show();
			nPopupWindowCnt = nPopupWindowCnt + 1;
		}
	</c:forEach>
	
	if(nPopupWindowCnt>0){
		$(".layerPop_bg").show();
	}	
	$(document).on('click', '.btnPopupWinodwChk', function(){
		var strPopupId = $(this).attr("popupId");
		$("#layerPop"+strPopupId).hide();
		
		 setCookie( "mainPopupId"+strPopupId, "done" , 1);
		 
		 
		 nPopupWindowCnt = nPopupWindowCnt -1;
		 if( nPopupWindowCnt == 0 ){
			 $(".layerPop_bg").hide();
		 }
	});

	$(document).on('click', '.btnPopupWinodwClose', function(){
		var strPopupId = $(this).attr("popupId");
		$("#layerPop"+strPopupId).hide();
		
		 nPopupWindowCnt = nPopupWindowCnt -1;
		 if( nPopupWindowCnt == 0 ){
			 $(".layerPop_bg").hide();
		 }		 
	});
});

</script>



</head>
<body>
<!-- skipNavigation-->
<dl id="accessibility">
	<dt>바로가기 및 건너띄기 링크</dt>
	<dd><a href="#body_area">본문 바로가기</a></dd>
	<dd><a href="#gnavigation">주메뉴 바로가기</a></dd>
</dl>
<!-- //skipNavigation -->

<div class="layerPop_bg"></div>
<c:forEach var="popupWindowList" items="${rtnPopupWindowList }" varStatus="loop">
	<div id="layerPop${popupWindowList.POPUPID }" class="layerPop display_none" style="z-index:1000;position:absolute; top:${popupWindowList.POSITIONX }px; left:${popupWindowList.POSITIONY }px; width:${popupWindowList.POPUPWIDTH }px; height:${popupWindowList.POPUPHEIGHT+30}px;">
		<div class="layerPop_area">
			<p><a href="${popupWindowList.LINKURL}" <c:if test="${popupWindowList.NEWWINDOWYN == 'Y'}">target="_blank"</c:if>><img src="${contextPath}/fileDownload?fileGubun=common&menuId=popupWindowMgr&userFileName=${popupWindowList.IMAGEFILENAME }&systemFileName=${popupWindowList.IMAGESFILENAME }" alt="${popupWindowList.KDESC }" width="100%"/></a></p>
			<p class="close">
				<span class="float_left"><a href="javascript:;" class="btnPopupWinodwChk" popupId="${popupWindowList.POPUPID }"><input type="checkbox" name="inputChk${popupWindowList.POPUPID }" id="inputChk${popupWindowList.POPUPID }" /> 1일간 열지 않음</a></span> 
				<span class="float_right"><a href="javascript:;" class="btnPopupWinodwClose" popupId="${popupWindowList.POPUPID }"><img src="${pageContext.request.contextPath}/resources/images/common/main/popup_close.png" alt="닫기"/></a></span>
			</p>
		</div>
	</div>
</c:forEach>

<!-- wrap -->
<div id="wrap">
	<header id="header">
		<tiles:insertAttribute name="common.header.top" />
		<tiles:insertAttribute name="common.header.nav" />
	</header>
	<hr/>
	<div id="body">
    	<tiles:insertAttribute name="common.body" />    	
	</div>
	<!-- //Body -->
    <hr/>    
    <!-- footer Area -->
    <tiles:insertAttribute name="common.footer" />
    <!-- //footer Area -->
</div>
<!-- //wrap -->
</body>
</html>
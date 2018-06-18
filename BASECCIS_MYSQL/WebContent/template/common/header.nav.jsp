<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"  %>
<%@ taglib prefix="tiles" uri="/WEB-INF/tld/tiles-jsp.tld" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<nav id="gnavigation">
	<ul>
	<c:set var="menuCnt" value="1" />
	<c:forEach items="${rtnUserMenu }" var="topMenu">
		<c:if test="${topMenu.DEPTH == 1 and topMenu.DISPLAYYN eq 'Y' }">
			<c:set var="strTarget" value=""/>
			<c:if test="${topMenu.MENUTYPE eq 'L' || topMenu.MENUTYPE eq 'P'}">
				<%//링크타입일경우 - http 여부에 따라서 새창 추가 %>
				<c:set var="strUrl" value="${contextPath }${topMenu.PROGRAMURL}"/>
				<c:if test="${fn:indexOf(topMenu.PROGRAMURL, 'menuId=') eq -1 }">
					<c:set var="strUrl" value="${strUrl}?menuId=${topMenu.MENUID}"/>
				</c:if>
				<c:if test="${topMenu.MENUTYPE eq 'L' && fn:indexOf(topMenu.PROGRAMURL, 'http') > -1 }">
					<c:set var="strUrl" value="${topMenu.PROGRAMURL}"/>
					<c:set var="strTarget" value="target='_blank' title='새창으로 열림'"/>
				</c:if>
				<c:if test="${topMenu.MENUTYPE eq 'P' && (topMenu.PROGRAMURL eq '-' or topMenu.PROGRAMURL eq '')}">
					<c:set var="strUrl" value="${contextPath }/menu?menuId=${topMenu.MENUID}"/>
				</c:if>
			</c:if>
			<c:if test="${topMenu.MENUTYPE ne 'L' && topMenu.MENUTYPE ne 'P'}">
				<c:set var="strUrl" value="${contextPath }/menu?menuId=${topMenu.MENUID}"/>
			</c:if>
			<li id="topNaviCom_${topMenu.MENUID}" ${ topMenu.KNAME eq '고객참여' or topMenu.KNAME eq '정부3.0' ? " class='underMenu'" : ""} class="menu0${menuCnt }">
				<a href="${strUrl }" ${strTarget} id="${topMenu.MENUID}" class="topMenu">${topMenu.KNAME}</a>
			</li>
			<c:set var="menuCnt" value="${menuCnt+1 }" />
		</c:if>
	</c:forEach>
	</ul>
</nav>	
<c:if test="${ !empty rtnUserMenu }">
</c:if>
<script type="text/javascript">
$(function() {
    <c:forEach items="${rtnUserMenu }" var="subMenu">
		<c:set var="strTarget" value=""/>
		<c:if test="${subMenu.MENUTYPE eq 'L' || subMenu.MENUTYPE eq 'P'}"><%//링크타입일경우 - http 여부에 따라서 새창 추가 %>
			<c:set var="strUrl" value="${contextPath }${subMenu.PROGRAMURL}"/>
			<c:if test="${fn:indexOf(subMenu.PROGRAMURL, 'menuId=') eq -1 }">
				<c:set var="strUrl" value="${strUrl}?menuId=${subMenu.MENUID}"/>
			</c:if>
			<c:if test="${subMenu.MENUTYPE eq 'L' && fn:indexOf(subMenu.PROGRAMURL, 'http') > -1 }">
				<c:set var="strUrl" value="${subMenu.PROGRAMURL}"/>
				<c:set var="strTarget" value="target='_blank' title='새창으로 열림'"/>
			</c:if>
			<c:if test="${subMenu.MENUTYPE eq 'P' && (subMenu.PROGRAMURL eq '-' or subMenu.PROGRAMURL eq '')}">
				<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
			</c:if>
		</c:if>
		<c:if test="${subMenu.MENUTYPE ne 'L' && subMenu.MENUTYPE ne 'P'}">
			<c:set var="strUrl" value="${contextPath }/menu?menuId=${subMenu.MENUID}"/>
		</c:if>
		
    	//2차 메뉴 지정
	    <c:if test="${subMenu.DEPTH eq 2 && subMenu.DISPLAYYN eq 'Y'}">
			//탑 2차 지정
			if($("#topNaviCom_${subMenu.PARENTMENUID} > ul").length < 1){
		    	$("#topNaviCom_${subMenu.PARENTMENUID}").append("<ul class='depth2'></ul>");
	    	}
	    	
	    	<c:if test="${subMenu.NEWMENUYN != 'Y'}">
	    		$("#topNaviCom_${subMenu.PARENTMENUID} > ul").append("<li id='topNavi2_${subMenu.MENUID}'><a href='${strUrl}' ${strTarget}>${subMenu.KNAME}</a></li>");
	    	</c:if>
	    	<c:if test="${subMenu.NEWMENUYN == 'Y'}">
				$("#topNaviCom_${subMenu.PARENTMENUID} > ul").append("<li id='topNavi2_${subMenu.MENUID}'><a href='${strUrl}' ${strTarget}><img src='/resources/images/common/icon/img_new.gif' /> ${subMenu.KNAME}</a></li>");
	    	</c:if>
	    	
			//전체메뉴 2차 지정
			if($("#topAllNaviCom_${subMenu.PARENTMENUID} > ul").length < 1){
		    	$("#topAllNaviCom_${subMenu.PARENTMENUID}").append("<ul class='depth2'></ul>");
	    	}
	    	$("#topAllNaviCom_${subMenu.PARENTMENUID} > ul").append("<li id='topAllNaviCom2_${subMenu.MENUID}'><a href='${strUrl}' ${strTarget}>${subMenu.KNAME}</a></li>");
	    </c:if>
	    
	  	//3차메뉴 지정
	    <c:if test="${subMenu.DEPTH eq 3 && subMenu.DISPLAYYN eq 'Y'}">
			//전체메뉴 3차 지정
			if($("#topAllNaviCom2_${subMenu.HIGHERID} > ul").length < 1){
		    	$("#topAllNaviCom2_${subMenu.HIGHERID}").append("<ul class='depth3'></ul>");
	    	}
	    	$("#topAllNaviCom2_${subMenu.HIGHERID} > ul").append("<li id='topAllNaviCom3_${subMenu.MENUID}'><a href='${strUrl}' ${strTarget}>${subMenu.KNAME}</a></li>");
	    </c:if>
    </c:forEach>
    
	$("#viewAllmenu").click(function(){
		$("#divAllmenu").show();
	});

	$("#closeAllmenu").click(function(){
		$("#divAllmenu").hide();
	});

	$(".topMenu").bind("keyup", function () {
		$(".depth2").css('display', 'none');
		var topMenuId = $(this).attr("id");
		$("#"+topMenuId).next().css('display', 'block');
		
		if($("#gnavigation").children().last().attr("id") == $("#"+topMenuId).parents().attr("id")){
			var pId = $("#gnavigation").children().last().attr("id");
			
			$(".depth2 >li>a").focus(function(){
				if($(this).parents().attr("id") == $("#"+pId+" >ul").children().last().attr("id")){
					$(this).blur(function(){
						$(".depth2").css('display', 'none');
					});
				};
			});
		};
	});
});

$(function() {
	var $gnb = $('#gnavigation');
	
	$gnb.find('a').on('focusin mouseover', function(){
		$gnb.addClass('active');
		$(this).parents('li').addClass('active').siblings().removeClass('active');
	});
	$gnb.on('focusout mouseleave', function(){
		$gnb.removeClass('active');
		$gnb.find('li').removeClass('active');
	});
});	
</script>
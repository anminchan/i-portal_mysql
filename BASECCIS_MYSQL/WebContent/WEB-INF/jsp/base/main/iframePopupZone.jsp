<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<link rel="stylesheet" href="${contextPath }/resources/css/common/main.css" />
<!-- 공통 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="http://www.khidi.or.kr/resources/js/scrolling.js" ></script>
<script type="text/javascript">
var gContextPath = "${contextPath }";
  
</script>

	<c:set var="strClass" value="popup_area"/>
	<%-- <c:set var="strWeight" value="width:100%;"/>
	<c:set var="strHeight" value=""/>
	<c:if test="${!empty param.css }">
		<c:set var="strClass" value="${param.css }"/>
	</c:if> --%>
	<c:set var="popupZoneCnt" value="0" />
		
	<%//비주얼영역에 콘텐츠가 등록되어 있을경우 %>
	<div class="${strClass }">
		<h2 class="title_hidden">팝업존</h2>					
		<c:if test="${fn:length(rtnPopupZoneList) > 1 }">
		<div class="btn_control">
			<button type="button" id="Popup-Prev" class="btn_prev">이전</button>
			<button type="button" id="Popup-Stop" class="btn_stop">정지</button>
			<button type="button" id="Popup-Start" class="btn_play" style="display: none;">시작</button>
			<button type="button" id="Popup-Next" class="btn_next">다음</button>
		</div>
		</c:if>
		<ul id="Popup-Wrapper" class="popup_list">
			<c:forEach items="${rtnPopupZoneList }" var="list" varStatus="loop">
				<li>
					<div ${loop.index eq 0 ? 'style="display:block;"' : 'style="display:none;"' }>
					<c:set var="linkURL" value="${list.linkURL}" />
					<c:if test="${linkURL eq '' or linkURL eq '-' or linkURL eq null or linkURL eq '#'}">
						<c:set var="linkUrl" value="#" />
					</c:if>
					<c:if test="${linkUrl ne '#' and list.newWindowYn == 'Y'}">
						<a href="${linkURL}" target="_blank" title="새창으로 열림">
							<img src="${contextPath}/fileDownload?fileGubun=common&menuId=popupZoneMgr&userFileName=${list.imageFileName }&systemFileName=${list.imageSFileName }" alt="${list.KDesc }" />
						</a>
					</c:if>
					<c:if test="${linkUrl ne '#' and list.newWindowYn == 'N'}">
						<a href="${linkURL}" target="_parent">
							<img src="${contextPath}/fileDownload?fileGubun=common&menuId=popupZoneMgr&userFileName=${list.imageFileName }&systemFileName=${list.imageSFileName }" alt="${list.KDesc }" />
						</a>
					</c:if>
					<c:if test="${linkUrl eq '#'}">
						<img src="${contextPath}/fileDownload?fileGubun=common&menuId=popupZoneMgr&userFileName=${list.imageFileName }&systemFileName=${list.imageSFileName }" alt="${list.KDesc }" />
					</c:if>
					</div>
				</li>
			<c:set var="popupZoneCnt" value="${popupZoneCnt + 1 }" />
			</c:forEach>
		</ul>
	</div>

	<script type="text/javascript">
	<c:if test="${popupZoneCnt ne 0}">
		var ObjScrollingPopup = new ScrollingPopup("Popup-Wrapper"); // 팝업존 슬라이더
	</c:if>
	</script>

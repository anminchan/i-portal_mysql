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

	<%-- <c:set var="strClass" value="topCont_area visual_widthLong"/>
	<c:set var="strWeight" value="width:100%;"/>
	<c:set var="strHeight" value=""/>
	<c:if test="${!empty param.css }">
		<c:set var="strClass" value="${param.css }"/>
	</c:if>
	<c:if test="${!empty param.width }">
		<c:set var="strWeight" value=" width:${param.width };"/>
	</c:if>
	<c:if test="${!empty param.height }">
		<c:set var="strWeight" value=" height:${param.width };"/>
	</c:if>

	<c:set var="styleHeight" value="" />
	<c:set var="visualZoneCnt" value="0" />
	<c:if test="${dynamicSiteInfo.HEIGHT ne '0' and !empty dynamicSiteInfo.HEIGHT}">
		<c:set var="styleHeight" value="height:${dynamicSiteInfo.HEIGHT}px;" />
	</c:if> --%>

	<c:set var="visualZoneCnt" value="0" />

	<c:set var="visualHtml" value="" />
	<c:forEach items="${contentList }" var="data" varStatus="loop">
		<c:if test="${data.DIVID eq '0000'}">
			<c:set var="visualHtml" value="${data.KHTML}"/>
		</c:if>
	</c:forEach>
	<%//비주얼영역에 콘텐츠가 등록되어 있을경우 %>
	<c:if test="${!empty visualHtml }">
		${visualHtml}
	</c:if>
	<c:if test="${empty visualHtml }">
	<%-- <div class="${strClass}" style="${strWeight}${strHeight}"> --%>
		<%-- <div class="visual_area" style="${styleHeight}"> --%>
		<div class="visual_area">
			<div class="btn_control">
				<a href="#void" id="Visual-Prev" class="btn_prev">이전 비쥬얼</a>
				<a href="#void" id="Visual-Stop" class="btn_stop">비쥬얼 정지</a>
				<a href="#void" id="Visual-Start" class="btn_play" style="display: none;">비쥬얼 시작</a>
				<a href="#void" id="Visual-Next" class="btn_next">다음 비쥬얼</a>
			</div>
			<ul class="visual_list" id="Visual-Wrapper">
				<c:forEach items="${rtnVisualZoneList }" var="list" varStatus="loop">
					<li>
						<div ${loop.index eq 0 ? 'style="display:block;"' : 'style="display:none;"' }>
						<%-- <a href="${list.linkURL}" ${list.newWindowYn == 'Y' ? 'target="_blank"' : ''}> --%>
						<a href="${list.linkURL}" <c:if test="${list.linkURL ne '#' and list.newWindowYn == 'Y'}">target="_blank"</c:if><c:if test="${list.linkURL ne '#' and list.newWindowYn == 'N'}">target="_parent"</c:if>>
							<img src="${contextPath}/fileDownload?fileGubun=common&menuId=visualZoneMgr&userFileName=${list.imageFileName }&systemFileName=${list.imageSFileName }" alt="${list.KName }" />
						</a>
						</div>
					</li>
				<c:set var="visualZoneCnt" value="${visualZoneCnt + 1 }" />
				</c:forEach>
			</ul>

		</div>
	<!-- </div> -->
	<script type="text/javascript">
		<c:if test="${visualZoneCnt ne 0}">
			var ObjScrollingVisual = new ScrollingVisual("Visual-Wrapper"); // 비주얼영역 슬라이더
			<c:if test="${visualZoneCnt < 2}">
				$(".btn_control").hide();
			</c:if>
		</c:if>
	</script>
	</c:if>
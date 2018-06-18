<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<link rel="stylesheet" href="${contextPath }/resources/css/common/main.css" />
<!-- 공통 js -->
<script src="${contextPath }/resources/js/lib/jquery/jquery-1.12.3.min.js"></script>
<script src="${contextPath }/resources/js/lib/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript">
var gContextPath = "${contextPath }";
  
</script>
	
<c:set var="firstMenuId" value=""/>
<c:set var="firstMenuName" value=""/>

<c:set var="strClass" value=""/>
<c:if test="${!empty param.css }">
	<c:set var="strClass" value="${param.css }"/>
</c:if>
<c:set var="menu"><c:out value='${param.menu }'/></c:set>

<c:if test="${strClass == '' || empty strClass }">
<c:choose>
	<c:when test="${fn:indexOf(menu,'|') > -1}">
		<div class="iframe_inside tabnews_area" id="ifmDivTab">
			<ul class="tab_newsitem">
			<c:set var="menuData" value="${fn:split(menu,'|')}" />
			<c:forEach var="data" items="${menuData}" varStatus="dataLoop">
				<c:set var="menuSplit" value="${fn:split(data,'^')}" />
				<c:if test="${dataLoop.index eq 0 }">
					<c:set var="firstMenuId" value="${menuSplit[0] }"/>
					<c:set var="firstMenuName" value="${menuSplit[1] }"/>
				</c:if>
				<li menuId="${menuSplit[0] }" id="title${menuSplit[0] }" class="on titleOn"><a href="javascript:fnCBoardIFrameTabMove('ifmDivTab','${menuSplit[0] }','${menuSplit[1] }');">${menuSplit[1] }</a></li>
			</c:forEach> 
			</ul>			
			<p class="txt_more"><a href="javascript:return false;" class="moreView">더보기</a></p>
		</div>
	</c:when>
	<c:otherwise>
		<div class="iframe_inside news_area" id="ifmDivTab">
			<c:set var="menuSplit" value="${fn:split(menu,'^')}" />
			<c:set var="firstMenuId" value="${menuSplit[0] }"/>
			<c:set var="firstMenuName" value="${menuSplit[1] }"/>
			<p class="txt_more"><a href="javascript:moreSingleView('${menuSplit[0] }');">더보기</a></p>
		</div>
	</c:otherwise>
</c:choose>
</c:if>

<c:if test="${strClass == 'photo_area' }">
	<div class="iframe_inside photo_area" id="ifmDivTab">
		<c:set var="menuSplit" value="${fn:split(menu,'^')}" />
		<c:set var="firstMenuId" value="${menuSplit[0] }"/>
		<c:set var="firstMenuName" value="${menuSplit[1] }"/>
		<p class="txt_more"><a href="javascript:moreSingleView('${menuSplit[0] }');">더보기</a></p>
	</div>
</c:if>
	
<script type="text/javascript">

	$(function() {
		// Tab 더보기
		$(document).on('click', '.moreView', function(){
			var strDivId = $(this).closest('div').attr('id');
			var strMenuId = $("#" + strDivId +">ul>li.on").attr('menuId');
			window.parent.location.href = "${contextPath}/board?menuId=" + strMenuId;
		});

		// 상세보기
		$(document).on('click', '.goView', function(){
			var strUrl = $(this).attr('goLink');
			window.parent.location.href = strUrl;
		});

		//첫번째 탭 리스트 호출
		fnCBoardIFrameTabMove("ifmDivTab", "${firstMenuId}", "${firstMenuName}");
	});
	
	// 싱글 더보기
	function moreSingleView(menuId){
		window.parent.location.href = "${contextPath}/board?menuId=" + menuId;
	}

	// 게시판 탭 메뉴 클릭 시 : 탭id, 메뉴id, 메뉴명
	function fnCBoardIFrameTabMove(strTabId, strMenuId, strMenuName){
		var rowCnt = 5; // 페이지당 리스트수
		$.ajax({
	 		url: gContextPath+"/board/listCBoard",
	 		data: {'menuId' : strMenuId, 'rowCnt' : rowCnt},
	 		async: false,
	 		cache: false,
	 		success:function(data, textStatus, jqXHR) {
	 			if(data != null) {
 					$("#"+strTabId+" .listContent").remove();
 					$("#"+strTabId+" .txt_more").remove();
 					
 					<c:if test="${param.css == '' || empty param.css}">
	 					<c:if test="${fn:indexOf(menu,'|') > -1}">
						$("#"+strTabId).append('<h2 class="title_hidden listContent">'+strMenuName+'</h2>');
						</c:if>
						<c:if test="${fn:indexOf(menu,'|') <= -1}">
						$("#"+strTabId).append('<h2 class="txt_title">'+strMenuName+'</h2>');
						</c:if>
						
						$("#"+strTabId).append('<ul class="news_list listContent" id="list'+strMenuId+'"></ul>');
 					</c:if>
 					
 					<c:if test="${param.css == 'photo_area'}">
						$("#"+strTabId).append('<h2 class="txt_title">'+strMenuName+'</h2>');
						
						$("#"+strTabId).append('<ul class="photo_list listContent" id="list'+strMenuId+'"></ul>');
 					</c:if>
					
	 				if(data != ""){
	 					// 게시판 게시글 조회
		 	 			$.each(data, function(i, item) {
		 	 				var strTitle =item.KNAME;
		 	 				// 게시판 제목 substring
		 	 				if(strTitle>=25 ) strTitle = strTitle.substring(0,25)+"...";
		 	 				
		 	 				
		 	 				<c:if test="${param.css == '' || empty param.css}">
			 	 				// 게시글 boardKind 확인 후 세팅
			 	 				if(item.BOARDKIND == 'CLIPPING'){
				 					$("#list"+strMenuId).append('<li><a href="'+item.LINKURL+'" target="_blank">'+strTitle+'</a><span class="date">'+item.INSTIME+'</span></li>');
			 	 				}else{
			 	 					// 게시판 게시글 세팅
				 					$("#list"+strMenuId).append('<li><a href="javascript:;" class="goView" goLink="${contextPath}/board/view?linkId='+item.LINKID+'&menuId='+strMenuId+'&refMenuId='+item.MENUID+'">'+strTitle+'</a><span class="date">'+item.INSTIME+'</span></li>');
			 	 				}
		 	 				</c:if>
		 	 				<c:if test="${param.css == 'photo_area'}">
		 	 					if(i<=1){
		 	 						$("#list"+strMenuId).append('<li><span class="thumb"><a href="javascript:;" class="goView" goLink="${contextPath}/board/view?linkId='+item.LINKID+'&menuId='+strMenuId+'">'
		 	 								                  + '<img alt="" src="/fileDownload?titleId=127070"/></a></span>'
		 	 								                  + '<a href="javascript:;" class="goView" goLink="${contextPath}/board/view?linkId='+item.LINKID+'&menuId='+strMenuId+'">'+strTitle+'</a></li>');
		 	 					}
		 	 				</c:if>
						});
	 				}else{
	 				    // 게시판 게시글 세팅
	 					$("#list"+strMenuId).append('<li> 조회된 데이터가 없습니다. </li>');
	 				}
	 				
	 				<c:if test="${param.css == '' || empty param.css}">
		 				<c:if test="${fn:indexOf(menu,'|') > -1}"> // Tab리스트
		 				$("#"+strTabId).append('<p class="txt_more"><a href="javascript:;" class="moreView">더보기</a></p>');
		 				</c:if>
		 				<c:if test="${fn:indexOf(menu,'|') <= -1}"> // 싱글리스트
		 				$("#"+strTabId).append('<p class="txt_more"><a href="javascript:moreSingleView(\''+strMenuId+'\');">더보기</a></p>');
		 				</c:if>
	 				</c:if>
		 				
	 				<c:if test="${param.css == 'photo_area'}">
	 					$("#"+strTabId).append('<p class="txt_more"><a href="javascript:;" class="moreView">더보기</a></p>');
					</c:if>
					
					<c:if test="${param.css == '' || empty param.css}">
						// 탭선택 시 이미지 변경 class 세팅
		 				$(".titleOn").prop('class', '');
		 				$("#title"+strMenuId).prop('class', 'on titleOn');
	 				</c:if>
	 				
	 			}
	 		}
	 	});
	}
	
</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
		
<!-- visual -->
<div id="mvisual">
	<ul class="visual_list">
		<c:forEach items="${rtnVisualZoneList }" var="data">
			<li>
				<strong class="eng"><img src="${contextPath}/resources/images/mps/main/visual_txt.png" alt="The Bridge to  Change"></strong>
				<span class="kor">비전과 가능성을 연결하는 사람들</span>
				<%-- <span class="img">
					<img src="${contextPath}/fileDownload?fileGubun=common&menuId=visualZoneMgr&userFileName=${data.imageFileName}&systemFileName=${data.imageSFileName}" alt="${data.KDesc}"/>
				</span> --%>
				<span class="img">
					<img src="${contextPath}/resources/images/mps/main/visual01.jpg" alt="비전과 가능성을 연결하는 사람들"/>
				</span>
			</li>
		</c:forEach>
	</ul>
</div>
<!-- //visual -->
<!-- contents body -->
<section class="section_first">
	<article class="notice_area">
		<h2 class="subject">공지사항</h2>
		<ul class="notice__list">
			<c:forEach items="${rtnBoardList }" var="data">
				<li><a href="/board/view?menuId=${data.MENUID }&linkId=${data.LINKID}">
						<strong><c:if test="${data.NOTICETITLEYN eq 'Y'}"><i class="xi-volume-up"><span class="hidden">공지</span></i></c:if> ${data.KNAME }</strong>
						<p>${data.KHTML }</p>
					</a>
					<span class="date"><dateFormat:dateFormat addPattern="." value="${data.INSTIME}" /> <span class="day">${fn:substring(data.INSTIME, 6, 8)}</span></span>
				</li>
			</c:forEach>
		</ul>
		<c:if test="${fn:length(rtnBoardList) > 0 }">
			<p class="more"><a href="/menu?menuId=${rtnBoardList[0].MENUID  }"><i class="xi-plus"></i><span class="hidden">더보기</span></a></p>
		</c:if>
	</article>
	<article class="popup_area">
		<h2 class="hidden">팝업존</h2>
		<ul class="popup_list">
			<c:forEach items="${rtnPopupZoneList }" var="data">
				<li>
					<a href="#">
						<img src="${contextPath}/fileDownload?fileGubun=common&menuId=popupZoneMgr&userFileName=${data.imageFileName}&systemFileName=${data.imageSFileName}" alt="${data.KDesc}"/>
					</a>
				</li>
			</c:forEach>
		</ul>
	</article>		
</section>
<!-- //contents body -->

<script type="text/javascript">
$(function(){
	try{ 
		$('article.popup_area').PopupZone
		({
			'delay'				: 3,											// 변경 딜레이
			'popupzone_name'	: '.popup_list'									// popup obj
		}); 
	}catch (e) { 
	
	}
	
});
</script>
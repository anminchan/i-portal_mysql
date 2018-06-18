<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/includes/taglib.jsp" %>

<!-- 하단 area -->
<footer id="footer">	
	<div class="wrap_con">
		<!-- <ul class="fsidemenu">
			<li><a href="">이용약관</a></li>
			<li><a href="" class="point02">개인정보처리방침</a></li>
			<li><a href="">이메일수집거부</a></li>
			<li><a href="">오시는길</a></li>
			<li><a href="">사이트맵</a></li>
		</ul> -->
		<div class="select_link">
			<strong class="link_title"><a href="Javascript:fnFamilySiteClick();">관련사이트<i class="xi-arrow-up"></i></a></strong>
			<ul class="link_site">
				<c:forEach items="${rtnFamilySiteList }" var="data">
					<li><a href="${data.linkURL }" <c:if test="${data.newWindowYn == 'Y'}">target="_blank" title="새창으로 열림"</c:if>>${data.KName }</a></li>
				</c:forEach>			          
			</ul>
		</div>
	</div>
	<p class="copyright">Coptyright 2017 © Plani. ALL Rights Reserved.</p>
</footer>
<!-- //하단 area -->
<script type="text/javascript">
function fnFamilySiteClick(){
	var dispalyAttr = $(".link_site").css('display');
	if(dispalyAttr == "none"){
		$(".link_site").css('display', 'block');
	}else{		
		$(".link_site").css('display', 'none');
	}
}
</script>
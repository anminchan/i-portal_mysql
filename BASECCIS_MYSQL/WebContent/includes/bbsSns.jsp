<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>

<script type="text/javascript">
<!--

$(window).load(function(){
	// SNS 공유하기
	var urlFaceBook = "http://www.facebook.com/sharer.php?u=" + encodeURIComponent("http://localhost/board/view?menuId=${obj.menuId}&linkId=${obj.linkId }");
	var urlTwitter = "http://twitter.com/share?status=" + encodeURIComponent("http://localhost/board/view?menuId=${obj.menuId}&linkId=${obj.linkId }");
	$(".facebook a").attr("href", urlFaceBook);
	$(".twitter a").attr("href", urlTwitter);
	
});

//-->
</script>

<c:if test="${rtnSetting.snsYN == 'Y' }">
	<div class="float_wrap">
		<ul class="sns_share">
			<li class="twitter"><a href="#" target="_blank" title="새창으로 열림">트위터</a></li>
			<li class="facebook"><a href="#" target="_blank" title="새창으로 열림">페이스북</a></li>
		</ul>
	</div>	
</c:if>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"  %>
<%@ taglib prefix="tiles" uri="/WEB-INF/tld/tiles-jsp.tld" %>

<c:if test="${!empty menuInfo.CHARGEUSER_NAME}">
	<dl class="autonomy_person">
		<dt>콘텐츠 담당 :</dt>
		<dd>${menuInfo.CHARGEUSER_NAME }</dd>
		<dt>연락처 :</dt>
		<dd></dd>
		<dt>이메일</dt>
		<dd>${menuInfo.CHARGEUSERID }</dd>
	</dl>
</c:if>
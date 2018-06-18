<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><?xml version="1.0" encoding="utf-8" ?>
<%@ include file="/includes/taglib.jsp" %>
<rss version="2.0">
	<channel>
		<title>${menuKName }</title>
		<description>RSS 설명</description>
		<link>www.khidi.or.kr</link>
		<language>ko</language>
		<copyright>COPYRIGHT 2015 KOREA HEALTH INDUSTRY DEVELOPMENT INSTITUTE. ALL RIGHTS RESERVED.</copyright>
		<webMaster>www.khidi.or.kr</webMaster>
		<c:forEach items="${result }" var="list" varStatus="loop">
		<item>
			<title><![CDATA[${list.KNAME}]]></title>
			<description><![CDATA[${list.KHTML}]]></description>
			<link><![CDATA[${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&linkId=${list.LINKID }${link}]]></link>
		</item>
		</c:forEach>
	</channel>
</rss>
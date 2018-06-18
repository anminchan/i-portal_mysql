<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% 
	// html소스를 스크립트에서 줄바꿈없이 불러올 시 종결되지 않은 문자열 오류 때문에 jstl 치환 사용 
	pageContext.setAttribute("crcn", "\r\n"); 
%>
<%@ include file="/includes/taglib.jsp" %>
<div style="width: 790px; margin:0 auto; padding: 10px 30px 30px; background: #f0f2f5; font-family: '맑은 고딕', Malgun Gothic, '돋움', Dotum, '굴림', san-serif; overflow: hidden;">
	<c:choose>
		<c:when test="${newsLetter.TEMPLATE eq 'TYPE00'}">
			<div class="logo_vol" style="height: 40px; line-height: 1;overflow: hidden;">
				<h1 class="logo" style="float: left; margin: 0; padding: 0; ">
				</h1>
				<p class="vol" style="float: right; margin: 0; padding: 0; color: #252525; font-size: 14px; font-weight: bold;">
					<span class="date" style="display: inline-block; margin-right: 2px;color: #6c6d70;font-weight: normal;"><c:if test="${!empty newsLetter.PUBDATE}"><fmt:formatDate value="${newsLetter.PUBDATE}" pattern="yyyy/MM/dd" /></c:if> 발행</span>
					뉴스레터
					<span class="num" style="font-size: 22px;">Vol.<c:out value="${newsLetter.PUBNO}"/></span>
				</p>
			</div>
		</c:when>

		<c:when test="${newsLetter.TEMPLATE eq 'TYPE02'}">
			<h1 style="height: 40px; margin:0; padding: 40px 0 0; background: #f0f2f5; overflow: hidden;">
				<span style="display: block; float: left;">
				</span>
				<span style="display: block; float: right;">
				</span>
			</h1>
		</c:when>

		<c:when test="${newsLetter.TEMPLATE eq 'TYPE03'}">
			<div class="logo_vol" style="height: 23px;margin-bottom: 18px;line-height: 1;overflow: hidden;">
				<h1 style="height: 39px; margin:0; padding:0; background: #f0f2f5; text-align: right; overflow: hidden;">
				</h1>
			</div>
		</c:when>
	</c:choose>

	<div class="newsLetter_box" style="background: #fff; border: solid 1px #c9cacc; border-bottom-color: solid 1px #c9cacc; overflow: hidden;">
		<c:choose>
			<c:when test="${newsLetter.TEMPLATE eq 'TYPE00'}">
				<div class="newsletter_visual" style="height: 280px; border-bottom: none; overflow: hidden;">
					<c:choose>
						<c:when test="${newsLetter.UPIMAGE eq 'image'}">
							<img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${newsLetter.UPIMAGEFILENAME}&systemFileName=${newsLetter.UPIMAGESFILENAME}" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
						</c:when>
						<c:when test="${newsLetter.UPIMAGE eq 'html'}">
							${newsLetter.UPIMAGEHTML}
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
			</c:when>

			<c:when test="${newsLetter.TEMPLATE eq 'TYPE02'}">
				<div class="newsletter_visual" style="height: 280px; border-bottom: none; overflow: hidden;">
					<c:choose>
						<c:when test="${newsLetter.UPIMAGE eq 'image'}">
							<img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${newsLetter.UPIMAGEFILENAME}&systemFileName=${newsLetter.UPIMAGESFILENAME}" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
						</c:when>
						<c:when test="${newsLetter.UPIMAGE eq 'html'}">
							${newsLetter.UPIMAGEHTML}
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
			</c:when>

			<c:when test="${newsLetter.TEMPLATE eq 'TYPE03'}">
				<div class="newsletter_visual mdi_visual" style="height: 250px; border-bottom: none; overflow: hidden;">
					<c:choose>
						<c:when test="${newsLetter.UPIMAGE eq 'image'}">
							<img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${newsLetter.UPIMAGEFILENAME}&systemFileName=${newsLetter.UPIMAGESFILENAME}" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
						</c:when>
						<c:when test="${newsLetter.UPIMAGE eq 'html'}">
							${newsLetter.UPIMAGEHTML}
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
			</c:when>
		</c:choose>

		<!-- 뉴스레터 포틀릿 구조 생성 -->
		<c:if test="${!empty portletList}">
			<div id="newsletter_content" style="margin: 30px 29px; padding-bottom: 60px; background: #fff; color: #6c6d70; font-size: 13px; border-bottom: dashed 1px #b5b6b6; overflow: hidden;">
				<c:forEach var="row" items="${portletLineList}" varStatus="rowIndex">
					<div id="${row.LINEID}" class="float_wrap" style="width: 100%; margin-top: 40px; overflow: hidden;">
						<c:set var="colData" value="${fn:split(row.LINETYPE,'-')}" />
						<c:forEach var="col" items="${colData}" varStatus="colIndex">
							<c:choose>
								<c:when test="${colIndex.index eq 0}">
									<c:set var="marginLeft" value="0"/>
								</c:when>
								<c:otherwise>
									<c:set var="marginLeft" value="26"/>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${col eq 'S'}">
									<div class="col contype_xs" id="0${rowIndex.count-1}0${colIndex.count-1}${col}" style="float: left; width: 163px; height: 100%; margin-left: ${marginLeft}px; overflow: hidden;">
								</c:when>
								<c:when test="${col eq 'M'}">
									<div class="col contype_md" id="0${rowIndex.count-1}0${colIndex.count-1}${col}" style="float: left; width: 352px; height: 100%; margin-left: ${marginLeft}px;overflow: hidden;">
								</c:when>
								<c:when test="${col eq 'L'}">
									<div class="col contype_lg" id="0${rowIndex.count-1}0${colIndex.count-1}${col}" style="float: left; width: 541px; height: 100%; margin-left: ${marginLeft}px; overflow: hidden;">
								</c:when>
								<c:when test="${col eq 'F'}">
									<div class="col contype_full" id="0${rowIndex.count-1}0${colIndex.count-1}${col}" style="float: left; width: 541px; height: 100%; margin-left: ${marginLeft}px; overflow: hidden;">
								</c:when>
								<c:otherwise>
									<div class="col contype_full" id="0${rowIndex.count-1}0${colIndex.count-1}${col}" style="float: left; width: 541px; height: 100%; margin-left: ${marginLeft}px; overflow: hidden;">
								</c:otherwise>
							</c:choose>

							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
		</c:if>

		<c:choose>
			<c:when test="${newsLetter.TEMPLATE eq 'TYPE00'}">
			</c:when>

			<c:when test="${newsLetter.TEMPLATE eq 'TYPE02'}">
			</c:when>

			<c:when test="${newsLetter.TEMPLATE eq 'TYPE03'}">
			</c:when>
		</c:choose>
	</div>

	<c:choose>
		<c:when test="${newsLetter.TEMPLATE eq 'TYPE00'}">
		</c:when>

		<c:when test="${newsLetter.TEMPLATE eq 'TYPE02'}">
		</c:when>

		<c:when test="${newsLetter.TEMPLATE eq 'TYPE03'}">
		</c:when>
	</c:choose>
</div>

<script type="text/javascript">

	window.onload = function()
	{
		<c:if test="${!empty portletList}">
			<c:forEach items="${portletList}" var="portlet" varStatus="index">
				<c:forEach items="${portlet.newsLetterPortletContentsList}" var="portletContents"  varStatus="index">
					<c:set var ="html" value="${portletContents.html}"/>
					<c:set var ="html" value="${fn:replace(html, crcn, '')}"/>
					<c:set var ="html" value="${fn:replace(html, '\\'', '')}"/>
					
					setPortletContentsData('${portlet.divId}', '${portlet.portletType}', '${portletContents.subject}', '${portletContents.link}', '${portletContents.userImgFileName}', '${portletContents.systemImgFileName}', '${portletContents.imgFilePath}', '${portletContents.imgDesc}', '${fn:replace(portletContents.contents, crcn, "<br />")}', '${html}', '${portlet.contents_title_use}', '${portlet.contents_title}');
				</c:forEach>
			</c:forEach>
		</c:if>
		
		// body안의 동적생성된 html소스중 script코드를 제거한 소스로 body갱신 (메일 발송용 html추출, 메일 발송시 스크립트 구문 포함 시 깨짐) 
		var html = document.documentElement.innerHTML;
		html = html.split("<body>")[1];
		var lastIndex = html.lastIndexOf("</div>");
		html = html.substring(0, lastIndex);
		if(html.indexOf("<script") > -1){
			html = html.split("<script")[0];
		}
		$("body").html(html);
	}

	function setPortletContentsData(portletId, portletType, subject, link, userImgFileName, systemImgFileName, imgFilePath, imgDesc, contents, html, contents_title_use, contents_title)
	{
		
		var portletDiv = $("#" + portletId);
		var contentsHtml = '';

		if ( $.trim(portletDiv.text()) == '' && contents_title_use != 'N' )
			contentsHtml =	'<h2 class="subject" style="margin: 0 0 18px 0; padding: 0 0 2px 33px; background: url(${currentUrl}${contextPath}/resources/images/newsletter/common/title_arrow.gif) no-repeat 0 2px; color: #333; font-size: 19px; letter-spacing: -0.05em; line-height: 1.3;">' + (contents_title ? contents_title : '') + '</h2>';

		if ( portletType == 'S' )
		{
			if ( $.trim(portletDiv.text()) == '' )
			{
				contentsHtml +=	'	<ul style="margin: 0; padding: 0; line-height: 1.8; letter-spacing: -0.05em;">';
			}

			contentsHtml +=	'<li style="margin: 0px; padding: 0px 0px 0px 8px; background: url(&quot;${currentUrl}${contextPath}/resources/images/common/content/gray_dot.gif&quot;) no-repeat 0px 10px; list-style: none; overflow: hidden;">' +
							'	<a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank">' + subject + '</a>' +
							'</li>';

			if ( $.trim(portletDiv.text()) == '' )
			{
				contentsHtml +=	'	</ul>';

				portletDiv.append(contentsHtml);
			}
			else
			{
				portletDiv.children("ul").append(contentsHtml);
			}
		}
		else if ( portletType == 'SC' )
		{
			contentsHtml +=	'<h3 style="margin: ' + ( $.trim(portletDiv.text()) == '' ? '0' : '25px' ) + ' 0 10px 0; padding: 0; color: #45474d; letter-spacing: -0.05em; font-size: 16px;">';
			
			if(link ==''){
				contentsHtml += subject + '</h3>';
			}else{
				contentsHtml += '<a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank">' ;
				contentsHtml += subject; 
				contentsHtml +='</a></h3>';
			}

			if(link ==''){	
				contentsHtml +='<p style="margin: 0; padding: 0; line-height: 1.5; overflow: hidden;">' + contents + '</p>';
			}else{
				contentsHtml +='<p style="margin: 0; padding: 0; line-height: 1.5; overflow: hidden;"><a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank">' + contents + '</a></p>';
			}							
							
							
							
			portletDiv.append(contentsHtml);
		}
		else if ( portletType == 'IC' )
		{
			contentsHtml +=	'<div style="overflow: hidden; margin-top: '+ ( $.trim(portletDiv.text()) == '' ? '0' : '25px' ) + ';">' +
							'	<div style="float: left; width: 126px; height: 117px; margin-right: 15px; overflow: hidden;">';
							
			if(link ==''){
				contentsHtml += '<img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=' + userImgFileName + '&systemFileName=' + systemImgFileName + '" border="0" alt="" style="width: 100%;"/>';
			}else{
				contentsHtml += '<a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank"><img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=' + userImgFileName + '&systemFileName=' + systemImgFileName + '" border="0" alt="" style="width: 100%;"/></a>';
			}
			
			if(link ==''){
				contentsHtml +='	</div><p style="margin: 0; padding: 0; line-height: 1.5; overflow: hidden;">' + contents + '</p></div>';
			}else{
				contentsHtml +='	</div><p style="margin: 0; padding: 0; line-height: 1.5; overflow: hidden;"><a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank">' + contents + '</a></p></div>';
			}				
							
			portletDiv.append(contentsHtml);
		}
		else if ( portletType == 'ISC' )
		{
			contentsHtml +=	'<div style="overflow: hidden; margin-top: '+ ( $.trim(portletDiv.text()) == '' ? '0' : '25px' ) + ';">' +
							'	<div style="float: left; width: 126px; height: 117px; margin-right: 15px; overflow: hidden;">' +
							'		<img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=' + userImgFileName + '&systemFileName=' + systemImgFileName + '" border="0" alt="" style="width: 100%;"/>' +
							'	</div>' +
							'	<div style="float: left; width: 210px;">';
							
			if(link ==''){
				contentsHtml += '<h3 style="margin: 0 0 13px 0; padding: 0; color: #45474d; letter-spacing: -0.05em; font-size: 15px;">';
				contentsHtml += subject;
				contentsHtml +='</h3>';
			}else{
				contentsHtml += '<h3 style="margin: 0 0 13px 0; padding: 0; color: #45474d; letter-spacing: -0.05em; font-size: 15px;"><a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank">';
				contentsHtml += subject; 
				contentsHtml += '</a></h3>';
			}
			
			if(link ==''){
				contentsHtml +='	<p style="margin: 0; padding: 0; line-height: 1.5; overflow: hidden;">' + contents + '</p></div></div>';
			}else{
				contentsHtml +='	<p style="margin: 0; padding: 0; line-height: 1.5; overflow: hidden;"><a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank">' + contents + '</a></p></div></div>';
			}				

			portletDiv.append(contentsHtml);
		}
		else if ( portletType == 'I' )
		{
			contentsHtml +=	'<p style="margin: 0; padding:0;">';
			
			if(link ==''){
				contentsHtml += '<img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=' + userImgFileName + '&systemFileName=' + systemImgFileName + '" alt="" style="width: 100%;"/>';
			}else{
				contentsHtml += '<a style="display: block; color: #45474d; text-decoration: none; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" href="' + link + '" target="_blank"><img src="${currentUrl}${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=' + userImgFileName + '&systemFileName=' + systemImgFileName + '" alt="" style="width: 100%;"/></a>';
			}	
			contentsHtml +='</p>';

			portletDiv.append(contentsHtml);
		}
		else if ( portletType == 'H' )
		{
			contentsHtml +=	'<pre style="height: 80px; margin: 0; padding: 0; line-height: 1.5; overflow: hidden;">' + html + '</pre>';

			portletDiv.append(contentsHtml);
		}
	}
		
</script>
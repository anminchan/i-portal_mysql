<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
	// html소스를 스크립트에서 줄바꿈없이 불러올 시 종결되지 않은 문자열 오류 때문에 jstl 치환 사용 
	pageContext.setAttribute("crcn", "\r\n"); 
%>

<%@ include file="/includes/taglib.jsp" %>

<link rel="stylesheet" href="${contextPath}/resources/css/ips/popup.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/common/newsletter.css" />

<spform:form id="insertForm" name="insertForm" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum}"/>
	<input type="hidden" id="schText" name="schText" value="${param.schText}"/>
	<input type="hidden" name="inDMLData" id="inDMLData" value="">
	<input type="hidden" name="saveStatus" id="saveStatus" value="">

	<input type="hidden" id="siteId" name="siteId" value="${newsletter.SITEID}"/>
	<input type="hidden" id="state" name="state" value="T"/>
	<input type="hidden" id="newsLetterId" name="newsLetterId" value="${newsletter.NEWSLETTERID}"/>
	<input type="hidden" id="version" name="version" value="1"/>

	<!-- 이미지 파일 hidden - (이미지에서 이미지등록 선택 시 필요)  -->
	<input type="hidden" name="upImageFileName" id="upImageFileName" value="${newsletter.UPIMAGEFILENAME}" />
	<input type="hidden" name="upImageSFileName" id="upImageSFileName" value="${newsletter.UPIMAGESFILENAME}" />
	<input type="hidden" name="upImageFilePath" id="upImageFilePath" value="${newsletter.UPIMAGEFILEPATH}" />

	<fieldset>
	<legend>뉴스레터 생성</legend>
	<!-- 뉴스레터 포틀릿 설정-->
	<article class="newsletter_wrap">
		<c:choose>
			<c:when test="${newsletter.TEMPLATE eq 'TYPE00'}">
				<header class="logo_vol">
					<h1 class="logo"></h1>
					<p class="vol">
						<span class="date">
							<c:if test="${!empty newsletter.PUBDATE}">
								<fmt:formatDate value="${newsletter.PUBDATE}" pattern="yyyy/MM/dd" /> 발행
							</c:if>
						</span>
						뉴스레터
						<span class="num">Vol.<c:out value="${newsletter.PUBNO}"/></span>
					</p>
				</header>
			</c:when>

			<c:when test="${newsletter.TEMPLATE eq 'TYPE02'}">
				<h1 class="logo_vol">
					<span class="float_left">
						
					</span>
					<span class="float_right">
						
					</span>
				</h1>
			</c:when>

			<c:when test="${newsletter.TEMPLATE eq 'TYPE03'}">
				<div class="logo_vol">
					<h1 class="txt_right">
						
					</h1>
				</div>
			</c:when>
		</c:choose>

		<div class="newsletter_box">
			<c:choose>
				<c:when test="${newsletter.TEMPLATE eq 'TYPE00'}">
					<div class="newsletter_visual">
						<c:choose>
							<c:when test="${newsletter.UPIMAGE eq 'image'}">
								<img src="${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${newsletter.UPIMAGEFILENAME}&systemFileName=${newsletter.UPIMAGESFILENAME}" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
							</c:when>
							<c:when test="${newsletter.UPIMAGE eq 'html'}">
								${newsletter.UPIMAGEHTML}
							</c:when>
							<c:otherwise>
								<img src="${contextPath}/resources/images/newsletter/mps/visual<c:if test="${!empty newsletter.UPIMAGE and newsletter.UPIMAGE ne 'default'}">_${newsletter.UPIMAGE}</c:if>.jpg" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>

				<c:when test="${newsletter.TEMPLATE eq 'TYPE02'}">
					<div class="newsletter_visual">
						<c:choose>
							<c:when test="${newsletter.UPIMAGE eq 'image'}">
								<img src="${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${newsletter.UPIMAGEFILENAME}&systemFileName=${newsletter.UPIMAGESFILENAME}" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
							</c:when>
							<c:when test="${newsletter.UPIMAGE eq 'html'}">
								${newsletter.UPIMAGEHTML}
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>

				<c:when test="${newsletter.TEMPLATE eq 'TYPE03'}">
					<div class="newsletter_visual">
						<c:choose>
							<c:when test="${newsletter.UPIMAGE eq 'image'}">
								<img src="${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${newsletter.UPIMAGEFILENAME}&systemFileName=${newsletter.UPIMAGESFILENAME}" alt="우리의 수준이 세계의 기준이 되다! 국내 보건산업의 성장과 발전은 물론, 전세계가 주목하는 보건혁신을 통하여 글로벌 경쟁력을 확보하겠습니다. 한국보건산업진흥원의 무한활동을 기대해 주십시오." />
							</c:when>
							<c:when test="${newsletter.UPIMAGE eq 'html'}">
								${newsletter.UPIMAGEHTML}
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>

				<c:when test="${newsletter.TEMPLATE eq 'TYPE04'}">
					<!-- 적용되는 디자인 없음 -->
				</c:when>
			</c:choose>

			<!-- 포틀릿 설정 영역 -->
			<section id="newsletter_content">
				<div id="contentArea">
				</div>
				<!-- 라인 추가 버튼 -->
				<div class="portlet_setting">
					<strong class="display_block">라인을 추가하여 <span class="point01">포틀릿을 생성</span>해 주세요.</strong>
					<button type="button" id="btnAddLine" class="btn_color">+ 라인추가</button>
				</div>
			</section>
		</div>
	</article>

	<!-- 뉴스레터 포틀릿 콘텐츠 팝업 설정 정보 -->
	<div id="divPortletContentsPopupArea">
	</div>

	<div id="fileComponentArea" style="display: none;"></div>
	
	</fieldset>
</spform:form>

<!-- 라인추가 시 포틀릿 갯수 선택 레이어 팝업-->
<div class="popup_wrap" id="divPortletLineCntPopup" style="display: none;">
	<div class="popup_body">
		<div class="content">
			<p class="txt_info">포틀릿 설정 한줄에 생성할 포틀릿 수를 선택해 주세요.</p>
			<ul id="tblPortletCnt" class="portlet_lineCount">
				<li class="type01"><input type="radio" name="portletCnt" value="F" id="F"/><label for="F">1개의 라인에 1개의 포플릿</label></li>
				<li class="type02"><input type="radio" name="portletCnt" value="L-S" id="L-S"/><label for="L-S">1개의 라인에 2개의(7:3) 포틀릿</label></li>
				<li class="type03"><input type="radio" name="portletCnt" value="M-M" id="M-M"/><label for="M-M">1개의 라인에 2개의(5:5) 포틀릿</label></li>
				<li class="type04"><input type="radio" name="portletCnt" value="M-S-S" id="M-S-S"/><label for="M-S-S">1개의 라인에 3개의 포틀릿</label></li>
				<li class="type05"><input type="radio" name="portletCnt" value="S-S-S-S" id="S-S-S-S"/><label for="S-S-S-S">1개의 라인에 4개의 포틀릿</label></li>
			</ul>
		</div>
	</div>
</div>

<!-- 라인추가 시 포틀릿 갯수 선택 레이어 팝업-->
<div class="popup_wrap" id="divPortletTypePopup" style="display: none;">
	<div class="popup_body">
		<div class="content">
			<%--<p class="txt_info">포틀릿 설정 한줄에 생성할 포틀릿 수를 선택해 주세요.</p>--%>
			<ul class="portlet_type_choice" id="ulPortletTypeChoide">
				<li id="portletType_S" class="type01"><input type="radio" name="portletType" value="S" id="S"/><label for="S">제목 Type</label></li>
				<li id="portletType_ISC" class="type02"><input type="radio" name="portletType" value="ISC" id="ISC"/><label for="ISC">이미지+제목+내용 Type</label></li>
				<li id="portletType_SC" class="type03"><input type="radio" name="portletType" value="SC" id="SC"/><label for="SC">제목+내용 Type</label></li>
				<li id="portletType_IC" class="type04"><input type="radio" name="portletType" value="IC" id="IC"/><label for="IC">이미지+내용 Type</label></li>
				<li id="portletType_I" class="type05"><input type="radio" name="portletType" value="I" id="I"/><label for="I">이미지 Type</label></li>
				<li id="portletType_H" class="type06"><input type="radio" name="portletType" value="H" id="H"/><label for="H">HTML Editor Type</label></li>
			</ul>
		</div>
	</div>
</div>

<!-- 버튼 그룹 영역 -->
<div class="btn_area">
	<span class="float_left">
		<button type="button" class="btn btn_type01" id="btnPreView">미리보기</button>
	</span>
	<span class="float_right">
		<button type="button" class="btn btn_type02 ${!empty result.NEWSLETTERID ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<button type="button" class="btn btn_type02" id="btnPrev">이전</button>
		<button type="button" class="btn btn_type02" id="btnList">목록</button>
	</span>
</div>


<div id ="dialog" class="selector" style="display: none;">
	<spform:form id="submitForm" enctype="multipart/form-data">	
		<table class="tstyle_view">
			<caption>
				첨부파일등록
			</caption>
			<colgroup>
				<col width="15%" />
	            <col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>첨부파일</th>
					<td><input name="files" id="files" type="file" class="input_long"/></td>
				</tr>
			</tbody>
		</table>
	</spform:form>
</div>

<script type="text/javascript">
	var PORTLET_LINE_DIV_ID = 10;
	var EXIST_FILE_OBJECT = false;

	// 파일 업로드 관련 경로
	var cusUploadURL = "${contextPath}/fileUpload?fileGubun=common&menuId=newsLetterMgr";
	var cusResultURL = "${ctxMgr}/newsLetterMgr/updateNewsLetterPortlet";

	$(function() {

		// 데이터가 존재하는 경우 데이터 초기화
		<c:choose>
			<c:when test="${!empty portletLineList}">
				// 포틀릿 라인 정보 세팅
				<c:forEach items="${portletLineList}" var="portletLine" varStatus="index">
					addPortletLine('${portletLine.LINEID}','${portletLine.LINETYPE}');
				</c:forEach>

				// 포틀릿 세부 정보 세팅
				<c:if test="${!empty portletList}">
					<c:forEach items="${portletList}" var="portlet" varStatus="index">
						if ( setPortletType('${portlet.divId}', '${portlet.portletType}', '${portlet.contents_title_use}', '${portlet.contents_title}' , '${portlet.contents_count}') )
						{
							// 포틀릿 콘텐츠 정보 세팅
							<c:forEach items="${portlet.newsLetterPortletContentsList}" var="portletContents"  varStatus="index">
								<c:set var ="html" value="${portletContents.html}"/>
								<c:set var ="html" value="${fn:replace(html, crcn, '')}"/>
								<c:set var ="html" value="${fn:replace(html, '\\'', '')}"/>
								setPortletContentsData('${portlet.divId}', '${portlet.portletType}', '${portletContents.seq}', '${portletContents.subject}', '${portletContents.link}', '${portletContents.userImgFileName}', '${portletContents.systemImgFileName}', '${portletContents.imgFilePath}', '${portletContents.imgDesc}', '${fn:replace(portletContents.contents, crcn, "<br />")}', '${html}');
							</c:forEach>
						}
					</c:forEach>
				</c:if>
			</c:when>
			<c:otherwise>
				addPortletBlank();
			</c:otherwise>
		</c:choose>

		// 저장 상태에 따라 메시지 표시
		var saveStatus = '${obj.saveStatus}';

		if ( saveStatus != '' )
		{
			if ( saveStatus == 'save' )
			{
				alert('저장 되었습니다.');
			}
			else if ( saveStatus == 'preView' )
			{
				fnPreView();
			}
		}


		$("#btnPreView").click(function() {

			$("#saveStatus").val("preView");

			var status = fnSave();

			if ( !status )
				$("#saveStatus").val("");

			return status;
		});

		$("#btnSave").click(function() {

			$("#saveStatus").val("save");

			var status = fnSave("save");

			if ( !status )
				$("#saveStatus").val("");

			return status;
		});

		$("#btnPrev").click(function() {

			$("#saveStatus").val("prev");

			var status = fnSave("prev");

			if ( !status )
				$("#saveStatus").val("");

			return status;
		});

		$("#btnList").click(function() {
			fnList();
		});

		$("#btnAddLine").click(function() {
			fnAddLine();
		});
	});

	// 미리보기 팝업
	function fnPreView()
	{
		var newsLetterId = $("#newsLetterId").val();

		try{win.focus();}catch(e){}
		win = window.open('${contextPath}/newsLetter/preView?newsLetterId='+ newsLetterId, 'preView_pop', 'width=870px,height=800px,scrollbars=yes,status=no');
	}

	// 저장
	function fnSave(saveStatus)
	{
		if ( saveStatus == 'save' )
		{
			if(!confirm("저장 하시겠습니까?"))
			{
				return false;
			}
		}
		else
		{
			alert("입력한 정보가 저장됩니다.");
		}

		var portletDataStr = '';

		// 라인순으로 포틀릿 정보를 읽어 들여서 처리하며, 초기의 portlet divId를 함께 저장
		$(".divPortletLine").each(function (index) {

			$("#"+this.id + " > p").remove();

			// 포틀릿 라인 내부의 개별 포틀릿의 정보 처리
			var portletDivIdList = $("#"+this.id).sortable("toArray");

			$.each(portletDivIdList, function(i, item) {

				var portletDiv = $('#'+item);

				var portletDivId = portletDiv.attr('id');
				var portletSize = portletDiv.attr('portletSize');
				var portletType = portletDiv.attr('portletType');

				var newDivId = "0" + index + "0" + i + portletSize;

				if ( (index+i) != 0 )
				{
					portletDataStr += "#";
				}

				portletDataStr +=	newDivId + '|' + portletDivId + '|' + (portletType=='' || portletType==undefined ? '-' : portletType);
			});
		});

		// 만들어진 포틀릿 데이터 String을 세팅
		$("#inDMLData").val(portletDataStr);

		// 업로드할 파일이 없는 경우 현재상태만 저장
		if ( EXIST_FILE_OBJECT )
		{
			File.Upload();
		}
		else
		{
			$("#insertForm").attr("action", gContextPath + "/mgr/newsLetterMgr/updateNewsLetterPortlet");
			$("#insertForm").submit();
		}

		return true;
	}

	// 목록
	function fnList()
	{
		location.href="${contextPath}/mgr/newsLetterMgr?${link}";
	}

	// 라인추가
	function fnAddLine()
	{
		popupAddPortletLine();
	}

	// 라인추가(포틀릿 라인 당 갯수 선택) 팝업 호출
	function popupAddPortletLine()
	{
		$("#divPortletLineCntPopup").dialog({
			width: 800,
			height: 820,
			resizable: false,
			modal: true,
			title: "포틀릿 설정",
			buttons:{
				"적용": function() {

					// 포틀릿 형태 선택 팝업에서 선택여부를 체크
					var selectRadio = $('input[name=portletCnt]:radio');	// .is('checked');

					// 선택하지 않았을 경우
					if ( !(selectRadio.is(':checked')) )
					{
						alert("추가할 포틀릿 형태를 선택하세요.");
						return;
					}

					var portletType = selectRadio.filter(':checked').val();

					// 포틀릿 라인 추가
					addPortletLine(null, portletType);

					$(this).dialog("close");
				},
				"닫기": function(){
					$(this).dialog("close");
				}
			}
		});
	}

	// 포틀릿 라인 추가
	function addPortletLine(portletLineDivId, portletLineType)
	{
		// 라인 추가시 무조건 포틀릿 없음 메시지는 제거
		deletePortletBlank();

		var lineDivId = PORTLET_LINE_DIV_ID;
		var lineType = 'M-M';
		var portletCnt = 2;

		// 포틀릿 라인 ID가 지정 OR 지정되어 있지 않은 경우의 처리
		if ( portletLineDivId )
		{
			lineDivId = portletLineDivId;
		}
		else
		{
			PORTLET_LINE_DIV_ID++;
		}

		// 포틀릿 라인 구조의 형태가 지정 OR 지정되어 있지 않은 경우의 처리
		if ( portletLineType )
		{
			lineType = portletLineType;
			portletCnt = portletLineType.split('-').length;
		}

		addLineDiv(lineDivId, lineType, portletCnt);

		// 포틀릿 내부 컨트롤 버튼 초기화
		setSortable(lineDivId);

		// 포틀릿 라인 컨트롤 버튼 초기화
		setSortable('contentArea');
	}

	//포틀릿 라인 삭제
	function deletePortletLine(lineDivId)
	{
		if ( !confirm('삭제하시겠습니까?') )
		{
			return false;
		}

		$("#"+lineDivId).remove();
	}

	// 포틀릿 라인 내부의 div 추가
	function addLineDiv(lineDivId, portletType, portletCnt)
	{
		var lineDivHtml =	'<div id="' + lineDivId + '" class="ui-sortable divPortletLine">' +
							'	<p class="portletLine_control">' +
							'		<button type="button" class="move before" onclick="potletMoveBefore(\'' + lineDivId + '\');">한줄 위로 이동</button>' +
							'		<button type="button" class="move after" onclick="potletMoveAfter(\'' + lineDivId + '\');">한줄 아래로 이동</button>' +
							'		<button type="button" class="delete" onclick="deletePortletLine(\'' + lineDivId + '\');" ><span class="hide">한줄</span>삭제</button>' +
							'	</p>' +
							'</div>';

		$("#contentArea").append(lineDivHtml);

		var portletTypeList = portletType.split('-');

		for (var i=0; i<portletTypeList.length; i++)
		{
			addPortletDiv(lineDivId, i, portletTypeList[i]);
		}
	}

	// 포틀릿 라인에 포틀릿의 실제 div 추가
	function addPortletDiv(lineDivId, divIndex, portletSize)
	{
		var portletId = lineDivId + "0" + divIndex + portletSize;
		var divHtml = '';
		var portletSizeClass = "full";

		switch ( portletSize )
		{
			case 'S' :
				portletSizeClass = 'xs';
				break;

			case 'M' :
				portletSizeClass = 'md';
				break;

			case 'L' :
				portletSizeClass = 'lg';
				break;

			case 'F' :
				portletSizeClass = 'full';
				break;

			default :
				portletSizeClass = 'full';
				break;
		}

		divHtml =	'<article portletSize="' + portletSize + '" id="' + portletId + '" class="contype_' + portletSizeClass + '">' +
					'	<h2 class="subject">' + '포틀릿 타입' + '</h2>' +
					'	<p class="type_setting" onclick="popupSelectPortletType(\'' + portletId + '\',\'' + portletSize + '\')"><button type="button">Type 설정/변경</button></p>' +
					'	<div class="potlet_control">' +
					'		<span class="addContent"><a href="javascript:;" portletId="' + portletId + '" onclick="popupPortletContentsDiv(\'divPC_' + portletId + '\',\'' + portletId + '\');">콘텐츠</a></span>' +
					'		<span class="potletMove">' +
					'			<button type="button" class="before" onclick="potletMoveBefore(\'' + portletId + '\');">왼쪽으로 이동</button>' +
					'			<button type="button" class="after" onclick="potletMoveAfter(\'' + portletId + '\');">오른쪽으로 이동</button>' +
					'		</span>' +
					'	</div>'+
					'</article>';

		$(divHtml).insertBefore($("#" + lineDivId + ' > p'));
	}

	// 포틀릿 라인 div가 드래그앤드랍이 가능하게 설정
	function setSortable(divId)
	{
		$("#"+divId).sortable({
			connectWith : "#"+divId,
			stop : function(e, ui) {
				resetControlButton(this, true);
			}
		});

		// div 이동 버튼의 활성/비활성 여부 초기화
		resetControlButton($('#'+divId),true);

		// contentArea의 경우 ui-sortable 클래스 제거
		if ( divId == 'contentArea' )
			$('#contentArea').removeClass('ui-sortable');
	}

	// 포틀릿 라인을 앞의 위치로 이동
	function potletMoveBefore(divId, divType)
	{
		var current = $('#'+divId);
		current.prev().before(current);

		resetControlButton(current, divType);
	}

	// 포틀릿 라인을 뒤의 위치로 이동
	function potletMoveAfter(divId, divType)
	{
		var current = $('#'+divId);
		current.next().after(current);

		resetControlButton(current, divType);
	}

	// 포틀릿 전체의 상하/좌우 버튼의 상태 새로고침
	function resetControlButton(currentDiv, isDrag)
	{
		var isPortlet = '';
		var divList = '';

		if ( isDrag )
		{
			isPortlet = $(currentDiv).hasClass('ui-sortable');
			divList = $(currentDiv).find((isPortlet ? '.potlet_control' : '.portletLine_control'));
		}
		else
		{
			isPortlet = $(currentDiv).parent('div').hasClass('ui-sortable');
			divList = $(currentDiv).parent('div').find((isPortlet ? '.potlet_control' : '.portletLine_control'));
		}

		var divLength = divList.length;

		$.each(divList, function (index, item)
		{
			if (index == 0)
			{
				$(item).find('.before').hide();
			}
			else
			{
				$(item).find('.before').show();
			}

			if (index == divLength - 1)
			{
				$(item).find('.after').hide();
			}
			else
			{
				$(item).find('.after').show();
			}
		});
	}

	// 포틀릿 라인이 없을 경우 메시지 처리
	function addPortletBlank()
	{
		var blankHtml = '<div id="emptyPortlet">설정된 포틀릿이 존재하지 않습니다. 라인을 추가하여 포틀릿을 생성해 주세요.</div>';

		$('#contentArea').html(blankHtml);
	}

	function deletePortletBlank()
	{
		$('#emptyPortlet').remove();
	}

	// 포틀릿 타입 선택 팝업 호출
	function popupSelectPortletType(portletId, portletSize)
	{
		// 포틀릿 사이즈에 따른 선택 유형 표시 변경
		if ( portletSize == 'F' || portletSize == 'L' || portletSize == 'M' )
		{
			$("#portletType_S").show();
			$("#portletType_ISC").show();
			$("#portletType_SC").show();
			$("#portletType_IC").show();
			$("#portletType_I").show();
			$("#portletType_H").show();
		}
		else if ( portletSize == 'S' )
		{
			$("#portletType_S").show();
			$("#portletType_ISC").hide();
			$("#portletType_SC").show();
			$("#portletType_IC").hide();
			$("#portletType_I").show();
			$("#portletType_H").show();
		}

		// 기존에 타입 정보가 설정되어 있을 경우
		var existPortletType = $("#" + portletId).attr("portletType");

		if ( existPortletType != undefined )
		{
			$("input:radio[name='portletType']:radio[value='" + existPortletType + "']").prop("checked", true);
		}

		$("#divPortletTypePopup").dialog({
			width: 800,
			height: 680,
			resizable: false,
			modal: true,
			title: "포틀릿 Type 설정/변경",
			buttons:{
				"적용": function() {

					// 포틀릿 형태 선택 팝업에서 선택여부를 체크
					var selectRadio = $('input[name=portletType]:radio');	// .is('checked');

					// 선택하지 않았을 경우
					if ( !(selectRadio.is(':checked')) )
					{
						alert("포틀릿 Type 선택하세요.");
						return;
					}

					var portletType = selectRadio.filter(':checked').val();

					// 기존에 선택되어 있던 portletType이 다를경우의 처리
					if ( existPortletType != undefined && existPortletType != portletType )
					{
						if ( confirm("포틀릿 타입을 변경하면, 기존에 설정한 콘텐츠 정보가 삭제됩니다.\n포틀릿 타입을 변경하시겠습니까?") )
						{
							// 기존 포틀릿 콘텐츠 Div 삭제
							deletePortletContentsDiv(portletId);

							// 포틀릿 Type 선택시 처리
							setPortletType(portletId, portletType, null, null, null);
						}
					}
					else if ( existPortletType == undefined )
					{
						setPortletType(portletId, portletType, null, null, null);
					}

					$(this).dialog("close");
				},
				"닫기": function(){
					$(this).dialog("close");
				}
			}
		});
	}

	// 포틀릿 타입 명칭
	function getPortletTypeName(portletType)
	{
		var portletTypeName = '';

		switch ( portletType )
		{
			case 'S' :
				portletTypeName= '제목 Type';
				break;

			case 'ISC' :
				portletTypeName= '이미지+제목+내용 Type';
				break;

			case 'SC' :
				portletTypeName= '제목+내용 Type';
				break;

			case 'IC' :
				portletTypeName= '이미지+내용 Type';
				break;

			case 'I' :
				portletTypeName= '이미지 Type';
				break;

			case 'H' :
				portletTypeName= 'HTML Editor Type';
				break;

			default :
				portletTypeName= '';
				break;
		}

		return portletTypeName;
	}

	// 포틀릿 타입 세팅
	function setPortletType(portletId, portletType, contents_title_use, contents_title, contents_count)
	{
		var portletTypeName = getPortletTypeName(portletType);

		if ( portletType != '-' )
		{
			$('#'+portletId).attr('portletType', portletType);
			$('#'+portletId+' > h2').text(portletTypeName);

			if ( addPortletContentsDiv(portletId, portletType, contents_title_use, contents_title, contents_count) )
				return true;
		}

		return false;
	}

	// 포틀릿 콘텐츠 팝업에 표시될 div를 생성
	function addPortletContentsDiv(portletId, portletType, contents_title_use, contents_title, contents_count)
	{
		var portletContentsDivId = 'divPC_' + portletId;
		var divHtml = '';

		/*
			포틀릿 콘텐츠 팝업 구조
			- CONTENTS_DIV_ID :  데이터가 구성된 div id (divPC_ + portletId)
			- CONTENTS_TITLE_USE : contents_title_use_ + CONTENTS_DIV_ID
			- CONTENTS_TITILE : contents_title_ + CONTENTS_DIV_ID
			- CONTENTS_COUNT : contents_count_ + CONTENTS_DIV_ID

			콘텐츠 입력 table은 라인별로 추가되며, 콘텐츠 입력라인의 속성은 다음과 같음
			- 콘텐츠 입력 라인 div id : CONTENTS_DIV_ID + _contList
		 */

		divHtml =	'<div class="popup_body" id="' + portletContentsDivId + '" portletType="' + portletType + '" style="display: none;">' +
					'	<div class="popup_body">' +
					'		<div class="content">' +
					'			<p class="txt_info">등록할 콘텐츠정보를 입력/선택해 주세요</p>' +
					'			<h2 class="depth2_title">타이틀</h2>' +
					'			<p>* 타이틀은 텍스트 또는 이미지 등록이 가능합니다. 미사용 선택 시 해당 포틀릿의 타이틀을 제공하지 않습니다.</p>' +
					'			<table class="tstyle_view">' +
					'				<caption>타이틀 사용여부 및 타이틀 입력</caption>' +
					'				<tbody>' +
					'				<tr>' +
					'					<th scope="row"><span class="point01">*</span> 사용여부</th>' +
					'					<td>' +
					'						<input type="radio" name="contents_title_use_' + portletContentsDivId + '" value="Y" ' + (contents_title_use == undefined || contents_title_use == null ||contents_title_use=='Y' ? "checked" : "") +  '/><label for="">사용</label>' +
					'						<input type="radio" name="contents_title_use_' + portletContentsDivId + '" value="N" ' + (contents_title_use=='N' ? "checked" : "") +  '/><label for="">미사용</label>' +
					'					</td>' +
					'				</tr>' +
					'				<tr>' +
					'					<th scope="row">타이틀</th>' +
					'					<td>' +
					'						<input type="text" name="contents_title_' + portletContentsDivId + '" id="contents_title_' + portletContentsDivId + '" class="input_mid" value="' + (contents_title == undefined || contents_title == null ? '' : contents_title) + '"/>' +
					'						<input type="hidden" name="contents_count_' + portletContentsDivId + '" id="contents_count_' + portletContentsDivId + '" class="input_mid" />' +
					'					</td>' +
					'				</tr>' +
					'				</tbody>' +
					'			</table>' +
					'			<div class="float_wrap02">' +
					'				<h2 class="depth2_title float_left">콘텐츠</h2>' +
					'				<p class="float_right cont_plus">' +
					'					<button type="button" class="btn_add" onclick="addPortletContents(\'' + portletContentsDivId + '\', \'' + portletType +'\', null, null, null);">콘텐츠 추가</button> ' +
					'					<button type="button" class="btn_delete" onclick="deletePortletContents(\'' + portletContentsDivId + '\');">콘텐츠 삭제</button>' +
					'				</p>' +
					'			</div>' +
					'			<p>* 콘텐츠는 직접 제목과 링크정보를 입력하거나 홈페이지에 등록된 게시글을 조회하여 등록할 수 있습니다.</p>' +
					'			<h3 class="depth3_title02">' + getPortletTypeName(portletType) + '</h3>' +
					'			<p><span class="point01">*</span> 필수 입력 항목입니다.</p>' +
					'			<div id="' + portletContentsDivId + '_contList"></div>' +
					'		</div>' +
					'	</div>';
					'</div>';

		// 콘텐츠 입력 팝업을 실제 생성
		if ( $("#divPortletContentsPopupArea > div").children('div').size() < 1 )
			$("#divPortletContentsPopupArea").html(divHtml);
		else
			$(divHtml).insertBefore($("#divPortletContentsPopupArea").children('div').last());

		// 콘텐츠 입력 table 추가
		if ( contents_count != null )
		{
			for ( var i=0; i < contents_count; i++ )
				addPortletContents(portletContentsDivId, portletType);
		}
		else
		{
			addPortletContents(portletContentsDivId, portletType);
		}

		return true;
	}

	// 포틀릿 콘텐츠 팝업에 표시될 div를 생성
	function deletePortletContentsDiv(portletId)
	{
		var portletContentsDivId = 'divPC_' + portletId;

		$("#"+portletContentsDivId).remove();
	}

	function popupPortletContentsDiv(portletContentsDivId, portletId)
	{
		// 포틀릿 타입이 설정되어 있지 않은 경우, 포틀릿 타입을 먼저 설정하게 알림.
		var portletType = $('#'+portletId).attr('portletType');

		if ( portletType == undefined || portletType == null )
		{
			alert('뉴스레터 포틀릿 타입을 먼저 설정하세요.');
			return false;
		}

		var portletContentsDiv = $("#" + portletContentsDivId + "_contList");
		var oldData = portletContentsDiv.clone(true);

		$("#"+portletContentsDivId).dialog({
			appendTo : "#divPortletContentsPopupArea",
			width: 800,
			height: 680,
			resizable: false,
			modal: true,
			title: "콘텐츠 등록/변경",
			buttons:{
				"적용": function() {

					// 입력한 데이터는 팝업을 닫아도 그대로 유지 되므로, 변경 점 없음

					// 타이틀을 사용으로 선택하였다면, 타이틀 입력을 체크
					var isTitleUse = $("input[name=contents_title_use_" + portletContentsDivId + "]:checked").val();
					var titleElement = $("#contents_title_" + portletContentsDivId);

					if ( isTitleUse == 'Y' && titleElement.val() == '' )
					{
						alert('타이틀을 입력하세요.');
						titleElement.focus();
						return false;
					}

					// 선택한 타입에 따라 valdation 체크
					// 포틀릿 콘텐츠 테이블의 갯수를 확인하여, validation을 체크
					var contentsListCount = portletContentsDiv.children("table").size();

					for ( var seq = 0; seq < contentsListCount; seq++ )
					{
						// 파라미터 명
						var subjectId = portletContentsDivId + '_subject_' + seq;
						var linkId = portletContentsDivId + '_link_' + seq;
						var userImgFileNameId = portletContentsDivId + '_uimgfilename_' + seq;
						var oldUserImgFileNameId = portletContentsDivId + '_ouimgfilename_' + seq;
						var imagedescId = portletContentsDivId + '_imagedesc_' + seq;
						var contentsId = portletContentsDivId + '_contents_' + seq;
						var htmlId = portletContentsDivId + '_html_' + seq;

						// 타이틀
						if ( portletType == 'S' || portletType == 'SC' || portletType == 'ISC' )
						{
							var subject = $("#" + subjectId);

							if ( subject.val() == '' )
							{
								alert('제목을 입력하세요.');
								subject.focus();
								return false;
							}
						}

						// 링크
						if ( portletType == 'S' || portletType == 'SC' || portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
						{
							var link = $("#" + linkId);

							if ( link.val() == '' )
							{
								alert('링크를 입력하세요.');
								link.focus();
								return false;
							}
						}

						// 이미지
						if ( portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
						{
							var currentImage = $("#" + userImgFileNameId);
							var oldImage = $("#" + oldUserImgFileNameId);
							var imageDesc = $("#" + imagedescId);

							if ( oldImage.val()=='' && currentImage.val() == '' )
							{
								alert('이미지 파일을 추가하세요.');
								currentImage.focus();
								return false;
							}

							if ( imageDesc.val() == '' )
							{
								alert('이미지 설명글을 입력하세요.');
								imageDesc.focus();
								return false;
							}
						}

						// 내용
						if ( portletType == 'SC' || portletType == 'ISC' || portletType == 'IC' )
						{
							var contents = $("#" + contentsId);

							if ( contents.val() == '' )
							{
								alert('내용을 입력하세요.');
								contents.focus();
								return false;
							}
						}

						// HTML
						if ( portletType == 'H' )
						{
							var html = $("#" + htmlId);

							if ( html.val() == '' )
							{
								alert('HTML 내용을 입력하세요.');
								html.parent().children('a').focus();
								return false;
							}
						}
					}

					$(this).dialog("close");
				},
				"닫기": function(){
					// 입력한 콘텐츠 삭제
					portletContentsDiv.empty();

					// 기존 데이터로 복구
					portletContentsDiv.replaceWith(oldData);

					$(this).dialog("close");
				}
			}
		});
	}

	// 포틀릿 콘텐츠 팝업 입력 라인 추가
	function addPortletContents(portletContentsDivId, portletType)
	{
		var portletContentsListDiv = $("#"+portletContentsDivId+"_contList");
		var seq = portletContentsListDiv.children('table').size();

		// 파라미터 명
		var tableId = portletContentsDivId + '_tab_' + seq;
		var subjectId = portletContentsDivId + '_subject_' + seq;
		var linkId = portletContentsDivId + '_link_' + seq;
		var imgViewId = portletContentsDivId + '_imgview_' + seq;
		var imgDivId = portletContentsDivId + '_imgdiv_' + seq;
		var userImgFileNameId = portletContentsDivId + '_uimgfilename_' + seq;
		var imgObjectId = userImgFileNameId + '_obj';
		var oldUserImgFileNameId = portletContentsDivId + '_ouimgfilename_' + seq;
		var oldSystemImgFileNameId = portletContentsDivId + '_osimgfilename_' + seq;
		var oldImgFilePath = portletContentsDivId + '_oimgfilepath_' + seq;
		var imagedescId = portletContentsDivId + '_imagedesc_' + seq;
		var contentsId = portletContentsDivId + '_contents_' + seq;
		var htmlId = portletContentsDivId + '_html_' + seq;

		var divHtml ='';

		divHtml =		'<table class="tstyle_view" id="' + tableId + '">' +
						'	<caption>이미지+제목+내용 Type 제목, 링크, 이미지 첨부, 이미지 설명글, 내용 입력</caption>' +
						'	<colgroup>' +
						'		<col width="15%" />' +
						'		<col width="*" />' +
						'	</colgroup>' +
						'	<tbody>';

		// 제목 - 제목 Type, 제목+내용 Type, 이미지+제목+내용 Type
		if ( portletType == 'S' || portletType == 'SC' || portletType == 'ISC' )
		{
			divHtml +=	'	<tr>' +
						'		<th scope="row"><span class="point01">*</span> 제목</th>' +
						'		<td><input type="text" name="' + subjectId + '" id="' + subjectId + '" class="input_mid" /> <button type="button" class="btn_smallbasic" onclick="popupSelectContents(\'' + subjectId + '\',\'' + linkId + '\');">게시글 조회</button></td>' +
						'	</tr>';
		}

		// 링크 - 제목 Type, 제목+내용 Type, 이미지+제목+내용 Type, 이미지+내용 Type, 이미지 Type
		if ( portletType == 'S' || portletType == 'SC' || portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
		{
			divHtml +=	'	<tr>' +
						'		<th scope="row"><span class="point01">*</span> 링크</th>' +
						'		<td><input type="text" name="' + linkId + '" id="' + linkId + '" class="input_long02" /></td>' +
						'	</tr>';
		}

		// 이미지 - 이미지+제목+내용 Type, 이미지+내용 Type, 이미지 Type
		if ( portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
		{
			divHtml +=	'	<tr>' +
						'		<th scope="row"><span class="point01">*</span> 이미지</th>' +
						'		<td>' +
						'			<span id="' + imgViewId + '" class="txt"><a href="#"></a></span>' +
						'			<input type="text" name="' + userImgFileNameId + '" id="' + userImgFileNameId + '" class="input_long04" readonly />' +
						'			<input type="button" value="파일찾기" class="input_smallBlack" onClick="fnFileAdd(\'' + oldUserImgFileNameId + '\',\'' + oldSystemImgFileNameId + '\',\'' + oldImgFilePath + '\',\'' + userImgFileNameId + '\');" />' +
						'			<input type="hidden" name="' + oldUserImgFileNameId + '" id="' + oldUserImgFileNameId +'" />' +
						'			<input type="hidden" name="' + oldSystemImgFileNameId + '" id="' + oldSystemImgFileNameId +'" />' +
						'			<input type="hidden" name="' + oldImgFilePath + '" id="' + oldImgFilePath +'" />' +
						'		</td>' +
						'	</tr>' +
						'	<tr>' +
						'		<th scope="row"><span class="point01">*</span> 이미지 설명글</th>' +
						'		<td><input type="text" name="' + imagedescId + '" id="' + imagedescId + '" class="input_long02" /></td>' +
						'	</tr>';
		}

		// 내용 - 제목+내용 Type, 이미지+제목+내용 Type, 이미지+내용 Type
		if ( portletType == 'SC' || portletType == 'ISC' || portletType == 'IC' )
		{
			divHtml +=	'	<tr>' +
						'		<th scope="row"><span class="point01">*</span> 내용</th>' +
						'		<td><textarea name="' + contentsId + '" id="' + contentsId + '" cols="45" rows="5" class="txtarea"></textarea></td>' +
						'	</tr>'
		}

		// HTML - HTML Editor Type
		if ( portletType == 'H' )
		{
			divHtml +=	'	<tr>' +
						'		<th scope="row"><span class="point01">*</span> HTML</th>' +
						'		<td>' +
						'			<a href="javascript:;" onclick="popupHtmlEditorType(\'' + htmlId + '\');">HTML 입력 팝업</a>' +
						'			<input type="hidden" id="' + htmlId + '" name="' +  htmlId +'" value=""/>' +
						'		</td>' +
						'	</tr>';
		}

		divHtml += 		'	</tbody>' +
						'</table> ';

		if ( seq < 1 )
			portletContentsListDiv.html(divHtml);
		else
			$(divHtml).insertAfter(portletContentsListDiv.children('table').last());

		// 뉴스레터 포틀릿 콘텐츠를 설정한 후, 포틀릿에 설정 된 컨텐츠의 수를 저장
		setContentPortletContentsCount(portletContentsDivId);

		//
		// 이미지 - 파일 컨트롤 오브젝트를 초기화 함
		if ( portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
		{
			// 파일 업로드 컴포넌트 생성 영역에 파일 컴포넌트 생성
			$("#fileComponentArea").append('<div id="' + imgDivId + '"></div>');

			//initInnoFile(imgDivId, imgObjectId);
		}
	}

	// 포틀릿 콘텐츠 팝업 입력 라인 삭제 (마지막 라인을 삭제)
	function deletePortletContents(portletContentsDivId)
	{
		var portletContentsListDiv = $("#"+portletContentsDivId+"_contList");

		if ( portletContentsListDiv.children('table').size() < 2 )
		{
			alert('콘텐츠는 1개 이상 입력해야 합니다.');
			return false;
		}
		else
		{
			portletContentsListDiv.children('table').last().remove();
		}

		// 뉴스레터 포틀릿 콘텐츠 삭제 후, 포틀릿에 설정 된 컨텐츠의 수를 갱신하여 저장
		setContentPortletContentsCount(portletContentsDivId);
	}

	// HTML Editor Type 편집을 위한 팝업 호출
	function popupHtmlEditorType(htmlId)
	{
		var strUrl = gContextPath + "/mgr/newsLetterMgr/htmlEditorTypePopup?htmlId=" + htmlId;
		var strStyle = "resizable=yes";

		gfnOpenWin(strUrl, "HtmlEditorTypePopup", strStyle, 900, 700);
	}

	// 게시글 조회를 위한 팝업 호출
	function popupSelectContents(subjectId, linkId)
	{
		var strUrl = gContextPath + "/mgr/newsLetterMgr/popupSelectContents?subjectId=" + subjectId + '&linkId=' + linkId;
		var strStyle = "resizable=yes";

		gfnOpenWin(strUrl, "SelectContentsPopup", strStyle, 900, 700);
	}

	// 뉴스레터 포틀릿에 몇개의 컨텐츠가 현재 등록되어 있는지 확인하여 count 파라미터에 저장
	function setContentPortletContentsCount(portletContentsDivId)
	{
		// 입력된 콘텐츠의 갯수를 체크하여 저장
		var portletContentsListCount = $("#"+portletContentsDivId+"_contList").children('table').size();

		$("#contents_count_" + portletContentsDivId).val(portletContentsListCount);
	}

	// 뉴스레터 포틀릿 콘텐츠를 저장
	function setPortletContentsData(portletId, portletType, seq, subject, link, userImgFileName, systemImgFileName, imgFilePath, imgDesc, contents, html)
	{
		var portletContentsDivId = 'divPC_' + portletId;

		var subjectId = portletContentsDivId + '_subject_' + seq;
		var linkId = portletContentsDivId + '_link_' + seq;
		var imgViewId = portletContentsDivId + '_imgview_' + seq;
		var imgDivId = portletContentsDivId + '_imgdiv_' + seq;
		var userImgFileNameId = portletContentsDivId + '_uimgfilename_' + seq;
		var imgObjectId = userImgFileNameId + '_obj';
		var oldUserImgFileNameId = portletContentsDivId + '_ouimgfilename_' + seq;
		var oldSystemImgFileNameId = portletContentsDivId + '_osimgfilename_' + seq;
		var oldImgFilePath = portletContentsDivId + '_oimgfilepath_' + seq;
		var imagedescId = portletContentsDivId + '_imagedesc_' + seq;
		var contentsId = portletContentsDivId + '_contents_' + seq;
		var htmlId = portletContentsDivId + '_html_' + seq;

		// Type별로 데이터 세팅
		if ( portletType == 'S' || portletType == 'SC' || portletType == 'ISC' )
			$("#"+subjectId).val(subject);

		if ( portletType == 'S' || portletType == 'SC' || portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
			$("#"+linkId).val(link);

		if ( portletType == 'ISC' || portletType == 'IC' || portletType == 'I' )
		{
			$("#"+imgViewId).children('a').text(userImgFileName);
			$("#"+imgViewId).children('a').attr('href', '${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=' + userImgFileName + '&systemFileName=' + systemImgFileName);
			$("#"+oldUserImgFileNameId).val(userImgFileName);
			$("#"+oldSystemImgFileNameId).val(systemImgFileName);
			$("#"+oldImgFilePath).val(imgFilePath);

			$("#"+imagedescId).val(imgDesc);
		}

		if ( portletType == 'SC' || portletType == 'ISC' || portletType == 'IC' )
			$("#"+contentsId).val(contents);

		if ( portletType == 'H' )
			$("#"+htmlId).val(html);
	}

	// 파일 처리 관련 메소드
	//function initInnoFile(imgDivId, imgObjectId)
	//{
	//	alert(imgDivId+"/"+imgObjectId);
	//}

	function fnFileAdd(id1,id2,id3,id4)
	{
		$("#files").val("");
		$("#dialog").dialog({
			width: 700,
			height: 315,
			resizable: false,
			modal: true,
			title: "이미지 등록",
			buttons:{
				"확인":function(){
					var ext = $("#files").val().split('.').pop().toLowerCase();
					if($.inArray(ext, ['gif','jpg','png','bmp']) == -1) {
						alert('gif,jpg,png,bmp 파일만 업로드 할수 있습니다.');
						$("#files").val("");
						return;
					}
						
					var data = new FormData(document.getElementById("submitForm"));
					$.ajax({
			             url: '/fileUpload?fileGubun=common&menuId=newsLetterMgr',
			             type: "post",
			             dataType: "text",
			             data: data,
			             processData: false,
			             contentType: false,
			             dataType:"json",
			             success: function(data) {
			            	$("#"+id1).val(data.userFileName);
			            	$("#"+id2).val(data.systemFileName);
			            	$("#"+id3).val(data.filePath);
			            	$("#"+id4).val(data.userFileName);
							$("#dialog").dialog("close");
			             }, error: function(jqXHR, textStatus, errorThrown) {
			            	 alert("이미지 업로드 중 오류가 발생하였습니다.");
			             }
			         });
				},
				"닫기":function(){
					$(this).dialog("close");
				}
			}
		});
		
		$("#dialog").show();
		
		
		//File.RemoveAllItems(imgObjectId);
		//File.OpenFileDialog(imgObjectId, 'true');
	}

	function innoOnEvent(msgEvent, arrParam, imgObjectId)
	{
		if (msgEvent == Event.msgBeforeAddFile)
		{
			var userImgFileNameId = imgObjectId.replace('_obj', '');

			document.getElementById(userImgFileNameId).value = arrParam[0];
		}
	}
</script>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<form id="searchForm" name="searchForm" method="get" class="search_form">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="siteId" id="siteId" value="${param.siteId}">

		<fieldset>
			<legend>검색조건</legend>
			<table class="tstyle_view">
				<caption>
					사이트, 제목검색
				</caption>
				<colgroup>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
				</colgroup>
				<tr>
					<th scope="row"><label>사이트</label></th>
					<td>
						<select name="siteIdSel" id="siteIdSel"></select>
					</td>
					<th scope="row"><label>제목</label></th>
					<td>
						<input type="text" name="schText" id="schText" class="input_mid" value="${param.schText}" title="검색어"/>
						<span class="float_right">
							<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
						</span>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>

<form id="listForm" name="listForm" action="${ctxMgr }/popupZoneMgr/delete" method="POST">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="pageNum" id="pageNum" value="${obj.pageNum}">
	<input type="hidden" name="siteId" value="${param.siteId}">
	<input type="hidden" name="schText" value="${param.schText}">
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<button type="button" class="btn btn_basic roleWRITE" id="btnAppList">신청현황</button>
			<button type="button" class="btn btn_basic roleWRITE" id="btnAdd">등록</button>
			<button type="button" class="btn btn_basic" id="btnExcel" onclick="javascript:doExcelDownload();">Excel</button>
			<button type="button" class="btn btn_basic" id="btnPrint" onclick="javascript:printIt('${contextPath }');"><i class="xi-print"></i>Print</button>
		</div>
	</div>
	
	<div class="table">
	<table class="tstyle_list">
		<caption>
			뉴스레터 관리 목록 - 번호, 사이트, 제목, 등록자, 등록일, 미리보기, 주소복사, 공개여부, 발송결과, 발송테스트
		</caption>
		<colgroup>
			<col width="50" />
			<col width="210" />
			<col width="*" />
			<col width="210" />
			<col width="120" />
			<col width="110" />
			<col width="110" />
			<col width="80" span="3" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">사이트</th>
				<th scope="col">제목</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
				<th scope="col">미리보기</th>
				<th scope="col">주소복사</th>
				<th scope="col">공개여부</th>
				<th scope="col">발송결과</th>
				<th scope="col">발송테스트</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${!empty result }">
				<c:forEach items="${result }" var="data" varStatus="loop">
				<tr>
					<td>${totalCnt - data.RNUM+1}</td>
					<td>${data.SITENAME}</td>
					<td class="txt_left">
						<a href="${ctxMgr }/newsLetterMgr/form?pageNum=${ obj.pageNum }&newsLetterId=${data.NEWSLETTERID }&version=1${link}">${data.KNAME }</a>
						<%-- <a href="${ctxMgr }/newsLetterMgr/form?pageNum=${ obj.pageNum }&newsLetterId=${data.NEWSLETTERID }&version=2${link}">&nbsp;(v2)</a> --%>
					</td>
					<td>${data.INSUSERNAME }</td>
					<td>
						<fmt:formatDate value="${data.INSTIME }" pattern="yyyy-MM-dd"/>
					</td>
					<td><button type="button" class="btn_basic_small" onclick="fnPreView('${data.NEWSLETTERID}');">미리보기</button></td>
					<td><a class="btn_graySmall" href="javascript:fnCopy('${data.NEWSLETTERID }');">주소복사</a></td>
					<td>
						<c:if test="${data.OPENYN == 'Y'}"><i class="xi-unlock"></i></c:if>
                		<c:if test="${data.OPENYN == 'N'}"><i class="xi-lock-o"></i></c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty data.SEND_FLAG }">
								<button type="button" class="btn_basic_small" onclick="javascript:fnSendEmail('${data.SITEID}', '${param.menuId}', '${data.NEWSLETTERID}');">발송</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn_basic_small" onclick="javascript:fnDetailView('${data.SITEID}', '${param.menuId}', '${data.NEWSLETTERID}');">보기</button>
								<c:if test="${data.SEND_FLAG eq 'N' }">
									<button type="button" class="btn_basic_small" onclick="javascript:fnSendEmailCancel('${data.SITEID}', '${param.menuId}', '${data.NEWSLETTERID}');">취소</button>
								</c:if>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<button type="button" class="btn_basic_small" onclick="javascript:fnSendEmailTest('${data.SITEID}', '${param.menuId}', '${data.NEWSLETTERID}');">발송</button>
					</td>
				</tr>
			
				</c:forEach>
			</c:when>
			<c:otherwise>
		
			<tr>
				<td colspan="10"> 조회된 데이터가 없습니다. </td>
			</tr>
			
			</c:otherwise>
			
		</c:choose>
			
		</tbody>
		
	</table>
	</div>
	
	</form>
	<div id="dialog" style="display: none;">
	이메일 주소 : <input type="text" name="appEmail" id="appEmail" class="input_long" value="">
	</div> 
	<div class="board_pager">
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<Previous><AllPageLink><Next>
		</paging:PageFooter>
	</div>
</div>
<script type="text/javascript">
$(function() {

	gfnSiteAdminComboList($("#siteIdSel"), "", <c:if test="${ADMUSER.totalAuth ne 'Y'}">""</c:if><c:if test="${ADMUSER.totalAuth eq 'Y'}">"전체"</c:if>, "${param.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#siteId").val($("#siteIdSel").val());
		$("#searchForm").attr('action', '${ctxMgr }/newsLetterMgr');
		$('#searchForm').submit();
	}); 
	
	$('#btnAdd').click(function(){
		document.location.href="${ctxMgr }/newsLetterMgr/form?${link}&pageNum=${ obj.pageNum }&version=1";
	});
	
	$('#btnAdd2').click(function(){
		document.location.href="${ctxMgr }/newsLetterMgr/form?${link}&pageNum=${ obj.pageNum }&version=2";
	});
	
	$('#btnAppList').click(function(){
		
		var siteId = $("#siteId").val();
		
		if(siteId == ""){
			alert("사이트를 선택하세요.");
			return;
		}
		
		try{win.focus();}catch(e){}
		win = window.open('${contextPath}/mgr/newsLetterMgr/mailAppList?siteId='+siteId,'AppList_pop', 'width=500px,height=650px,scrollbars=yes,status=no');
	});
	
	//클릭이벤트
	
});

// 미리보기 팝업
function fnPreView(newsLetterId)
{
	try{win.focus();}catch(e){}
	win = window.open('${contextPath}/newsLetter/preView?newsLetterId='+newsLetterId, 'preView_pop', 'width=870px,height=800px,scrollbars=yes,status=no');
}

//엑셀다운로드
function doExcelDownload(){
    var url = "${contextPath}/mgr/newsLetterMgr/ExcelDown";
    document.searchForm.action = url;
    document.searchForm.submit();
}


function fnSendEmail(siteId, menuId, newsLetterId)
{
	if (!window.confirm("메일을 보내시겠습니까?"))
	{
		return;
	}
	
	// 발송 전, preview 화면에서 스크립트코드를 제외하고 생성된 html소스를 iframe으로 불러와 ajax로 update처리   
	$("body").append("<iframe id='frame' src='' width='0' height='0'></iframe>");
	$("#frame").attr("src", "${contextPath}/newsLetter/preView?newsLetterId="+newsLetterId);
	
	$("#frame").load(function(){
		
		var previewHtml = $(this).contents().find('body').html();
		
		// 추출한 html소스를 ajax로 update처리
		$.ajax({
			type: "POST",
			url: "${contextPath}/mgr/newsLetterMgr/updatePreviewHtml",
			data: {
				'newsLetterId': newsLetterId,
				'previewHtml': previewHtml
			},
			async: true,
			cache: false,
			success: function (result, textStatus, jqXHR)
			{
				if (result != null)
				{
					if (result=="success")
					{
						fnSendEmailNext(siteId, menuId, newsLetterId);
					}
				}
			}
		});
	});
}

function fnSendEmailNext(siteId, menuId, newsLetterId){
	$.ajax({
		url: "${contextPath}/mgr/newsLetterMgr/sendEmail",
		data: {
			'siteId': siteId,
			'newsLetterId': newsLetterId,
			'menuId': menuId,
			'urlInfo': '${contextPath}/newsLetter/preViewHTML?newsLetterId=' + newsLetterId
		},
		async: true,
		cache: false,
		success: function (result, textStatus, jqXHR)
		{
			if (result != null)
			{
				if (result)
				{
					alert("메일을 보냈습니다.");

					$("#siteId").val($("#siteIdSel").val());
					$("#searchForm").attr('action', '${ctxMgr }/newsLetterMgr');
					$('#searchForm').submit();
				} else
				{
					alert("발송에 실패했습니다.");
				}
			}
		}
	});
}

function fnSendEmailTest(siteId, menuId, newsLetterId)
{
	try
	{
		$("#dialog").dialog({
			width: 300,
			height: 200,
			resizable: false,
			modal: true,
			title: "테스트 발송",
			buttons: {
				"발송": function ()
				{
					if (!confirm("테스트 발송 하시겠습니까?"))
					{
						$(this).dialog("close");
					} else
					{

						if ($('#appEmail').val() == "")
						{
							alert("이메일을 입력하세요");
							return;
						}

						$(this).dialog("close");
						fnSendEmailTestAjax(siteId, menuId, newsLetterId);
					}
				},
				"취소": function ()
				{
					$(this).dialog("close");
				}
			},
			open: function ()
			{

			}
		});
	}
	catch (e)
	{
		alert("File.InsertTagSelectedItems: " + e);
	}
}


function fnSendEmailTestAjax(siteId, menuId, newsLetterId)
{
	// 발송 전, preview 화면에서 스크립트코드를 제외하고 생성된 html소스를 iframe으로 불러와 ajax로 update처리   
	$("body").append("<iframe id='frame' src='' width='0' height='0'></iframe>");
	$("#frame").attr("src", "${contextPath}/newsLetter/preView?newsLetterId="+newsLetterId);
	
	$("#frame").load(function(){
		
		var previewHtml = $(this).contents().find('body').html();
		
		// 추출한 html소스를 ajax로 update처리
		$.ajax({
			type: "POST",
			url: "${contextPath}/mgr/newsLetterMgr/updatePreviewHtml",
			data: {
				'newsLetterId': newsLetterId,
				'previewHtml': previewHtml
			},
			async: true,
			cache: false,
			success: function (result, textStatus, jqXHR)
			{
				if (result != null)
				{
					if (result=="success")
					{
						fnSendEmailTestAjaxNext(siteId, menuId, newsLetterId);
					}
				}
			}
		});
	});
}

function fnSendEmailTestAjaxNext(siteId, menuId, newsLetterId){
	$.ajax({
		url: "${contextPath}/mgr/newsLetterMgr/sendEmailTest",
		data: {
			'appEmail': $('#appEmail').val(),
			'siteId': siteId,
			'newsLetterId': newsLetterId,
			'menuId': menuId,
			'urlInfo': '${contextPath}/newsLetter/preViewHTML?newsLetterId=' + newsLetterId
		},
		async: true,
		cache: false,
		success: function (result, textStatus, jqXHR)
		{
			if (result != null)
			{
				if (result)
				{
					alert("메일을 보냈습니다.");

					$("#siteId").val($("#siteIdSel").val());
					$("#searchForm").attr('action', '${ctxMgr}/newsLetterMgr');
					$('#searchForm').submit();
				} else
				{
					alert("발송에 실패했습니다.");
				}
			}
		}
	});
}

function fnDetailView(siteId, menuId, newsLetterId)
{
	try{win.focus();}catch(e){}
	win = window.open('${contextPath}/mgr/newsLetterMgr/mailResult?newsLetterId=' + newsLetterId + '&menuId=' + menuId,'rsMail_pop', 'width=870px,height=600px,scrollbars=yes,status=no');
}

function fnCopy(newsLetterId){
	var strUrl = '${contextPath}/newsLetter/preView?newsLetterId='+newsLetterId;
	var IE=(document.all)?true:false;
	if (IE) {
		if (!confirm("주소를 복사하시겠습니까?")) {
			return;
		}
		window.clipboardData.setData("Text", strUrl);
		alert ( "주소가 복사되었습니다. \'Ctrl+V\'를 눌러 붙여넣기 해주세요." );
	} else {
		temp = prompt("뉴스레터 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", strUrl);
	}
}

function fnSendEmailCancel(siteId, menuId, newsLetterId)
{
	if(!window.confirm("발송 취소 하시겠습니까?"))
	{
		return;
	}

	$.ajax({
		url: "${contextPath}/mgr/newsLetterMgr/sendEmailCancel",
		data: {'siteId' : siteId, 'menuId' : menuId, 'newsLetterId' : newsLetterId},
		async: false,
 		success:function(result, textStatus, jqXHR) {
 			if(result != null) {
 				if(result == "SUCCESS"){
 					alert("발송 취소 되었습니다.");

 					$("#siteId").val($("#siteIdSel").val());
 					$("#searchForm").attr('action', '${ctxMgr}/newsLetterMgr');
 					$('#searchForm').submit();
 				}else if(result == "SEND"){
 					alert("이미 발송되었습니다.");
 				}else{
 					alert("발송 취소 실패했습니다.");
 				}
 			}
 		}
	});
}

</script>

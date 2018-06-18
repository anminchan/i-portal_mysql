<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<div id="contentArea">
	<form id="searchForm" name="searchForm" method="get">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId}">
	<input type="hidden" name="siteId" id="siteId" value="${param.siteId}">
	<input type="hidden" name="newsLetterId" id="newsLetterId" value="${param.newsLetterId}">

		<fieldset>
			<legend>검색조건</legend>
			<table class="tstyle_view">
				<caption>
					신청기간
				</caption>
				<colgroup>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
				</colgroup>
				<tr>
					<th scope="row"><label>이메일</label></th>
					<td>
                        <input type="text" class="input_mid" name="appEmail" id="appEmail" value="${param.appEmail}"/>
					</td>
					<th scope="row"><label>성공여부</label></th>
					<td>
                        <select id="sendFlag" name="sendFlag">
                        	<option value="" <c:if test="${empty param.sendFlag or param.sendFlag eq '' }">selected</c:if>>전체</option>
                        	<option value="Y" <c:if test="${param.sendFlag eq 'Y' }">selected</c:if>>성공</option>
                        	<option value="E" <c:if test="${param.sendFlag eq 'E' }">selected</c:if>>실패</option>
                        </select>
                        <span class="float_right">
							<input type="button" id="btnSearch" class="btn_black" value="검색">
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
	<input type="hidden" name="schKName" value="${param.schKName}">
	
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<br />
	<div class="float_wrap">	
		<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
		<div class="basic_searchForm float_right">
			<button type="button" class="btn_colorType01" id="btnExcel" onclick="javascript:doExcelDownload();">Excel</button>
		</div>
	</div>
	
	<!-- <br />
	<div class="float_wrap">
		<div class="basic_searchForm float_right">
			<button type="button" class="btn_colorType01" id="btnExcel" onclick="javascript:doExcelDownload();">Excel</button>
		</div>
	</div> -->
	<table class="tstyle_list" summary="전체, 순선, 사이트명, 제목, 게시시작일, 게시종료일, 순서, 사용여부">
		<caption>
			팝업존관리 목록
		</caption>
		<colgroup>
			<col style="width:80px" />
			<col style="width:200px" />
			<col style="width:110px" />
			<col style="width:*" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">이메일</th>
				<th scope="col">성공여부</th>
				<th scope="col">실패이유</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>			
			<c:when test="${!empty result }">
				<c:forEach items="${result }" var="data" varStatus="loop">
				<tr>
					<td>${totalCnt - data.RNUM+1}</td>
					<td>${data.EMAIL }</td>
					<td>
						<c:choose>
							<c:when test="${data.SEND_FLAG eq 'N'}">
								대기
							</c:when>
							<c:otherwise>
								<c:choose>
								<c:when test="${data.SEND_RSLT_CD eq '00'}">
									성공
								</c:when>
								<c:otherwise>
									실패
								</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${data.SEND_RSLT_CD eq '00'}">
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '01'}">
								형식오류
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '02'}">
								알 수 없는 HOST / 발송 서버 DNS 장애
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '03'}">
								알 수 없는 User / 휴면계정
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '04'}">
								발송 서버 IP 수신거부 처리 / 회원 개인이 수신거부 처리
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '05'}">
								메일박스가 가득 참 / 휴면계정
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '06'}">
								연결 오류 / 발송 서버 SPAM 등재 시 연결 거부
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '07'}">
								연결 시간 초과
							</c:when>
							<%-- <c:when test="${data.SEND_RSLT_CD eq '91' or data.SEND_RSLT_CD eq '92' or data.SEND_RSLT_CD eq '99'}">
							</c:when> --%>
							<c:when test="${data.SEND_RSLT_CD eq '91'}">
								H-etc error (다시 발송 해도 발송이 안될 확률이 높은 메일들)
							</c:when>
							<c:when test="${data.SEND_RSLT_CD eq '92'}">
								S-etc error (다시 발송 하면 발송 될 확률이 높은 메일들)
							</c:when>
							<c:when test="${data.SEND_FLAG eq 'N' and empty data.SEND_RSLT_CD}">
								대기
							</c:when>
							<c:when test="${data.SEND_FLAG eq 'Y' and empty data.SEND_RSLT_CD}">
								발송중
							</c:when>
							<c:otherwise>
								발송실패
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			
				</c:forEach>
			</c:when>
			<c:otherwise>
		
			<tr>
				<td colspan="4"> 조회된 데이터가 없습니다. </td>
			</tr>
			
			</c:otherwise>
			
		</c:choose>
			
		</tbody>
	</table>
	</form>
	
	<div class="board_pager">
		<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
			<Previous><AllPageLink><Next>
		</paging:PageFooter>
	</div>
</div>

<script type="text/javascript">

$(function(){
	
	//클릭이벤트
	$('#btnSearch').click(function(){
		$("#searchForm").attr('action', '${ctxMgr}/newsLetterMgr/mailResult');
		$('#searchForm').submit();
	}); 
});

//엑셀다운로드
function doExcelDownload(){
var url = "${contextPath}/mgr/newsLetterMgr/mailResultExcelDown";
document.searchForm.action = url;
document.searchForm.submit();
}

</script>
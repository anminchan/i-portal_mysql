<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
        
	<spform:form id="viewForm" name="viewForm" action="${contextPath }/mgr/changLogMgr/form" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>

	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schStartDate" value="${param.schStartDate}">
	<input type="hidden" name="schEndDate" value="${param.schEndDate}">
	<input type="hidden" name="siteId" value="${param.siteId}">
	
	<fieldset>
		<legend>변경현황 관리 로그</legend>
		<h2 class="depth2_title">변경현황 관리 상세</h2>
		<table class="tstyle_view">
			<caption>
				개인정보조회로그를 각 항목별 보여주는 표
			</caption>
			<colgroup>
			<col width="150" />
		    <col />
		    <col width="150" />
		    <col />
			</colgroup>
			<tbody>	
				<tr>
					<th scope="row">처리일시</th>
					<td>${dmlTime }</td>
					<th scope="row">처리자</th>
					<td>${dmlUserName }</td>
				</tr>		
				<tr>
					<th scope="row">사이트</th>
					<td>${siteName }</td>
					<th scope="row">메뉴</th>
					<td>${namePath }</td>
				</tr>
				<tr>
					<th scope="row">기능</th>
					<td>${dmlTypeName }</td>
					<th scope="row">접속IP</th>
					<td>${dmlIp }</td>
				</tr>
				<tr>
					<th scope="row">기존데이터</th>
					<td colspan="3">
					<textarea name="beforeData" id="beforeData" class="txtarea" style="height: 150px;" title="기존데이터" readonly="readonly">
					${beforeData }
					</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">수정데이터</th>
					<td colspan="3">
					<textarea name="afterData" id="afterData" class="txtarea" style="height: 150px;" title="수정데이터" readonly="readonly">
					${afterData }
					</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>
	</spform:form>
	
	<div class="btn_area_form">
		<span class="float_right">
			<button type="button" class="btn_colorType01" id="btnList">목록</button>
		</span>
	</div>

<script type="text/javascript">
$(function() {	
	$("#btnList").click(function(){
		$("#viewForm").attr('action', '${ctxMgr }/changLogMgr');
		$("#viewForm").submit();
	});
	
});

</script>
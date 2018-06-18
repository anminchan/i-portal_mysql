<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
        
	<spform:form id="viewForm" name="viewForm" action="${contextPath }/mgr/satisfyStat/form" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>

	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="schStartDate" value="${param.schStartDate}">
	<input type="hidden" name="schEndDate" value="${param.schEndDate}">
	<input type="hidden" name="siteId" value="${param.siteId}">
	
	<fieldset>
		<legend>만족도 통계</legend>
		<table class="tstyle_view">
			<caption>
				만족도 통계를 각 항목별 보여주는 표
			</caption>
			<colgroup>
			<col width="150" />
		    <col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사이트</th>
					<td>${siteKName }</td>
				</tr>		
				<tr>
					<th scope="row">메뉴</th>
					<td>${namePath }</td>
				</tr>
			</tbody>
		</table>
	</fieldset>
	<br />
	<br />
	
	<div id="contentArea">
		<h2 class="depth2_title">만족도 통계 상세</h2>
		<table class="tstyle_list" summary="등록일, 점수, COMMENT, ID">
			<caption>
				만족도 통계 상세
			</caption>
			<colgroup>
				<col style="width:210px" />
				<col style="width:110px" />
				<col style="width:*" />
				<col style="width:210px" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">등록일</th>
					<th scope="col">점수</th>
					<th scope="col">COMMENT</th>
					<th scope="col">ID</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
					<tr>
						<td>${data.REGDATE }</td>
						<td>${data.POINT }</td>
						<td>${data.COMMENT }</td>
						<td>${data.DMLUSERID }</td>
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
	</div>
	</spform:form>
	<div class="btn_area_form">
		<span class="float_right">
			<button type="button" class="btn_colorType01" id="btnList">목록</button>
		</span>
	</div>

<script type="text/javascript">
$(function() {	
	$("#btnList").click(function(){
		$("#viewForm").attr('action', '${ctxMgr }/satisfyStat');
		$("#viewForm").submit();
	});
	
});

</script>
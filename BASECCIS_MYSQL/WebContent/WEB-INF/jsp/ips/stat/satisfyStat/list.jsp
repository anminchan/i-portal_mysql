<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
        
<spform:form id="searchForm" name="searchForm" method="GET" action="${contextPath }/mgr/satisfyStat" class="search_form">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="siteId">사이트</label>
				<select name="siteId" id="siteId" title="사이트">
				</select>
			</div>
			<div class="row">
				<label for="connectTime">기간</label>				  
		        <input type="text" id="schStartDate" name="schStartDate" title="신청기간 입력" value="${obj.schStartDate }" readonly="readonly"/> ~
		        <input type="text" id="schEndDate" name="schEndDate" title="신청기간 입력" value="${obj.schEndDate }" readonly="readonly"/>				        
			</div>
			<span class="display_block txt_center">
				<input type="submit" id="btnSearch" class="btn btn_type02" value="검색">
			</span>
		</div>
	</fieldset>
</spform:form>

<c:if test="${empty first}">	
	<c:if test="${!empty result }">
	<ul class="tree_structure">
		<c:forEach items="${result }" var="data" varStatus="loop">
			<c:if test="${data.DEPTH == 1}">
				<li id="depth_${data.MENUID}">
					<strong>${data.MENUNAME}</strong> 
					<span class="progress_area">
						<c:if test="${data.USERGRADEYN != 'N' }">
							<span class="progress"><span class="bar" style="width: ${data.RATE }%;"></span>(${data.RATE }%)</span>
						</c:if>
						<c:if test="${data.USERGRADEYN == 'N' }">
							-
						</c:if>
						${data.AVGGRADE} ${data.CNTGRADE } 
					</span>	
				</li>
			</c:if>
		</c:forEach>
	</ul>
	</c:if>
</c:if>

<c:if test="${empty first}">	
<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/satisfyStat" method="POST">
    <input type="hidden" name="menuId" id="menuId" value="${obj.menuId }" />  
    <input type="hidden" name="schStartDate" value="${param.schStartDate}">
	<input type="hidden" name="schEndDate" value="${param.schEndDate}">
	
	<input type="hidden" name="paramMenuId" id="paramMenuId" value="">
	<input type="hidden" name="namePath" id="namePath" value="">
	<input type="hidden" name="siteKName" id="siteKName"  value="">
		
		<div class="table">
			<table class="tstyle_list">
				<caption>
					만족도 통계 - 메뉴, 만족도 결과, 평균, 등록수
				</caption>
				<colgroup>
					<col class="menu">
					<col class="access_effect">
					<col class="hit">
					<col class="hit">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">메뉴</th>
						<th scope="col">만족도 결과</th>
						<th scope="col">평균</th>
						<th scope="col">등록수</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>			
					<c:when test="${!empty result }">
						<c:forEach items="${result }" var="data" varStatus="loop">
						<tr>
							<td class="txt_left"> 
								<c:choose>
									<c:when test="${data.DEPTH == 1}">◎</c:when>
								  	<c:when test="${data.DEPTH == 2}">▶</c:when>
									<c:otherwise>→</c:otherwise>
							  	</c:choose>
								${data.MENUNAME }
							</td>
							<c:if test="${data.USERGRADEYN != 'N' }">
								<td class="txt_left">
									<span class="progress"><span class="bar" style="width: ${data.RATE }%;"></span></span> (${data.RATE }%)
								</td>
							</c:if>
							<c:if test="${data.USERGRADEYN == 'N' }">
								<td>-</td>
							</c:if>
							<td>${data.AVGGRADE }</td>
							<td>${data.CNTGRADE }</td>						
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
</c:if>
	
<script type="text/javascript">
$(function() {	
	gfnSiteComboList($("#siteId"), "", "사이트 선택", "${obj.siteId}");
	    
	//달력 세팅
    $( "#schStartDate, #schEndDate" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
		onClose: function( selectedDate ) { 
			$('#schEndDate').datepicker("option","minDate", selectedDate); 
		} 
    });
    
	$('#btnSearch').click(function(){
		if($('#schStartDate').val() != null && $('#schStartDate').val() != ''){
    		if($('#schEndDate').val() == null || $('#schEndDate').val() == ''){
    			alert("검색 종료일을 입력하세요");
    			document.searchForm.schEndDate.focus();
    			return false;
    		}
    	}
    	
    	if($('#schEndDate').val() != null && $('#schEndDate').val() != ''){
    		if($('#schStartDate').val() == null || $('#schStartDate').val() == ''){
    			alert("검색 시작일을 입력하세요");
    			document.searchForm.schStartDate.focus();
    			return false;
    		}
    	}
    	
		$("#searchForm").attr('action', '${ctxMgr }/satisfyStat');
		$('#searchForm').submit();
	});
	
	<c:if test="${empty first}">
		<c:forEach items="${result }" var="data" varStatus="loop">
			<c:if test="${data.DEPTH == 2}">
				if($("#depth_${data.HIGHERID} > ul").length < 1){
			    	$("#depth_${data.HIGHERID}").append("<ul class='depth2'></ul>");
		    	}
				
				var str1="<li id='depth_${data.MENUID}'>";
				str1+="<strong>${data.MENUNAME }</strong><span class='progress_area'>"; 
					<c:if test="${data.USERGRADEYN != 'N' }">
						str1+="<span class='progress'><span class='bar' style='width: ${data.RATE }%;'></span></span> (${data.RATE }%)";
					</c:if>
					<c:if test="${data.USERGRADEYN == 'N' }">
						str1+="-";
					</c:if>
				str1+=" ${data.AVGGRADE} ${data.CNTGRADE }</span></li>";
				$("#depth_${data.HIGHERID} > ul").append(str1);
			</c:if>
			<c:if test="${data.DEPTH == 3}">
				if($("#depth_${data.HIGHERID} > ul").length < 1){
			    	$("#depth_${data.HIGHERID}").append("<ul class='depth3'></ul>");
		    	}

				var str2="<li id='depth_${data.MENUID}'>";
				str2+="<strong>${data.MENUNAME }</strong><span class='progress_area'>"; 
					<c:if test="${data.USERGRADEYN != 'N' }">
						str2+="<span class='progress'><span class='bar' style='width: ${data.RATE }%;'></span></span> (${data.RATE }%)";
					</c:if>
					<c:if test="${data.USERGRADEYN == 'N' }">
						str2+="-";
					</c:if>
				str2+=" ${data.AVGGRADE} ${data.CNTGRADE }</span></li>";
				$("#depth_${data.HIGHERID} > ul").append(str2);
			</c:if>
	    </c:forEach>
	</c:if>
});

//상세보기
function fnGradeView(menuId, namePath){
	$("#paramMenuId").val(menuId);
	$("#namePath").val(namePath);
	$("#siteKName").val($("#siteId option:selected").text());
	
	$("#listForm").attr('action', '${ctxMgr }/satisfyStat/form');
	$("#listForm").submit();
}

</script>

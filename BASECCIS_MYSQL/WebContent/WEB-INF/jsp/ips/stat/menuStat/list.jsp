<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
        
<spform:form id="searchForm" name="searchForm" method="GET" action="${contextPath }/mgr/menuStat" class="search_form">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<input type="hidden" name="statisSchGubun" id="statisSchGubun" value="">
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
	<c:if test="${!empty resultMenu }">
	<ul class="tree_structure">
		<c:forEach items="${resultMenu }" var="data" varStatus="loop">
			<c:if test="${data.DEPTH == 1}">
				<li id="depth_${data.MENUID}">
					<strong>${data.MENUNAME}</strong> 
					<span class="progress_area">
						<span class="progress"><span class="bar" style="width: ${data.RATE }%;"></span></span>
						${data.CONNECTCNT} (${data.RATE }%) 
					</span>	
				</li>
			</c:if>
		</c:forEach>
	</ul>
	</c:if>
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
    	
		$("#searchForm").attr('action', '${ctxMgr }/menuStat');
		$('#searchForm').submit();
	});
	
	<c:if test="${empty first}">
		<c:forEach items="${resultMenu }" var="data" varStatus="loop">
			<c:if test="${data.DEPTH == 2}">
				if($("#depth_${data.HIGHERID} > ul").length < 1){
			    	$("#depth_${data.HIGHERID}").append("<ul class='depth2'></ul>");
		    	}
				$("#depth_${data.HIGHERID} > ul").append("<li id='depth_${data.MENUID}'><strong>${data.MENUNAME }</strong> <span class='progress_area'><span class='progress'><span class='bar' style='width: ${data.RATE }%;'></span></span>${data.CONNECTCNT} (${data.RATE }%) </span></li>");
			</c:if>
			<c:if test="${data.DEPTH == 3}">
				if($("#depth_${data.HIGHERID} > ul").length < 1){
			    	$("#depth_${data.HIGHERID}").append("<ul class='depth3'></ul>");
		    	}
				$("#depth_${data.HIGHERID} > ul").append("<li id='depth_${data.MENUID}'><strong>${data.MENUNAME }</strong> <span class='progress_area'><span class='progress'><span class='bar' style='width: ${data.RATE }%;'></span></span>${data.CONNECTCNT} (${data.RATE }%)</span></li>");
			</c:if>
	    </c:forEach>
	</c:if>
});

</script>

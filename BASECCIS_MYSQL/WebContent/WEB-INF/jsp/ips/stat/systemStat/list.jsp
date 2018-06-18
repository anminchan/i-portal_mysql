<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<script type="text/javascript">

   	// 변수 설정 start
	var hitChart;
	var hitChartData = [];
				
    $(function(){
		if("${statisSchGubun}" != "BROWSER"){
			<c:forEach items="${resultUser}" var="data" varStatus="loop">
			var date = "${statisSchGubun}" == "TIME" ? "${data.CONNECTDATEHH}" : new Date("${data.CONNECTDATE}");
				hitChartData.push({
					date: date,
		            member: "${data.CONNECTCNT}",
		            guest: "${resultGuest[loop.index].CONNECTCNT}"
				});
			</c:forEach>
				
			hitChart = new AmCharts.AmSerialChart();
		    hitChart.dataProvider = hitChartData;
		    hitChart.categoryField = "date";
		    hitChart.startDuration = 1;
		    hitChart.addListener("dataUpdated", zoomHitChart);
		    hitChart.svgIcons = false; // svg 버튼 사용안하고 png 버튼으로 대체

		    var categoryAxis1 = hitChart.categoryAxis;
		    <c:if test="${statisSchGubun ne 'TIME'}">
		    categoryAxis1.parseDates = true; // as our data is date-based, we set parseDates to true
		    categoryAxis1.minPeriod = "${statisSchGubun}" == "MONTH" ? "MM" : "DD"; // our data is daily, so we set minPeriod to DD
			categoryAxis1.dateFormats = [{period:'MM',format:'M월'},{period:'YYYY',format:'YYYY년'},{period:'DD',format:'DD일'}];
		    </c:if>
		    categoryAxis1.minorGridEnabled = true;
		    categoryAxis1.axisColor = "#DADADA";
			categoryAxis1.twoLineMode = true;
		    categoryAxis1.autoGridCount = false; // auto 사용안함
		    categoryAxis1.gridCount = 30; // 표시할 x축 label 수

		    var valueAxis1 = new AmCharts.ValueAxis();
		    valueAxis1.axisColor = "#DADADA";
			valueAxis1.axisThickness = 2;
		    valueAxis1.gridAlpha = 0;
			// valueAxis1.inside = true; (값 기준선을 안쪽으로)
		    hitChart.addValueAxis(valueAxis1);

		    // 비회원
		    var guestGraph = new AmCharts.AmGraph();
		    guestGraph.valueAxis = valueAxis1; // we have to indicate which value axis should be used
		    guestGraph.title = "비회원";
		    guestGraph.lineColor = "#DA3D00";
		    guestGraph.valueField = "guest";
		    guestGraph.bullet = "round";
		    guestGraph.hideBulletsCount = 30;
		    guestGraph.bulletBorderThickness = 1;
		    guestGraph.balloonText = "비회원: [[value]]";
		    hitChart.addGraph(guestGraph);

		    // 회원
		    var memberGraph = new AmCharts.AmGraph();
		    memberGraph.valueAxis = valueAxis1; // we have to indicate which value axis should be used
		    memberGraph.title = "회원";
		    memberGraph.lineColor = "#227BC1";
		    memberGraph.valueField = "member";
		    memberGraph.bullet = "round";
		    memberGraph.hideBulletsCount = 30;
		    memberGraph.bulletBorderThickness = 1;
		    memberGraph.balloonText = "회원: [[value]]";
		    hitChart.addGraph(memberGraph);
		    
		    var chartCursor1 = new AmCharts.ChartCursor();
		    chartCursor1.cursorAlpha = 0.1;
		    chartCursor1.fullWidth = true;
		    <c:if test="${statisSchGubun ne 'TIME'}">
		    chartCursor1.categoryBalloonDateFormat = "${statisSchGubun}" == "MONTH" ? "YYYY.MM" : "YYYY.MM.DD";
		    </c:if>
		    hitChart.addChartCursor(chartCursor1);

		    var chartScrollbar1 = new AmCharts.ChartScrollbar();
		    hitChart.addChartScrollbar(chartScrollbar1);
		 	
			// 언어설정
			hitChart.language = "ko";
		    hitChart.write("chart_div");
		}
    });
    function zoomHitChart() {
    	hitChart.zoomToIndexes(hitChartData.length - 40, hitChartData.length - 1);
    }
</script>


<ul class="tab_menu">
	<li <c:if test="${statisSchGubun == 'MONTH'}"> class="on"</c:if>><a href="javascript:goList('MONTH')">월별 접속통계</a></li>
	<li <c:if test="${statisSchGubun == 'DAY'}"> class="on"</c:if>><a href="javascript:goList('DAY')">일별 접속통계</a></li>
	<li <c:if test="${statisSchGubun == 'TIME'}"> class="on"</c:if>><a href="javascript:goList('TIME')">시간별 접속통계</a></li>
	<li <c:if test="${statisSchGubun == 'BROWSER'}"> class="on"</c:if>><a href="javascript:goList('BROWSER')">접속기기별</a></li>
</ul>


<spform:form id="searchForm" name="searchForm" method="GET" action="${contextPath }/mgr/systemStat" class="search_form">
	<input type="hidden" name="menuId" value="${param.menuId}">
	<input type="hidden" name="statisSchGubun" id="statisSchGubun" value="${statisSchGubun }">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="siteId">사이트</label>
				<select name="siteId" id="siteId" title="사이트">
				</select>
			</div>
			<div class="row">
				<label for="schStartDate">기간</label>
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
<c:if test="${statisSchGubun != 'BROWSER'}">
	<div id="chart_div" class="chart_area"></div>
	<h2 class="depth2_title">회원 접속통계</h2>
	<div class="table">
		<table class="tstyle_list">
			<caption>
			회원 접속통계 - <c:if test="${statisSchGubun == 'MONTH'}">월별</c:if><c:if test="${statisSchGubun == 'DAY'}">일별</c:if><c:if test="${statisSchGubun == 'TIME'}">시간별</c:if>, 접속수, 비율 정보 제공
			</caption>
			<colgroup>
				<col class="menu">
				<col class="hit">
				<col class="access_effect">
			</colgroup>
			<thead>
				<tr>
					<c:if test="${statisSchGubun == 'MONTH'}">
			      	  	<th scope="col">월별</th>
			      	 </c:if>
			      	 <c:if test="${statisSchGubun == 'DAY'}">
			      	    <th scope="col">일별</th>
			      	 </c:if>
			      	 <c:if test="${statisSchGubun == 'TIME'}">
			      	    <th scope="col">시간별</th>
			       	 </c:if>
					<th scope="col">접속수</th>
					<th scope="col">비율</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>			
					<c:when test="${!empty resultUser }">
						<c:set var="nTotal" value="0" />
						<c:forEach items="${resultUser }" var="data" varStatus="loop">
							<tr>
								<td><c:out value='${data.CONNECTDATE }' /></td>
								<td><fmt:formatNumber value='${data.CONNECTCNT }' pattern='#,###'/></td>
								<td class="txt_left">
									<span class="progress"><span class="bar" style="width: ${data.RATE }%;"></span></span> (${data.RATE }%)
								</td>
							</tr>
							<c:set var="nTotal" value="${nTotal + data.CONNECTCNT }" />			
						</c:forEach>
						<tr>
							<td>합계</td>
							<td><fmt:formatNumber value='${nTotal }' pattern='#,###'/></td>
							<td></td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="3"> 조회된 데이터가 없습니다. </td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<h2 class="depth2_title">비회원 접속통계</h2>
	<div class="table">
		<table class="tstyle_list">
			<caption>
			투표경향분석
			</caption>
			<colgroup>
				<col class="menu">
				<col class="hit">
				<col class="access_effect">
			</colgroup>
			<thead>
				<tr>
					<c:if test="${statisSchGubun == 'MONTH'}">
		       	  	<th scope="col">월별</th>
		       	  	</c:if>
		       	    <c:if test="${statisSchGubun == 'DAY'}">
		       	    <th scope="col">일별</th>
		       	    </c:if>
		       	    <c:if test="${statisSchGubun == 'TIME'}">
		       	    <th scope="col">시간별</th>
		        	    </c:if>
					<th scope="col">접속수</th>
					<th scope="col">비율</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty resultGuest }">
					<c:set var="nTotal" value="0" />
					<c:forEach items="${resultGuest }" var="data" varStatus="loop">
						<tr>
							<td><c:out value='${data.CONNECTDATE }' /></td>
							<td><fmt:formatNumber value='${data.CONNECTCNT }' pattern='#,###'/></td>
							<td class="txt_left">
								<span class="progress"><span class="bar" style="width: ${data.RATE }%;"></span></span> (${data.RATE }%)
							</td>
						</tr>		
						<c:set var="nTotal" value="${nTotal + data.CONNECTCNT }" />				
					</c:forEach>
					<tr>
						<td>합계</td>
						<td><fmt:formatNumber value='${nTotal }' pattern='#,###'/></td>
						<td></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3"> 조회된 데이터가 없습니다. </td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</c:if>
<c:if test="${statisSchGubun == 'BROWSER'}">
	<div class="table">
		<table class="tstyle_list" >
			<caption>
				접속기기별통계 목록 -접속기기, 조회수, 비율에 따른 접속기기별통계 목록
			</caption>
			<colgroup>
				<col class="menu">
				<col class="hit">
				<col class="access_effect">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">접속기기</th>
					<th scope="col">조회수</th>
					<th scope="col">비율</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>	
				<c:when test="${!empty resultBrowser }">
					<c:set var="nTotal" value="0" />
					<c:forEach items="${resultBrowser }" var="data" varStatus="loop">
						<tr>
							<td><c:out value='${data.MODULE }' /></td>
							<td><fmt:formatNumber value='${data.CONNECTCNT }' pattern='#,###'/></td>
							<td class="txt_left"><span class="progress"><span class="bar" style="width: ${data.RATE }%;"></span></span> (${data.RATE }%)</td>
						</tr>
						<c:set var="nTotal" value="${nTotal + data.CONNECTCNT }" />		
					</c:forEach>
					<tr>
						<td>합계</td>
						<td><fmt:formatNumber value='${nTotal }' pattern='#,###'/></td>
						<td></td>
					</tr>
				</c:when>
				<c:otherwise>			
				<tr>
					<td colspan="3"> 조회된 데이터가 없습니다. </td>
				</tr>
				</c:otherwise>
			</c:choose>				
			</tbody>
		</table>
	</div>
</c:if>
</c:if>
	
<script type="text/javascript">
$(function() {	
	gfnSiteComboList($("#siteId"), "", "사이트 선택", "${obj.siteId}");
	    
	//달력 세팅
    $( "#schStartDate" ).datepicker({
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
    
    $( "#schEndDate" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
		onClose: function( selectedDate ) { 
			$('#schStartDate').datepicker("option","maxDate", selectedDate); 
		}
    });
    
	$('#btnSearch').click(function(){
		if($('#siteId').val() == ''){
   			alert("사이트를 선택하세요");
   			$('#siteId').focus();
    		return false;
		}
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
    	
		$("#searchForm").attr('action', '${ctxMgr }/systemStat');
		$('#searchForm').submit();
	});
	
});

//탭 메뉴 이동
function goList(statisSchGubun) {
	if($('#siteId').val() == ''){
		alert("사이트를 선택하세요");
		$('#siteId').focus();
	}else{
		$("#statisSchGubun").val(statisSchGubun);
		$("#schStartDate").val("");
		$("#schEndDate").val("");
		
		$("#searchForm").attr('action', '${ctxMgr }/systemStat');
		$('#searchForm').submit();
	}
}

</script>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/doodlesMgr/act" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	
	<!-- DoodlesHiddenData -->
	<input type="hidden" id="siteId" name="siteId" value="${rtnDoodles.siteId}"/>
	<input type="hidden" id="doodlesId" name="doodlesId" value="${rtnDoodles.doodlesId}"/>
	
	<!-- BeforeData -->
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnDoodles.inBeforeData}"/>
	
	<!-- 나모첨부파일 사용경우 START -->
	<!-- 파일 정보를 저장할 폼 데이터 -->
	<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
	<!-- 나모첨부파일 사용경우 END -->
	
	<!--  파일 hidden -->
	<%-- <input type="hidden" name="imageFileName" id="imageFileName" value="${rtnDoodles.imageFileName }"/>
	<input type="hidden" name="imageSFileName" id="imageSFileName" value="${rtnDoodles.imageSFileName }"/>
	<input type="hidden" name="filePath" id="filePath" value="${rtnDoodles.filePath }"/> --%>
	<input type="hidden" name="fileGubun" id="fileGubun" value="ips"/>
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schSiteId" value="${param.schSiteId }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	<input type="hidden" name="schState" value="${param.schState }">
	
	<fieldset>
		<legend>두들 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<table class="tstyle_view" summary="등록일, 이름, 이메일, 담당부서, 제목, 내용에 따른 게시물상세 안내">
			<caption>
				사이트 상세 정보 입력
			</caption>
			<colgroup>
				<col width="170" />
				<col />
				<col width="170" />
				<col />
			</colgroup>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KName">사이트</label></th>
				<td colspan="3"><select name="siteIdSel" id="siteIdSel"></select></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
				<td colspan="3"><input type="text" id="KName" name="KName" value="${rtnDoodles.KName}" class="input_mid02" maxlength="40" title="두들제목" /></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="url">게시기간</label></th>
				<td colspan="3">
					<input type="hidden" id="startTime" name="startTime" />
		        	<input type="hidden" id="endTime" name="endTime" />
		        	
		        	<fmt:parseDate value="${rtnDoodles.startTime }" pattern="yyyyMMddHH" var="pStartTime" />
					<fmt:formatDate value="${pStartTime}" pattern="yyyy-MM-dd" var="startDate"/>
					<fmt:formatDate value="${pStartTime}" pattern="HH" var="hh"/>
					<c:set var="startTimeHh" value="${hh }" />
					
					<fmt:parseDate value="${rtnDoodles.endTime }" pattern="yyyyMMddHH" var="pEndTime" />
					<fmt:formatDate value="${pEndTime}" pattern="yyyy-MM-dd" var="endDate"/>
					<fmt:formatDate value="${pEndTime}" pattern="HH" var="hh"/>
					<c:set var="endTimeHh" value="${hh }" />
					
					<input type="text" name="startDate" id="startDate" value="${startDate}" readOnly="readOnly" />
					<select name="startTime_hh" id="startTime_hh" class="timeSetting">
						<c:forEach begin="0" end="23" var="items" varStatus="status">
							<c:if test="${status.index < 10 }">
								<c:set var="startTimeHhVal" value="0${status.index }" />
							</c:if>
							<c:if test="${status.index >= 10 }">
								<c:set var="startTimeHhVal" value="${status.index }" />
							</c:if>
							<option value="${startTimeHhVal }" <c:if test="${startTimeHh == startTimeHhVal }">selected="selected"</c:if>>${startTimeHhVal }</option>
						</c:forEach>
					</select>
					 ~ <input type="text" name="endDate" id="endDate" value="${endDate}" readOnly="readOnly" />
					 <select name="endTime_hh" id="endTime_hh" class="timeSetting">
						<c:forEach begin="0" end="23" var="items" varStatus="status">
							<c:if test="${status.index < 10 }">
								<c:set var="endTimeHhVal" value="0${status.index }" />
							</c:if>
							<c:if test="${status.index >= 10 }">
								<c:set var="endTimeHhVal" value="${status.index }" />
							</c:if>
							<option value="${endTimeHhVal }" <c:if test="${endTimeHh == endTimeHhVal }">selected="selected"</c:if>>${endTimeHhVal }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="state">사용여부</label></th>
				<td>
					<input name="state" id="stateY" value="T" type="radio" title="사용여부" checked/>
					<label for="stateY">사용</label>
					<input name="state" id="stateN" value="F" type="radio" title="사용여부" />
					<label for="stateN">미사용</label>
				</td>
				<th scope="row"><span class="point01">*</span> <label for="sort">우선순위</label></th>
				<td><input type="text" id="sort" name="sort" value="${rtnDoodles.sort}" class="input_Num" maxlength="8" title="우선순위" /></td>
			</tr>
			<!-- 
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KName">새창여부</label></th>
				<td colspan="3">
					<select name="newWindowYn" id="newWindowYn" style="width:150px;"></select>
				</td>
			</tr>
			 -->
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="imageUserFileName">이미지</label></th>
				<td colspan="3">
					<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
			        <div id="flashContentManager" style="display: none;">
			            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
			            <script type="text/javascript"> 
			                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
			                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
			                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
			                <c:if test="${!empty rtnDoodles.doodlesId}">
                         		var strOldFileInfo = new Object();
                         		strOldFileInfo.fileId = "common@@doodlesMgr@@${rtnDoodles.imageSFileName}@@${rtnDoodles.imageFileName}@@${rtnDoodles.filePath}";
                                strOldFileInfo.fileName = "${rtnDoodles.imageFileName}";
                                strOldFileInfo.fileSName = "${rtnDoodles.imageSFileName}";
                                strOldFileInfo.filePath = "${rtnDoodles.filePath}";
                                strOldFileInfo.fileSize = "${rtnDoodles.fileRealSize}";
                                strOldFileInfoArray.push(strOldFileInfo);
			                </c:if>
			            </script> 
			        </div>
			        <!-- NamoCrossUploader의 Monitor 객체가 위치할 HTML Id와 Monitor Layer Id-->
					<div id="monitorLayer" style="display: none;">
						<div id="flashContentMonitor" style="display:none;"></div>
					</div>
					<!-- NamoCrossUploader의 Monitor 창이 출력될 때 화면의 백그라운드 Layer Id -->
					<div id="monitorBgLayer" style="display: none;"></div>
				</td>
			</tr>
			<%-- 
			<c:if test="${!empty rtnDoodles.doodlesId}">
				<tr>
					<th scope="row">다운로드</th>
					<td colspan="3">
						<ul class="download_list">
							<li><a href="${contextPath}/fileDownload?fileGubun=common&menuId=doodlesMgr&userFileName=${rtnDoodles.imageFileName}&systemFileName=${rtnDoodles.imageSFileName}" title="${rtnDoodles.imageFileName}">${rtnDoodles.imageFileName}<span>내려받기</span></a></li>
						</ul>
					</td>
				</tr>
			</c:if>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="linkURL">링크URL</label></th>
				<td colspan="3">
				<input type="text" name="linkURL" id="linkURL" value="<c:if test="${empty rtnDoodles.linkURL }">http://</c:if><c:if test="${!empty rtnDoodles.linkURL }">${rtnDoodles.linkURL}</c:if>" class="input_long" title="링크URL"/>
				<div>※ 링크URL이 없을 경우 #을 입력하시기 바랍니다.</div>
				<div>※ 다중링크제공형태(사용: §§ ) : url_1§§url_2 (예: http://www.naver.com§§http://www.daum.net)</div>
				</td>
			</tr>
			 --%>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KDesc">내용</label></th>
				<td colspan="3"><input type="text" name="KDesc" id="KDesc" value="${rtnDoodles.KDesc}" class="input_long" title="팝업내용"/></td>
			</tr>
			
		</table>
	</fieldset>
	<input type="hidden" name="newWindowYn" id="newWindowYn" value="N"/>
	<input type="hidden" name="linkURL" id="linkURL" value="#"/>
</spform:form>

<div class="btn_area">
		<button type="button" class="btn btn_type02 ${!empty rtnDoodles.doodlesId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<c:if test="${!empty rtnDoodles.doodlesId}">
		<button type="button" class="btn btn_type01 roleDELETE" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

<script type="text/javascript">
$(function() {
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnDoodles.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
// 	gfnCodeComboList($("#newWindowYn"), "NewWindowYN", "0", "코드 선택", "0"); // 새창여부 코드조회
// 	$('#newWindowYn').on("change", function() { // 새창여부 이벤트
		
// 	});
	
	// 새창 기본세팅
// 	<c:if test="${!empty rtnDoodles.doodlesId }">
// 		$("#newWindowYn").val("${rtnDoodles.newWindowYn }").prop("selected", "selected");
// 	</c:if>
// 	<c:if test="${empty rtnDoodles.doodlesId }">
// 		$("#newWindowYn").val("N").prop("selected", "selected");
// 	</c:if>
	
	//달력 세팅
   $("#startDate").datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        onClose: function( selectedDate ) { 
			$('#endDate').datepicker("option","minDate", selectedDate); 
		}
    });
    
    $("#endDate").datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        onClose: function( selectedDate ) { 
			$('#startDate').datepicker("option","maxDate", selectedDate); 
		}
    });
    
	$("input:radio[name='state']:radio[value='${rtnDoodles.state}']").attr("checked",true);
	
	// 숫자만입력
	$(".input_Num").keyup(function(){
		fnNumCheck($(this).prop("id"));
	});
	
	$("#btnSave").click(function(){
		if($("#siteIdSel option:selected").val() == "") {
			alert("사이트를 선택하세요.");
			$("#siteIdSel").focus();
			return false;
		}
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		if($("#startDate").val().length <= 0) {
			alert("게시일을 입력하세요.");
			$("#startDate").focus();
			return false;
		}
		if($("#endDate").val().length <= 0) {
			alert("게시일을 입력하세요.");
			$("#endDate").focus();
			return false;
		}
		
		// 게시일 시작일 종료일 기간 체크
		// 년도, 월, 일로 분리
        var start_dt = $("#startDate").val().split("-");
        var end_dt = $("#endDate").val().split("-");
        
         // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
        // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
        start_dt[1] = (Number(start_dt[1]) - 1) + "";
        end_dt[1] = (Number(end_dt[1]) - 1) + "";
 
        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2], $("#startTime_hh option:selected").val());
        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2], $("#endTime_hh option:selected").val());
  
	    var chkDate = (to_dt.getTime() - from_dt.getTime());
	    
	    if(chkDate < 0 ){
			alert("종료시간이 시작시간 이전이면 안됩니다. 다시 확인하세요.");
		    return false;
	    }
	    
		if($("#sort").val().length <= 0) {
			alert("우선순위를 입력하세요.");
			$("#sort").focus();
			return false;
		}
		if(cuManager.getTotalFileCount() == 0){
			alert("이미지를 입력하세요.");
			return false;
		}
// 		if($("#linkURL").val().length <= 0) {
// 			alert("링크URL를 입력하세요.");
// 			$("#linkURL").focus();
// 			return false;
// 		}
// 		if($("#linkURL").val().indexOf("http://") < 0){
// 			if(!confirm("프로토콜(http://)이 빠지면 링크에 오류가 생길 수 있습니다.\n저장하시겠습니까?")){
// 				$("#linkURL").focus();
// 				return false;			
// 			}		
// 		}
		if($("#KDesc").val().length <= 0) {
			alert("내용을 입력하세요.");
			$("#KDesc").focus();
			return false;
		}

		if(!confirm("등록하시겠습니까?")) {
			return false;
		}

		//게시일 시간설정 2015.09.21
		$("#startTime").val($("#startDate").val() +" "+$("#startTime_hh option:selected").val());
		$("#endTime").val($("#endDate").val() +" "+$("#endTime_hh option:selected").val());
		
		// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
		if(cuManager.getTotalFileCount() == 0){
			$("#insertForm").attr('action', '${ctxMgr}/doodlesMgr/act');
			$("#insertForm").submit();
		}else{
			cuManager.startUpload();
		}
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr}/doodlesMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/doodlesMgr');
		$("#insertForm").submit(); */

		location.href="${contextPath}/mgr/doodlesMgr?${link}";
	});
	
});

function fnNumCheck(id){
	$("#"+id).keyup(function(e){
		if($("#"+id).val().match(/[^0-9]/g) != null){
			alert("숫자만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
	});
}

//나모첨부파일 시작
$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('BASE'); //파일Init : 이미지만
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr}/doodlesMgr/act";
	filePath = "${contextPath}/namoFileUpload?fileGubun=common&fileMenuId=doodlesMgr";
	fileMaxSize = "${rtnSetting.fileMaxSize}" * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = "1";
	/*나모 End*/
});

</script>

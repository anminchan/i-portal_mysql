<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/popupWindowMgr/act" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	
	<!-- PopupWindowHiddenData -->
	<input type="hidden" id="siteId" name="siteId" value="${rtnPopupWindow.siteId}"/>
	<input type="hidden" id="popupId" name="popupId" value="${rtnPopupWindow.popupId}"/>
	
	<!-- BeforeData -->
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnPopupWindow.inBeforeData}"/>
	
	<!--  파일 hidden -->
	<input type="hidden" name="imageFileName" id="imageFileName" value="${rtnPopupWindow.imageFileName }"/>
	<input type="hidden" name="imageSFileName" id="imageSFileName" value="${rtnPopupWindow.imageSFileName }"/>
	<input type="hidden" name="filePath" id="filePath" value="${rtnPopupWindow.filePath }"/>
	<input type="hidden" name="fileGubun" id="fileGubun" value="ips"/>
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schSiteId" value="${param.schSiteId }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	
	<!-- 첨부파일 사용경우 START -->
	<!-- 파일 정보를 저장할 폼 데이터 -->
	<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
	<!-- 첨부파일 사용경우 END -->
	
	<fieldset>
		<legend>팝업 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
			<table class="tstyle_view">
				<caption>
					사이트 상세 정보 입력
				</caption>
				<colgroup>
					<col class="col-sm-3"/>
					<col />
				</colgroup>			
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="siteIdSel">사이트</label></th>
						<td><select name="siteIdSel" id="siteIdSel"></select></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
						<td><input type="text" id="KName" name="KName" value="${rtnPopupWindow.KName}" class="input_mid02" maxlength="40" title="팝업제목" /></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> 게시일</th>
						<td>
							<input type="hidden" id="startTime" name="startTime" />
				        	<input type="hidden" id="endTime" name="endTime" />
				        	
				        	<fmt:parseDate value="${rtnPopupWindow.startTime }" pattern="yyyyMMddHH" var="pStartTime" />
							<fmt:formatDate value="${pStartTime}" pattern="yyyy-MM-dd" var="startDate"/>
							<fmt:formatDate value="${pStartTime}" pattern="HH" var="hh"/>
							<c:set var="startTimeHh" value="${hh }" />
							
							<fmt:parseDate value="${rtnPopupWindow.endTime }" pattern="yyyyMMddHH" var="pEndTime" />
							<fmt:formatDate value="${pEndTime}" pattern="yyyy-MM-dd" var="endDate"/>
							<fmt:formatDate value="${pEndTime}" pattern="HH" var="hh"/>
							<c:set var="endTimeHh" value="${hh }" />
							
							<input type="text" name="startDate" id="startDate" value="${startDate}" readonly="readonly"/>
							<select name="startTime_hh" id="startTime_hh" class="timeSetting">
								<c:forEach begin="0" end="24" var="items" varStatus="status">
									<c:if test="${status.index < 10 }">
										<c:set var="startTimeHhVal" value="0${status.index }" />
									</c:if>
									<c:if test="${status.index >= 10 }">
										<c:set var="startTimeHhVal" value="${status.index }" />
									</c:if>
									<option value="${startTimeHhVal }" <c:if test="${startTimeHh == startTimeHhVal }">selected="selected"</c:if>>${startTimeHhVal }</option>
								</c:forEach>
							</select> 
							~ <input type="text" name="endDate" id="endDate" value="${endDate}" readonly="readonly"/>
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
						<th scope="row"><span class="point01">*</span> 사용여부</th>
						<td>
							<input name="state" id="stateY" value="T" type="radio" title="사용여부" checked/>
							<label for="T">사용</label>
							<input name="state" id="stateN" value="F" type="radio" title="사용여부" />
							<label for="F">미사용</label>
						</td>
						<th scope="row"><span class="point01">*</span> <label for="sort">순서</label></th>
						<td><input type="text" id="sort" name="sort" value="${rtnPopupWindow.sort}" class="input_Num" maxlength="8" title="순서" /></td>
					</tr>			
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="newWindowYn">새창여부</label></th>
						<td>
							<select name="newWindowYn" id="newWindowYn"></select>
						</td>
						<th scope="row"><span class="point01">*</span> <label for="daySessionYn">일일세션여부</label></th>
						<td>
							<input name="daySessionYn" id="daySessionY" value="T" type="radio" title="사용여부" checked/>
							<label for="T">사용</label>
							<input name="daySessionYn" id="daySessionN" value="F" type="radio" title="사용여부" />
							<label for="F">미사용</label>
						</td>
					</tr>					
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="positionXY">시작위치</label></th>
						<td>
							X: <input name="positionX" id="positionX" value="${(empty rtnPopupWindow.positionX or rtnPopupWindow.positionX == 0) ? 100 : rtnPopupWindow.positionX}" type="text" class="input_Num" title="시작위치"/>
							Y: <input name="positionY" id="positionY" value="${(empty rtnPopupWindow.positionY or rtnPopupWindow.positionX == 0) ? 100 : rtnPopupWindow.positionY}" type="text" class="input_Num" title="시작위치"/>
						</td>
						<th scope="row"><span class="point01">*</span> <label for="popupSize">팝업크기</label></th>
						<td>
							Width: <input name="popupWidth" id="popupWidth" value="${(empty rtnPopupWindow.popupWidth or rtnPopupWindow.popupWidth == 0) ? 250 : rtnPopupWindow.popupWidth}" type="text" class="input_Num" title="넓이"/>
							Height: <input name="popupHeight" id="popupHeight" value="${(empty rtnPopupWindow.popupHeight or rtnPopupWindow.popupHeight == 0) ? 350 : rtnPopupWindow.popupHeight}" type="text" class="input_Num" title="높이"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="imageUserFileName">이미지</label></th>
						<td>
							<c:if test="${!empty rtnPopupWindow.imageFileName }">
								<ul class="download_list">
						        	<li><a href="${contextPath}/fileDownload?fileGubun=common&menuId=popupWindowMgr&userFileName=${rtnPopupWindow.imageFileName }&systemFileName=${rtnPopupWindow.imageSFileName }"><c:out value="${rtnPopupWindow.imageFileName }" /> <span>내려받기</span></a></li>
								</ul>
							</c:if>
							<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
					        <div id="flashContentManagerImages" style="display: none;">
					            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
					            <script type="text/javascript"> 
					                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
					                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
					                 + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );

					                <c:if test="${!empty(rtnPopupWindow.imageFileName)}">
	                             		var strOldImgFileInfo = new Object();
	                             		strOldImgFileInfo.fileId = "${rtnPopupWindow.popupId}";
	                                    strOldImgFileInfo.fileName = "${rtnPopupWindow.imageFileName}";
	                                    strOldImgFileInfo.fileSName = "${rtnPopupWindow.imageSFileName}";
	                                    strOldImgFileInfo.filePath = "${rtnPopupWindow.filePath}";
	                                    strOldImgFileInfo.fileSize = 0;
	                                    strOldImgFileInfoArray.push(strOldImgFileInfo);
					                </c:if>
					            </script> 
					        </div>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="linkURL">링크URL</label></th>
						<td>
							<input type="text" name="linkURL" id="linkURL" value="<c:if test="${empty rtnPopupWindow.linkURL }">http://</c:if><c:if test="${!empty rtnPopupWindow.linkURL }">${rtnPopupWindow.linkURL}</c:if>" class="input_long" title="링크URL"/>
							<p>※ 링크URL이 없을 경우 #을 입력하시기 바랍니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KDesc">내용</label></th>
						<td><input type="text" name="KDesc" id="KDesc" value="${rtnPopupWindow.KDesc}" class="input_long" title="팝업내용"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02 ${!empty rtnPopupZone.popupZoneId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
	<c:if test="${!empty rtnPopupWindow.popupId}">
		<button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

<script type="text/javascript">
$(function() {
	
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnPopupWindow.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	gfnCodeComboList($("#newWindowYn"), "NewWindowYN", "0", "코드 선택", "0"); // 새창여부 코드조회
	$('#newWindowYn').on("change", function() { // 새창여부 이벤트
		
	});
	
	// 새창 기본세팅
	<c:if test="${!empty rtnPopupWindow.popupId }">
		$("#newWindowYn").val("${rtnPopupWindow.newWindowYn }").prop("selected", "selected");
	</c:if>
	<c:if test="${empty rtnPopupWindow.popupId }">
		$("#newWindowYn").val("N").prop("selected", "selected");
	</c:if>
	
	$( "#startDate, #endDate" ).datepicker({
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
	
	$("input:radio[name='state']:radio[value='${rtnPopupWindow.state}']").attr("checked",true);
	$("input:radio[name='daySessionYn']:radio[value='${rtnPopupWindow.daySessionYn}']").attr("checked",true);
	
	// 숫자만입력
	$(".input_Num").keyup(function(){
		if($(this).val().match(/[^0-9]/g) != null){
			alert("숫자만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
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
			alert("순서를 입력하세요.");
			$("#sort").focus();
			return false;
		}
		if(cuManagerImages.getTotalFileCount() == 0 ) {
			alert("이미지를 입력하세요.");
			return false;
		}
		if($("#linkURL").val().length <= 0) {
			alert("링크URL를 입력하세요.");
			$("#linkURL").focus();
			return false;
		}
		if($("#linkURL").val().indexOf("http://") < 0){
			if(!confirm("프로토콜(http://)이 빠지면 링크에 오류가 생길 수 있습니다.\n저장하시겠습니까?")){
				$("#linkURL").focus();
				return false;			
			}			
		}
		
		if($("#KDesc").val().length <= 0) {
			alert("내용을 입력하세요.");
			$("#KDesc").focus();
			return false;
		}
		
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}

		//게시일 시간설정 2015.09.21
		$("#startTime").val($("#startDate").val()+" "+$("#startTime_hh option:selected").val());
		$("#endTime").val($("#endDate").val()+" "+$("#endTime_hh option:selected").val());

		// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
		if(cuManagerImages.getTotalFileCount() == 0){
			$("#insertForm").attr('action', '${ctxMgr}/popupWindowMgr/act');
			$("#insertForm").submit();
		}else{
			cuManagerImages.startUpload();
		}
		
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/popupWindowMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/popupWindowMgr');
		$("#insertForm").submit(); */
		
		location.href="${contextPath}/mgr/popupWindowMgr?${link}";
	});
	
});

//나모첨부파일 시작
$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('IMG'); //파일Init : 이미지만
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr}/popupWindowMgr/act";
    filePath = "${contextPath}/namoFileUpload?fileGubun=common&fileMenuId=popupWindowMgr";
	fileMaxSize = 5120 * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = 1;
	/*나모 End*/
});

</script>

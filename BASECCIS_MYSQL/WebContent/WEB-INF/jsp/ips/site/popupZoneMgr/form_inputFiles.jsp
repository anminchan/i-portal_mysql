<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/popupZoneMgr/act" method="POST" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>	
	<!-- PopupZoneHiddenData -->
	<input type="hidden" id="siteId" name="siteId" value="${rtnPopupZone.siteId}"/>
	<input type="hidden" id="popupZoneId" name="popupZoneId" value="${rtnPopupZone.popupZoneId}"/>	
	<!-- BeforeData -->
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnPopupZone.inBeforeData}"/>	
	<!--  파일 hidden -->
	<input type="hidden" name="imageFileName" id="imageFileName" value="${rtnPopupZone.imageFileName }"/>
	<input type="hidden" name="imageSFileName" id="imageSFileName" value="${rtnPopupZone.imageSFileName }"/>
	<input type="hidden" name="filePath" id="filePath" value="${rtnPopupZone.filePath }"/>
	<input type="hidden" name="fileGubun" id="fileGubun" value="ips"/>	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schSiteId" value="${param.schSiteId }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	<input type="hidden" name="schState" value="${param.schState }">
		
	<fieldset>
		<legend>팝업존 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
			<table class="tstyle_view">
				<caption>
					사이트 상세 정보 입력
				</caption>
				<colgroup>
					<col class="col-sm-3" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="siteIdSel">사이트</label></th>
						<td><select name="siteIdSel" id="siteIdSel"></select></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
						<td><input type="text" id="KName" name="KName" value="${rtnPopupZone.KName}" class="input_mid02" maxlength="40" title="팝업존제목" /></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> 게시기간</th>
						<td>
							<input type="hidden" id="startTime" name="startTime" />
				        	<input type="hidden" id="endTime" name="endTime" />	        	
				        	<fmt:parseDate value="${rtnPopupZone.startTime }" pattern="yyyyMMddHH" var="pStartTime" />
							<fmt:formatDate value="${pStartTime}" pattern="yyyy-MM-dd" var="startDate"/>
							<fmt:formatDate value="${pStartTime}" pattern="HH" var="hh"/>
							<c:set var="startTimeHh" value="${hh }" />						
							<fmt:parseDate value="${rtnPopupZone.endTime }" pattern="yyyyMMddHH" var="pEndTime" />
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
							 ~ 
							 <input type="text" name="endDate" id="endDate" value="${endDate}" readOnly="readOnly" />
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
							<label for="stateY">사용</label>
							<input name="state" id="stateN" value="F" type="radio" title="사용여부" />
							<label for="stateN">미사용</label>
						</td>
					</tr>		
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="sort">순서</label></th>
						<td><input type="text" id="sort" name="sort" value="${rtnPopupZone.sort}" class="input_Num" maxlength="8" title="순서" /></td>
					</tr>		
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="newWindowYn">새창여부</label></th>
						<td>
							<select name="newWindowYn" id="newWindowYn"></select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> 이미지</th>
						<td colspan="3">
							<c:if test="${!empty rtnPopupZone.imageFileName && rtnPopupZone.imageFileName ne '-' }">
		                		<input type="hidden" name="fileImgId" id="fileImgId" value="${rtnPopupZone.imageFileName}@@${rtnPopupZone.imageSFileName}@@0@@${rtnPopupZone.filePath}@@img" />
		                		<div id="fileView" style="margin-bottom: 10px;">
		                			${rtnPopupZone.imageFileName}
	                              	<a href="${contextPath}/fileDownload?fileGubun=common&menuId=bannerMgr&userFileName=${rtnPopupZone.imageFileName }&systemFileName=${rtnPopupZone.imageSFileName }">
	                              		<i class="xi-download"></i>
                              		</a>
							  	</div>
			                </c:if>
							<input type="file" id="fileImg_upload" name="fileImg_upload" class="input_mid" accept="image/*" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="linkURL">링크URL</label></th>
						<td><input type="text" name="linkURL" id="linkURL" value="<c:if test="${empty rtnPopupZone.linkURL }">http://</c:if><c:if test="${!empty rtnPopupZone.linkURL }">${rtnPopupZone.linkURL}</c:if>" class="input_long" title="링크URL"/>
							<p>※ 링크URL이 없을 경우 #을 입력하시기 바랍니다.<br/>
								※ 다중링크제공형태(사용: §§ ) : url_1§§url_2 (예: http://www.naver.com§§http://www.daum.net)</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KDesc">내용</label></th>
						<td><input type="text" name="KDesc" id="KDesc" value="${rtnPopupZone.KDesc}" class="input_long" title="팝업내용"/></td>
					</tr>		
				</tbody>
			</table>
		</div>
	</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02 ${!empty rtnPopupZone.popupZoneId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
	<c:if test="${!empty rtnPopupZone.popupZoneId}">
		<button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

<script type="text/javascript">
$(function() {
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnPopupZone.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	gfnCodeComboList($("#newWindowYn"), "NewWindowYN", "0", "코드 선택", "0"); // 새창여부 코드조회
	$('#newWindowYn').on("change", function() { // 새창여부 이벤트
		
	});
	
	// 새창 기본세팅
	<c:if test="${empty rtnPopupZone.popupZoneId }">
		$("#newWindowYn").val("${rtnPopupZone.newWindowYn }").prop("selected", "selected");
	</c:if>
	<c:if test="${empty rtnPopupZone.popupZoneId }">
		$("#newWindowYn").val("N").prop("selected", "selected");
	</c:if>
	
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

	$("input:radio[name='state']:radio[value='${rtnPopupZone.state}']").attr("checked",true);
	
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
		if($("#fileImg_upload").val() == "" && ($("#fileImgId").val() == undefined || $("#fileImgId").val() == "")){
			alert("이미지 첨부파일을 하나 이상 등록하세요.");
			$("#file_upload").focus();
			return true;
 		}
 		
 		if($("#fileImg_upload").val() != ""){
			var thumbext = document.getElementById('fileImg_upload').value; //파일을 추가한 input 박스의 값
			thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
	
			if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "gif" &&  thumbext != "bmp"){ //확장자를 확인합니다.
				alert('썸네일은 이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
				$("#file_upload").focus();
				return;
			}
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
		
		$("#insertForm").attr('action', '${ctxMgr}/popupZoneMgr/act');
		$("#insertForm").submit();
		
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('enctype', '');
		$("#insertForm").attr('action', '${ctxMgr }/popupZoneMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/popupZoneMgr');
		$("#insertForm").submit(); */

		location.href="${contextPath}/mgr/popupZoneMgr?${link}";
	});
	
});

</script>

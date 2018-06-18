<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/surveyMgr/act" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="state" name="state" value="${empty rtnSurvey.state ? 'T' : rtnSurvey.state}"/>
	
	<!-- SurveyHiddenData -->
	<input type="hidden" id="siteId" name="siteId" value="${rtnSurvey.siteId}"/>
	<input type="hidden" id="surveyId" name="surveyId" value="${rtnSurvey.surveyId}"/>
	
	<!-- BeforeData -->
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnSurvey.inBeforeData}"/>
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schSiteId" value="${param.schSiteId }">
	<input type="hidden" name="schType" value="${param.schType }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	<fieldset>
		<legend>설문조사 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
			<div class="table">
			<table class="tstyle_view">
				<caption>
					사이트 상세 정보 입력 - 주관사이트, 설문조사제목, 설문조사기간, 공개여부, 설문조사대상, 결과공개형태, 설문개요에 따른 게시물상세 안내
				</caption>
				<colgroup>
					<col class="col-sm-3" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="siteIdSel">주관사이트</label></th>
						<td><select name="siteIdSel" id="siteIdSel"></select></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KName">설문조사제목</label></th>
						<td><input type="text" id="KName" name="KName" value="${rtnSurvey.KName}" class="input_mid02" maxlength="40" title="설문조사제목" /></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="url">설문조사기간</label></th>
						<td>
							<input type="text" name="surveyStartTime" id="surveyStartTime" value="${rtnSurvey.surveyStartTime}" readOnly="readOnly" />
							<%-- <select name="startTime_hh" id="startTime_hh" class="timeSetting">
								<c:forEach begin="0" end="23" var="items" varStatus="status">
									<c:if test="${status.index < 10 }">
										<c:set var="startTimeHhVal" value="0${status.index }" />
									</c:if>
									<c:if test="${status.index >= 10 }">
										<c:set var="startTimeHhVal" value="${status.index }" />
									</c:if>
									<option value="${startTimeHhVal }">${startTimeHhVal }</option>
								</c:forEach>
							</select> --%>
							 ~ <input type="text" name="surveyEndTime" id="surveyEndTime" value="${rtnSurvey.surveyEndTime}" readOnly="readOnly" />
							 <%-- <select name="endTime_hh" id="endTime_hh" class="timeSetting">
								<c:forEach begin="0" end="23" var="items" varStatus="status">
									<c:if test="${status.index < 10 }">
										<c:set var="endTimeHhVal" value="0${status.index }" />
									</c:if>
									<c:if test="${status.index >= 10 }">
										<c:set var="endTimeHhVal" value="${status.index }" />
									</c:if>
									<option value="${endTimeHhVal }">${endTimeHhVal }</option>
								</c:forEach>
							</select> --%>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="openYn">공개여부</label></th>
						<td>
							<input name="openYn" id="openYnY" value="Y" type="radio" title="공개" />
							<label for="openYnY">공개</label>
							<input name="openYn" id="openYnN" value="N" type="radio" title="미공개" />
							<label for="openYnN">미공개</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="surveyTarget">설문조사대상</label></th>
						<td>
							<select name="surveyTarget" id="surveyTarget">
								<option value="">설문조사대상 선택</option>
								<option value="A">전체</option>
								<option value="N">비회원</option>
								<option value="P">개인회원</option>
								<option value="C">기업회원</option>
								<!-- <option value="K">내부직원</option> -->
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="resultOpenForm">결과공개형태</label></th>
						<td>
							<select name="resultOpenForm" id="resultOpenForm">
								<option value="">결과공개형태 선택</option>
								<option value="A">전체</option>
								<option value="N">비회원</option>
								<option value="P">개인회원</option>
								<option value="C">기업회원</option>
								<option value="S">비공개</option>
								<!-- <option value="K">내부직원</option> -->
							</select>
						</td>
					</tr>
					 <tr>
						<th scope="row"><label for="viewtxt">설문개요</label></th>
			            <td>
			            	<textarea id="KHtml" name="KHtml" rows="" cols="" style="display: none;"><c:out value="${rtnSurvey.KHtml }" escapeXml="true" /></textarea>
			                <c:if test="${editor eq 'Namo'}">		            
					            <!-- ▼ 에디터 -->  
					          	<script type="text/javascript">         
					            var CrossEditor = new NamoSE('namoEditor');
					            CrossEditor.params.ImageSavePath = "${editorImgPath}";
					            CrossEditor.params.UploadFileExecutePath = "${editorUploadFileExePath}";
					            //에디터 업로드 용량
					           	CrossEditor.params.UploadFileSizeLimit = "movie:524288000, image:20971520";
					            CrossEditor.params.Width = "100%";
					            CrossEditor.EditorStart();
					            function OnInitCompleted(e){
					            	e.editorTarget.SetBodyValue($("#KHtml").val());
					            }
					          	</script>
					           	<!-- ▲ 에디터  -->
				           	</c:if>
				           	<c:if test="${editor eq 'Daum'}">
				            	<!-- ▼ 에디터 -->  
					          	<script type="text/javascript">
					          		gfnInitEditor("KHtml", 'self');
					          	</script>
				           		<div id="editor_frame"></div>
				           	</c:if>
						</td>
					</tr>
				</tbody>
			</table>		
		</div>
	</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<c:if test="${!empty rtnSurvey.surveyId}">
		<button type="button" class="btn  btn_type01" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn  btn_type01" id="btnList">목록</button>
</div>

<script type="text/javascript">
$(function() {
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnSurvey.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
    $("#surveyStartTime").datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        onClose: function( selectedDate ) { 
			$('#surveyEndTime').datepicker("option","minDate", selectedDate); 
		}
    });
    
    $("#surveyEndTime").datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        onClose: function( selectedDate ) { 
			$('#surveyStartTime').datepicker("option","maxDate", selectedDate); 
		}
    });
    
    <c:if test="${!empty rtnSurvey.surveyId}">
		$("input:radio[name='openYn']:radio[value='${rtnSurvey.openYn}']").attr("checked",true);
		$("#surveyTarget").val("${rtnSurvey.surveyTarget}");
		$("#resultOpenForm").val("${rtnSurvey.resultOpenForm}");
	</c:if>

	// 숫자만입력
	$(".input_Num").keyup(function(){
		if($(this).val().match(/[^0-9]/g) != null){
			alert("숫자만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
	});
	
	$("#btnSave").click(function(){
		if($("#siteIdSel option:selected").val() == "") {
			alert("주관사이트를 선택하세요.");
			$("#siteIdSel").focus();
			return false;
		}
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		if($("#surveyStartTime").val().length <= 0) {
			alert("설문조사시작일을 입력하세요.");
			$("#surveyStartTime").focus();
			return false;
		}
		if($("#surveyEndTime").val().length <= 0) {
			alert("설문조사종료일을 입력하세요.");
			$("#surveyEndTime").focus();
			return false;
		}
		if($(":radio[name='openYn']:checked").length <= 0) {
			alert("공개여부를 선택하세요.");
			$("#openYnY").focus();
			return false;
		}
		if($("#surveyTarget").val().length <= 0) {
			alert("설문조사대상을 선택하세요.");
			$("#surveyTarget").focus();
			return false;
		}
		if($("#resultOpenForm").val().length <= 0) {
			alert("결과공개형태를 선택하세요.");
			$("#resultOpenForm").focus();
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#KHtml").val(Editor.getContent());
		}else{
			$("#KHtml").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
		if($("#KHtml").val().length <= 0) {
			alert("설문조사개요를 입력하세요.");
			$("#KHtml").focus();
			return false;
		}
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}

		//게시일 시간설정 2015.09.21
		//$("#startTime").val($("#startTime").val()+" "+$("#startTime_hh option:selected").val());
		//$("#endTime").val($("#endTime").val()+" "+$("#endTime_hh option:selected").val())
		
		$("#insertForm").attr('action', '${ctxMgr}/surveyMgr/act');
		$("#insertForm").submit();
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr}/surveyMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		
		location.href="${contextPath}/mgr/surveyMgr?${link}";
	});
	
});

</script>

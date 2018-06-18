<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- ▼ 등록페이지  -->
<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actFreeBoard" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />	
	<!-- 나모첨부파일 사용경우 START --> 
	<!-- 파일 정보를 저장할 폼 데이터 -->
	<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
	<!-- 나모첨부파일 사용경우 END -->	
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>"/>
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" />
	<c:choose>
		<c:when test="${!empty(rtnContent.STARTTIME)}"> 
			<!-- 글 수정 -->
			<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }" />
		</c:when>
		<c:otherwise> 
			<!-- 글 입력/답글 -->
			<input type="hidden" id="linkId" name="linkId" value="${!empty(obj.parentLinkId) && obj.parentLinkId > 0 ? obj.parentLinkId : '-1' }" />
			<input type="hidden" id="parentId" name="parentId" value="${obj.parentLinkId}" />
		</c:otherwise>
	</c:choose>
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
	<c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest'}">
		<input type="hidden" id="guestName" name="guestName" value="${obj.myName }" />
		<input type="hidden" id="key1" name="key1" value="${obj.key1 }" />
		<input type="hidden" id="key2" name="key2" value="${obj.key2 }" />
		<input type="hidden" id="key3" name="key3" value="${obj.key3 }" />
		<input type="hidden" id="dKey" name="dKey" value="${obj.dKey }" />
	</c:if>
	<fieldset>
		<legend>상세등록</legend>
		<div class="table">
			<table class="tstyle_view">
				<caption>
					등록일, 이름, 이메일, 담당부서, 제목, 내용 등록
				</caption>
				<colgroup>
					<col class="col-sm-3"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="subject">제목</label></th>
						<td><c:choose>
								<c:when test="${!empty(rtnContent.STARTTIME)}"> 
									<!-- 글 수정 -->
									<input type="text" id="KName" name="KName" value="${rtnContent.KNAME }"  class="input_long"/>
								</c:when>
								<c:otherwise> 
									<!-- 글 입력/답글 -->
									<input type="text" id="KName" name="KName" value="${title}"  class="input_long"/>
								</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td><c:out value="${!empty(rtnContent.USERNAME) ? rtnContent.USERNAME : obj.myName  }" /></td>
					</tr>
					<tr>
						<th scope="row">키워드</th>
						<td><input type="text" id="keyword1" name="keyword1" class="keyword" value="${rtnContent.KEYWORD1}" maxlength="30"/>
							<input type="text" id="keyword2" name="keyword2" class="keyword" value="${rtnContent.KEYWORD2}" maxlength="30"/>
							<input type="text" id="keyword3" name="keyword3" class="keyword" value="${rtnContent.KEYWORD3}" maxlength="30"/>
							<input type="text" id="keyword4" name="keyword4" class="keyword" value="${rtnContent.KEYWORD4}" maxlength="30"/>
							<input type="text" id="keyword5" name="keyword5" class="keyword" value="${rtnContent.KEYWORD5}" maxlength="30"/>
							<input type="text" id="keyword6" name="keyword6" class="keyword" value="${rtnContent.KEYWORD6}" maxlength="30"/>
							<input type="text" id="keyword7" name="keyword7" class="keyword" value="${rtnContent.KEYWORD7}" maxlength="30"/>
							<input type="text" id="keyword8" name="keyword8" class="keyword" value="${rtnContent.KEYWORD8}" maxlength="30"/>
							<input type="text" id="keyword9" name="keyword9" class="keyword" value="${rtnContent.KEYWORD9}" maxlength="30"/>
							<input type="text" id="keyword10" name="keyword10" class="keyword" value="${rtnContent.KEYWORD10}" maxlength="30"/>
							<input type="button" value="키워드검색" class="input_smallBlack" onClick="javascript:gfnKeywordSearch('${obj.menuId}');" />
						</td>
					</tr>
					<tr>
						<th scope="row">공개여부</th>
						<td><!-- 입력시 공개가 기본 선택 -->						
							<c:if test="${empty(rtnContent.STARTTIME)}">
								<input type="radio" id="openY" name="openYN" value="Y" checked="checked" />
								<label for="openY">공개</label>
								<input type="radio" id="openN" name="openYN" value="N" />
								<label for="openN">비공개</label>
							</c:if>						
							<!-- 수정시 기본 선택 -->						
							<c:if test="${!empty(rtnContent.STARTTIME)}">
								<input type="radio" id="openY" name="openYN" value="Y" ${rtnContent.OPENYN == 'Y' ? 'checked="checked"' : ''} />
								<label for="openY">공개</label>
								<input type="radio" id="openN" name="openYN" value="N" ${rtnContent.OPENYN == 'N' ? 'checked="checked"' : ''} />
								<label for="openN">비공개</label>
							</c:if>
						</td>
					</tr>
					<%-- <tr>
						<th scope="row"><label for="temp_ocode">유효기간</label></th>
						<td>
							<input type="text" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />~
							<input type="text" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
						</td>
					</tr> --%>
					<tr>
						<c:if test="${rtnSetting.noticeYN == 'Y' }">
							<th scope="row">공지글지정</th>
							<td><input type="hidden" id="noticeYN" name="noticeYN" />
								<input type="checkBox" id="checkNotice" name="checkNotice" ${rtnContent.NOTICETITLEYN == 'Y' ? 'checked="checked"' : ''} />
								<div id="noticePeriod" <c:if test="${rtnContent.NOTICETITLEYN == 'N' or empty rtnContent.STARTTIME }">style="display: none;"</c:if>>
									<input type="hidden" id="noticeStartTime" name="noticeStartTime" />
									<input type="hidden" id="noticeEndTime" name="noticeEndTime" />
									<input type="text" id="noticeStartDate" name="noticeStartDate" value="<fmt:formatDate value="${rtnContent.NOTICESTARTTIME }" pattern="yyyy-MM-dd"/>" readonly />
									<fmt:formatDate value="${rtnContent.NOTICESTARTTIME }" pattern="HH" var="noticeStartHh"/>
									<select name="noticeStartTimeHh" id="noticeStartTimeHh" class="timeSetting">
										<c:forEach begin="0" end="23" var="items" varStatus="status">
											<c:if test="${status.index < 10 }">
												<c:set var="noticeStartTimeHhVal" value="0${status.index }" />
											</c:if>
											<c:if test="${status.index >= 10 }">
												<c:set var="noticeStartTimeHhVal" value="${status.index }" />
											</c:if>
											<option value="${noticeStartTimeHhVal }" <c:if test="${noticeStartHh == noticeStartTimeHhVal }">selected="selected"</c:if>>${noticeStartTimeHhVal }</option>
										</c:forEach>
									</select>
									~
									<input type="text" id="noticeEndDate" name="noticeEndDate" value="<fmt:formatDate value="${rtnContent.NOTICEENDTIME }" pattern="yyyy-MM-dd"/>" readonly />
									<fmt:formatDate value="${rtnContent.NOTICEENDTIME }" pattern="HH" var="noticeEndHh"/>
									<select name="noticeEndTimeHh" id="noticeEndTimeHh" class="timeSetting">
										<c:forEach begin="0" end="23" var="items" varStatus="status">
											<c:if test="${status.index < 10 }">
												<c:set var="noticeEndTimeHhVal" value="0${status.index }" />
											</c:if>
											<c:if test="${status.index >= 10 }">
												<c:set var="noticeEndTimeHhVal" value="${status.index }" />
											</c:if>
											<option value="${noticeEndTimeHhVal }" <c:if test="${noticeEndHh == noticeEndTimeHhVal }">selected="selected"</c:if>>${noticeEndTimeHhVal }</option>
										</c:forEach>
									</select>
								</div>
							</td>
						</c:if>
						<c:if test="${rtnSetting.categoryYN == 'Y' }">
							<th scope="row"><span class="point01">*</span> <label for="categoryId">카테고리</label></th>
							<td><select id="categoryId" name="categoryId">
								</select>
							</td>
						</c:if>
					</tr>
					<!-- ▼ 비밀글유무 -->
					<c:if test="${rtnSetting.secretYN == 'Y' }">
						<tr>
							<th scope="row"><label for="secretTitleYN">비밀글</label></th>
							<td><input type="radio" id="secretTitleY" name="secretTitleYN" value="Y" <c:if test="${empty rtnContent.SECRETTITLEYN or rtnContent.SECRETTITLEYN eq 'Y'}">checked="checked"</c:if> />
								<label for="openY">적용</label>
								<input type="radio" id="secretTitleN" name="secretTitleYN" value="N" ${rtnContent.SECRETTITLEYN == 'N' ? 'checked="checked"' : ''} />
								<label for="openN">미적용</label>
							</td>
						</tr>
					</c:if>
					<!-- ▼ 국가필드유무 -->
					<c:if test="${rtnSetting.countryYN == 'Y' }">
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="country">국가정보</label></th>
							<td><select id="continent" name="continent">
									<option>선택</option>
								</select>
								<select id="country" name="country">
									<option>선택</option>
								</select>
							</td>
						</tr>
					</c:if>
					<!-- ▼ 추가 필드가 있을 시 -->
					<c:if test="${!empty(rtnSetting.addField1) }">
						<tr>
							<th scope="row"><label class="contents1"><c:out value="${rtnSetting.addField1}" /></label></th>
							<td><input type="text" id="contents1" name="contents1" maxlength="42" class="input_long" value="${rtnContent.CONTENTS1 }" /></td>
						</tr>
					</c:if>
					<c:if test="${!empty(rtnSetting.addField2) }">
						<tr>
							<th scope="row"><label for="contents1"><c:out value="${rtnSetting.addField2}" /></label></th>
							<td><input type="text" id="contents2" name="contents2" maxlength="42" class="input_long" value="${rtnContent.CONTENTS2 }" /></td>
						</tr>
					</c:if>
					<c:if test="${!empty(rtnSetting.addField3) }">
						<tr>
							<th scope="row"><label for="contents3"><c:out value="${rtnSetting.addField3}" /></label></th>
							<td><input type="text" id="contents3" name="contents3" maxlength="42" class="input_long" value="${rtnContent.CONTENTS3 }" /></td>
						</tr>
					</c:if>
					<c:if test="${!empty(rtnSetting.addField4) }">
						<tr>
							<th scope="row"><label for="contents4"><c:out value="${rtnSetting.addField4}" /></label></th>
							<td><input type="text" id="contents4" name="contents4" value="<fmt:formatDate value="${rtnContent.CONTENTS4 }" pattern="yyyy-MM-dd"/>" /></td>
						</tr>
					</c:if>
					<c:if test="${!empty(rtnSetting.addField5) }">
						<tr>
							<th scope="row"><label for="contents5"><c:out value="${rtnSetting.addField5}" /></label></th>
							<td><input type="text" id="contents5" name="contents5" value="<fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/>" /></td>
						</tr>
					</c:if>
					<c:if test="${!empty(rtnSetting.addField6) }">
						<tr>
							<th scope="row"><label for="contents6"><c:out value="${rtnSetting.addField6}" /></label></th>
							<td><input type="text" id="contents6" name="contents6" value="<fmt:formatDate value="${rtnContent.CONTENTS6 }" pattern="yyyy-MM-dd"/>" /></td>
						</tr>
					</c:if>
					<!-- ▲ 추가 필드가 있을 시 -->			
					<tr>
						<th scope="row"><label for="viewtxt">내용</label></th>
						<td><textarea id="KHtml" name="KHtml" rows="" cols="" style="display: none;"><c:out value="${rtnContent.KHTML }" escapeXml="true" /></textarea>
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
					<c:if test="${rtnSetting.fileMaxCount > 0 }"> 
					<!-- ▼ 파일 업/다운로드 에디터  -->
					<tr>
						<th scope="row">첨부파일</th>
						<td>
							<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->						
							<div id="flashContentManager" style="display: none;">
								<p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
								<script type="text/javascript"> 
					                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
					                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='"
					                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );				                
					                <c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
					                	<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
			                         		var strOldFileInfo = new Object();
			                         		strOldFileInfo.fileId = "board@@${param.menuId}@@${fileList.SYSTEMFILENAME}@@${fileList.FILEID}@@${fileList.FILEPATH}";
			                                strOldFileInfo.fileName = "${fileList.USERFILENAME}";
			                                strOldFileInfo.fileSName = "${fileList.SYSTEMFILENAME}";
			                                strOldFileInfo.filePath = "${fileList.FILEPATH}";
			                                strOldFileInfo.fileSize = ${fileList.FILESIZE};
			                                strOldFileInfoArray.push(strOldFileInfo);
		                                </c:forEach>
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
					<!-- ▲ 파일 업로드 에디터  --> 
					</c:if>			
				</tbody>
			</table>
		</div>
	</fieldset>
</spform:form>
<!-- ▲ 등록페이지  --> 
<!-- ▼ 버튼 -->
<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<button type="button" class="btn btn_type01" id="btnCancel">취소</button>
</div>
<!-- ▲ 버튼 --> 

<script type="text/javascript">

$(function() {
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리선택', '${rtnContent.CATEGORYID != null ? rtnContent.CATEGORYID : ""}');
	
	gfnCodeComboList($("#continent"), "country", "", "대륙 선택", "${rtnContent.CONTINENT}", ""); // 대륙 코드조회
	$('#continent').on("change", function() { // 대륙 이벤트
		if($("#continent").val() != ""){
			gfnCodeComboList($("#country"), $("#continent").val(), "", "국가 선택", "", ""); // 국가 코드조회
		}else{
			$("#country").find('option').remove();
			$("#country").append("<option value=''>국가 선택</option>");
		}
	});
	
	<c:if test="${!empty rtnContent.COUNTRY}">
		gfnCodeComboList($("#country"), "${rtnContent.CONTINENT }", "", "국가 선택", "${!empty rtnContent.COUNTRY ? rtnContent.COUNTRY : ''}", ""); // 국가 코드조회
	</c:if>
		
	$('.keyword').focus(function(i){
		var indexNode = $(this).index()+1;
		var strLength;
		
		if(indexNode > 1){
			for(var i=1; i<indexNode; i++){
				strLength = $.trim($('#keyword'+i).val());
				if(strLength == null || strLength.length <= 0){
					alert("키워드 "+i+"번째 값부터 입력하세요.");
					$('#keyword'+i).focus();
					return true;
				}
			}
		}
	});
	
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	// 저장
	$('#btnSave').click(function(){
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		/* if($.trim($("#keyword1").val()) == null || $.trim($("#keyword1").val()) == ""){
			alert("키워드를 입력하세요");
			return true;
		} */
		
		if($('#categoryId').length){
			if($('#categoryId').val() == ""){
				alert("카테고리를 선택하세요");
				return true;
			}
		}
		
		<c:if test="${rtnSetting.countryYN == 'Y' }">
			if($('#continent').length){
				if($('#continent').val() == ""){
					alert("대륙을 선택하세요");
					$('#continent').focus();
					return true;
				}
			}
			
			if($('#country').length){
				if($('#country').val() == ""){
					alert("국가를 선택하세요");
					$('#country').focus();
					return true;
				}
			}
		</c:if>
		
		if($('#checkNotice').length){
			if($('#checkNotice').is(":checked")){
				$('#noticeYN').val('Y');
				
				// 년도, 월, 일로 분리
		        var start_dt = $("#noticeStartDate").val().split("-");
		        var end_dt = $("#noticeEndDate").val().split("-");
		        
		         // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
		        // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
		        start_dt[1] = (Number(start_dt[1]) - 1) + "";
		        end_dt[1] = (Number(end_dt[1]) - 1) + "";
		 
		        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2], $("#noticeStartTimeHh").val());
		        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2], $("#noticeEndTimeHh").val());
		  
			    var chkDate = (to_dt.getTime() - from_dt.getTime());
			    
			    if(chkDate < 0 ){
					alert("종료시간이 시작시간 이전이면 안됩니다. 다시 확인하세요.");
				    return false;
			    }
			    
			    $("#noticeStartTime").val($("#noticeStartDate").val()+" "+$("#noticeStartTimeHh").val());
			    $("#noticeEndTime").val($("#noticeEndDate").val()+" "+$("#noticeEndTimeHh").val());
			}else{
				$('#noticeYN').val('N');
			}
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#KHtml").val(Editor.getContent());
		}else{
			$("#KHtml").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
		// 유해어 검출 스크립트
 		if(gfnTabooWordCheck('KName§§KHtml')[1] > 0){
 			alert(gfnTabooWordCheck('KName§§KHtml')[0]);
 			return false;
 		}
		
 		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
		if(cuManager.getTotalFileCount() == 0){
			$("#insertForm").attr('action', '${ctxMgr }/contentMgr/actFreeBoard');
			$("#insertForm").submit();
		}else{
			cuManager.startUpload();
		}
		
	});

	// 삭제
	$("#btnDelete").click(function(){
		$("#inCondition").val("삭제");
		$('#insertForm').submit();
	});
	
	//취소
    $("#btnCancel").click(function(){
        if('${obj.linkId}' != null && '${obj.linkId}' != '0'){
            document.location.href="${contextPath}/mgr/contentMgr/view?${link}&linkId=${obj.linkId}";
        }else {
            document.location.href="${contextPath}/mgr/contentMgr?${link}";
        }
    });

	// 공지글지정 시 날짜 선택
	$("#checkNotice").click(function(){
		if($(this).is(':checked') == true){
			$('#noticePeriod').show();
		}else{
			$('#noticeYN').val('N');
			
			$('#noticePeriod').hide();
		}
	});
	
	//입력시 달력 기본 셋팅
	$('#startTime').val('<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd"/>');
	$('#endTime').val(<fmt:formatDate value="${DATE }" pattern="yyyy"/>+10+'<fmt:formatDate value="${DATE }" pattern="-MM-dd"/>');
	
	//달력 세팅
   /*  $( "#startTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
    
    $( "#endTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    }); */
    
    $( "#noticeStartDate, #noticeEndDate" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
		onClose: function( selectedDate ) { 
			$('#noticeEndDate').datepicker("option","minDate", selectedDate); 
		} 
    });
    
    $( "#contents4" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
    
    $( "#contents5" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
    
    $( "#contents6" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
    
});

//나모첨부파일 시작
$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('BASE'); //파일Init : 첨부파일
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr }/contentMgr/actFreeBoard";
	filePath = "${contextPath }/namoFileUpload?fileGubun=board&fileMenuId=${param.menuId}";
	fileMaxSize = "${rtnSetting.fileMaxSize}" * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = "${rtnSetting.fileMaxCount}";
	/*나모 End*/
	
});

</script> 
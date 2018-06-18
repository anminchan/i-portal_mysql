<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<spform:form id="insertForm" name="insertForm" action="${contextPath }/board/actBoard" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />
	<c:choose>
	<c:when test="${!empty(rtnContent.STARTTIME)}">
	<!-- 글 수정 -->
	<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }" />
	</c:when>
	<c:otherwise>
	<!-- 글 입력/답글 -->
	<input type="hidden" id="linkId" name="linkId" value="${!empty(obj.parentLinkId) && obj.parentLinkId > 0 ? obj.parentLinkId : '-1' }" />
	</c:otherwise>
	</c:choose>
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
	
	<c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest' and USER.kind eq 'N'}">
	<input type="hidden" id="guestName" name="guestName" value="${USER.userName }" />
	<input type="hidden" id="key1" name="key1" value="-" />
	<input type="hidden" id="key2" name="key2" value="-" />
	<input type="hidden" id="key3" name="key3" value="-" />
	<input type="hidden" id="dKey" name="dKey" value="${USER.dKey }" />
	</c:if>
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
        
	<input type="hidden" id="noticeYN" name="noticeYN" value="N" />
	<input type="hidden" id="openYN" name="openYN" value="Y" />
	<input type="hidden" id="KHtml" name="KHtml" value="" />
	
	<!-- 나모첨부파일 사용경우 START -->
	<!-- 파일 정보를 저장할 폼 데이터 -->
	<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
	<!-- 나모첨부파일 사용경우 END -->

	<fieldset>
		<legend>상세등록</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<table class="tstyle_view" summary="게시판 등록/수정 기능">
			<caption>
			제목, 등록자, 담당부서, 추가필드, 카테고리1~2, 공개여부, 공지여부, 유효기간 등록
			</caption>
			<colgroup>
				<col width="15%" />
	            <col width="85%" />
	            <!-- <col width="15%" />
	            <col width="35%" /> -->
			</colgroup>	
			<tbody>
				<tr>
					<th scope="row"><span class="point01_bold">*</span> <label for="">Title</label></th>
					<td colspan="3">
                    <c:choose>
			            <c:when test="${!empty(rtnContent.STARTTIME)}">
						<!-- 글 수정 -->
                        <input type="text" id="KName" name="KName" value="${rtnContent.KNAME }" class="input_long"/>
                        </c:when>
                        <c:otherwise>
						<!-- 글 입력/답글 -->
                        <input type="text" id="KName" name="KName" value="${title}" class="input_long"/>
                        </c:otherwise>
                    </c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="">Writer</label></th>
					<td colspan="3">
                        <c:out value="${!empty(rtnContent.USERNAME) ? rtnContent.USERNAME : USER.userName  }" />
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01_bold">*</span> <label for="keyword">keyWord</label></th>
					<td colspan="3">                       
                        <input type="text" id="keyword1" name="keyword1" class="keyword" value="${rtnContent.KEYWORD1}" />
                        <input type="text" id="keyword2" name="keyword2" class="keyword" value="${rtnContent.KEYWORD2}" />
                        <input type="text" id="keyword3" name="keyword3" class="keyword" value="${rtnContent.KEYWORD3}" />
                        <input type="text" id="keyword4" name="keyword4" class="keyword" value="${rtnContent.KEYWORD4}" />
                        <input type="text" id="keyword5" name="keyword5" class="keyword" value="${rtnContent.KEYWORD5}" />
                        <input type="text" id="keyword6" name="keyword6" class="keyword" value="${rtnContent.KEYWORD6}" />
                        <input type="text" id="keyword7" name="keyword7" class="keyword" value="${rtnContent.KEYWORD7}" />
                        <input type="text" id="keyword8" name="keyword8" class="keyword" value="${rtnContent.KEYWORD8}" />
                        <input type="text" id="keyword9" name="keyword9" class="keyword" value="${rtnContent.KEYWORD9}" />
                        <input type="text" id="keyword10" name="keyword10" class="keyword" value="${rtnContent.KEYWORD10}" />
					</td>
				</tr>
				<c:if test="${rtnSetting.categoryYN == 'Y' }">
					<tr>
					    <th scope="row"><label for="categoryId">Category</label></th>
					    <td colspan="3">
					        <select id="categoryId" name="categoryId">
					        </select>
					    </td>
					</tr>
				</c:if>
                <!-- // 추가 필드가 있을 시 -->
                <c:if test="${!empty(rtnSetting.addField1) }">
                <tr>
                    <th scope="row"><label><c:out value="${rtnSetting.addField1}" /></label></th>
                    <td colspan="3"><input type="text" id="contents1" name="contents1" maxlength="42" value="${rtnContent.CONTENTS1 }" class="input_long" /></td>
                </tr>
                </c:if>
                <c:if test="${!empty(rtnSetting.addField2) }">
                <tr>
                    <th scope="row"><label><c:out value="${rtnSetting.addField2}" /></label></th>
                    <td colspan="3"><input type="text" id="contents2" name="contents2" maxlength="42" value="${rtnContent.CONTENTS2 }" class="input_long" /></td>
                </tr>
                </c:if>
                <c:if test="${!empty(rtnSetting.addField3) }">
                <tr>
                    <th scope="row"><label><c:out value="${rtnSetting.addField3}" /></label></th>
                    <td colspan="3"><input type="text" id="contents3" name="contents3" maxlength="42" value="${rtnContent.CONTENTS3 }" class="input_long" /></td>
                </tr>
                </c:if>
                <!-- // 추가 필드가 있을 시 -->
                <c:if test="${rtnSetting.boardKind eq 'LINK' }"><%//링크형게시판 : 내용, 첨부파일 사용안함, url 사용 %>
	                <tr>
	                    <th scope="row"><span class="point01">*</span>Link URL</th>
	                    <td colspan="3"><input type="text" id="linkUrl" name="linkUrl" class="input_long" maxlength="200" value="${rtnContent.LINKURL }" /></td>                    
	                </tr>
                </c:if>
                <c:if test="${rtnSetting.boardKind ne 'LINK' }"><%//링크형게시판 이외 : 내용, 첨부파일 사용%>
					<tr>
						<th scope="row">Content</th>
						<td colspan="3">
							<textarea name="KHtmlTextArea" id="KHtmlTextArea" cols="45" rows="5" class="txtarea" title="내용 입력" ><c:out value="${fn:replace(rtnContent.KHTML, '<br/>', newLine) }" escapeXml="false" /></textarea>
						</td>
					</tr>
					<!-- ▼ 파일 업로드 에디터  -->    
	                <tr>
	                    <th scope="row">Attached File</th>
	                    <td colspan="3">
	                    	<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
					        <div id="flashContentManager" style="display: none;">
					            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
					            <script type="text/javascript"> 
					                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
					                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
					                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
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
	</fieldset>
</spform:form>

<!-- ▼ 버튼 -->
<div class="btn_area">
	<span class="float_right">
		<c:if test="${ADMIN eq 'T' or WRITE eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 등록권한, 본인글 %>
			<button type="button" class="btn_type01" id="btnSave">Save</button>	
		</c:if>
		<c:if test="${ADMIN eq 'T' or DELETE eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
			<c:if test="${!empty(rtnContent.linkId) }">
				<button type="button" class="btn_type01" id="btnDelete">Save</button>	
			</c:if>
		</c:if>
		<button type="button" class="btn_type01" id="btnCancel">Cancel</button>
	</span>
</div>
<!-- ▲ 버튼 -->

<script type="text/javascript">

$(function() {
	//입력시 달력 기본 셋팅
	$('#startTime').val('<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd"/>');
	$('#endTime').val(<fmt:formatDate value="${DATE }" pattern="yyyy"/>+10+'<fmt:formatDate value="${DATE }" pattern="-MM-dd"/>');
		
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리선택', '${rtnContent.CATEGORYID != null ? rtnContent.CATEGORYID : ""}');
	
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
		if($('#KName').val() == ""){
			alert("Please enter a Title.");
			$('#KName').focus();
			return true;
		}
		if($.trim($("#keyword1").val()) == null || $.trim($("#keyword1").val()) == ""){
			alert("Please enter a KeyWord.");
			$('#keyword1').focus();
			return true;
		}
		if($('#categoryId').length){
			if($('#categoryId').val() == ""){
				alert("Please enter a Category.");
				return true;
			}
		}
	
        <c:if test="${rtnSetting.boardKind eq 'LINK' }"><%%>
	        //링크형게시판 : url 필수 체크
			if($.trim($("#linkUrl").val()) == null || $.trim($("#linkUrl").val()) == ""){
				alert("Please enter a LinkUrl.");
				return true;
			}
		</c:if>
		
		$("#KHtml").val($("#KHtmlTextArea").val().replace(/\n/g, "<br/>"));
		
		// 유해어 검출 스크립트
		if(gfnTabooWordCheck('KName§§KHtml')[1] > 0){
			alert(gfnTabooWordCheck('KName§§KHtml')[0]);
			return false;
		}
		
		if(!confirm("Do you want to Save?")) {
			return false;
		}

        <c:if test="${rtnSetting.boardKind ne 'LINK' }">
			// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
			if(cuManager.getTotalFileCount() == 0){
				$("#insertForm").attr('action', '/board/actBoard');
				$("#insertForm").submit();
			}else{
				cuManager.startUpload();
			}
		</c:if>
		
        <c:if test="${rtnSetting.boardKind eq 'LINK' }">
	        //링크형게시판 : 파일 업로드가 없어서 submit 으로 
			$("#insertForm").submit();
		</c:if>
	});

	// 삭제
	$("#btnDelete").click(function(){
    	
    	if(!confirm("Do you want to Delete?")){
    		return;
    	}
		$("#inCondition").val("삭제");
		
		$('#insertForm').submit();
	});
	
	//취소
	$("#btnCancel").click(function(){
		if('${obj.linkId}' != null && '${obj.linkId}' != '0'){
		    document.location.href="${contextPath}/board/view?${link}&linkId=${obj.linkId}";
		}else {
		    document.location.href="${contextPath}/board?${link}";
		}
	});
	
});

//나모첨부파일 시작
$(window).load(function(){
	createNamoCrossUploader(
 	   "crossUploadManager",   // NamoCrossUploader의 Manager 객체 Id
       "crossUploadMonitor",   // NamoCrossUploader의 Monitor 객체 Id 
       "flashContentManager",  // NamoCrossUploader의 Manager 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
       "flashContentMonitor"   // NamoCrossUploader의 Monitor 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
   );
	
});

/**
* NamoCrossUploader의 Manager 객체 생성 완료 시 호출됩니다.
*/
var onCreationCompleteCu = function () {
    cuManager = document.getElementById("crossUploadManager");

	var cusUploadURL = "${contextPath }/namoFileUpload?fileGubun=board&fileMenuId=${param.menuId}"; 
	
    // upload url 설정
    cuManager.setUploadURL(cusUploadURL);

    /*
     * 기존에 업로드된 파일을 추가
     */
    <c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
    	<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
     		cuManager.addUploadedFile({ fileId: "board@@${param.menuId}@@${fileList.SYSTEMFILENAME}@@${fileList.FILEID}@@${fileList.FILEPATH}", fileName: "${fileList.USERFILENAME}", fileSize: ${fileList.FILESIZE} });
     	</c:forEach>
    </c:if>
    
 	// UI 프로퍼티를 설정합니다.
	var uiProperties = {
	    "visibleUploadButton": false
	};
	cuManager.setUIProperties(uiProperties);
    
    // 옵션 설정
	// 전체 파일 크기를 제한
    cuManager.setMaxTotalFileSize("${rtnSetting.fileMaxSize}" * 1024 * 1024 * 10);
	// 허용하지 않을 파일 확장자 기준으로 File Extension을 설정하시려면 setAllowedFileExtension 메소드의 두번째 파라미터에 true를 입력해 주십시오.
	cuManager.setAllowedFileExtension("${extFilterExclude}", true); 
    // 파일 개수 제한
    cuManager.setMaxFileCount("${rtnSetting.fileMaxCount}");
    
}

/** 
* 전송창이 닫힐 때 호출됩니다.
*/ 
var onCloseMonitorWindowCu = function () { 
	window.focus(); 
    document.getElementById("monitorBgLayer").style.display = "none";
    document.getElementById("monitorLayer").style.display = "none";    

	// 데이터 처리 페이지로 업로드 결과를 전송합니다. 
	// onEndUploadCu 나 onCloseMonitorWindowCu 이벤트 시점에 처리하시면 되며, onCloseMonitorWindowCu 시에는 getUploadStatus()를 사용하여 업로드 상태를 체크해 주십시오.
	if(cuManager.getUploadStatus() == "COMPLETE") {
		/**
		* 업로드된 전체 파일의 정보를 가져옵니다. 
		* 서버측에서 JSON 타입으로 반환했을 경우는 JSON 타입으로 가져오는 것을 권장하며, 그 외의 경우는 개별 파일 정보를 조합할 delimiter 문자(또는 문자열)를 입력해 주십시오.
		*/
		var uploadedFilesInfo = cuManager.getUploadedFilesInfo("JSON"); 
		
		/**
         * addUploadedFile로 추가한 전체 파일 정보를 가져옵니다. 
         */ 
		var modifiedFilesInfo = cuManager.getModifiedFilesInfo("JSON");
		
		// 데이터 처리 페이지로 업로드 결과를 전송합니다.
		document.insertForm.uploadedFilesInfo.value = uploadedFilesInfo;
		document.insertForm.modifiedFilesInfo.value = modifiedFilesInfo;
		
		$("#insertForm").attr('action', '/board/actBoard');
		$("#insertForm").submit();

	}
}
</script>

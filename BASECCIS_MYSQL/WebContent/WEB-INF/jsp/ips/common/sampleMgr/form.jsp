<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/sampleMgr/act" method="post">
	<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
	<input type="hidden" id="sampleId" name="sampleId" value="${result.SAMPLEID > 0 ? result.SAMPLEID : 0}"/>
	
	<c:if test="${fileUploadType eq 'Namo'}">
		<!-- 나모첨부파일 사용경우 START -->
		<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
		<!-- 나모첨부파일 사용경우 END -->	
	</c:if>
	<c:if test="${fileUploadType eq 'Uploadify'}">
		<c:import url="/includes/uploadify.jsp" charEncoding="UTF-8" />
	</c:if>
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${obj.pageNum }">
	<input type="hidden" name="schType" value="${obj.schType }">
	<input type="hidden" name="schText" value="${obj.schText }">	
	<fieldset>
		<legend>사이트 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
		     <table class="tstyle_view">
				<caption>
					사이트 상세 정보 입력 - 제목, 내용, 첨부파일
				</caption>
				<colgroup>
					<col class="col-sm-3"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="sampleTitle">제목</label></th>
						<td><input type="text" name="sampleTitle" id="sampleTitle" value="${result.SAMPLETITLE}" class="input_long" title="제목"/></td>
					</tr>
					<tr>
			            <th scope="row"><label for="sampleContent">내용</label></th>
			            <td >
			            	<textarea id="sampleContent" name="sampleContent" rows="" cols="" style="display: none;"><c:out value="${result.SAMPLECONTENT }" escapeXml="true" /></textarea>
			            	<c:if test="${editor eq 'Namo'}">		            
					            <!-- ▼ 에디터 -->  
					          	<script type="text/javascript">         
					            var CrossEditor = new NamoSE('namoEditor');
					            //에디터 업로드 용량
					           	CrossEditor.params.UploadFileSizeLimit = "movie:524288000, image:20971520";
					            CrossEditor.params.Width = "100%";
					            CrossEditor.EditorStart();
					            function OnInitCompleted(e){
					            	e.editorTarget.SetBodyValue(document.getElementById("sampleContent").value);
					            }
					          	</script>
					           	<!-- ▲ 에디터  -->
				           	</c:if>
				           	<c:if test="${editor eq 'Daum'}">
				            	<!-- ▼ 에디터 -->  
					          	<script type="text/javascript">
					          		gfnInitEditor("sampleContent", 'self');
					          	</script>
				           		<div id="editor_frame"></div>
				           	</c:if>
			        	</td>
			        </tr>		         
			        <!-- ▼ 파일 업/다운로드 에디터  -->
					<tr>
						<th scope="row">첨부파일</th>
						<td>
							<c:if test="${fileUploadType eq 'Namo'}">	
								<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
								<div id="flashContentManager" style="display: none;">
									<p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
									<script type="text/javascript"> 
									   var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
									   document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
									   
									   <c:if test="${!empty(resultFile) && fn:length(resultFile) > 0 }">
						                	<c:forEach items="${resultFile }" var="fileList" varStatus="status">
				                         		var strOldFileInfo = new Object();
				                         		strOldFileInfo.fileId = "function@@$sampleMgr@@${fileList.SYSTEMFILENAME}@@${fileList.FILEID}@@${fileList.FILEPATH}";
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
							</c:if>
							<c:if test="${fileUploadType eq 'Uploadify'}">
								<div class="fileUpload_area" id="fileUpload_area">
									<h2>첨부파일</h2><input type="file" name="file_upload" id="file_upload"/>
									<ul class="fileUpload_progress">
										<c:forEach var="fileList" items="${resultFile}" varStatus="status">
											<li>
												<div id="divAtcharea_${status.index }" class="uploadify-queue-item">
													<div class="cancel">
														<a href="javascript:uploadifyCancel('', '${status.index }');">X</a>
													</div>
													<div class="file_area">
														<span class="fileName">
															<a href="${contextPath}/fileDownload?fileGubun=function&menuId=sampleMgr&userFileName=${fileList.USERFILENAME }&systemFileName=${fileList.SYSTEMFILENAME }">
															${fileList.USERFILENAME } (${fileList.FILESIZE}B)
															</a>
														</span>
														<span class="data"></span>
													</div> 
												</div>
											</li>
										</c:forEach>
										<li><div id="divSelectFileArea"></div></li>
									</ul>
									<script type="text/javascript">
										<c:forEach items="${resultFile }" var="fileList" varStatus="status">
											var strOldFileInfo = new Object();
			                                strOldFileInfo.filePath = "${fileList.FILEPATH}";
			                                strOldFileInfo.userFileName = "${fileList.USERFILENAME}";
			                                strOldFileInfo.systemFileName = "${fileList.SYSTEMFILENAME}";
			                                strOldFileInfo.fileExtension = "${fileList.FILEEXTENSION}";
			                                strOldFileInfo.fileSize = ${fileList.FILESIZE};
											fileInfoList.push(JSON.stringify(strOldFileInfo));
										</c:forEach>
									</script>
								</div>
							</c:if>
				    	</td>
					</tr>
					<!-- ▲ 파일 업로드 에디터  -->
				</tbody>
			</table>
		</div>
	</fieldset>
	<div class="btn_area">	
		<button type="button" class="btn btn_type02" id="btnSave">저장</button>
		 <button type="button" class="btn btn_type01" id="btnCancel">취소</button>
	</div>
</spform:form>							
<script type="text/javascript">
$(function() {
	// 파일업로드종류 Init
	if("${fileUploadType}" == "Uploadify"){
		// uploadify Init funtion : form, action, uploadUrl
		uploadifyInit($("#insertForm"), '${ctxMgr }/sampleMgr/act', 'fileGubun=function&fileMenuId=sampleMgr');
	}
	
	$("#btnSave").click(function(){
		if($("#sampleTitle").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#sampleTitle").focus();
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#sampleContent").val(Editor.getContent());
		}else{
			$("#sampleContent").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		if("${fileUploadType}" == "Namo"){
			// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
			if(cuManager.getTotalFileCount() == 0){
				$("#insertForm").attr('action', '${ctxMgr }/sampleMgr/act');
				$("#insertForm").submit();
			}else{
				cuManager.startUpload();
			}
		}else{
			if($('#file_upload').data('uploadify').queueData.queueLength <= 0 && $('#file_upload2').data('uploadify').queueData.queueLength <= 0){
				$("#uploadedFilesInfo").val(fileInfoList);
				$("#insertForm").attr('action', '${ctxMgr }/sampleMgr/act');
				$("#insertForm").submit();
			}else{
				$("#file_upload").uploadify('upload', '*');
				$("#file_upload2").uploadify('upload', '*');
			}
		}
		
	});

	//취소
    $("#btnCancel").click(function(){
    	if(!confirm("취소하시겠습니까?")) {
			return false;
		}
    	$("#insertForm").attr('action', '${ctxMgr }/sampleMgr');
		$("#insertForm").submit();
    });
    
});

if("${fileUploadType}" == "Namo"){
	$(window).load(function(){
		/*나모 Start*/
		onInitNamoUploader('BASE'); //파일Init : 기본
		// 파일정보파라메타
		actionfrom = $("#insertForm");
		formaction = "${ctxMgr}/sampleMgr/act";
	    filePath = "${contextPath}/namoFileUpload?fileGubun=function&fileMenuId=sampleMgr";
		fileMaxSize = 5120 * 1024 * 1024 * 10;
		extFilterExclude = "${extFilterExclude}";
		fileMaxCount = 1;
		/*나모 End*/
	});
}
</script>

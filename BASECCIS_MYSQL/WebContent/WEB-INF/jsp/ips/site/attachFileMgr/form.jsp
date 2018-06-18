<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- ▼ 등록페이지  -->
 <spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/attachFileMgr" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="attachFileId" name="attachFileId" value="${result.ATTACHFILEID > '0' ? result.ATTACHFILEID : '0'}" />
	<!-- 나모첨부파일 사용경우 START -->
	<!-- 파일 정보를 저장할 폼 데이터 -->
	<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
	<!-- 나모첨부파일 사용경우 END -->
    <fieldset>
	    <legend>상세등록</legend>
	    <div class="table">
			<table class="tstyle_view">
				<caption>
                	첨부파일관리 - 제목, 작성자, 작성일, 내용, 첨부파일
               </caption>
               <colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
				</colgroup>
               <tbody>
	               <tr>
	                   <th scope="row"><label for="KName">제목</label></th>
	                   <td>
	                   		<input type="text" id="KName" name="KName" value="${result.KNAME }"  class="input_long"/>
	                   </td>
	               </tr>
	               <tr>
	                   <th scope="row">작성자</th>
	                   <td><c:out value="${!empty(result.USERNAME) ? result.USERNAME : obj.myName  }" /></td>
	               </tr>
	               <tr>
	                   <th scope="row"><label for="viewtxt">내용</label></th>
	                   <td>
	                	   <textarea id="KHtml" name="KHtml" rows="" cols="" style="display: none;"><c:out value="${result.KHTML }" escapeXml="true" /></textarea>
		                    <c:if test="${editor eq 'Namo'}">		            
					            <!-- ▼ 에디터 -->  
					          	<script type="text/javascript">         
					            var CrossEditor = new NamoSE('namoEditor');
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
				                
				                <c:if test="${!empty(resultFile) && fn:length(resultFile) > 0 }">
				                	<c:forEach items="${resultFile }" var="fileList" varStatus="status">
		                         		var strOldFileInfo = new Object();
		                         		strOldFileInfo.fileId = "common@@$attachFileMgr@@${fileList.SYSTEMFILENAME}@@${fileList.FILEID}@@${fileList.FILEPATH}";
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
	// 저장
	$('#btnSave').click(function(){
		
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#KHtml").val(Editor.getContent());
		}else{
			$("#KHtml").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End

		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
		if(cuManager.getTotalFileCount() == 0){
			$("#insertForm").attr('action', '${ctxMgr }/attachFileMgr/act');
			$("#insertForm").submit();
		}else{
			cuManager.startUpload();
		}
	});

	//취소
    $("#btnCancel").click(function(){
        document.location.href="${contextPath}/mgr/attachFileMgr?${link}";
    });
	
});

//나모첨부파일 시작
$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('BASE'); //파일Init : 첨부파일만
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr }/attachFileMgr/act";
	filePath = "${contextPath }/namoFileUpload?fileGubun=common&fileMenuId=attachFileMgr";
	fileMaxSize = 5120 * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = 10;
	/*나모 End*/
});

</script>
